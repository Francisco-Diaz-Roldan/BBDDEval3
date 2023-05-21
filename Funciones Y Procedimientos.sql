/*Ejercicios de funciones y procedimientos

Realiza los siguientes ejercicios de funciones y procedimientos a través del Workbench de MySQL. 
Utiliza la tabla Netflix para realizar los ejercicios propuestos.*/

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

CREATE TABLE IF NOT EXISTS Actores(
	id_actor INT,
    nombre VARCHAR(30),
    fecha_nac DATE,
    sueldo INT,
    sexo ENUM ('femenino', 'masculino', 'otros'),
    primary key (id_actor)
);

INSERT INTO Actores(id_actor, nombre, fecha_nac, sueldo, sexo) VALUES
(101, 'Leonarno', '1980/12/01' , 3000000, 'masculino'),
(102, 'Julia', '1997/09/09' , 1000000, 'femenino'),
(103, 'Brad', '1983/02/02' , 700000, 'masculino'),
(104, 'Carlos', '1986/03/03' , 250000, 'masculino'),
(105, 'Santiago', '1970/04/04' , 4000000, 'masculino'),
(106, 'Penelope', '1976/05/05' , 23000, 'femenino'),
(107, 'Noa', '1981/06/06' , 770000, 'otros'),
(108, 'Jon', '1996/07/07' , 6000, 'otros');

INSERT INTO Peliculas (nombre_peli, duracion, director_peli, género_peli, nota_peli, id_peli) VALUES
('Bright', 120, 'Fernando', 'acción', 3.1, 1),
('Frida', 100, 'Daniel', 'drama', 7.6, 2),
('Los dos papas', 160, 'Adrián', 'comedia', 8.3, 3),
('Animales nocturnos', 185, 'Tomás', 'drama', 9.5, 4),
('Oceans Eleven', 150, 'Nuria', 'acción', 3.5, 5),
('Buscando a Nemo', 120, 'Jon', 'acción', 2.1, 6),
('El Hoyo', 110, 'Ivan', 'acción', 9.9, 7),
('Diamante en bruto', 140, 'Paola', 'acción', 7, 8);


/*Ejercicio 1.- Crea un procedimiento que modifique la puntuación de la película “Buscando a Nemo” 
  sumándole un punto a su puntuación establecida. Muestra la tabla resultante al finalizar el procedimiento.

	- Realiza la suma del punto mediante la función “Sumapunto” e intégrala en el procedimiento
	- En el procedimiento deberás insertar solo el nombre de la película

	*Las funciones NO realizarán ninguna modificación en las tablas*/

drop procedure nemo;
drop function sumapunto;

delimiter //
create procedure nemo(nombre varchar(30))
begin
declare nota_nemo float;
declare nota_nemo2 float;
set nota_nemo =(select nota_peli from peliculas where nombre_peli= nombre);
set nota_nemo2=(select sumapunto(nota_nemo));
update Peliculas set nota_peli=nota_nemo2 where nombre_peli=nombre;
select * from peliculas;
end//

delimiter //
create function sumapunto(nota float)returns float no sql
begin
declare nota_final float;
set nota_final = nota+1;
return nota_final;
end//

call nemo("Buscando a Nemo");

/*Ejercicio 2.- Crea un procedimiento que duplique el sueldo del actor que menos dinero cobre, y divida entre dos el sueldo del actor que más cobre. Muestra la tabla resultante al finalizar el procedimiento.

	- Realiza la modificación de los sueldos mediante el procedimiento modificar sueldos
	- Inserta dos funciones, “duplicar” y “dividir”, que devuelvan el valor resultado de los sueldos
	- La selección de los actores que más y menos cobran, se realizará en el procedimiento

	*Las funciones NO realizarán ninguna modificación en las tablas*/

drop procedure sueldos;
drop function dividir;
drop function duplicar;

delimiter //
create procedure sueldos()
begin
declare id_max int;
declare id_min int;
declare sueldo_max int;
declare sueldo_min int;
declare sueldo_max_nuevo int;
declare sueldo_min_nuevo int;

set id_max=(select id_actor from actores where sueldo=(select max(sueldo) from actores));
set id_min=(select id_actor from actores where sueldo=(select min(sueldo) from actores));
set sueldo_max=(select sueldo from actores where id_actores=id_max);
set sueldo_min=(select sueldo from actores where id_actores=id_min);

set sueldo_max_nuevo = (select dividir(sueldo_max));
set sueldo_min_nuevo = (select duplicar(sueldo_min));

update actores set sueldo=sueldo_max_nuevo where id_actores=id_max;
update actores set sueldo=sueldo_min_nuevo where id_actores=id_min;

select * from actores;
end//

delimiter //
create function dividir(sueldo_max int) returns int no sql
begin
declare sueldo_max2 int;
set sueldo_max2=sueldo_max/2;
return sueldo_max2;
end//

delimiter //
create function duplicar(sueldo_min int) returns int no sql
begin
declare sueldo_min2 int;
set sueldo_min2=sueldo_min*2;
return sueldo_min2;
end//

call sueldos();
select * from actores;


/*Ejercicio 3.- Crea un procedimiento que modifique la duración de las películas, reduciendo en 5 minutos
la duración de las películas que duren más de 145 minutos. Muestra la tabla resultante al finalizar el procedimiento.

	- Realiza la modificación mediante el procedimiento “modificarduracion”
	- Inserta una función “restartiempo” que se encargue de reducir 5 minutos a las películas
	- La función solo recibirá el id de la película

	*Las funciones NO realizarán ninguna modificación en las tablas*/

delimiter //
create procedure modificarduracion()

/*Ejercicio 4.- Crea un procedimiento añada un prefijo en el nombre de los actores y actrices. Cuando el actor sea de género masculino se le añadirá el prefijo “Sr”, y cuando el género sea femenino se le añadirá “Sra”. Muestra la tabla resultante al finalizar el procedimiento.

	- Realiza la modificación de los nombre mediante el procedimiento “modificarnombre”
	- Inserta dos funciones, “prefijo_sr” y “prefijo_sra”, que devuelvan los nombres con sus prefijos
	
	*Las funciones NO realizarán ninguna modificación en las tablas



Ejercicio 5.- Crea un procedimiento “Modificar_edades” que añada una nueva columna “Edad” a la tabla “Alumno” y que sea capaz de insertar la edad  de los alumnos dada la fecha actual. Añade una función dentro del procedimiento que se devuelva la edad de cada alumno.

El procedimiento recibe los 3 parámetros de una fecha (año, mes y día) que tomará como la fecha actual. A partir de ahí, asignara a cada alumno la edad que tendría en esa fecha concreta.

Por ejemplo) Call modificar_edades (2020, 12, 9);

Fila ejemplo→ Nombre: Jon; Fecha_nac: 10/10/1990
Fila resultante→ Nombre: Jon; Fecha_nac: 10/10/1990;  Edad: 29;

	*Las funciones NO realizarán ninguna modificación en las tablas*/