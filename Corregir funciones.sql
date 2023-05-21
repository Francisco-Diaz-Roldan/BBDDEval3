/*Funciones MySQL

Corrige las siguientes funciones implementadas en MySQL y explica brevemente la función que realiza cada una de ellas.
*/

drop database BaseDatos;
CREATE DATABASE IF NOT EXISTS BaseDatos;
USE BaseDatos;

#Ejercicio 1.- 
drop function `ejercicio7`;

delimiter //
create function `ejercicio7`(nom varchar(15), apellido varchar(15)) returns varchar(50) DETERMINISTIC
begin
declare resultado varchar(50);

set resultado=concat("Bienvenido ", nom, " ", apellido,"!!");

return resultado;
end//

select ejercicio7("Jon", "Zamora");

#Ejercicio 2.- 

drop function `ejercicio1`;

delimiter //
create function `ejercicio1`(num1 int, num2 int, operacion varchar(15)) returns VARCHAR(20) NO SQL
begin
declare resultado varchar(20);

if operacion="suma" then
	set resultado=num1+num2;
elseif operacion="resta" then
	set resultado=num1-num2;
elseif operacion="division" then
	set resultado=num1 div num2;
elseif operacion="multiplicacion" then
	set resultado=num1*num2;
end if;
return resultado;
end //

select `ejercicio1`(7, 2, "resta");

#Ejercicio 3.- 

drop function `ejercicio2`;

delimiter //
create function `ejercicio2`(num1 int) returns int NO SQL
begin
declare resultado int;

set resultado=power(num1, 2);
return resultado;
end //

select `ejercicio2`(5);

#Ejercicio 4.- 

drop function `ejercicio3`;

delimiter //
create function `ejercicio3`(num1 int, operacion varchar(10)) returns int NO SQL
begin
declare resultado int;

if operacion="potencia" then
	set resultado=power(num1, 2);
elseif operacion="raiz" then
	set resultado=sqrt(num1);
end if;
    
return resultado;
end //

select `ejercicio3`(3, "potencia");

#Ejercicio 5.- 

drop function`ejercicio6`;

delimiter //
create function `ejercicio6`(num1 int) returns varchar(15) NO SQL
begin
declare resultado varchar(15);
declare aleatorio int;

set aleatorio=rand()*(10-1)+1;

if aleatorio=num1 then
	set resultado="Has acertado";
elseif aleatorio <> num1  then
	set resultado="Has fallado";
end if;

return resultado;
end//

select `ejercicio6`(7);

#Ejercicio 6.- 

drop function `ejercicio5`;

delimiter //
create function `ejercicio5`(num1 int) returns varchar(50) DETERMINISTIC
begin
declare resultado varchar(50);
declare numero int;
declare Resto int;

set numero=30;

set resto=mod(numero, num1);

if resto=0 then
	set resultado=concat("el numero es divisible por ", num1);
elseif resto<>0 then
	set resultado=concat("el numero no es divisible por ", num1);
end if;

return resultado;
end //

select `ejercicio5`(5);