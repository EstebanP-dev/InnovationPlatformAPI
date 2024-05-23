from enum import Enum


class DeliverableStatusEnum(str, Enum):
    PENDING = 'Pending'
    REVIEWING = 'Reviewing'
    APPROVED = 'Approved'
    REJECTED = 'Rejected'
