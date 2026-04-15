-- Base de datos MyraFit
-- Ejecutar este script en MySQL Workbench

CREATE DATABASE IF NOT EXISTS myrafit;
USE myrafit;

-- Tabla de usuarios
CREATE TABLE IF NOT EXISTS usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

-- Tabla de rutinas
CREATE TABLE IF NOT EXISTS rutinas (
    id_rutina INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    objetivo VARCHAR(50) NOT NULL,
    nivel VARCHAR(20) NOT NULL,
    duracion INT NOT NULL,
    descripcion TEXT
);

-- Tabla de entrenamientos
CREATE TABLE IF NOT EXISTS entrenamientos (
    id_entrenamiento INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    fecha DATE NOT NULL,
    duracion INT NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    notas TEXT,
    id_rutina INT,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_rutina) REFERENCES rutinas(id_rutina) ON DELETE SET NULL
);

-- Tabla de habitos
CREATE TABLE IF NOT EXISTS habitos (
    id_habito INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    fecha DATE NOT NULL,
    horas_sueno DECIMAL(4,2) NOT NULL,
    pasos INT NOT NULL,
    agua DECIMAL(4,2) NOT NULL,
    energia INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

-- Tabla de ciclo menstrual
CREATE TABLE IF NOT EXISTS ciclo_menstrual (
    id_ciclo INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    fecha DATE NOT NULL,
    fase VARCHAR(20) NOT NULL,
    notas TEXT,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

-- Usuario administrador (contraseña: admin123)
-- Hash BCrypt: $2a$10$XkQ4.Q7Z3lK9R5V6jX8tLuB.Y3G5p7R8n0m1S2cT3uV4wX5yZ6a
INSERT INTO usuarios (nombre, email, password) VALUES 
('Administrador', 'admin@myrafit.com', '$2a$10$XkQ4.Q7Z3lK9R5V6jX8tLuB.Y3G5p7R8n0m1S2cT3uV4wX5yZ6a');
