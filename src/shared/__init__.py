from fastapi import Depends
from pydantic import BaseModel, Field
from sqlalchemy import Column, String, CHAR, Date
from typing import Optional, List, Any, Annotated
from .application import *
from .domain import *
from .infrastructure import *
from .presentation import *
