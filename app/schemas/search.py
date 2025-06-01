from pydantic import BaseModel
from typing import List, Optional, Any, Dict
from datetime import datetime

class SearchFilters(BaseModel):
    status: Optional[str] = None
    min_price: Optional[float] = None
    max_price: Optional[float] = None
    content_type: Optional[str] = None
    is_answered: Optional[bool] = None

class SearchResults(BaseModel):
    items: List[Any]
    total: int
    page: int
    pages: int

class SearchSuggestion(BaseModel):
    text: str
    type: str  # course, topic, discussion
    score: float

class SearchMetadata(BaseModel):
    total_results: int
    execution_time: float
    filters_applied: Dict[str, Any]