from abc import ABC, abstractmethod
from typing import Generic, TypeVar

from ...domain import Result, Success

TCommand = TypeVar('TCommand')
TResult = TypeVar('TResult')


class CommandHandler(ABC, Generic[TCommand, TResult]):

    @abstractmethod
    async def handle(self, command: TCommand) -> Result[TResult]:
        pass
