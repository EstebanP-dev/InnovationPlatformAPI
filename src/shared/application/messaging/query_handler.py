from abc import ABC, abstractmethod
from typing import Generic, TypeVar

from ...domain import Result

TQuery = TypeVar('TQuery')
TResult = TypeVar('TResult')


class QueryHandler(ABC, Generic[TQuery, TResult]):

    @abstractmethod
    async def handle(self, query: TQuery) -> Result[TResult]:
        pass
