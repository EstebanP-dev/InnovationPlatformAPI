import firebase_admin
import os
import dotenv
from firebase_admin import storage
from fastapi import UploadFile

dotenv.load_dotenv()

FIREBASE_API_KEY = os.getenv("FIREBASE_API_KEY")
FIREBASE_AUTH_DOMAIN = os.getenv("FIREBASE_AUTH_DOMAIN")
FIREBASE_PROJECT_ID = os.getenv("FIREBASE_PROJECT_ID")
FIREBASE_STORAGE_BUCKET = os.getenv("FIREBASE_STORAGE_BUCKET")
FIREBASE_MESSAGING_SENDER_ID = os.getenv("FIREBASE_MESSAGING_SENDER_ID")
FIREBASE_APP_ID = os.getenv("FIREBASE_APP_ID")
FIREBASE_MEASUREMENT_ID = os.getenv("FIREBASE_MEASUREMENT_ID")


class FirebaseProvider:
    def __init__(self):
        firebase_config = {
            "apiKey": FIREBASE_API_KEY,
            "authDomain": FIREBASE_AUTH_DOMAIN,
            "projectId": FIREBASE_PROJECT_ID,
            "storageBucket": FIREBASE_STORAGE_BUCKET,
            "messagingSenderId": FIREBASE_MESSAGING_SENDER_ID,
            "appId": FIREBASE_APP_ID,
            "measurementId": FIREBASE_MEASUREMENT_ID
        }
        firebase_admin.initialize_app(options=firebase_config)
        self._storage = storage

    async def upload_file(self, file_path: str, file: UploadFile):
        bucket = self._storage.bucket()

        contents = await file.read()

        blob = bucket.blob(file_path)

        blob.upload_from_string(contents, content_type=file.content_type)

        return blob.public_url
