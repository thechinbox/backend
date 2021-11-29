-------------Poblar USUARIOS-----------------------------------
INSERT INTO usuarios(rut,clave,email,idtipo ) VALUES('112223334','abc123','pro@gmail.com',2);
INSERT INTO usuarios(rut,clave,email,idtipo ) VALUES('99999999999','abc123','empresa@gmail.com',3);
INSERT INTO usuarios(rut,clave,email,idtipo ) VALUES('11111111111','abc123','empresa2@gmail.com',3);
INSERT INTO usuarios(rut,clave,email,idtipo ) VALUES('22222222222','abc123','empresa3@gmail.com',3);
INSERT INTO profesional(rutpro, nombres, apellidos, pais, ciudad, telefono, anoegreso, casaestudio)
	VALUES('112223334', 'JUAN IGNACIO', 'PEREZ GONZALEZ', 'Chile', 'Valparaiso', '+56911223344', 2020, 'PUCV');
INSERT INTO empresa(rutempresa,nombreempresa,logo,pais, ciudad, telefono, descripcion) 
	VALUES('99999999999','PROYECTOSING','logoPROYECTOSING.png','Chile','Valparaiso','+56955223311','Empresa de Prueba');
INSERT INTO empresa(rutempresa,nombreempresa,logo,pais, ciudad, telefono, descripcion) 
	VALUES('22222222222','LAPRUEBA','logoLAPRUEBA.png','Chile','Valparaiso','+56244778899','Empresa de Prueba 2');
INSERT INTO empresa(rutempresa,nombreempresa,logo,pais, ciudad, telefono, descripcion) 
	VALUES('11111111111','CHIMBOMBO','logoCHIMBOMBO.png','Chile','Valparaiso','+56213457893','Empresa de Prueba 3');
--------------------------POBLAR CURSOS--------------------------------------------------------------------------

--------------------------------------SHORTCUTS PARA VER O BORRAR DATOS------------------------------------------
DELETE FROM clase WHERE idclase is not null
DELETE FROM modulo WHERE idmodulo is not null
DELETE FROM curso Where clavecurso is not null
SELECT * FROM curso
SELECT * FROM modulo
SELECT * FROM clase
SELECT * FROM empresa
---------------------------------------CURSO 1-------------------------------------------------------------------
INSERT INTO curso(rutpro,nombrecurso,descripcion,duracioncurso,publicado,cerrado)
	VALUES('112223334','CURSO DE PRUEBA 1','DESCRIPCION CURSO DE PRUEBA 1',0,false,false);
INSERT INTO modulo(clavecurso,idmodulo,nombremodulo,video,descripcionmodulo,duracionmodulo)
	VALUES(1,1,'MODULO DE PRUEBA PARA CURSO 1', 'modulo1curso3240','DESCRIPCION DE MODULO DE PRUEBA 1 CURSO 1',0);
INSERT INTO modulo(clavecurso,idmodulo,nombremodulo,video,descripcionmodulo,duracionmodulo)
	VALUES(1,2,'MODULO DE PRUEBA 2 PARA CURSO 1', 'modulo2curso3240','DESCRIPCION DE MODULO DE PRUEBA 2 CURSO 1',0);
INSERT INTO modulo(clavecurso,idmodulo,nombremodulo,video,descripcionmodulo,duracionmodulo)
	VALUES(1,3,'MODULO DE PRUEBA 3 PARA CURSO 1', 'modulo3curso3240','DESCRIPCION DE MODULO DE PRUEBA 3 CURSO 1',0);
INSERT INTO clase(idclase, idmodulo, clavecurso, nombreclase, descripcionclase, videoclase, duracionclase)
	VALUES(1,1,1,'CLASE DE PRUEBA 1 PARA MODULO 1 PARA CURSO 1', 'DESCRIPCION CLASE DE PRUEBA 1 PARA MODULO 1 PARA CURSO 1', 'clase1modulo1curso3240', 20);
INSERT INTO clase(idclase, idmodulo, clavecurso, nombreclase, descripcionclase, videoclase, duracionclase)
	VALUES(2,1,1,'CLASE DE PRUEBA 2 PARA MODULO 1 PARA CURSO 1', 'DESCRIPCION CLASE DE PRUEBA 2 PARA MODULO 1 PARA CURSO 1', 'clase2modulo1curso3240', 20);
INSERT INTO clase(idclase, idmodulo, clavecurso, nombreclase, descripcionclase, videoclase, duracionclase)
	VALUES(3,1,1,'CLASE DE PRUEBA 3 PARA MODULO 1 PARA CURSO 1', 'DESCRIPCION CLASE DE PRUEBA 3 PARA MODULO 1 PARA CURSO 1', 'clase3modulo1curso3240', 20);
INSERT INTO clase(idclase, idmodulo, clavecurso, nombreclase, descripcionclase, videoclase, duracionclase)
	VALUES(1,2,1,'CLASE DE PRUEBA 1 PARA MODULO 2 PARA CURSO 1', 'DESCRIPCION CLASE DE PRUEBA 1 PARA MODULO 2 PARA CURSO 1', 'clase1modulo2curso3240', 20);
