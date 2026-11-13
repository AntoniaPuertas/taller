-- Taller Mecánico Genil: clientes, vehículos, mecánicos, reparaciones y piezas (práctica de diseño PD2)
-- IFCD0210 · UF1845 · Base de datos para MySQL 8.4 (WAMP)
-- Importar en phpMyAdmin: pestaña «Importar», elegir este archivo y pulsar «Importar».
-- Crea la base de datos `taller` (si ya existía, la borra y la vuelve a crear).

DROP DATABASE IF EXISTS taller;
CREATE DATABASE taller CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci;
USE taller;

CREATE TABLE clientes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(40) NOT NULL,
  apellidos VARCHAR(60) NOT NULL,
  telefono VARCHAR(15) NOT NULL,
  email VARCHAR(100) UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

CREATE TABLE vehiculos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  matricula VARCHAR(10) NOT NULL UNIQUE,
  marca VARCHAR(30) NOT NULL,
  modelo VARCHAR(30) NOT NULL,
  anio INT,
  cliente_id INT NOT NULL,
  FOREIGN KEY (cliente_id) REFERENCES clientes(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

CREATE TABLE mecanicos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(40) NOT NULL,
  especialidad VARCHAR(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

CREATE TABLE reparaciones (
  id INT AUTO_INCREMENT PRIMARY KEY,
  vehiculo_id INT NOT NULL,
  mecanico_id INT NOT NULL,
  fecha_entrada DATE NOT NULL,
  fecha_salida DATE,
  descripcion VARCHAR(200) NOT NULL,
  mano_obra DECIMAL(7,2) NOT NULL,
  FOREIGN KEY (vehiculo_id) REFERENCES vehiculos(id),
  FOREIGN KEY (mecanico_id) REFERENCES mecanicos(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

CREATE TABLE piezas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  referencia VARCHAR(20) NOT NULL UNIQUE,
  nombre VARCHAR(60) NOT NULL,
  precio DECIMAL(7,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

CREATE TABLE reparacion_piezas (
  reparacion_id INT NOT NULL,
  pieza_id INT NOT NULL,
  cantidad INT NOT NULL CHECK (cantidad > 0),
  PRIMARY KEY (reparacion_id, pieza_id),
  FOREIGN KEY (reparacion_id) REFERENCES reparaciones(id),
  FOREIGN KEY (pieza_id) REFERENCES piezas(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO clientes (id, nombre, apellidos, telefono, email) VALUES
  (1, 'Antonio', 'Pérez Lara', '611000001', 'antonio@correo.es'),
  (2, 'Carmen', 'Ruiz Moreno', '611000002', NULL),
  (3, 'Javier', 'Ortega Núñez', '611000003', 'javier@correo.es'),
  (4, 'Lucía', 'Herrera Díaz', '611000004', 'lucia@correo.es'),
  (5, 'Pedro', 'Campos Gil', '611000005', NULL),
  (6, 'María', 'Vidal Soto', '611000006', 'maria@correo.es');

INSERT INTO vehiculos (id, matricula, marca, modelo, anio, cliente_id) VALUES
  (1, '1234 BCD', 'Seat', 'Ibiza', 2015, 1),
  (2, '5678 FGH', 'Renault', 'Clio', 2018, 2),
  (3, '9012 JKL', 'Toyota', 'Corolla', 2020, 3),
  (4, '3456 MNP', 'Ford', 'Focus', 2012, 1),
  (5, '7890 RST', 'Peugeot', '208', 2021, 4),
  (6, '2468 VWX', 'Volkswagen', 'Golf', 2016, 3),
  (7, '1357 YZB', 'Citroën', 'C3', 2019, 5),
  (8, '8642 CDF', 'Kia', 'Ceed', 2022, 6);

INSERT INTO mecanicos (id, nombre, especialidad) VALUES
  (1, 'Raúl', 'motor'),
  (2, 'Elena', 'electricidad'),
  (3, 'Sergio', 'chapa y pintura'),
  (4, 'Nuria', 'frenos y suspensión');

INSERT INTO reparaciones (id, vehiculo_id, mecanico_id, fecha_entrada, fecha_salida, descripcion, mano_obra) VALUES
  (1, 1, 1, '2026-09-02', '2026-09-04', 'Cambio de aceite y filtro', 30),
  (2, 2, 4, '2026-09-10', '2026-09-11', 'Cambio de pastillas de freno', 45),
  (3, 3, 1, '2026-09-15', '2026-09-18', 'Revisión de los 60 000 km', 80),
  (4, 4, 2, '2026-10-01', '2026-10-03', 'Batería descargada', 20),
  (5, 5, 4, '2026-10-08', '2026-10-09', 'Amortiguadores delanteros', 90),
  (6, 1, 4, '2026-10-20', '2026-10-21', 'Ruido al frenar', 25),
  (7, 6, 1, '2026-11-03', NULL, 'Fallo de inyección', 60),
  (8, 3, 2, '2026-11-06', NULL, 'Luces delanteras', 15);

INSERT INTO piezas (id, referencia, nombre, precio) VALUES
  (1, 'ACE-5W30', 'Aceite 5W30 (litro)', 9.50),
  (2, 'FIL-ACE', 'Filtro de aceite', 12.00),
  (3, 'FIL-AIR', 'Filtro de aire', 15.00),
  (4, 'PAS-DEL', 'Pastillas de freno delanteras', 48.00),
  (5, 'BAT-70', 'Batería 70 Ah', 95.00),
  (6, 'AMO-DEL', 'Amortiguador delantero', 72.50),
  (7, 'LAM-H7', 'Lámpara H7', 8.75),
  (8, 'ESC-LIM', 'Escobilla limpiaparabrisas', 11.00),
  (9, 'LIQ-REF', 'Líquido refrigerante', 14.00);

INSERT INTO reparacion_piezas (reparacion_id, pieza_id, cantidad) VALUES
  (1, 1, 4), (1, 2, 1),
  (2, 4, 1),
  (3, 1, 4), (3, 2, 1), (3, 3, 1),
  (4, 5, 1),
  (5, 6, 2),
  (7, 3, 1),
  (8, 7, 2);
