from ...domain import PaginationParameters
from fastapi import Request


async def pagination_parameters(request: Request) -> PaginationParameters:
    page = request.query_params.get("page")
    rows = request.query_params.get("rows")
    order_by = request.query_params.get("order_by")
    direction = request.query_params.get("direction")

    return PaginationParameters(
        page=page,
        rows=rows,
        order_by=order_by,
        direction=direction
    )
