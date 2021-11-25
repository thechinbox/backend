CREATE TABLE usuarios(
	rut varchar(20) not null,
	clave varchar(300),
	email varchar(200),
	idtipo integer,
	constraint pk_usuarios primary key (rut),
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

CREATE TABLE tipousuario(
	idtipo SERIAl,
	tipo varchar(20) not null,
	constraint pk_tipo_usuario primary key (idtipo)
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
	nromodulos integer not null,
	duraciontotal integer not null,
	cerrado boolean,
	constraint pk_curso primary key (clavecurso),
	constraint fk_curso_pro foreign key (rutpro)
	                      references profesional (rutpro),
	constraint chk_duracion_curso check (duraciontotal >= 1 AND nromodulos >= 1)
);

CREATE TABLE modulo(
	idmodulo SERIAL,
	nombremodulo varchar(100) not null,
	clavecurso integer not null,
	video varchar(300) not null,
	descripcionmodulo varchar(300) not null,
	duracionmodulo integer not null,
	constraint pk_modulo primary key (idmodulo, clavecurso),
	constraint chk_duracion_modulos check (duracionmodulo >= 1)
);

CREATE TABLE clase(
	idclase BIGSERIAL,
	idmodulo integer,
	clavecurso integer,
	nombreclase varchar(50),
	descripcionclase varchar(300),
	videoclase varchar(150),
	constraint pk_clase primary key (idclase, idmodulo, clavecurso),
	constraint fk_clase_modulo foreign key (idmodulo, clavecurso)
	                      references modulo (idmodulo, clavecurso)
);

CREATE TABLE etiqueta(
	idetiqueta SERIAL,
	etiqueta varchar(20),
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
	idmodulo SERIAL,
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
	ultmodulofin integer,
	ultclasefin integer,
	tasavance integer not null,
	tiempoestudio integer not null,
	finalizado boolean not null,
	constraint pk_participante primary key (clavecurso, rutcomun),
	constraint fk_participante_clavecurso foreign key (clavecurso)
	                      references curso (clavecurso),
	constraint fk_participante_rutcomun foreign key (rutcomun)
	                      references comun (rutcomun),
	constraint fk_participante_ultmodulofin foreign key (ultmodulofin, clavecurso)
	                      references modulo (idmodulo, clavecurso),
	constraint fk_participante_ultclasefin foreign key (ultclasefin,ultmodulofin,clavecurso)
	                      references clase (idclase, idmodulo, clavecurso)
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


