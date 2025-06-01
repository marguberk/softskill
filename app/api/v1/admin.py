from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List

from app.db.base import get_db
from app.models.user import User
from app.models.learning_material import LearningMaterial, LearningTask
from app.schemas.learning_material import (
    LearningMaterialCreate, 
    LearningMaterialUpdate, 
    LearningMaterial as LearningMaterialSchema,
    LearningMaterialList
)
from app.api.deps import get_current_user

router = APIRouter()

def require_admin(current_user: User = Depends(get_current_user)):
    """Проверка что пользователь - администратор"""
    if current_user.role != "admin":
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Нет прав доступа"
        )
    return current_user

@router.get("/materials", response_model=List[LearningMaterialList])
def get_materials(
    skip: int = 0,
    limit: int = 100,
    db: Session = Depends(get_db),
    admin: User = Depends(require_admin)
):
    """Получить список всех материалов для админки"""
    materials = db.query(LearningMaterial).offset(skip).limit(limit).all()
    return materials

@router.post("/materials", response_model=LearningMaterialSchema)
def create_material(
    material: LearningMaterialCreate,
    db: Session = Depends(get_db),
    admin: User = Depends(require_admin)
):
    """Создать новый обучающий материал"""
    # Создаем материал
    db_material = LearningMaterial(**material.dict(exclude={"tasks"}))
    db.add(db_material)
    db.commit()
    db.refresh(db_material)
    
    # Создаем задания
    for task_data in material.tasks:
        db_task = LearningTask(
            material_id=db_material.id,
            **task_data.dict()
        )
        db.add(db_task)
    
    db.commit()
    db.refresh(db_material)
    
    return db_material

@router.get("/materials/{material_id}", response_model=LearningMaterialSchema)
def get_material(
    material_id: int,
    db: Session = Depends(get_db),
    admin: User = Depends(require_admin)
):
    """Получить материал по ID"""
    material = db.query(LearningMaterial).filter(LearningMaterial.id == material_id).first()
    if not material:
        raise HTTPException(status_code=404, detail="Материал не найден")
    
    # Получаем задания
    tasks = db.query(LearningTask).filter(LearningTask.material_id == material_id).all()
    material.tasks = tasks
    
    return material

@router.put("/materials/{material_id}", response_model=LearningMaterialSchema)
def update_material(
    material_id: int,
    material_update: LearningMaterialUpdate,
    db: Session = Depends(get_db),
    admin: User = Depends(require_admin)
):
    """Обновить материал"""
    db_material = db.query(LearningMaterial).filter(LearningMaterial.id == material_id).first()
    if not db_material:
        raise HTTPException(status_code=404, detail="Материал не найден")
    
    # Обновляем поля
    for field, value in material_update.dict(exclude_unset=True).items():
        setattr(db_material, field, value)
    
    db.commit()
    db.refresh(db_material)
    
    return db_material

@router.delete("/materials/{material_id}")
def delete_material(
    material_id: int,
    db: Session = Depends(get_db),
    admin: User = Depends(require_admin)
):
    """Удалить материал"""
    db_material = db.query(LearningMaterial).filter(LearningMaterial.id == material_id).first()
    if not db_material:
        raise HTTPException(status_code=404, detail="Материал не найден")
    
    # Удаляем задания
    db.query(LearningTask).filter(LearningTask.material_id == material_id).delete()
    
    # Удаляем материал
    db.delete(db_material)
    db.commit()
    
    return {"message": "Материал удален"}

@router.get("/stats")
def get_admin_stats(
    db: Session = Depends(get_db),
    admin: User = Depends(require_admin)
):
    """Получить статистику для админки"""
    total_materials = db.query(LearningMaterial).count()
    published_materials = db.query(LearningMaterial).filter(LearningMaterial.is_published == True).count()
    total_users = db.query(User).count()
    
    return {
        "total_materials": total_materials,
        "published_materials": published_materials,
        "draft_materials": total_materials - published_materials,
        "total_users": total_users
    } 