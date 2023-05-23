drop database Netflix;

CREATE DATABASE IF NOT EXISTS Netflix;
USE Netflix;

CREATE TABLE IF NOT EXISTS Peliculas(
	id_peli int,
    nombre_peli VARCHAR(30),
    duracion INT,
    director_peli VARCHAR(20),
    género_peli ENUM ('acción', 'drama', 'comedia'),
    nota_peli FLOAT,
    primary key (id_peli)
);

INSERT INTO Peliculas (nombre_peli, duracion, director_peli, género_peli, nota_peli, id_peli) VALUES
('Bright', 120, 'Fernando', 'acción', 3.1, 1),
('Frida', 100, 'Daniel', 'drama', 7.6, 10),
('Los dos papas', 160, 'Adrián', 'comedia', 8.3, 11),
('Animales nocturnos', 185, 'Tomás', 'drama', 9.5, 100),
('Oceans Eleven', 150, 'Nuria', 'acción', 3.5, 21),
('Buscando a Nemo', 120, 'Jon', 'acción', 2.1, 17),
('El Hoyo', 110, 'Ivan', 'acción', 9.9, 41),
('Diamante en bruto', 140, 'Paola', 'acción', 7, 101);

/*Ejercicio 1.- Realiza un procedimiento donde se inserte una nueva película a la tabla “Peliculas” con
los datos expuestos. Una vez hecho esto, haz que en el propio procedimiento se muestre la tabla resultante.
- Nombre película: La historia interminable
- Duración: 110
- Director: Barbara
- Género: acción
- Nota: 8
- Identificador: 3*/

drop procedure ej1;

delimiter //
create procedure ej1()
begin
INSERT INTO Peliculas (id_peli, nombre_peli, duracion, director_peli, género_peli, nota_peli) VALUES
(3, "La historia interminable",110, "Barbara", "acción", 8);
select * from Peliculas;
end//

call ej1();

/*Ejercicio 2.- Realiza un procedimiento que modifique la nota de una película. El nombre de la película y
 la nota se insertarán a través del Select. Una vez hecho esto, haz que en el propio procedimiento se muestre
 la tabla resultante.*/
 
 drop procedure ej2;
 
 delimiter //
 create procedure ej2(nom varchar(150), nota float)
 begin 
update Peliculas set nota_peli=nota where nombre_peli=nom;
select * from Peliculas;
end//
 
 call ej2('Los dos papas', 8.5);
 
 /*Ejercicio 3.- Realiza un procedimiento que añada valores de forma automática a nueva columna llamada
 “Valoraciones” en la tabla películas. La columna Valoraciones podrá tener 3 valores (buena, mala o regular).
- Si la nota de la película es menor que 3.5, la valoración será “mala”
- Si la nota de la película es mayor que 7, la valoración será “buena”
- Si la nota de la película está entre 3.5 y 7 (ambos incluidos), la valoración será “regular”*/


drop procedure ej3;

delimiter //
create procedure ej3()
begin 
alter table Peliculas add column valoracion enum("buena", "mala", "regular");

update Peliculas set valoracion="mala" where nota_peli <3.5;
update Peliculas set valoracion="buena" where nota_peli > 7;
update Peliculas set valoracion="regular"where nota_peli >=3.5 and nota_peli <=7;
select * from peliculas;
end//

call ej3();

/*Ejercicio 4.- Realiza un procedimiento que modifique el director/directora de una película
 seleccionada por el usuario de la tabla Películas. Una vez hecho esto, haz que en el propio
 procedimiento se muestre la tabla resultante.
- El usuario insertará el identificador de la pelícila que desea modificar a través del Select
- El usuario insertará el nombre del director a través del select
*/

drop procedure ej4;

delimiter //
create procedure ej4(ID int, Director varchar(150))
begin 

update Peliculas set director_peli=Director where id_peli=ID;

select * from Peliculas;
end//

call ej4(101, "M. Rajoy");