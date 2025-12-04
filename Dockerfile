# Dockerfile para PostgreSQL
# Servicio de base de datos para la plataforma de entrenamientos

FROM postgres:16-alpine

# Etiquetas de metadatos
LABEL maintainer="Training Platform"
LABEL description="PostgreSQL para plataforma de entrenamientos"

# Variables de entorno por defecto (sobreescribir en produccion)
ENV POSTGRES_USER=training_user
ENV POSTGRES_PASSWORD=training_pass
ENV POSTGRES_DB=training_db
ENV PGDATA=/var/lib/postgresql/data/pgdata

# Copiar scripts de inicializacion (se ejecutan al crear la BD)
COPY init/ /docker-entrypoint-initdb.d/

# Puerto por defecto de PostgreSQL
EXPOSE 5432

# Healthcheck para verificar que PostgreSQL esta listo
HEALTHCHECK --interval=10s --timeout=5s --start-period=30s --retries=5 \
    CMD pg_isready -U ${POSTGRES_USER} -d ${POSTGRES_DB} || exit 1

