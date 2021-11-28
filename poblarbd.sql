-------------Poblar USUARIOS-----------------------------------
INSERT INTO usuarios(rut,clave,email,idtipo ) VALUES('112223334','abc123','pro@gmail.com',2)
INSERT INTO usuarios(rut,clave,email,idtipo ) VALUES('99999999999','abc123','empresa@gmail.com',3);
INSERT INTO profesional(rutpro, nombres, apellidos, pais, ciudad, telefono, anoegreso, casaestudio)
	VALUES('112223334', 'JUAN IGNACIO', 'PEREZ GONZALEZ', 'Chile', 'Valparaiso', '+56911223344', 2020, 'PUCV');
INSERT INTO empresa(rutempresa,nombreempresa,logo) VALUES('99999999999','PROYECTOSING','logoPROYECTOSING.png');
--------------------------POBLAR CURSOS--------------------------------------------------------------------------

--------------------------------------SHORTCUTS PARA VER O BORRAR DATOS------------------------------------------
DELETE FROM clase WHERE idclase is not null
DELETE FROM modulo WHERE idmodulo is not null
DELETE FROM curso Where clavecurso is not null
SELECT * FROM curso
SELECT * FROM modulo
SELECT * FROM clase
---------------------------------------CURSO 1-------------------------------------------------------------------
INSERT INTO curso(clavecurso,rutpro,nombrecurso,descripcion,duracioncurso,cerrado)
	VALUES(3240,'112223334','CURSO DE PRUEBA 1','DESCRIPCION CURSO DE PRUEBA 1',0,false);
INSERT INTO modulo(clavecurso,idmodulo,nombremodulo,video,descripcionmodulo,duracionmodulo)
	VALUES(3240,1,'MODULO DE PRUEBA PARA CURSO 1', 'modulo1curso3240','DESCRIPCION DE MODULO DE PRUEBA 1 CURSO 1',0);
INSERT INTO modulo(clavecurso,idmodulo,nombremodulo,video,descripcionmodulo,duracionmodulo)
	VALUES(3240,2,'MODULO DE PRUEBA 2 PARA CURSO 1', 'modulo2curso3240','DESCRIPCION DE MODULO DE PRUEBA 2 CURSO 1',0);
INSERT INTO modulo(clavecurso,idmodulo,nombremodulo,video,descripcionmodulo,duracionmodulo)
	VALUES(3240,3,'MODULO DE PRUEBA 3 PARA CURSO 1', 'modulo3curso3240','DESCRIPCION DE MODULO DE PRUEBA 3 CURSO 1',0);
INSERT INTO clase(idclase, idmodulo, clavecurso, nombreclase, descripcionclase, videoclase, duracionclase)
	VALUES(1,1,3240,'CLASE DE PRUEBA 1 PARA MODULO 1 PARA CURSO 1', 'DESCRIPCION CLASE DE PRUEBA 1 PARA MODULO 1 PARA CURSO 1', 'clase1modulo1curso3240', 20);
INSERT INTO clase(idclase, idmodulo, clavecurso, nombreclase, descripcionclase, videoclase, duracionclase)
	VALUES(2,1,3240,'CLASE DE PRUEBA 2 PARA MODULO 1 PARA CURSO 1', 'DESCRIPCION CLASE DE PRUEBA 2 PARA MODULO 1 PARA CURSO 1', 'clase2modulo1curso3240', 20);
INSERT INTO clase(idclase, idmodulo, clavecurso, nombreclase, descripcionclase, videoclase, duracionclase)
	VALUES(3,1,3240,'CLASE DE PRUEBA 3 PARA MODULO 1 PARA CURSO 1', 'DESCRIPCION CLASE DE PRUEBA 3 PARA MODULO 1 PARA CURSO 1', 'clase3modulo1curso3240', 20);
INSERT INTO clase(idclase, idmodulo, clavecurso, nombreclase, descripcionclase, videoclase, duracionclase)
	VALUES(1,2,3240,'CLASE DE PRUEBA 1 PARA MODULO 2 PARA CURSO 1', 'DESCRIPCION CLASE DE PRUEBA 1 PARA MODULO 2 PARA CURSO 1', 'clase1modulo2curso3240', 20);
INSERT INTO clase(idclase, idmodulo, clavecurso, nombreclase, descripcionclase, videoclase, duracionclase)
	VALUES(2,2,3240,'CLASE DE PRUEBA 2 PARA MODULO 2 PARA CURSO 1', 'DESCRIPCION CLASE DE PRUEBA 2 PARA MODULO 2 PARA CURSO 1', 'clase2modulo2curso3240', 20);
INSERT INTO clase(idclase, idmodulo, clavecurso, nombreclase, descripcionclase, videoclase, duracionclase)
	VALUES(3,2,3240,'CLASE DE PRUEBA 3 PARA MODULO 2 PARA CURSO 1', 'DESCRIPCION CLASE DE PRUEBA 3 PARA MODULO 2 PARA CURSO 1', 'clase3modulo2curso3240', 20);
INSERT INTO clase(idclase, idmodulo, clavecurso, nombreclase, descripcionclase, videoclase, duracionclase)
	VALUES(1,3,3240,'CLASE DE PRUEBA 1 PARA MODULO 3 PARA CURSO 1', 'DESCRIPCION CLASE DE PRUEBA 1 PARA MODULO 3 PARA CURSO 1', 'clase1modulo3curso3240', 20);
INSERT INTO clase(idclase, idmodulo, clavecurso, nombreclase, descripcionclase, videoclase, duracionclase)
	VALUES(2,3,3240,'CLASE DE PRUEBA 2 PARA MODULO 3 PARA CURSO 1', 'DESCRIPCION CLASE DE PRUEBA 2 PARA MODULO 3 PARA CURSO 1', 'clase2modulo3curso3240', 20);
