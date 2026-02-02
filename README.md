# tike-api-docker
Docker for dev tike API

## Descripción

Este repositorio contiene la configuración de Docker Compose para desarrollar la API de Tike con Laravel y MySQL.

## Requisitos

- Docker
- Docker Compose

## Estructura del Proyecto

```
tike-api-docker/
├── docker-compose.yml      # Configuración de servicios Docker
├── Dockerfile              # Imagen de PHP/Laravel
├── nginx/                  # Configuración de Nginx
│   └── default.conf
├── mysql/                  # Configuración de MySQL
│   └── init/              # Scripts de inicialización de base de datos
├── .env.example           # Variables de entorno de ejemplo
└── tike-api/              # Proyecto Laravel (no incluido en el repositorio)
```

## Instalación y Configuración

### 1. Clonar el repositorio

```bash
git clone <repository-url>
cd tike-api-docker
```

### 2. Configurar variables de entorno

Copia el archivo de ejemplo y configura tus variables:

```bash
cp .env.example .env
```

Edita el archivo `.env` según tus necesidades:

```env
DB_DATABASE=tike_db
DB_ROOT_PASSWORD=root
DB_USERNAME=tike_user
DB_PASSWORD=secret
DB_PORT=3306
APP_PORT=8000
```

### 3. Crear el proyecto Laravel

Crea un nuevo proyecto Laravel en la carpeta `tike-api`:

```bash
# Opción 1: Crear nuevo proyecto Laravel
docker run --rm -v $(pwd):/app composer create-project laravel/laravel tike-api

# Opción 2: Si ya tienes un proyecto Laravel, simplemente cópialo o clónalo en la carpeta tike-api
```

### 4. Configurar Laravel para usar Docker

Edita el archivo `tike-api/.env` con la configuración de la base de datos:

```env
DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=tike_db
DB_USERNAME=tike_user
DB_PASSWORD=secret
```

### 5. Iniciar los contenedores

```bash
docker-compose up -d
```

### 6. Instalar dependencias de Laravel (si es necesario)

```bash
docker-compose exec app composer install
```

### 7. Generar la clave de la aplicación

```bash
docker-compose exec app php artisan key:generate
```

### 8. Ejecutar migraciones

```bash
docker-compose exec app php artisan migrate
```

## Uso

### Acceder a la aplicación

La aplicación estará disponible en: `http://localhost:8000`

### Comandos útiles

```bash
# Ver logs
docker-compose logs -f

# Acceder al contenedor de la aplicación
docker-compose exec app bash

# Acceder a MySQL
docker-compose exec mysql mysql -u tike_user -p

# Ejecutar comandos Artisan
docker-compose exec app php artisan <comando>

# Ejecutar Composer
docker-compose exec app composer <comando>

# Detener los contenedores
docker-compose down

# Detener y eliminar volúmenes
docker-compose down -v
```

## Servicios

### MySQL
- **Puerto:** 3306 (configurable en .env)
- **Base de datos:** tike_db
- **Usuario:** tike_user
- **Contraseña:** secret

### Nginx
- **Puerto:** 8000 (configurable en .env)
- Sirve la aplicación Laravel

### App (PHP-FPM)
- PHP 8.2
- Extensiones: PDO, MySQL, GD, Zip, Mbstring, etc.
- Composer incluido

## Notas

- La carpeta `tike-api` está excluida del repositorio mediante `.gitignore`
- Los datos de MySQL se persisten en un volumen Docker
- Puedes colocar scripts SQL de inicialización en `mysql/init/` para que se ejecuten automáticamente

## Troubleshooting

### Permisos en Linux

Si tienes problemas de permisos con la carpeta `tike-api`:

```bash
sudo chown -R $USER:$USER tike-api
```

### Limpiar todo y empezar de nuevo

```bash
docker-compose down -v
docker system prune -a
# Luego volver a ejecutar docker-compose up -d
```
