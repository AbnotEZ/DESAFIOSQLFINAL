Requerimientos

CREATE DATABASE final_fernando_munoz_123;

\c final_fernando_munoz_123;



1.- Crea el modelo (revisa bien cuál es el tipo de relación antes de crearlo), respeta las
claves primarias, foráneas y tipos de datos. 

-- TABLA PELICULAS
CREATE TABLE Peliculas (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(255),
  anno INTEGER
);

-- TABLA TAGS
CREATE TABLE tags (id SERIAL PRIMARY KEY, tag VARCHAR(32));

-- TABLA INTERMEDIA N-N
CREATE TABLE pelicula_tags (
  pelicula_id BIGINT,
  tag_id BIGINT,
  FOREIGN KEY (pelicula_id) REFERENCES peliculas (id),
  FOREIGN KEY (tag_id) REFERENCES tags (id)
);

2.-  Inserta 5 películas y 5 tags, la primera película tiene que tener 3 tags asociados, la
segunda película debe tener dos tags asociados

--Peliculas
INSERT INTO peliculas (nombre, anno) VALUES('Mad Max: Fury Road', 2015);
INSERT INTO peliculas (nombre, anno) VALUES('Space Jam: El Juego del Siglo', 1996);
INSERT INTO peliculas (nombre, anno) VALUES('AVATAR', 2009);
INSERT INTO peliculas (nombre, anno) VALUES('Jurasic Park', 1993);
INSERT INTO peliculas (nombre, anno) VALUES('Blade: Cazador de Vampiros', 1998);

--Tags
INSERT INTO tags (tag) VALUES ('Accion');
INSERT INTO tags (tag) VALUES ('Comedia');
INSERT INTO tags (tag) VALUES ('Drama');
INSERT INTO tags (tag) VALUES ('Terror');
INSERT INTO tags (tag) VALUES ('Suspenso');

--Tabla Intemedia Peliculas_tags
INSERT INTO pelicula_tags (pelicula_id, tag_id) VALUES (1,1);
INSERT INTO pelicula_tags (pelicula_id, tag_id) VALUES (1,3);
INSERT INTO pelicula_tags (pelicula_id, tag_id) VALUES (1,4);
INSERT INTO pelicula_tags (pelicula_id, tag_id) VALUES (2,1);
INSERT INTO pelicula_tags (pelicula_id, tag_id) VALUES (2,2);

3.- Cuenta la cantidad de tags que tiene cada película. Si una película no tiene tags debe
mostrar 0.

SELECT peliculas.nombre,
count(pelicula_tags.tag_id)
FROM peliculas
LEFT JOIN pelicula_tags on peliculas.id = pelicula_tags.pelicula_id
GROUP BY peliculas.nombre;

