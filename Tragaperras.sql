/*Ejercicio 1.- Realiza un programa que calcule las perdidas y ganancias en una máquina traga-perras, que cumpla 
las siguientes condiciones.
- El usuario insertará una cantidad de dinero X a través de la consulta Select
- Por cada 20 céntimos que haya apostado el usuario, la máquina realizará una “tirada”
- En cada “tirada” de la máquina se obtendrán 3 iconos (variables) al azar.
- La máquina tendrá 10 iconos en cada “engranaje”, y 3 engranajes en total.
- Cuando los 3 iconos coincidan, el usuario ganará un premio especificado en la tabla “Premios”
- Las ganancias del usuario se irán acumulando para mostrarlas al final del programa
- Cuando los 3 iconos no coincidan, el usuario no ganará nada.
- Cuando el usuario gaste el dinero invertido al principio del programa, se mostrará la siguiente frase:
“Ganancias del usuario: X euros; Pérdidas del usuario: Y euros.”*/

DROP DATABASE Netflix;

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

drop function tragaperras;

delimiter //
create function tragaperras(dinero_apostado float) returns varchar(150) no sql
begin
declare resultado varchar(150);
declare ganancias float;
declare perdidas float;
declare dinero_perdido float;

#Declaro las 3 ruedas de la tragaperras
declare rueda1 int;
declare rueda2 int;
declare rueda3 int;

#Declaro los 10 iconos de la tragaperras
declare icono_Fresa int;
declare icono_Manzana int;
declare icono_Pera int;
declare icono_Limon int;
declare icono_Frambuesa int;
declare icono_Cereza int;
declare icono_Mandarina int;
declare icono_Naranja int;
declare icono_Melocoton int;
declare icono_Sandia int;

#Declaro el valor de las ganancias y el de las perdidas iniciales
set ganancias = 0;

set perdidas=dinero_apostado;

set dinero_perdido= dinero_apostado;


#Declaro el valor de los iconos
set icono_Fresa = 0;
set icono_Manzana = 1;
set icono_Pera = 2;
set icono_Limon = 3;
set icono_Frambuesa = 4;
set icono_Cereza = 5;
set icono_Mandarina = 6;
set icono_Naranja = 7;
set icono_Melocoton = 8;
set icono_Sandia = 9;

#En caso de no tener suficiente dinero


while dinero_apostado >= 0.20 do
#Establezco el valor de las 3 ruedas de la tragaperras
    set rueda1 = floor(RAND() * 10);
	set rueda2 = floor(RAND() * 10);
    set rueda3 = floor(RAND() * 10);

	if rueda1=rueda2 and rueda2=rueda3 then 
    if rueda1 = icono_Fresa  
    then set ganancias = (ganancias + 0.40);
    elseif rueda1 = icono_Manzana 
    then set ganancias = (ganancias + 0.80);
    elseif rueda1 = icono_Pera 
    then set ganancias = (ganancias + 1.20);
	elseif rueda1 = icono_Limon 
    then set ganancias = (ganancias + 1.40);
	elseif rueda1 = icono_Frambuesa 
    then set ganancias = (ganancias + 1.60);
    elseif rueda1 = icono_Cereza 
    then set ganancias = (ganancias + 1.80);
	elseif rueda1 = icono_Mandarina 
    then set ganancias = (ganancias + 2.00);
	elseif rueda1 = icono_Naranja
    then set ganancias = (ganancias + 3.00);
	elseif rueda1 = icono_Melocoton 
    then set ganancias = (ganancias +4.00);
	elseif rueda1 = icono_Sandia 
    then set ganancias = (ganancias + 6.00);
	end if;
	end if;

	set dinero_apostado = dinero_apostado - 0.20;
end while; 

set perdidas=(dinero_perdido-ganancias);
set resultado = concat("Ganancias del usuario:", ganancias, " euros; Pérdidas del usuario: ", perdidas, " euros.");
return resultado;
end//

select tragaperras(15);