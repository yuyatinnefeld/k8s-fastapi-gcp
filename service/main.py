from typing import Union

from fastapi import FastAPI

app = FastAPI()


@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.get("/items/{item_id}")
def read_item(item_id: int, q: Union[str, None] = None):
    return {"item_id": item_id, "q": q}


@app.get("/ping", summary="Check that the service is operational")
def pong():
    """
    Sanity check - this will let the user know that the service is operational.

    It is also used as part of the HEALTHCHECK. Docker uses curl to check that the API service is still running, by exercising this endpoint.

    """
    return {"ping": "pong!"}
