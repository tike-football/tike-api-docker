# tike-api-docker
Docker setup for Tike API development with Laravel and MySQL.

## Requirements
- Docker Desktop
- The Laravel code must live in `tike-api/` (this repo ignores it in git).

## How to run
1. Put the Laravel project inside `tike-api/`.
2. Start the services:
   ```bash
   docker compose up --build
   ```
3. Open the app at `http://localhost:8080`.

## Services
- `app`: PHP-FPM 8.2 with Laravel-required extensions.
- `nginx`: HTTP proxy on `http://localhost:8080`.
- `mysql`: MySQL 8.0 database.

## Expected Laravel environment variables
Set these values in `tike-api/.env`:
```
DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=tike
DB_USERNAME=tike
DB_PASSWORD=tike
```

## Queue Workers

### View application logs in real-time:
```bash
docker compose exec app tail -f storage/logs/laravel.log
```

### Run the queue worker for the "emails" queue:
```bash
docker compose exec app php artisan queue:work --queue=emails --verbose
```

### Run the queue worker with retry attempts:
```bash
docker compose exec app php artisan queue:work --queue=emails --verbose --tries=3
```

### Recommended for development (auto-reloads on code changes):
```bash
docker compose exec app php artisan queue:listen --queue=emails --verbose --tries=3 --timeout=60
```
