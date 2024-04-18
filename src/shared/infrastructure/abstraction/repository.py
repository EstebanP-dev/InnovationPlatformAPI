from abc import ABC, abstractmethod

from fastapi import Depends
from sqlalchemy import inspect
from sqlalchemy.orm import Session

from ..database import create_session


def get_entity_fields(entity):
    return [column.key for column in inspect(entity).mapper.column_attrs()]


class Repository(ABC):

    def __init__(self, db: Session = Depends(create_session)):
        self._context = db

    @property
    @abstractmethod
    def __table_name__(self):
        pass
