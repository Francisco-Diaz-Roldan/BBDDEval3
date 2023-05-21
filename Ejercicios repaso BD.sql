
CREATE DATABASE IF NOT EXISTS Netflix;
USE Netflix;

CREATE TABLE IF NOT EXISTS Peliculas(
    ID int primary key,
    Nombre VARCHAR(30),
    Duracion INT NOT NULL,
    Director VARCHAR(20),
    Genero ENUM ('acción', 'drama', 'comedia'),
    Nota decimal(2,1),
    Protagonista int
);

INSERT INTO Peliculas (ID, Nombre, Duracion, Director, Genero, Nota, Protagonista) VALUES
(1, 'Bright', 120, 'Fernando', 'acción', 3.1, "1234"),
(2, 'Frida', 100, 'Daniel', 'drama', 7.6, "1357"),
(3, 'Los dos papas', 160, 'Adrián', 'comedia', 8.3, "1222"),
(4, 'Animales nocturnos', 185, 'Tomás', 'drama', 9.5, "1357"),
(5, 'Oceans Eleven', 150, 'Nuria', 'acción', 3.5, "1222"),
(6, 'Buscando a Nemo', 120, 'Jon', 'comedia', 2.1, "1212"),
(7, 'El Hoyo', 110, 'Ivan', 'acción', 9.9, "1265"),
(8, 'Diamante en bruto', 140, 'Paola', 'acción', 8.1, "1265");


/*Ejercicio 1.- Crea una función en MySQL que se encargue de mostrar información de la tabla películas.

	- Número de películas que contiene la tabla
	- Media de duración de las películas
	- Puntuación máxima de las notas de las películas
	- Puntuación mínima de las notas de las películas

Ejemplo Resultado) 

“La tabla películas contiene 10 películas, con una duración media de 160 minutos, y notas entre 4.2 y 9.5.”*/

drop function ejercicio1;

delimiter //
create function ejercicio1() returns varchar(150) deterministic
begin
declare resultado varchar(150);
declare numPeliculas int;
declare mediaDurac int;
declare notaMax float;
declare notaMin float;

set numPeliculas = (select count(ID) from Peliculas);
set mediaDurac = (select avg(Duracion) from Peliculas);
set notaMax = (select max(Nota) from Peliculas);
set notaMin = (select min(Nota) from Peliculas);
set resultado= concat("La tabla películas contiene ", numPeliculas, " películas, con una duración media de ", mediaDurac, " minutos, y notas entre ", notaMin, " y " , notaMax);

return resultado;
end//

select ejercicio1();

/*Ejercicio 2.- Crea una función en MySQL que a partir de dos IDs insertados por el usuario,
  devuelva el nombre de la película con menor puntuación de las dos.

	- Control de errores: si alguno de los dos no existe, devuelve un mensaje de error
*/

drop function ejercicio2;

delimiter //
create function ejercicio2 (ID1 int, ID2 int) returns varchar(100) no sql
begin 
declare resultado varchar (100);

if ((select Nota from Peliculas where ID= ID1)<=(select Nota from Peliculas where ID= ID2)) then
set resultado= concat("La pelicula con menor nota de las 2 es ",(select Nombre from Peliculas where ID= ID1), " con un ",(select Nota from Peliculas where ID= ID1), " sobre 10");
elseif((select Nota from Peliculas where ID= ID1)>(select Nota from Peliculas where ID= ID2))then
set resultado = concat("La pelicula con menor nota de las 2 es ",(select Nombre from Peliculas where ID= ID2), " con un ",(select Nota from Peliculas where ID= ID2), " sobre 10");
else
set resultado= "Has introducido una ID no existente, por favor introduce una IDs validas";
end if;

return resultado;
end//

select ejercicio2(1,2);


/*Ejercicio 3.- Crea una función en MySQL que a partir del Genero de la película insertado
 por el usuario devuelva el número de películas de ese género contenidas en la tabla, siempre
 y cuando existan más de 2 películas de dicho genero en la base de datos.
	
	- Control de errores: si el género no existe, devuelve un mensaje de error
*/


drop function ejercicio3;

delimiter //
create function ejercicio3(opcion varchar(50))returns varchar(150) no sql
begin 
declare numPeliculas int;
declare resultado varchar(150);
set numPeliculas=(select count(*) from peliculas where Genero=opcion);

