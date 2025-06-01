import os
import aiofiles
import uuid
from typing import Optional, Tuple
from fastapi import UploadFile, HTTPException
from app.core.config import settings

class VideoService:
    ALLOWED_EXTENSIONS = {'.mp4', '.webm', '.mkv'}
    CHUNK_SIZE = 1024 * 1024  # 1MB chunks

    def __init__(self):
        self.upload_dir = settings.UPLOAD_FOLDER / 'videos'
        self.upload_dir.mkdir(parents=True, exist_ok=True)

    async def save_video(self, file: UploadFile) -> Tuple[str, str]:
        """
        Сохранить загруженное видео
        Returns: (filename, file_path)
        """
        # Проверка расширения файла
        ext = os.path.splitext(file.filename)[1].lower()
        if ext not in self.ALLOWED_EXTENSIONS:
            raise HTTPException(
                status_code=400,
                detail=f"File extension not allowed. Use {', '.join(self.ALLOWED_EXTENSIONS)}"
            )

        # Генерация уникального имени файла
        filename = f"{uuid.uuid4()}{ext}"
        file_path = self.upload_dir / filename

        try:
            # Сохранение файла
            async with aiofiles.open(file_path, 'wb') as out_file:
                while content := await file.read(self.CHUNK_SIZE):
                    await out_file.write(content)

            return filename, str(file_path)
        except Exception as e:
            raise HTTPException(
                status_code=500,
                detail=f"Could not save video file: {str(e)}"
            )

    async def get_video_path(self, filename: str) -> str:
        """Получить путь к видео файлу"""
        file_path = self.upload_dir / filename
        if not file_path.exists():
            raise HTTPException(
                status_code=404,
                detail="Video not found"
            )
        return str(file_path)

    def get_video_url(self, filename: str) -> str:
        """Получить URL для доступа к видео"""
        return f"/api/v1/videos/{filename}"

    async def delete_video(self, filename: str) -> None:
        """Удалить видео файл"""
        file_path = self.upload_dir / filename
        if file_path.exists():
            os.remove(file_path)