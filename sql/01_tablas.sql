/* Base de datos para control de ayudas humanitarias */
CREATE DATABASE ayudas_humanitarias;
USE ayudas_humanitarias;

/* Barrios */
CREATE TABLE barrio (
    id INTEGER PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    estado VARCHAR(50)
);

/* Persona de contacto del hogar */
CREATE TABLE persona_contacto (
    id INTEGER PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    tipo_documento VARCHAR(20),
    numero_documento VARCHAR(30),
    telefono VARCHAR(20)
);

/* Condiciones de prioridad */
CREATE TABLE condicion_prioridad (
    id INTEGER PRIMARY KEY,
    embarazadas INTEGER,
    ninos INTEGER,
    discapacitados INTEGER,
    adultos_mayores INTEGER
);

/* Tipos de necesidad */
CREATE TABLE necesidad (
    id INTEGER PRIMARY KEY,
    categoria VARCHAR(100) NOT NULL
);

/* Tipos de ayuda */
CREATE TABLE tipo_ayuda (
    id INTEGER PRIMARY KEY,
    categoria VARCHAR(100) NOT NULL,
    nombre_articulo VARCHAR(100) NOT NULL
);

/* Donantes */
CREATE TABLE donante (
    id INTEGER PRIMARY KEY,
    tipo_donante VARCHAR(50),
    nombre VARCHAR(100) NOT NULL
);

/* Jornadas de entrega */
CREATE TABLE jornada_entrega (
    id INTEGER PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    fecha DATE NOT NULL,
    lugar VARCHAR(100),
    descripcion VARCHAR(255),
    estado VARCHAR(50)
);

/* Puntos de atencion */
CREATE TABLE punto_atencion (
    id INTEGER PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    ubicacion VARCHAR(255)
);

/* Hogares */
CREATE TABLE hogar (
    id INTEGER PRIMARY KEY,
    id_persona_contacto INTEGER,
    id_barrio INTEGER,
    id_condicion_prioridad INTEGER,
    cantidad_personas INTEGER NOT NULL,
    tipo_zona VARCHAR(20) NOT NULL,
    division_territorial VARCHAR(100) NOT NULL,
    referencia_ubicacion VARCHAR(255)
);

/* Reportes de necesidades */
CREATE TABLE reporte (
    id INTEGER PRIMARY KEY,
    id_hogar INTEGER NOT NULL,
    id_necesidad INTEGER NOT NULL,
    id_condicion_prioridad INTEGER,
    cantidad INTEGER,
    observacion VARCHAR(255),
    fecha DATE NOT NULL,
    nivel_urgencia VARCHAR(20),
    estado VARCHAR(20)
);

/* Inventario de ayudas */
CREATE TABLE inventario (
    id INTEGER PRIMARY KEY,
    id_tipo_ayuda INTEGER NOT NULL,
    cantidad INTEGER NOT NULL,
    disponible INTEGER NOT NULL
);

/* Donaciones */
CREATE TABLE donacion (
    id INTEGER PRIMARY KEY,
    id_donante INTEGER NOT NULL,
    fecha DATE NOT NULL
);

/* Detalle de las donaciones */
CREATE TABLE detalle_donacion (
    id INTEGER PRIMARY KEY,
    id_donacion INTEGER NOT NULL,
    id_tipo_ayuda INTEGER NOT NULL,
    cantidad INTEGER NOT NULL,
    unidad_medida VARCHAR(30),
    id_inventario INTEGER
);

/* Seleccion de ayudas para un reporte */
CREATE TABLE seleccion_ayuda (
    id INTEGER PRIMARY KEY,
    id_reporte INTEGER NOT NULL,
    id_inventario INTEGER NOT NULL,
    cantidad INTEGER NOT NULL,
    id_punto_atencion INTEGER
);

/* Entregas */
CREATE TABLE entrega (
    id INTEGER PRIMARY KEY,
    id_punto_atencion INTEGER NOT NULL,
    id_jornada_entrega INTEGER NOT NULL
);

/* Llaves foraneas */
ALTER TABLE hogar ADD FOREIGN KEY (id_persona_contacto) REFERENCES persona_contacto(id);
ALTER TABLE hogar ADD FOREIGN KEY (id_barrio) REFERENCES barrio(id);
ALTER TABLE hogar ADD FOREIGN KEY (id_condicion_prioridad) REFERENCES condicion_prioridad(id);

ALTER TABLE reporte ADD FOREIGN KEY (id_hogar) REFERENCES hogar(id);
ALTER TABLE reporte ADD FOREIGN KEY (id_necesidad) REFERENCES necesidad(id);
ALTER TABLE reporte ADD FOREIGN KEY (id_condicion_prioridad) REFERENCES condicion_prioridad(id);

ALTER TABLE inventario ADD FOREIGN KEY (id_tipo_ayuda) REFERENCES tipo_ayuda(id);

ALTER TABLE donacion ADD FOREIGN KEY (id_donante) REFERENCES donante(id);

ALTER TABLE detalle_donacion ADD FOREIGN KEY (id_donacion) REFERENCES donacion(id);
ALTER TABLE detalle_donacion ADD FOREIGN KEY (id_tipo_ayuda) REFERENCES tipo_ayuda(id);
ALTER TABLE detalle_donacion ADD FOREIGN KEY (id_inventario) REFERENCES inventario(id);

ALTER TABLE seleccion_ayuda ADD FOREIGN KEY (id_reporte) REFERENCES reporte(id);
ALTER TABLE seleccion_ayuda ADD FOREIGN KEY (id_inventario) REFERENCES inventario(id);
ALTER TABLE seleccion_ayuda ADD FOREIGN KEY (id_punto_atencion) REFERENCES punto_atencion(id);

ALTER TABLE entrega ADD FOREIGN KEY (id_punto_atencion) REFERENCES punto_atencion(id);
ALTER TABLE entrega ADD FOREIGN KEY (id_jornada_entrega) REFERENCES jornada_entrega(id);
