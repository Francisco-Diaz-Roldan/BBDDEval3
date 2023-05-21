CREATE DATABASE IF NOT EXISTS PiedraPapelTijeras;

use PiedraPapelTijeras;

delimiter //
create function Ejercicio2 (eleccionUsuario enum("piedra", "papel", "tijeras")) returns varchar (100) no sql
begin
declare resultado varchar (100);
declare opcion int;
declare eleccionMaquina enum("piedra", "papel", "tijeras");
set opcion = rand()*(3-1)+1;
if opcion = 1 then
set eleccionMaquina = "piedra";
elseif opcion = 2 then
set eleccionMaquina = "papel";
elseif opcion = 3 then
set eleccionMaquina = "tijeras";
end if;

if eleccionUsuario = "piedra" and eleccionMaquina = "papel" then 
set resultado = "El usuario ha elegido piedra, la maquina ha elegido papel, por lo que gana la maquina";
elseif eleccionUsuario = "piedra" and eleccionMaquina = "tijeras" then 
set resultado = "El usuario ha elegido piedra, la maquina ha elegido tijeras, por lo que gana el usuario";
elseif eleccionUsuario = "piedra" and eleccionMaquina = "piedra" then 
set resultado = "El usuario ha elegido piedra, la maquina ha elegido piedra, por lo que ha habido un empate";
elseif eleccionUsuario = "papel" and eleccionMaquina = "papel" then 
set resultado = "El usuario ha elegido papel, la maquina ha elegido papel, por lo que ha habido un empate";
elseif eleccionUsuario = "papel" and eleccionMaquina = "tijeras" then 
set resultado = "El usuario ha elegido papel, la maquina ha elegido tijeras, por lo que gana la maquina";
elseif eleccionUsuario = "papel" and eleccionMaquina = "piedra" then 
set resultado = "El usuario ha elegido papel, la maquina ha elegido piedra, por lo que gana el usuario";
elseif eleccionUsuario = "tijeras" and eleccionMaquina = "papel" then 
set resultado = "El usuario ha elegido tijeras, la maquina ha elegido papel, por lo que gana el usuario";
elseif eleccionUsuario = "tijeras" and eleccionMaquina = "tijeras" then 
set resultado = "El usuario ha elegido tijeras, la maquina ha elegido tijeras, por lo que ha habido un empate";
elseif eleccionUsuario = "tijeras" and eleccionMaquina = "piedra" then 
set resultado = "El usuario ha elegido tijeras, la maquina ha elegido piedra, por lo que gana la maquina";
end if;
return resultado;
end //

select Ejercicio2("piedra");
drop function Ejercicio2;
