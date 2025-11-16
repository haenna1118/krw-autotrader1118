from typing import Optional

from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()


class Item(BaseModel):
    name: str
    description: Optional[str] = None
    price: float


@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.post("/items/")
def create_item(item: Item):
    # Echo the validated item back as JSON
    return item