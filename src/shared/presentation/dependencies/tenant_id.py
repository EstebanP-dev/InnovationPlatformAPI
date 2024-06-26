from fastapi import Header, HTTPException


def get_tenant_id(tenant_id: str = Header(alias="X-Tenant-Id")) -> str:
    if tenant_id is None:
        raise HTTPException(status_code=403, detail="Not authenticated.")
    return tenant_id
