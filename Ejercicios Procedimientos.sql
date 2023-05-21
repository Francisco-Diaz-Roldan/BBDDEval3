drop database netflix;
CREATE DATABASE IF NOT EXISTS Netflix;
USE Netflix;

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

/*Ejercicio 1.- Realiza un procedimiento donde se modifiquen los sueldos de todos los actores,
 asignando el sueldo medio a todos ellos. Una vez hecho esto, haz que en el propio procedimiento
 se muestre la tabla resultante.*/
 
 delimiter //
 create procedure ejercicio1()
 begin 
 declare media int;
 set media = (select avg(sueldo) from Actores);
update Actores set sueldo = media;
 select * from Actores;
 end //
 
 call ejercicio1();
 
 drop procedure ejercicio1;
 
 
 /*Ejercicio 2.- Realiza un procedimiento que borre los X actores con más sueldo. El número de 
 actores a borrar se insertarán a través del procedimiento. Una vez hecho esto, haz que en el 
 propio procedimiento se muestre la tabla resultante.*/
 
 delimiter //
 create procedure ejercicio2(actoresABorrar int)
 begin
 declare actoresABorrar int;
 
 delete from actores where sueldo in
 (select sueldo from Actores order by sueldo limit actoresABorrar);
 
 select * from Actores;
 end //


 call ejercicio2(3);
 
 drop procedure ejercicio2;