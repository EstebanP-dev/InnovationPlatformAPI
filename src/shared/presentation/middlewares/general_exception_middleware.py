from fastapi import Request, FastAPI
from fastapi.responses import JSONResponse
from pydantic import ValidationError
from ...domain import Result, Error


class GeneralExceptionMiddleware:
    def __init__(self, app: FastAPI):
        self.app = app

    async def __call__(self, request: Request, call_next):
        try:
            response = await call_next(request)
            return response
        except ValidationError as e:
            errors = [Error.validation(f"{error['loc'][0]}: {error['msg']}") for error in e.errors()]
            result = Result.failure(errors)
            return JSONResponse(
                status_code=400,
                content=result.dic(),
            )
        except Exception as e:
            error = Error.from_exception(e)
            result = Result.failure(error)
            return JSONResponse(
                status_code=500,
                content=result.dic(),
            )
