from abc import ABC, abstractmethod
from typing import Any, Dict

from fastapi import Depends
from sqlalchemy import inspect, text, outparam
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

    async def execute_stored_procedure_from_model(self, sp_name: str, model: Any):
        model_properties = [prop for prop in dir(model) if
                            not prop.startswith('_') and not callable(getattr(model, prop))]

        params = {prop: getattr(model, prop) for prop in model_properties}

        sql = text(f"CALL {sp_name}({','.join(':' + prop for prop in model_properties)})")

        entity_rows = self._context.execute(sql, params)

        result = [{column: value for column, value in row.items()} for row in entity_rows.mappings()]

        self._context.commit()

        return result

    async def execute_stored_procedure_with_in_params(self, sp_name: str,
                                                      in_params: Dict[str, Any]):
        sql = text(
            f"CALL {sp_name}({','.join(':' + param for param in list(in_params.keys()))})")

        params = {**in_params}

        entity_rows = self._context.execute(sql, params)

        result = [{column: value for column, value in row.items()} for row in entity_rows.mappings()]

        self._context.commit()

        return result

    async def execute_stored_procedure_with_in_and_out_params(self, sp_name: str,
                                                              in_params: Dict[str, Any],
                                                              out_params: list[str]):

        out_params_str = ','.join('@' + param for param in out_params)

        call_sp_sql = f"CALL {sp_name}({','.join(
            ':' + param
            for param in list(in_params.keys()))}, {out_params_str})"

        get_out_params_sql = "SELECT " + out_params_str

        entity_rows = self._context.execute(text(call_sp_sql), in_params)
        out_params_values = self._context.execute(text(get_out_params_sql)).fetchone()

        out_params_result = {param: value for param, value in zip(out_params, out_params_values)}

        result = [{column: value for column, value in row.items()} for row in entity_rows.mappings()]

        self._context.commit()

        return out_params_result, result

    async def execute_view(self, view_name: str):
        sql = text(f"SELECT * FROM {view_name}")

        entity_rows = self._context.execute(sql).mappings()

        result = [{column: value for column, value in row.items()} for row in entity_rows]

        self._context.commit()

        return result