if (opcion <> "acción" or opcion <>"drama" or opcion <> "comedia") then 
set resultado="Ese genero no existe";
else
if numPeliculas> 2 then
set resultado = concat("Hay ", numPeliculas, " peliculas del genero ", opcion);
else 
set resultado="";
end if;
end if;

return resultado;
end//

select ejercicio3("doraemon");


/*Ejercicio 4.- Crea una función en MySQL que a partir del dos números insertados por el usuario, devuelva
el nombre de las películas (concatenadas) contenidas en ese límite. El primer dato que inserte el usuario
corresponderá al número de saltos (número de registros a omitir) que desea dar el usuario. El segundo dato
corresponderá al número de registros que se desean mostrar.
	
- Control de errores: si la suma de ambos datos es mayor o igual que el número de registros total de la tabla,
 se mostrará un mensaje de error
	
Ejemplo) select ej4(4, 2)

	RESULTADO: Oceans Eleven Buscando a Nemo
*/

drop function ejercicio4;

DELIMITER //

CREATE FUNCTION ejercicio4(numSaltos int, numRegistros int) returns varchar(150) no sql
begin
    declare contador int;
    declare totalRegistros int;
    declare resultado varchar(150);
    set totalRegistros = (select COUNT(*) from Peliculas);

if (numSaltos + numRegistros >= totalRegistros) then
	set resultado = 'Error, no hay tantos registros';
else
	set contador = numSaltos;
	set resultado = '';

	while contador < numSaltos + numRegistros do
		set resultado = concat(resultado, (select Nombre from Peliculas where ID = contador));

		set contador = contador + 1;
            
		if contador < numSaltos + numRegistros then
			set resultado = CONCAT(resultado, ', ');
		end if;
	end while;
end if;

return resultado;
end//

select ejercicio4(4,2);

/*PROCEDIMIENTOS
/*Ejercicio 5.- S
*/
drop procedure ejercicio6();

delimiter //
create procedure ejercicio6()

/*Ejercicio 6.- Crea un procedimiento en MySQL que añada una nueva columna a la tabla Películas con las características que el usuario elija. El usuario insertará 4 datos en la ejecución del procedimiento, nombre de la columna, tipo de dato, número de caracteres y valor por defecto.

	- Nombre de la columna: dato que indique el nombre de la columna que se va a crear
	- Tipo de dato: el tipo de la columna podrá ser un INT, FLOAT o VARCHAR
	- Número caracteres: número de caracteres del contenido de la columna
	- Valor por defecto: valor de la columna por defecto

- Control de errores:
	- Si el tipo de dato no está entre las 3 opciones, la columna tendrá un valor “null”
	- Si el número de caracteres es mayor que el permitido, la columna tendrá un valor “null”

*Muestra la tabla en el propio procedimiento.


Ejercicio 7.- Crea un procedimiento en MySQL que a partir de un ID insertado por el usuario, modifique el nombre del director de dicha película. El nuevo nombre del director será el mismo nombre que tenía de derecha a izquierda. Muestra la tabla en el propio procedimiento.

	Ejemplo) Fernando → odnanreF

*Muestra la tabla en el propio procedimiento.


Ejercicio 8.- Crea un procedimiento en MySQL que a partir de dos datos insertados por el usuario realice una consulta SQL a la tabla Películas. El usuario insertará 4 datos en la ejecución del procedimiento, nombre columna y valor columna.

- Nombre columna: corresponderá a la columna por la cual desea filtrar los datos (Nombre, Duración, Nota)
- Valor columna: corresponderá a los valores que NO se desean mostrar de la columna

- Condiciones:
- Si la columna elegida es Nombre, mostraremos todos los datos ordenados alfabéticamente por nombre
- Si la columna elegida es Duración, mostraremos todos los datos ordenados por la duración (de menor a mayor)
- Si la columna elegida es Nota, mostraremos todos los datos ordenados por la nota (de mayor a menor)


Ejemplo) Call ej8(“Nombre”, “Bright”)

El procedimiento mostrará todos los datos de la tabla Películas ordenador alfabéticamente por el Nombre de las películas, sin incluir la película “Bright”
*/