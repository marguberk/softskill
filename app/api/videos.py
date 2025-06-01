from typing import Optional
from fastapi import APIRouter, Depends, HTTPException, UploadFile, File, Response
from fastapi.responses import StreamingResponse
from sqlalchemy.orm import Session
from app.db.base import get_db
from app.services.video import VideoService
from app.api.deps import get_current_user
from app.models.user import User
import os

router = APIRouter()
video_service = VideoService()

@router.post("/upload")
async def upload_video(
    file: UploadFile = File(...),
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    """Загрузка видео файла"""
    if not current_user.role in ["teacher", "admin"]:
        raise HTTPException(
            status_code=403,
            detail="Not enough permissions"
        )

    try:
        filename, file_path = await video_service.save_video(file)
        return {
            "filename": filename,
            "url": video_service.get_video_url(filename)
        }
    except Exception as e:
        raise HTTPException(
            status_code=500,
            detail=str(e)
        )

@router.get("/{filename}")
async def get_video(
    filename: str,
    range: Optional[str] = None,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    """Стриминг видео с поддержкой range requests"""
    try:
        video_path = await video_service.get_video_path(filename)
        file_size = os.path.getsize(video_path)

        # Обработка range request для поддержки перемотки
        start = 0
        end = file_size - 1

        if range is not None:
            start, end = range.replace("bytes=", "").split("-")
            start = int(start)
            end = int(end) if end else file_size - 1

        chunk_size = end - start + 1

        # Заголовки для стриминга
        headers = {
            'Content-Range': f'bytes {start}-{end}/{file_size}',
            'Accept-Ranges': 'bytes',
            'Content-Length': str(chunk_size),
            'Content-Type': 'video/mp4',
        }

        # Функция для стриминга файла
        async def video_stream():
            async with aiofiles.open(video_path, mode='rb') as video:
                await video.seek(start)
                remaining = chunk_size
                while remaining > 0:
                    chunk = await video.read(min(remaining, video_service.CHUNK_SIZE))
                    if not chunk:
                        break
                    remaining -= len(chunk)
                    yield chunk

        return StreamingResponse(
            video_stream(),
            headers=headers,
            status_code=206 if range else 200
        )

    except Exception as e:
        raise HTTPException(
            status_code=500,
            detail=str(e)
        )

@router.delete("/{filename}")
async def delete_video(
    filename: str,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    """Удаление видео файла"""
    if not current_user.role in ["teacher", "admin"]:
        raise HTTPException(
            status_code=403,
            detail="Not enough permissions"
        )

    try:
        await video_service.delete_video(filename)
        return {"message": "Video deleted successfully"}
    except Exception as e:
        raise HTTPException(
            status_code=500,
            detail=str(e)
        )