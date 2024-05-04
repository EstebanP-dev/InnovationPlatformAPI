import re


class PasswordValidator:
    def __init__(self, max_length=12, min_length=8):
        self.max_length = max_length
        self.min_length = min_length

    def validate_password(self, password: str):
        if len(password) < self.min_length:
            raise ValueError(f'Password must be at least {self.min_length} characters')
        if len(password) > self.max_length:
            raise ValueError(f'Password must be at most {self.max_length} characters')
        if not re.search(r'[a-z]', password):
            raise ValueError('Password must contain at least one lowercase letter')
        if not re.search(r'[A-Z]', password):
            raise ValueError('Password must contain at least one uppercase letter')
        if not re.search(r'\d', password):
            raise ValueError('Password must contain at least one digit')
        return password
