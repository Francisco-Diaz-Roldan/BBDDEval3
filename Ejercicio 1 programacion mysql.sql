CREATE DATABASE IF NOT EXISTS ParesONones;

use ParesONones;
/*Ejercicio 1.- Realiza una función donde el usuario juegue contra la máquina al juego Pares o nones donde se cumplan las siguientes condiciones.
- El usuario insertará su elección en el Select mediante caracteres (pares o nones), y un número
- La máquina “insertará” un número aleatorio del 1 al 10 dentro de la función
- En el resultado se deberá mostrar los siguientes datos:
- Elección del usuario (pares o impares)
- Número insertado por el usuario
- Número “insertado” por la máquina
- Suma total de ambos números
 - Ganador del juego (máquina o usuario)*/

delimiter //
create function ParesOnones (num1 int , tipo enum("pares", "nones")) returns varchar(250) no sql /*Entre parentesis le pongo los vlores que le meto por teclado*/
begin 
declare resultado varchar(250); /*mismo numero caracteres que arriba*/
declare numMaquina int;
declare suma int;
set numMaquina =rand()*(10-1)+1;
set suma = numMaquina+num1;

if suma mod 2=0 then
	if tipo="pares" then 
	set resultado = concat( "El usuario ha elegido ", tipo, " y el numero: ", numMaquina, "su suma es ", suma, " por lo que el ganador es el usuario");
	else
	set resultado = concat( "El usuario ha elegido ", tipo, " y el numero: ", numMaquina, "su suma es ", suma, " por lo que gana la maquina");
	end if;
    else
if tipo="nones" then 
	set resultado = concat( "El usuario ha elegido ", tipo, " y el numero: ", numMaquina, "su suma es ", suma, " por lo que gana la maquina");
	else
	set resultado = concat( "El usuario ha elegido ", tipo, " y el numero: ", numMaquina, "su suma es ", suma, " por lo que el ganador es el usuario");
	end if;
	end if;
return resultado;
end //
select ParesONones(5,"pares");
drop function ParesONones;