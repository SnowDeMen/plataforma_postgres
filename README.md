# PostgreSQL - Servicio de Base de Datos

Servicio PostgreSQL independiente para la plataforma de entrenamientos.

## Despliegue en EasyPanel

### 1. Crear el Servicio

1. En EasyPanel, crear nuevo servicio desde este directorio
2. Configurar las variables de entorno:

```
POSTGRES_USER=training_user
POSTGRES_PASSWORD=<password_seguro>
POSTGRES_DB=training_db
```

### 2. Configurar el Backend

En el servicio backend, agregar la variable `DATABASE_URL`:

```
DATABASE_URL=postgresql+asyncpg://training_user:<password>@postgres:5432/training_db
```

> **Nota**: Reemplaza `postgres` con el nombre del servicio si es diferente.

## Desarrollo Local

```bash
cd postgres

# Copiar variables de entorno
cp env.example .env

# Editar .env con tus credenciales
# ...

# Iniciar PostgreSQL
docker compose up -d

# Ver logs
docker compose logs -f

# Conectarse a la base de datos
docker compose exec postgres psql -U training_user -d training_db
```

## Estructura

```
postgres/
├── Dockerfile              # Imagen de PostgreSQL
├── docker-compose.yml      # Configuracion del servicio
├── env.example             # Template de variables
├── README.md               # Este archivo
└── init/
    └── 01-init-schema.sql  # Script de inicializacion
```

## Backups

### Crear backup manual

```bash
docker compose exec postgres pg_dump -U training_user training_db > backup.sql
```

### Restaurar backup

```bash
docker compose exec -T postgres psql -U training_user training_db < backup.sql
```

## Variables de Entorno

| Variable | Descripcion | Valor por defecto |
|----------|-------------|-------------------|
| `POSTGRES_USER` | Usuario de la BD | `training_user` |
| `POSTGRES_PASSWORD` | Password del usuario | (requerido) |
| `POSTGRES_DB` | Nombre de la BD | `training_db` |

## Conexion desde el Backend

El backend se conecta usando la URL:

```
postgresql+asyncpg://<user>:<password>@<host>:5432/<database>
```

En EasyPanel, el `<host>` es el nombre del servicio (por defecto `postgres`).

