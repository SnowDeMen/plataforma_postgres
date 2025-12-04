-- Script de inicializacion de PostgreSQL
-- Se ejecuta automaticamente al crear la base de datos por primera vez
--
-- Las tablas se crean automaticamente via SQLAlchemy (init_db),
-- pero este script garantiza que las extensiones necesarias esten habilitadas.

-- Habilitar extension para UUIDs (opcional, por si se necesita en el futuro)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Configurar timezone por defecto
SET timezone = 'UTC';

-- Mensaje de confirmacion
DO $$
BEGIN
    RAISE NOTICE 'Base de datos inicializada correctamente';
END $$;

