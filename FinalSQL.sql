REQUERIMIENTOS

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
segunda película debe tener dos tags asociados.

--Peliculas
INSERT INTO peliculas (nombre, anno) VALUES('Mad Max: Fury Road', 2015);
INSERT INTO peliculas (nombre, anno) VALUES('Space Jam: El Juego del Siglo', 1996);
INSERT INTO peliculas (nombre, anno) VALUES('AVATAR', 2009);
INSERT INTO peliculas (nombre, anno) VALUES('Jurasic Park', 1993);
INSERT INTO peliculas (nombre, anno) VALUES('Blade: Cazador de Vampiros', 1998);

SELECT * FROM peliculas;

--Tags
INSERT INTO tags (tag) VALUES ('Accion');
INSERT INTO tags (tag) VALUES ('Comedia');
INSERT INTO tags (tag) VALUES ('Drama');
INSERT INTO tags (tag) VALUES ('Terror');
INSERT INTO tags (tag) VALUES ('Suspenso');

SELECT * FROM tags;

--Tabla Intemedia Peliculas_tags
INSERT INTO pelicula_tags (pelicula_id, tag_id) VALUES (1,1);
INSERT INTO pelicula_tags (pelicula_id, tag_id) VALUES (1,3);
INSERT INTO pelicula_tags (pelicula_id, tag_id) VALUES (1,4);
INSERT INTO pelicula_tags (pelicula_id, tag_id) VALUES (2,1);
INSERT INTO pelicula_tags (pelicula_id, tag_id) VALUES (2,2);

SELECT * FROM pelicula_tags;


3.- Cuenta la cantidad de tags que tiene cada película. Si una película no tiene tags debe
mostrar 0.

SELECT peliculas.nombre,
COUNT(pelicula_tags.tag_id)
FROM peliculas
LEFT JOIN pelicula_tags on peliculas.id = pelicula_tags.pelicula_id
GROUP BY peliculas.nombre;

4.- Crea las tablas respetando los nombres, tipos, claves primarias y foráneas y tipos de
datos. 

-- TABLA PREGUNTAS
CREATE TABLE preguntas (
id SERIAL PRIMARY KEY,
pregunta VARCHAR(255),
respuesta_correcta VARCHAR
);


--TABLA USUARIOS
CREATE TABLE usuarios(
id SERIAL PRIMARY key,
nombre VARCHAR(255),
edad INTEGER
);

--TABLA RESPUESTAS
CREATE TABLE respuestas (
id SERIAL PRIMARY KEY,
respuesta VARCHAR(255),
usuario_id BIGINT,
pregunta_id BIGINT,
FOREIGN KEY (usuario_id) REFERENCES usuarios (id),
FOREIGN KEY (pregunta_id) REFERENCES preguntas (id)
);

5.- Agrega datos, 5 usuarios y 5 preguntas, la primera pregunta debe estar contestada
dos veces correctamente por distintos usuarios, la pregunta 2 debe estar contestada
correctamente sólo por un usuario, y las otras 2 respuestas deben estar incorrectas.

--INSERT TABLA USUARIOS
INSERT INTO usuarios (nombre, edad) VALUES ('Fernando',30);
INSERT INTO usuarios (nombre, edad) VALUES ('Valeria',29);
INSERT INTO usuarios (nombre, edad) VALUES ('Renato',25);
INSERT INTO usuarios (nombre, edad) VALUES ('Rafaella',20);
INSERT INTO usuarios (nombre, edad) VALUES ('Maria',53);

--INSERT TABLA PREGUNTAS
INSERT INTO preguntas (pregunta, respuesta_correcta) VALUES ('Cuantos minutos tiene una hora', '60 minutos' );
INSERT INTO preguntas (pregunta, respuesta_correcta) VALUES ('Cuantas patas tiene una araña', '8 patas' );
INSERT INTO preguntas (pregunta, respuesta_correcta) VALUES ('Cual es el rio mas caudaloso del mundo', 'El Amazonas' );
INSERT INTO preguntas (pregunta, respuesta_correcta) VALUES ('Cada cuantos años tenemos un año bisiesto', 'Cada cuatro años' );
INSERT INTO preguntas (pregunta, respuesta_correcta) VALUES ('Que planeta es el mas cercano al sol', 'Mercurio' );

--INSERT TABLA RESPUESTAS
INSERT INTO respuestas (respuesta, usuario_id, pregunta_id ) VALUES('60 minutos',1,1);
INSERT INTO respuestas (respuesta, usuario_id, pregunta_id ) VALUES('60 minutos',2,1);
INSERT INTO respuestas (respuesta, usuario_id, pregunta_id ) VALUES('8 patas',3,2);
INSERT INTO respuestas (respuesta, usuario_id, pregunta_id ) VALUES('Nilo',4,3);
INSERT INTO respuestas (respuesta, usuario_id, pregunta_id ) VALUES('Loa',5,3);

6.- Cuenta la cantidad de respuestas correctas totales por usuario (independiente de la
pregunta)

SELECT usuarios.nombre,
COUNT(preguntas.respuesta_correcta) AS correctas
FROM preguntas
RIGHT JOIN respuestas ON respuestas.respuesta = preguntas.respuesta_correcta
JOIN usuarios ON usuarios.id = respuestas.usuario_id
GROUP BY usuario_id, usuarios.nombre;

7.- Por cada pregunta, en la tabla preguntas, cuenta cuántos usuarios tuvieron la
respuesta correcta. 

SELECT preguntas.pregunta,
COUNT(respuestas.usuario_id) AS correctas
FROM respuestas
RIGHT JOIN preguntas ON respuestas.pregunta_id = preguntas.id
GROUP BY preguntas.pregunta;

8.- Implementa borrado en cascada de las respuestas al borrar un usuario y borrar el
primer usuario para probar la implementación.

ALTER TABLE respuestas 
DROP CONSTRAINT respuestas_usuario_id_fkey, 
ADD FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE;

DELETE FROM usuarios WHERE id = 1;

9.- Crea una restricción que impida insertar usuarios menores de 18 años en la base de
datos.

ALTER TABLE usuarios ADD CHECK (edad > 18); 

10.- Altera la tabla existente de usuarios agregando el campo email con la restricción de
único

ALTER TABLE usuarios ADD email VARCHAR(50) UNIQUE;



VIDEO TRABAJO https://www.youtube.com/watch?v=L__5PANAsNY