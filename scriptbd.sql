CREATE TABLE tipousuario(
	idtipo SERIAl,
	tipo varchar(20) not null,
	constraint pk_tipo_usuario primary key (idtipo)
);
INSERT INTO tipousuario(tipo) VALUES('comun');
INSERT INTO tipousuario(tipo) VALUES('profesional');
INSERT INTO tipousuario(tipo) VALUES('empresa');

CREATE TABLE usuarios(
	rut varchar(20) not null,
	clave varchar(300),
	email varchar(200),
	idtipo integer,
	constraint pk_usuarios primary key (rut),
	constraint fk_empresa_rut foreign key (idtipo)
	                      references tipousuario (idtipo),
	constraint chk_idtipo check (idtipo = 0 OR idtipo = 1 OR idtipo = 2)
);

CREATE TABLE empresa(
	rutempresa varchar(20) not null,
	nombreempresa varchar(100) not null,
	logo varchar(150) not null,
	constraint pk_empresa primary key (rutempresa),
	constraint fk_empresa_rut foreign key (rutempresa)
	                      references usuarios (rut)
);

CREATE TABLE comun(
	rutcomun varchar(10) not null,
	nombres varchar(100) not null,
	apellidos varchar(100) not null,
	pais varchar(50) not null,
	ciudad varchar(50) not null,
	telefono varchar(20) not null,
	constraint pk_comun primary key (rutcomun),
	constraint fk_comun_rut foreign key (rutcomun)
	                      references usuarios (rut)
);

CREATE TABLE profesional(
	rutpro varchar(10) not null,
	nombres varchar(100) not null,
	apellidos varchar(100) not null,
	pais varchar(50) not null,
	ciudad varchar(50) not null,
	telefono varchar(20) not null,
	anoegreso smallint not null,
	casaestudio varchar(50) not null,
	constraint pk_pro primary key (rutpro),
	constraint fk_pro_user foreign key (rutpro)
	                      references usuarios (rut)
);

CREATE TABLE ofertalaboral(
	idoferta SERIAL ,
	rutempresa varchar(20) not null,
	fechapublicacion DATE,
	descripcion varchar(500),
	ubicacion varchar(150),
	cargo varchar(50),
	etiquetas varchar(200),
	constraint pk_oferta primary key (idoferta),
	constraint fk_empresa_oferta foreign key (rutempresa)
	                      references empresa (rutempresa)
);

CREATE TABLE solicitudempleo(
	idsolicitud SERIAL,
	rut varchar(10) not null,
	idoferta bigint not null,
	constraint pk_solicitud primary key (idsolicitud),
	constraint fk_solicitud_rut foreign key (rut)
	                      references comun (rutcomun),
	constraint fk_solicitud_oferta foreign key (idoferta)
	                      references ofertalaboral (idoferta)
);

CREATE TABLE curso(
	clavecurso integer not null,
	rutpro varchar(10) not null,
	nombrecurso varchar(50) not null,
	descripcion varchar(300) not null,
	duracioncurso integer not null,
	cerrado boolean,
	constraint pk_curso primary key (clavecurso),
	constraint fk_curso_pro foreign key (rutpro)
	                      references profesional (rutpro),
	constraint chk_duracion_curso check (duracioncurso >= 0)
);
/*
El id del modulo debe ser el nro de modulo que es, ejemplo: si el modulo es el segundo modulo del curso de 4 modulos 
entonces su id sera = 2 y la del modulo final sera igual a 4
*/
CREATE TABLE modulo(
	clavecurso integer not null,
	idmodulo integer not null,
	nombremodulo varchar(100) not null,
	video varchar(300) not null,
	descripcionmodulo varchar(300) not null,
	duracionmodulo integer not null,
	constraint pk_modulo primary key (idmodulo, clavecurso),
	constraint chk_duracion_modulos check (duracionmodulo >= 0)
);

/*
El id de la clase debe ser el nro de clase que es, ejemplo: si la clase es la segunda clase del modulo de 4 clases 
entonces su id sera = 2 y la de la clase final sera igual a 4
*/
CREATE TABLE clase(
	idclase integer not null,
	idmodulo integer not null,
	clavecurso integer not null,
	nombreclase varchar(50) not null,
	descripcionclase varchar(300) not null,
	videoclase varchar(150) not null,
	duracionclase integer not null,
	constraint pk_clase primary key (idclase, idmodulo, clavecurso),
	constraint fk_clase_modulo foreign key (idmodulo, clavecurso)
	                      references modulo (idmodulo, clavecurso),
	constraint chk_duracion_clase check (duracionclase >= 0)
);

