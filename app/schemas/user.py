from pydantic import BaseModel, EmailStr
from typing import Optional

class UserBase(BaseModel):
    email: str
    full_name: Optional[str] = None
    role: str = "student"

class UserCreate(UserBase):
    password: str

class User(UserBase):
    id: int
    is_active: bool = True
    access_token: Optional[str] = None
    token_type: Optional[str] = None

    class Config:
        from_attributes = True

class Token(BaseModel):
    access_token: str
    token_type: str
    user: dict

class TokenData(BaseModel):
    email: Optional[str] = None