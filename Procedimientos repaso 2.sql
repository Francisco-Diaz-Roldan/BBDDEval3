drop database netflix;
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


/*Ejercicio 5.- Crea un procedimiento en MySQL que a partir de un dato dado por el
 usuario añada un nuevo registro a la tabla Películas con los siguientes datos específicos. 

- ID: añade un ID que sea igual al ID mayor de la tabla más 1
- Nombre: dato insertado por el usuario
- Duracion: añade una duración igual al 80% de la duración de la película con mayor duración de la tabla
- Director: deja el dato vacío
- Genero: añade un género aleatorio de los 3 posibles
- Nota: añade un 10 de nota
 */
 
 drop procedure ejercicio5;
 
 delimiter //
 create procedure ejercicio5(nombre_peli varchar(20))
 begin
 #Procedimientos para hacer modificaciones 
 
 #En los procedure las variabes nuevas que declaro son para modificar los de la tabla
 declare id_peli int;
 declare duracion_peli float;
 # declare director_peli varchar(20); Ya que es vacio no hace falta que lo ponga
 declare genero_peli enum ('acción', 'drama', 'comedia');
 declare nota_peli float;
 declare aleatorio int;
 
# - ID: añade un ID que sea igual al ID mayor de la tabla más 1
set id_peli=(select max(ID)from Peliculas)+1;
# - Duracion: añade una duración igual al 80% de la duración de la película con mayor duración de la tabla
set duracion_peli=(select max(Duracion) from Peliculas)*0.8;
# - Genero: añade un género aleatorio de los 3 posibles
set aleatorio = floor(rand() * 3) + 1;
if aleatorio=1 then
set genero_peli= "acción";

elseif aleatorio=2 then
set genero_peli= "drama";

else
set genero_peli= "comedia";
end if;
# - Nota: añade un 10 de nota
set nota_peli=10;
#Hacer un alter table para que me coja el 10 con el decimal
alter table peliculas modify nota decimal(3,1);

#Hago un insert into con los valores que le puedo meter  y debajo le inserto los valores declarados en el procedimiento
INSERT INTO Peliculas (ID, Nombre, Duracion, Genero, Nota) VALUES
(id_peli, nombre_peli, duracion_peli, genero_peli, nota_peli);

end//
 call ejercicio5("Samuel Leiva");
  select * from Peliculas;

 
 
/*Ejercicio 6.- Crea un procedimiento en MySQL que a partir de un ID insertado por el usuario, modifique el nombre del director de dicha película. El nuevo nombre del director será el mismo nombre que tenía de derecha a izquierda. Muestra la tabla en el propio procedimiento.

	Ejemplo) Fernando → odnanreF

*Muestra la tabla en el propio procedimiento. */
 
 CREATE PROCEDURE cambiar_orden_nombre_pelicula(IN pelicula_id INT)
BEGIN
    DECLARE nombre_pelicula VARCHAR(30);
    DECLARE nuevo_nombre_pelicula VARCHAR(30);


    SELECT nombre_peli INTO nombre_pelicula FROM Peliculas WHERE id_peli = pelicula_id;

    SET nuevo_nombre_pelicula = REVERSE(nombre_pelicula);

 
    UPDATE Peliculas SET nombre_peli = nuevo_nombre_pelicula WHERE id_peli = pelicula_id;


    SELECT nuevo_nombre_pelicula AS 'Nuevo nombre de la película';
END//
 
 
 
 
 
 
 /*Ejercicio 7.- Crea un procedimiento en MySQL que a partir de dos datos insertados por el usuario realice
 una consulta SQL a la tabla Películas. El usuario insertará 2 datos en la ejecución del procedimiento, nombre
 columna y valor columna.

- Nombre columna: corresponderá a la columna por la cual desea filtrar los datos (Nombre, Duración, Nota)
- Valor columna: corresponderá a los valores que NO se desean mostrar de la columna

- Condiciones:
- Si la columna elegida es Nombre, mostraremos todos los datos ordenados alfabéticamente por nombre
- Si la columna elegida es Duración, mostraremos todos los datos ordenados por la duración (de menor a mayor)
- Si la columna elegida es Nota, mostraremos todos los datos ordenados por la nota (de mayor a menor)


Ejemplo) Call ej8(“Nombre”, “Bright”)

El procedimiento mostrará todos los datos de la tabla Películas ordenador alfabéticamente por el Nombre de las
películas, sin incluir la película “Bright”.*/

drop procedure ejercicio7;
delimiter //
create procedure ejercicio7(nombre_col varchar(150), valor_col varchar(150))
begin

if nombre_col= "Nombre" then
select * from Peliculas where Nombre!= valor_col order by Nombre desc;

elseif nombre_col= "Duracion" then
select * from Peliculas where Duracion!= valor_col order by Duracion desc;

elseif nombre_col= "Nota" then
select * from Nota where Nota!= valor_col order by Nota desc;
end if;

end//
 
 call ejercicio7("Nombre","Bright");
 select * from Peliculas;
 
 

 