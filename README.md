# Innovation Platform API

Este proyecto es una API construida con FastAPI y MySQL, dockerizada para facilitar su despliegue.

## Requisitos

- Python 3.12
- Docker
- Docker Compose

## Instalación

### 1. Clonar el repositorio

```bash
git clone <URL_DEL_REPOSITORIO>
cd <NOMBRE_DEL_REPOSITORIO>
```
### 2. Crear archivo `.env`
Crea un archivo `.env` en el directorio base del proyecto con el siguiente contenido:

```
MYSQL_USERNAME=databe_user
MYSQL_PASSWORD=databe_password
MYSQL_HOST=databe_host
MYSQL_PORT=databe_port
MYSQL_DATABASE=database_name
SECRET_KEY=HEX-32CHAR
ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=60
WEB_ORIGIN=http://localhost:8080
```

### 3. Construir y ejecutar los contenedores

```bash
docker-compose up -d --build
```

Esto levantará dos servicios:
- `fastapi`: La API FastAPI corriendo en el puerto 8000.
- `database`: El servidor MySQL corriendo en el puerto 3306.

### 4. Inicializar la base de datos

Para crear las tablas y poblar la base de datos con datos de prueba, ejecuta los siguientes comandos:

```bash
docker exec -i innovation-platform-db mysql -uroot -proot innovation-platform < create_database.sql
docker exec -i innovation-platform-db mysql -uroot -proot innovation-platform < test_data.sql
```

## Uso

La API estará disponible en http://localhost:8000.

## Dependencias
El archivo requirements.txt contiene todas las dependencias necesarias para el proyecto. Para instalarlas localmente, puedes usar:

```bash
pip install -r requirements.txt
```

## Archivos importantes:

- `create_database.sql`: Contiene las sentencias SQL para crear la estructura de la base de datos..
- `test_data.sql`: Contiene datos de prueba para poblar la base de datos.

## Comandos útiles

- Levantar los contenedores: `docker-compose up --build`.
- Detener los contenedores: `docker-compose down`.
- Ejecutar comandos dentro del contenedor de la API: `docker exec -it innovation-platform-api /bin/bash`.
- Ejecutar comandos dentro del contenedor de la base de datos: `docker exec -it innovation-platform-db /bin/bash`.
