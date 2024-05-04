from typing import Tuple, Any

from sqlalchemy import text, Row
from src.shared import Depends, Repository, create_session, SESSION_LOCAL


class UsersRepository(Repository):

    def __init__(self, db: SESSION_LOCAL = Depends(create_session)):
        super().__init__(db)

    @property
    def __table_name__(self):
        return 'users'

    async def user_exists(self, field: str) -> Tuple[bool, str]:
        sql = text("CALL sp_exist_user_by_uniques(:field, @password_hash)")
        result = self._context.execute(sql, {'field': field})

        out_params = self._context.execute(text("SELECT @password_hash"))
        out_params_fetch = out_params.fetchone()

        password_hash = out_params_fetch[0] if out_params_fetch else None

        user_exists = result.fetchone()
        return (user_exists[0] if user_exists else False), password_hash

    async def get_user(self, field: str):
        sql = text("CALL sp_get_user_by_uniques(:field)")

        execute_data = self._context.execute(sql, {'field': field})

        self._context.commit()

        fetch_data_dict = [{column: value for column, value in row.items()} for row in execute_data.mappings()][0]

        return fetch_data_dict

    async def create_user(self, user_data: dict):
        roles = ','.join(user_data['roles'])

        sql = text(
            """
            CALL sp_insert_user(
                :branch_id,
                :document_type_id,
                :gender_id,
                :roles_ids,
                :user_code,
                :user_document_number,
                :user_email,
                :user_user_name,
                :user_password_hash,
                :user_phone_number,
                :user_birth_date,
                :user_given_name,
                :user_family_name,
                :user_avatar,
                :user_assessor_code
            )
            """
        )

        self._context.execute(sql, {
            'branch_id': user_data['branch'],
            'document_type_id': user_data['document_type'],
            'gender_id': user_data['gender'],
            'roles_ids': roles,
            'user_code': user_data['code'],
            'user_document_number': user_data['document_number'],
            'user_email': user_data['email'],
            'user_user_name': user_data['user_name'],
            'user_password_hash': user_data['password_hash'],
            'user_phone_number': user_data['phone_number'],
            'user_birth_date': user_data['birth_date'],
            'user_given_name': user_data['given_name'],
            'user_family_name': user_data['family_name'],
            'user_avatar': user_data['avatar'],
            'user_assessor_code': user_data['assessor_code']
        })

        self._context.commit()

        return True
