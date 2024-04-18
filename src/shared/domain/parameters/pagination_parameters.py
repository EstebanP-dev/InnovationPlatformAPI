from typing import Optional


class PaginationParameters:
    def __init__(self, page: Optional[int] = None, rows: Optional[int] = None, order_by: Optional[str] = None, direction: Optional[str] = None):
        self.page = page
        self.rows = rows
        self.order_by = order_by
        self.direction = direction
