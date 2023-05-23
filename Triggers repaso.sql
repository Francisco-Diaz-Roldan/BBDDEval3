/*Ejercicios Triggers

Crea los siguientes triggers a partir de la base de datos Netflix. Realiza las comprobaciones necesarias para asegurarte de que los trigger realizan correctamente su función.
*/

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

CREATE TABLE IF NOT EXISTS nueva_peliculas(
	id_peli int,
    	nombre_peli VARCHAR(30),
    	duracion INT,
    	director_peli VARCHAR(20),
    	género_peli ENUM ('acción', 'drama', 'comedia'),
   	nota_peli FLOAT,
	calidad enum ("buena", "regular", "mala"),
	estado enum ("activo", "eliminado") default "activo"
);

	CREATE TABLE IF NOT EXISTS informe_modificaciones(
		id int,
  	 	usuario varchar(30),
		fecha date,
 	  	hora time
	);



/*Ejercicio 1.- Crea un trigger Backup_peliculas que se encargue de guardar en una segunda 
tabla nueva_peliculas todos los datos que se inserten en la tabla original, cada vez que se realicen 
inserciones en la base de datos.
*/

delimiter //
create trigger Backup_peliculas
after insert on Peliculas
for each row
begin
		insert into nueva_Peliculas(id_peli, nombre_peli, duracion, director_peli, género_peli, nota_peli)
        values (new.id_peli, new.nombre_peli, new.duracion, new.director_peli, new.género_peli, new.nota_peli);
end//

insert into nueva_peliculas (id_peli, nombre_peli, duracion, director_peli, género_peli, nota_peli)
values
(1, 'Click', 181, 'Adam Sandler', 'comedia', 8.4),
(2, 'Parasite', 132, 'Bong Joon Ho', 'drama', 8.6),
(3, 'Joker', 122, 'Todd Phillips', 'drama', 8.4);

/*
Ejercicio 2.- Crea un trigger eliminadas que se encargue de asignar un valor de Estado “eliminado”
en la tabla nueva_peliculas a las películas que se eliminen de la tabla Peliculas. 
*/	
    
delimiter //
create trigger eliminadas
after delete on Peliculas
for each row 
begin
    update nueva_peliculas set estado = "eliminado" where id_peli = old.id_peli;
end //

delete from nueva_Peliculas
where id_peli =1;

select * from nueva_Peliculas;


/*Ejercicio 3.- Crea un trigger calidad_peliculas que se encargue de asignar un valor de Calidad
 en la tabla nueva_peliculas en base a la nota de las películas, cada vez que se realicen inserciones
 en la tabla Peliculas. 

	- Si la nota de las películas es mayor que 5, se les asignará calidad “buena”
	- Si la nota de las películas es menor que 5, se les asignará calidad “mala”
	- Si la nota de las películas es igual que 5, se les asignará calidad “regular”
*/

DELIMITER //
CREATE TRIGGER calidad_peliculas
AFTER INSERT ON peliculas
FOR EACH ROW
BEGIN
	declare cal varchar(20);
    
		if NEW.nota_peli > 5 then
			set cal="buena";
		elseif NEW.nota_peli < 5 then
			set cal="mala";
		else 
			set cal="regular";
		end if;

    insert into nueva_peliculas (nombre_peli, duracion, director_peli, género_peli, nota_peli, id_peli, calidad)
 	VALUES (NEW.nombre_peli, NEW.duracion, NEW.director_peli, NEW.género_peli, NEW.nota_peli, 	NEW.id_peli, cal);
END//
/*
Ejercicio 4.- Crea un trigger modificaciones que se encargue de almacenar en la tabla Informe_modificaciones los siguientes datos cada vez que se modifique algún dato de la tabla Peliculas.

- ID: identificador de la película modificada
- Usuario_conectado: usuario que ha realizado la modificación (usuario conectado en MySQL)
- Fecha: fecha de la modificación
- Hora: hora de la modificación

*/

delimiter //
create trigger modificaciones
after update on Informe_modificaciones
for each row
begin
declare usuario_conectado varchar(30);
set usuario_conectado=(select user());

insert into informe_modificaciones (id, usuario, fecha, hora) values (new.id_peli, usuario_conectado, curdate(), now());
end//


 /*Ejercicio1*/
    delimiter //
    create trigger backup_peliculas
    after insert on Peliculas
    for each row
    begin
    insert into nueva_peliculas (id_peli, nombre_peli, duracion, director_peli, género_peli, nota_peli)
    values (new.id_peli, new.nombre_peli, new.duracion, new.director_peli, new.género_peli, new.nota_peli);
    end //
    
    /*Ejercicio3*/
	delimiter //
    create trigger calidad
    after insert on Peliculas
    for each row
    begin
    update nueva_peliculas set calidad = "buena" where nota_peli >5;
	update nueva_peliculas set calidad = "mala" where nota_peli <5;
    update nueva_peliculas set calidad = "regular" where nota_peli =5;
    end //
    
    insert into Peliculas (id_peli, nombre_peli, duracion, director_peli, género_peli, nota_peli) values (1, "Star Trek", 120, "JJAbrahams", "acción", 6);
    
    /*Ejercicio4*/
    delimiter //
    create trigger modificaciones
    after update on Peliculas
    for each row
    begin
    insert into informe_modificaciones(id, usuario, fecha, hora)
    values (old.id_peli, user(), curdate(), curtime());
    end //
    
     Update Peliculas set nombre_peli = "Pipi Calzaslargas" where id_peli = 1;
     
     select * from informe_modificaciones;
    
    /*Ejercicio2*/
	delimiter //
    create trigger eliminadas
    before delete on Peliculas
    for each row
    begin
    update nueva_peliculas set estado = "eliminado" where id_peli = old.id_peli;
    end //
    
    delete from Peliculas where id_peli = 1;
    
    select * from nueva_peliculas;
    
    /*Los ejercicios aparecen desordenados porque he probado que todos funcionen en cascada y a la vez*/
    
    
    /*Ejercicios corregidos por el samu*/
    
    /*/Ejercicio 4/

delimiter //
create trigger calidad_peliculas
after insert on Peliculas
for each row
begin
declare calidad enum ("buena", "regular", "mala");
if NEW.nota_peli>5 then 
set calidad="buena";
elseif NEW.nota_peli<5 then
set calidad="mala";
elseif NEW.nota_peli=5 then
set calidad="regular";

end if;
insert into nueva_peliculas (id_peli,calidad) values (NEW.id_peli,calidad);
end //
insert into Peliculas values (10,"Peli inventada",4,"El migue","drama",7);
select * from nueva_peliculas;

/Ejercicio 5/

delimiter //
create trigger modificaciones
after update on Peliculas
for each row
begin
declare fecha date;
declare hora time;
set fecha = date(NOW());
set hora = time(NOW());

insert into informe_modificaciones (id,usuario,fecha,hora) values (OLD.id_peli,current_user(),fecha,hora);
end //
drop trigger modificaciones;
select * from informe_modificaciones;
Update peliculas set duracion=3 where duracion>3;*/