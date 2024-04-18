from fastapi.responses import JSONResponse
from fastapi.encoders import jsonable_encoder


def handle_result(result):
    result_encoded = jsonable_encoder(result)
    if result.is_failure:
        error = result.first_error
        return JSONResponse(status_code=error.code, content=result_encoded)

    return result
