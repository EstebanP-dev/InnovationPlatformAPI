UUID_REGEX = r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$'
EMAIL_REGEX = r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$'
PHONE_NUMBER_REGEX = r'^\+?1?\d{9,15}$'
USER_CODE_REGEX = r'^\d{5,20}$'
USER_NAME_REGEX = r'^[a-zA-Z0-9_.+-]{5,100}$' # At least 8 characters
NAME_REGEX = r'^[a-zA-Z\s]{5,100}$'
