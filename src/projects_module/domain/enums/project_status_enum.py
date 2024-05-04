from enum import Enum


class ProjectStatusEnum(str, Enum):
    COMPLETED = 'Completado'
    IN_PROGRESS = 'En Progreso'
    WAITING = 'En Espera'
    PENDING = 'Pendiente'
