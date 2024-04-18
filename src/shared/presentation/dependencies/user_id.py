from fastapi import Header, HTTPException


def get_user_id(user_id: str = Header(None)):
    if user_id is None:
        raise HTTPException(status_code=403, detail="Not authenticated.")
    return user_id