INSERT INTO clase(idclase, idmodulo, clavecurso, nombreclase, descripcionclase, videoclase, duracionclase)
	VALUES(2,2,1,'CLASE DE PRUEBA 2 PARA MODULO 2 PARA CURSO 1', 'DESCRIPCION CLASE DE PRUEBA 2 PARA MODULO 2 PARA CURSO 1', 'clase2modulo2curso3240', 20);
INSERT INTO clase(idclase, idmodulo, clavecurso, nombreclase, descripcionclase, videoclase, duracionclase)
	VALUES(3,2,1,'CLASE DE PRUEBA 3 PARA MODULO 2 PARA CURSO 1', 'DESCRIPCION CLASE DE PRUEBA 3 PARA MODULO 2 PARA CURSO 1', 'clase3modulo2curso3240', 20);
INSERT INTO clase(idclase, idmodulo, clavecurso, nombreclase, descripcionclase, videoclase, duracionclase)
	VALUES(1,3,1,'CLASE DE PRUEBA 1 PARA MODULO 3 PARA CURSO 1', 'DESCRIPCION CLASE DE PRUEBA 1 PARA MODULO 3 PARA CURSO 1', 'clase1modulo3curso3240', 20);
INSERT INTO clase(idclase, idmodulo, clavecurso, nombreclase, descripcionclase, videoclase, duracionclase)
	VALUES(2,3,1,'CLASE DE PRUEBA 2 PARA MODULO 3 PARA CURSO 1', 'DESCRIPCION CLASE DE PRUEBA 2 PARA MODULO 3 PARA CURSO 1', 'clase2modulo3curso3240', 20);
INSERT INTO clase(idclase, idmodulo, clavecurso, nombreclase, descripcionclase, videoclase, duracionclase)
	VALUES(3,3,1,'CLASE DE PRUEBA 3 PARA MODULO 3 PARA CURSO 1', 'DESCRIPCION CLASE DE PRUEBA 3 PARA MODULO 3 PARA CURSO 1', 'clase3modulo3curso3240', 20);


---------------------------------------CURSO 2-----------------------------------------------------------------------------------
INSERT INTO curso(rutpro,nombrecurso,descripcion,duracioncurso, publicado, cerrado)
	VALUES('112223334','CURSO DE PRUEBA 2','DESCRIPCION CURSO DE PRUEBA 2',0,true,false);
INSERT INTO modulo(clavecurso,idmodulo,nombremodulo,video,descripcionmodulo,duracionmodulo)
	VALUES(2,1,'MODULO DE PRUEBA 1 PARA CURSO 2', 'modulo1curso2240','DESCRIPCION DE MODULO DE PRUEBA 1 CURSO 2',0);
INSERT INTO modulo(clavecurso,idmodulo,nombremodulo,video,descripcionmodulo,duracionmodulo)
	VALUES(2,2,'MODULO DE PRUEBA 2 PARA CURSO 2', 'modulo2curso2240','DESCRIPCION DE MODULO DE PRUEBA 2 CURSO 2',0);
INSERT INTO modulo(clavecurso,idmodulo,nombremodulo,video,descripcionmodulo,duracionmodulo)
	VALUES(2,3,'MODULO DE PRUEBA 3 PARA CURSO 2', 'modulo3curso2240','DESCRIPCION DE MODULO DE PRUEBA 3 CURSO 2',0);
INSERT INTO clase(idclase, idmodulo, clavecurso, nombreclase, descripcionclase, videoclase, duracionclase)
	VALUES(1,1,2,'CLASE DE PRUEBA 1 PARA MODULO 1 PARA CURSO 2', 'DESCRIPCION CLASE DE PRUEBA 1 PARA MODULO 1 PARA CURSO 2', 'clase1modulo1curso2240', 20);
INSERT INTO clase(idclase, idmodulo, clavecurso, nombreclase, descripcionclase, videoclase, duracionclase)
	VALUES(2,1,2,'CLASE DE PRUEBA 2 PARA MODULO 1 PARA CURSO 2', 'DESCRIPCION CLASE DE PRUEBA 2 PARA MODULO 1 PARA CURSO 2', 'clase2modulo1curso2240', 20);
INSERT INTO clase(idclase, idmodulo, clavecurso, nombreclase, descripcionclase, videoclase, duracionclase)
	VALUES(3,1,2,'CLASE DE PRUEBA 3 PARA MODULO 1 PARA CURSO 2', 'DESCRIPCION CLASE DE PRUEBA 3 PARA MODULO 1 PARA CURSO 2', 'clase3modulo1curso2240', 20);
INSERT INTO clase(idclase, idmodulo, clavecurso, nombreclase, descripcionclase, videoclase, duracionclase)
	VALUES(1,2,2,'CLASE DE PRUEBA 1 PARA MODULO 2 PARA CURSO 2', 'DESCRIPCION CLASE DE PRUEBA 1 PARA MODULO 2 PARA CURSO 2', 'clase1modulo2curso2240', 20);
