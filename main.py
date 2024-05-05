import dotenv
import os
from fastapi import FastAPI, APIRouter
from fastapi.middleware.cors import CORSMiddleware
from src import (
    country_router,
    authentication_module_router)
from src.shared import GeneralExceptionMiddleware

from src.projects_module import project_module_router

dotenv.load_dotenv()

WEB_ORIGIN = os.getenv("WEB_ORIGIN")

print(WEB_ORIGIN)

app = FastAPI(root_path="/api/v1")

origins = [WEB_ORIGIN]


app.include_router(country_router)
app.include_router(authentication_module_router)
app.include_router(project_module_router)

app.middleware("http")(GeneralExceptionMiddleware(app))

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.get("/hello/{name}")
async def say_hello(name: str):
    return {"message": f"Hello {name}"}
