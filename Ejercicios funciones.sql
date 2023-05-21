# Ejercicio 1.- Crea una función que a partir de dos números, calcule y muestre el resultado de la multiplicación 
# entre ambos.

drop database BaseDatos;
CREATE DATABASE IF NOT EXISTS BaseDatos;
USE BaseDatos;

drop function ejercicio1;

delimiter //
create function ejercicio1(num1 int, num2 int) returns int no sql
begin
declare resultado int;
set multiplicacion = num1*num2;

return multiplicacion;
end//

select ejercicio1(3,5);

# Ejercicio 2.- Crea una función que a partir de un número y una palabra, calcule y muestre el resultado de la suma
# del número y el número de caracteres de la palabra.

drop function ejercicio2;

delimiter //
create function ejercicio2(palabra varchar(25), num int) returns int no sql
begin 
declare suma int;
set suma = char_length(palabra) + num;

return suma;
end//

select ejercicio2("caca", 5);

/* Ejercicio 3.- Crea una función que a partir de dos palabras muestre como resultado las dos palabras separadas por
 el conector “y”.  Ejemplo) Palabra1: hola;  Palabra2: adios;  Resultado: hola y adios*/
 
 drop function ejercicio3;
 
 delimiter //
 create function ejercicio3(palabra1 varchar(25), palabra2 varchar(25)) returns varchar(100) no sql
 begin
 declare resultado varchar(100);
 set resultado = concat(palabra1, " y ", palabra2);
 
 return resultado;
 end//
 
 select ejercicio3("hola","adios");
 
 /*Ejercicio 4.- Crea una función que calcule la división entre dos números insertados por el usuario a través de la
 función Select.*/
 
 drop function ejercicio4;
 
 delimiter //
 create function ejercicio4(num1 int, num2 int) returns int no sql
 begin
 declare division int;
 set division = num1/num2;
 
 return division;
 end//
 
 select ejercicio4(20,4);
 
 drop function ejercicio4;
 
 delimiter //
 create function ejercicio4(num1 decimal(4,1), num2 decimal (4,1)) returns decimal (4,1) no sql
 begin 
 declare division decimal (4,1);
 set division = num1/num2;
 
 return division;
 end//
 
 select ejercicio4(20.5,4.5);
 
 /*Ejercicio 5.- Crea una función dados dos números, uno insertado por el usuario, y otro dentro de la función, 
 muestre una frase indicando si el número insertado por el usuario es mayor, menor o igual al otro.*/
 
 drop function ejercicio5;
 
 delimiter //
 create function ejercicio5(num1 int) returns varchar(100) no sql
 begin
 declare num2 int;
 declare resultado varchar(100);
 set num2=5;
 
 if num1>num2 then
 set resultado = concat(num1, " es mayor que ", num2);
 elseif num1<num2 then
 set resultado = concat(num1, " es menor que ", num2);
 elseif num1=num2 then
 set resultado = concat(num1, " es igual que ", num2);
 end if;
 
 return resultado;
 end//
 
 select ejercicio5(15);