INSERT INTO clase(idclase, idmodulo, clavecurso, nombreclase, descripcionclase, videoclase, duracionclase)
	VALUES(2,2,2,'CLASE DE PRUEBA 2 PARA MODULO 2 PARA CURSO 2', 'DESCRIPCION CLASE DE PRUEBA 2 PARA MODULO 2 PARA CURSO 2', 'clase2modulo2curso2240', 20);
INSERT INTO clase(idclase, idmodulo, clavecurso, nombreclase, descripcionclase, videoclase, duracionclase)
	VALUES(3,2,2,'CLASE DE PRUEBA 3 PARA MODULO 2 PARA CURSO 2', 'DESCRIPCION CLASE DE PRUEBA 3 PARA MODULO 2 PARA CURSO 2', 'clase3modulo2curso2240', 20);
INSERT INTO clase(idclase, idmodulo, clavecurso, nombreclase, descripcionclase, videoclase, duracionclase)
	VALUES(1,3,2,'CLASE DE PRUEBA 1 PARA MODULO 3 PARA CURSO 2', 'DESCRIPCION CLASE DE PRUEBA 1 PARA MODULO 3 PARA CURSO 2', 'clase1modulo3curso2240', 20);
INSERT INTO clase(idclase, idmodulo, clavecurso, nombreclase, descripcionclase, videoclase, duracionclase)
	VALUES(2,3,2,'CLASE DE PRUEBA 2 PARA MODULO 3 PARA CURSO 2', 'DESCRIPCION CLASE DE PRUEBA 2 PARA MODULO 3 PARA CURSO 2', 'clase2modulo3curso2240', 20);
INSERT INTO clase(idclase, idmodulo, clavecurso, nombreclase, descripcionclase, videoclase, duracionclase)
	VALUES(3,3,2,'CLASE DE PRUEBA 3 PARA MODULO 3 PARA CURSO 2', 'DESCRIPCION CLASE DE PRUEBA 3 PARA MODULO 3 PARA CURSO 2', 'clase3modulo3curso2240', 20);


--------------------------------------OFERTAS LABORALES----------------------------------------------------------
INSERT INTO ofertalaboral(rutempresa,fechapublicacion,descripcion,ubicacion,cargo,cerrada)
	VALUES('22222222222', NOW(), 'OFERTA LABORAL DE PRUEBA EMPRESA LAPRUEBA', 'Valparaiso,Chile', 'CARGO PRUEBA', false);
INSERT INTO ofertalaboral(rutempresa,fechapublicacion,descripcion,ubicacion,cargo,cerrada)
	VALUES('22222222222', NOW(), 'OFERTA LABORAL DE PRUEBA EMPRESA LAPRUEBA 2', 'Valparaiso,Chile', 'CARGO PRUEBA 2', false);
INSERT INTO ofertalaboral(rutempresa,fechapublicacion,descripcion,ubicacion,cargo,cerrada)
	VALUES('22222222222', NOW(), 'OFERTA LABORAL DE PRUEBA EMPRESA LAPRUEBA 3', 'Valparaiso,Chile', 'CARGO PRUEBA 3', false);
INSERT INTO ofertalaboral(rutempresa,fechapublicacion,descripcion,ubicacion,cargo,cerrada)
	VALUES('11111111111', NOW(), 'OFERTA LABORAL DE PRUEBA EMPRESA LAPRUEBA', 'Valparaiso,Chile', 'CARGO PRUEBA', false);
INSERT INTO ofertalaboral(rutempresa,fechapublicacion,descripcion,ubicacion,cargo,cerrada)
	VALUES('11111111111', NOW(), 'OFERTA LABORAL DE PRUEBA EMPRESA CHIMBOMBO 2', 'Valparaiso,Chile', 'CARGO PRUEBA 2', false);
INSERT INTO ofertalaboral(rutempresa,fechapublicacion,descripcion,ubicacion,cargo,cerrada)
	VALUES('11111111111', NOW(), 'OFERTA LABORAL DE PRUEBA EMPRESA CHIMBOMBO 3', 'Valparaiso,Chile', 'CARGO PRUEBA 3', false);
INSERT INTO ofertalaboral(rutempresa,fechapublicacion,descripcion,ubicacion,cargo,cerrada)
	VALUES('99999999999', NOW(), 'OFERTA LABORAL DE PRUEBA EMPRESA CHIMBOMBO ', 'Valparaiso,Chile', 'CARGO PRUEBA ', false);
INSERT INTO ofertalaboral(rutempresa,fechapublicacion,descripcion,ubicacion,cargo,cerrada)
	VALUES('99999999999', NOW(), 'OFERTA LABORAL DE PRUEBA EMPRESA PROYECTOSING 2', 'Valparaiso,Chile', 'CARGO PRUEBA 2', false);
INSERT INTO ofertalaboral(rutempresa,fechapublicacion,descripcion,ubicacion,cargo,cerrada)
	VALUES('99999999999', NOW(), 'OFERTA LABORAL DE PRUEBA EMPRESA PROYECTOSING 3', 'Valparaiso,Chile', 'CARGO PRUEBA 3', false);
