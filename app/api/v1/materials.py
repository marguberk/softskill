from typing import List
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.db.base import get_db
from app.models.learning_material import LearningMaterial
from app.schemas.learning_material import LearningMaterialList

router = APIRouter()

@router.get("/materials", response_model=List[LearningMaterialList])
def get_published_materials(
    skip: int = 0,
    limit: int = 100,
    db: Session = Depends(get_db)
):
    """Получить список опубликованных материалов для студентов"""
    materials = db.query(LearningMaterial).filter(
        LearningMaterial.is_published == True
    ).offset(skip).limit(limit).all()
    return materials

@router.get("/materials/{material_id}", response_model=LearningMaterialList)
def get_material(
    material_id: int,
    db: Session = Depends(get_db)
):
    """Получить конкретный опубликованный материал"""
    material = db.query(LearningMaterial).filter(
        LearningMaterial.id == material_id,
        LearningMaterial.is_published == True
    ).first()
    
    if not material:
        raise HTTPException(status_code=404, detail="Material not found")
    
    return material 