INSERT INTO clase(idclase, idmodulo, clavecurso, nombreclase, descripcionclase, videoclase, duracionclase)
	VALUES(3,3,3240,'CLASE DE PRUEBA 3 PARA MODULO 3 PARA CURSO 1', 'DESCRIPCION CLASE DE PRUEBA 3 PARA MODULO 3 PARA CURSO 1', 'clase3modulo3curso3240', 20);


---------------------------------------CURSO 2-----------------------------------------------------------------------------------
INSERT INTO curso(clavecurso,rutpro,nombrecurso,descripcion,duracioncurso,cerrado)
	VALUES(2240,'112223334','CURSO DE PRUEBA 2','DESCRIPCION CURSO DE PRUEBA 2',0,false);
INSERT INTO modulo(clavecurso,idmodulo,nombremodulo,video,descripcionmodulo,duracionmodulo)
	VALUES(2240,1,'MODULO DE PRUEBA 1 PARA CURSO 2', 'modulo1curso2240','DESCRIPCION DE MODULO DE PRUEBA 1 CURSO 2',0);
INSERT INTO modulo(clavecurso,idmodulo,nombremodulo,video,descripcionmodulo,duracionmodulo)
	VALUES(2240,2,'MODULO DE PRUEBA 2 PARA CURSO 2', 'modulo2curso2240','DESCRIPCION DE MODULO DE PRUEBA 2 CURSO 2',0);
INSERT INTO modulo(clavecurso,idmodulo,nombremodulo,video,descripcionmodulo,duracionmodulo)
	VALUES(2240,3,'MODULO DE PRUEBA 3 PARA CURSO 2', 'modulo3curso2240','DESCRIPCION DE MODULO DE PRUEBA 3 CURSO 2',0);
INSERT INTO clase(idclase, idmodulo, clavecurso, nombreclase, descripcionclase, videoclase, duracionclase)
	VALUES(1,1,2240,'CLASE DE PRUEBA 1 PARA MODULO 1 PARA CURSO 2', 'DESCRIPCION CLASE DE PRUEBA 1 PARA MODULO 1 PARA CURSO 2', 'clase1modulo1curso2240', 20);
INSERT INTO clase(idclase, idmodulo, clavecurso, nombreclase, descripcionclase, videoclase, duracionclase)
	VALUES(2,1,2240,'CLASE DE PRUEBA 2 PARA MODULO 1 PARA CURSO 2', 'DESCRIPCION CLASE DE PRUEBA 2 PARA MODULO 1 PARA CURSO 2', 'clase2modulo1curso2240', 20);
INSERT INTO clase(idclase, idmodulo, clavecurso, nombreclase, descripcionclase, videoclase, duracionclase)
	VALUES(3,1,2240,'CLASE DE PRUEBA 3 PARA MODULO 1 PARA CURSO 2', 'DESCRIPCION CLASE DE PRUEBA 3 PARA MODULO 1 PARA CURSO 2', 'clase3modulo1curso2240', 20);
INSERT INTO clase(idclase, idmodulo, clavecurso, nombreclase, descripcionclase, videoclase, duracionclase)
	VALUES(1,2,2240,'CLASE DE PRUEBA 1 PARA MODULO 2 PARA CURSO 2', 'DESCRIPCION CLASE DE PRUEBA 1 PARA MODULO 2 PARA CURSO 2', 'clase1modulo2curso2240', 20);
INSERT INTO clase(idclase, idmodulo, clavecurso, nombreclase, descripcionclase, videoclase, duracionclase)
	VALUES(2,2,2240,'CLASE DE PRUEBA 2 PARA MODULO 2 PARA CURSO 2', 'DESCRIPCION CLASE DE PRUEBA 2 PARA MODULO 2 PARA CURSO 2', 'clase2modulo2curso2240', 20);
INSERT INTO clase(idclase, idmodulo, clavecurso, nombreclase, descripcionclase, videoclase, duracionclase)
	VALUES(3,2,2240,'CLASE DE PRUEBA 3 PARA MODULO 2 PARA CURSO 2', 'DESCRIPCION CLASE DE PRUEBA 3 PARA MODULO 2 PARA CURSO 2', 'clase3modulo2curso2240', 20);
INSERT INTO clase(idclase, idmodulo, clavecurso, nombreclase, descripcionclase, videoclase, duracionclase)
	VALUES(1,3,2240,'CLASE DE PRUEBA 1 PARA MODULO 3 PARA CURSO 2', 'DESCRIPCION CLASE DE PRUEBA 1 PARA MODULO 3 PARA CURSO 2', 'clase1modulo3curso2240', 20);
INSERT INTO clase(idclase, idmodulo, clavecurso, nombreclase, descripcionclase, videoclase, duracionclase)
	VALUES(2,3,2240,'CLASE DE PRUEBA 2 PARA MODULO 3 PARA CURSO 2', 'DESCRIPCION CLASE DE PRUEBA 2 PARA MODULO 3 PARA CURSO 2', 'clase2modulo3curso2240', 20);
INSERT INTO clase(idclase, idmodulo, clavecurso, nombreclase, descripcionclase, videoclase, duracionclase)
	VALUES(3,3,2240,'CLASE DE PRUEBA 3 PARA MODULO 3 PARA CURSO 2', 'DESCRIPCION CLASE DE PRUEBA 3 PARA MODULO 3 PARA CURSO 2', 'clase3modulo3curso2240', 20);



