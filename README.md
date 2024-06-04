# Innovation Platform API

Este proyecto es una API construida con FastAPI y MySQL, dockerizada para facilitar su despliegue.

## Requisitos

- [Python 3.12](https://www.python.org/downloads/release/python-3123/)
- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Instalación

### 1. Clonar el repositorio

```bash
git clone https://github.com/EstebanP-dev/InnovationPlatformAPI.git
cd InnovationPlatformAPI
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

Tener en cuenta que los valores de `MYSQL_USERNAME`, `MYSQL_PASSWORD`, `MYSQL_HOST`, `MYSQL_PORT` y `MYSQL_DATABASE` deben coincidir con los valores de las variables de entorno del archivo `docker-compose.yml`. Es decir, si cambias los valores de las variables de entorno en el archivo `docker-compose.yml`, también debes cambiar los valores correspondientes en el archivo `.env`. Por otro lado, el `MYSQL_HOST` debe ser el nombre del servicio de la base de datos en el archivo `docker-compose.yml`.

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
docker exec -i INNP.Database mysql -u root -proot innovation_platform < /create_db.sql
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
- `test_data.sql`: Contiene datos de prueba para poblar la base de datos. Tener en cuenta que estos datos fueron realizados para una prueba local. Por temas de `SECRET_KEY`, las contraseñas de los usuarios, no podrán ser verificadas en la API.

## Comandos útiles

- Levantar los contenedores: `docker-compose up --build`.
- Detener los contenedores: `docker-compose down`.
- Ejecutar comandos dentro del contenedor de la API: `docker exec -it innovation-platform-api /bin/bash`.
- Ejecutar comandos dentro del contenedor de la base de datos: `docker exec -it innovation-platform-db /bin/bash`.