CREATE TABLE etiqueta(
	idetiqueta SERIAL,
	etiqueta varchar(20) not null,
	constraint pk_etiqueta primary key (idetiqueta)
);

CREATE TABLE etiquetacurso(
	idetiqueta SERIAL,
	clavecurso integer not null,
	constraint pk_etiqueta_curso primary key (idetiqueta, clavecurso),
	constraint fk_etiqueta_id foreign key (idetiqueta)
	                      references etiqueta (idetiqueta),
	constraint fk_etiqueta_curso foreign key (clavecurso)
	                      references curso (clavecurso)
);

CREATE TABLE etiquetamodulo(
	idetiqueta SERIAL,
	idmodulo integer not null,
	clavecurso integer not null,
	constraint pk_etiqueta_modulo primary key (idetiqueta, idmodulo, clavecurso),
	constraint fk_etiqueta_idem foreign key (idetiqueta)
	                      references etiqueta (idetiqueta),
	constraint fk_etiqueta_modulo foreign key (idmodulo, clavecurso)
	                      references modulo (idmodulo,clavecurso)
);

CREATE TABLE participante(
	clavecurso integer not null,
	rutcomun varchar(10) not null,
	tiempoestudio integer not null,
	finalizado boolean not null,
	fechafin DATE,
	constraint pk_participante primary key (clavecurso, rutcomun),
	constraint fk_participante_clavecurso foreign key (clavecurso)
	                      references curso (clavecurso),
	constraint fk_participante_rutcomun foreign key (rutcomun)
	                      references comun (rutcomun)
);

CREATE TABLE comentario(
	idcomentario SERIAL,
	clavecurso integer not null, 
	rutcomun varchar(10) not null,
	comentario varchar(300) not null,
	constraint pk_comentario primary key (idcomentario, clavecurso, rutcomun),
	constraint fk_comentario_curso foreign key (clavecurso)
	                      references curso (clavecurso),
	constraint fk_comentario_rut foreign key (rutcomun)
	                      references comun (rutcomun)
);

CREATE TABLE tasaavance(
	rut varchar(20),
	clavecurso integer not null,
	idmodulo integer not null,
	idclase integer not null,
	constraint pk_tasaavance primary key (rut, clavecurso, idmodulo, idclase),
	constraint fk_tasaavance_curso foreign key (clavecurso)
	                      references curso (clavecurso),
	constraint fk_tasaavance_modulo foreign key (clavecurso,idmodulo)
	                      references modulo (clavecurso,idmodulo),
	constraint fk_tasaavance foreign key (clavecurso,idmodulo,idclase)
	                      references clase (clavecurso, idmodulo,idclase)
);


------------------------------TRIGGERS-----------------------------------------------------
CREATE OR REPLACE FUNCTION ftr_tasaavance() RETURNS TRIGGER AS $$
	DECLARE 
		rutp varchar(20);
		clavep integer;
		aux varchar;
		idmodulop integer;
		idclasep integer;
	BEGIN
		aux:= SPLIT_PART(NEW::varchar, ',', 1);
		aux:= SUBSTRING(aux, 2, LENGTH(aux) - 1);
		clavep := aux::integer;
		rutp:= SPLIT_PART(NEW::varchar, ',', 2)::integer;
		idmodulop:= (SELECT idmodulo FROM modulo WHERE (clavecurso = clavep AND nromodulo_curso = 1))::integer;
		idclasep:= (SELECT idclase FROM clase WHERE (clavecurso = clavep AND idmodulo = idmodulop AND nroclase_modulo = 1))::INTEGER;
		INSERT INTO tasaavance(rut, clavecurso, idmodulo, idclase) VALUES(rutp, clavep, idmodulop, idclasep);
		RETURN(NEW);
	END
$$ LANGUAGE plpgsql;
CREATE TRIGGER tr_tasaavance BEFORE INSERT ON participante
      FOR EACH ROW EXECUTE PROCEDURE  ftr_tasaavance();