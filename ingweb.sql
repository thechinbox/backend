--
-- PostgreSQL database dump
--

-- Dumped from database version 13.4
-- Dumped by pg_dump version 13.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: ftr_duraciones(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.ftr_duraciones() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	DECLARE 
		idm integer;
		clave integer;
		duracion integer;
		aux varchar;
	BEGIN
		idm:= SPLIT_PART(NEW::varchar, ',', 2)::INTEGER;
		clave:= SPLIT_PART(NEW::varchar, ',', 3)::INTEGER;
		aux:= SPLIT_PART(NEW::varchar, ',', 7);
		duracion:= SUBSTRING(aux, 1, LENGTH(aux) - 1)::INTEGER;
		RAISE NOTICE '%', duracion;
		UPDATE curso SET duracioncurso = (duracion + curso.duracioncurso) WHERE clavecurso = clave ;
		UPDATE modulo SET duracionmodulo = (duracion + modulo.duracionmodulo) WHERE clavecurso = clave AND idmodulo = idm ;
		RETURN(null);
	END
$$;


ALTER FUNCTION public.ftr_duraciones() OWNER TO postgres;

--
-- Name: ftr_tasaavance(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.ftr_tasaavance() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	DECLARE 
		rutp varchar(20);
		clavep integer;
		aux varchar;
	BEGIN
		aux:= SPLIT_PART(NEW::varchar, ',', 1);
		aux:= SUBSTRING(aux, 2, LENGTH(aux) - 1);
		clavep := aux::integer;
		rutp:= SPLIT_PART(NEW::varchar, ',', 2);
		RAISE NOTICE '%,%', rutp, clavep;
		INSERT INTO tasaavance(rut, clavecurso, idmodulo, idclase) VALUES(rutp, clavep, 1, 1);
		RETURN(NEW);
	END
$$;


ALTER FUNCTION public.ftr_tasaavance() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: clase; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clase (
    idclase integer NOT NULL,
    idmodulo integer NOT NULL,
    clavecurso integer NOT NULL,
    nombreclase character varying(50) NOT NULL,
    descripcionclase character varying(300) NOT NULL,
    videoclase character varying(150) NOT NULL,
    duracionclase integer NOT NULL,
    CONSTRAINT chk_duracion_clase CHECK ((duracionclase >= 0))
);


ALTER TABLE public.clase OWNER TO postgres;

--
-- Name: comentario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comentario (
    idcomentario integer NOT NULL,
    clavecurso integer NOT NULL,
    rutcomun character varying(10) NOT NULL,
    comentario character varying(300) NOT NULL
);


ALTER TABLE public.comentario OWNER TO postgres;

--
-- Name: comentario_idcomentario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.comentario_idcomentario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comentario_idcomentario_seq OWNER TO postgres;

--
-- Name: comentario_idcomentario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comentario_idcomentario_seq OWNED BY public.comentario.idcomentario;


--
-- Name: comun; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comun (
    rutcomun character varying(10) NOT NULL,
    nombres character varying(100) NOT NULL,
    apellidos character varying(100) NOT NULL,
    pais character varying(50) NOT NULL,
    ciudad character varying(50) NOT NULL,
    telefono character varying(20) NOT NULL
);


ALTER TABLE public.comun OWNER TO postgres;

--
-- Name: curso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.curso (
    clavecurso integer NOT NULL,
    rutpro character varying(10) NOT NULL,
    nombrecurso character varying(50) NOT NULL,
    descripcion character varying(300) NOT NULL,
    duracioncurso integer NOT NULL,
    publicado boolean NOT NULL,
    cerrado boolean,
    CONSTRAINT chk_duracion_curso CHECK ((duracioncurso >= 0))
);


ALTER TABLE public.curso OWNER TO postgres;

--
-- Name: curso_clavecurso_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.curso_clavecurso_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.curso_clavecurso_seq OWNER TO postgres;

--
-- Name: curso_clavecurso_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.curso_clavecurso_seq OWNED BY public.curso.clavecurso;


--
-- Name: empresa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.empresa (
    rutempresa character varying(20) NOT NULL,
    nombreempresa character varying(100) NOT NULL,
    logo character varying(150) NOT NULL,
    pais character varying(100) NOT NULL,
    ciudad character varying(100) NOT NULL,
    telefono character varying(20) NOT NULL,
    descripcion character varying(300) NOT NULL
);


ALTER TABLE public.empresa OWNER TO postgres;

--
-- Name: etiqueta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etiqueta (
    idetiqueta integer NOT NULL,
    etiqueta character varying(20) NOT NULL
);


ALTER TABLE public.etiqueta OWNER TO postgres;

--
-- Name: etiqueta_idetiqueta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etiqueta_idetiqueta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.etiqueta_idetiqueta_seq OWNER TO postgres;

--
-- Name: etiqueta_idetiqueta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etiqueta_idetiqueta_seq OWNED BY public.etiqueta.idetiqueta;


--
-- Name: etiquetacurso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etiquetacurso (
    idetiqueta integer NOT NULL,
    clavecurso integer NOT NULL
);


ALTER TABLE public.etiquetacurso OWNER TO postgres;

--
-- Name: etiquetacurso_idetiqueta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etiquetacurso_idetiqueta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.etiquetacurso_idetiqueta_seq OWNER TO postgres;

--
-- Name: etiquetacurso_idetiqueta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etiquetacurso_idetiqueta_seq OWNED BY public.etiquetacurso.idetiqueta;


--
-- Name: etiquetamodulo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etiquetamodulo (
    idetiqueta integer NOT NULL,
    idmodulo integer NOT NULL,
    clavecurso integer NOT NULL
);


ALTER TABLE public.etiquetamodulo OWNER TO postgres;

--
-- Name: etiquetamodulo_idetiqueta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etiquetamodulo_idetiqueta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.etiquetamodulo_idetiqueta_seq OWNER TO postgres;

--
-- Name: etiquetamodulo_idetiqueta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etiquetamodulo_idetiqueta_seq OWNED BY public.etiquetamodulo.idetiqueta;


--
-- Name: etiquetaoferta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etiquetaoferta (
    idoferta integer NOT NULL,
    idetiqueta integer NOT NULL
);


ALTER TABLE public.etiquetaoferta OWNER TO postgres;

--
-- Name: modulo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.modulo (
    clavecurso integer NOT NULL,
    idmodulo integer NOT NULL,
    nombremodulo character varying(100) NOT NULL,
    descripcionmodulo character varying(300) NOT NULL,
    duracionmodulo integer NOT NULL,
    CONSTRAINT chk_duracion_modulos CHECK ((duracionmodulo >= 0))
);


ALTER TABLE public.modulo OWNER TO postgres;

--
-- Name: ofertalaboral; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ofertalaboral (
    idoferta integer NOT NULL,
    rutempresa character varying(20) NOT NULL,
    fechapublicacion timestamp without time zone NOT NULL,
    descripcion character varying(500) NOT NULL,
    ubicacion character varying(150) NOT NULL,
    cargo character varying(50) NOT NULL,
    cerrada boolean
);


ALTER TABLE public.ofertalaboral OWNER TO postgres;

--
-- Name: ofertalaboral_idoferta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ofertalaboral_idoferta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ofertalaboral_idoferta_seq OWNER TO postgres;

--
-- Name: ofertalaboral_idoferta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ofertalaboral_idoferta_seq OWNED BY public.ofertalaboral.idoferta;


--
-- Name: participante; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.participante (
    clavecurso integer NOT NULL,
    rutcomun character varying(10) NOT NULL,
    tiempoestudio integer NOT NULL,
    finalizado boolean NOT NULL,
    fechafin date
);


ALTER TABLE public.participante OWNER TO postgres;

--
-- Name: profesional; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.profesional (
    rutpro character varying(10) NOT NULL,
    nombres character varying(100) NOT NULL,
    apellidos character varying(100) NOT NULL,
    pais character varying(50) NOT NULL,
    ciudad character varying(50) NOT NULL,
    telefono character varying(20) NOT NULL,
    anoegreso smallint NOT NULL,
    casaestudio character varying(50) NOT NULL
);


ALTER TABLE public.profesional OWNER TO postgres;

--
-- Name: solicitudempleo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.solicitudempleo (
    idsolicitud integer NOT NULL,
    rut character varying(10) NOT NULL,
    idoferta bigint NOT NULL
);


ALTER TABLE public.solicitudempleo OWNER TO postgres;

--
-- Name: solicitudempleo_idsolicitud_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.solicitudempleo_idsolicitud_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.solicitudempleo_idsolicitud_seq OWNER TO postgres;

--
-- Name: solicitudempleo_idsolicitud_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.solicitudempleo_idsolicitud_seq OWNED BY public.solicitudempleo.idsolicitud;


--
-- Name: tasaavance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tasaavance (
    rut character varying(20) NOT NULL,
    clavecurso integer NOT NULL,
    idmodulo integer NOT NULL,
    idclase integer NOT NULL
);


ALTER TABLE public.tasaavance OWNER TO postgres;

--
-- Name: tipousuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipousuario (
    idtipo integer NOT NULL,
    tipo character varying(20) NOT NULL
);


ALTER TABLE public.tipousuario OWNER TO postgres;

--
-- Name: tipousuario_idtipo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipousuario_idtipo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipousuario_idtipo_seq OWNER TO postgres;

--
-- Name: tipousuario_idtipo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipousuario_idtipo_seq OWNED BY public.tipousuario.idtipo;


--
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    rut character varying(20) NOT NULL,
    clave character varying(300),
    email character varying(200),
    idtipo integer,
    CONSTRAINT chk_idtipo CHECK (((idtipo = 1) OR (idtipo = 2) OR (idtipo = 3)))
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- Name: comentario idcomentario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentario ALTER COLUMN idcomentario SET DEFAULT nextval('public.comentario_idcomentario_seq'::regclass);


--
-- Name: curso clavecurso; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.curso ALTER COLUMN clavecurso SET DEFAULT nextval('public.curso_clavecurso_seq'::regclass);


--
-- Name: etiqueta idetiqueta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etiqueta ALTER COLUMN idetiqueta SET DEFAULT nextval('public.etiqueta_idetiqueta_seq'::regclass);


--
-- Name: etiquetacurso idetiqueta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etiquetacurso ALTER COLUMN idetiqueta SET DEFAULT nextval('public.etiquetacurso_idetiqueta_seq'::regclass);


--
-- Name: etiquetamodulo idetiqueta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etiquetamodulo ALTER COLUMN idetiqueta SET DEFAULT nextval('public.etiquetamodulo_idetiqueta_seq'::regclass);


--
-- Name: ofertalaboral idoferta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ofertalaboral ALTER COLUMN idoferta SET DEFAULT nextval('public.ofertalaboral_idoferta_seq'::regclass);


--
-- Name: solicitudempleo idsolicitud; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.solicitudempleo ALTER COLUMN idsolicitud SET DEFAULT nextval('public.solicitudempleo_idsolicitud_seq'::regclass);


--
-- Name: tipousuario idtipo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipousuario ALTER COLUMN idtipo SET DEFAULT nextval('public.tipousuario_idtipo_seq'::regclass);


--
-- Data for Name: clase; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clase (idclase, idmodulo, clavecurso, nombreclase, descripcionclase, videoclase, duracionclase) FROM stdin;
1	1	1	CLASE DE PRUEBA 1 PARA MODULO 1 PARA CURSO 1	DESCRIPCION CLASE DE PRUEBA 1 PARA MODULO 1 PARA CURSO 1	clase1modulo1curso3240	20
2	1	1	CLASE DE PRUEBA 2 PARA MODULO 1 PARA CURSO 1	DESCRIPCION CLASE DE PRUEBA 2 PARA MODULO 1 PARA CURSO 1	clase2modulo1curso3240	20
3	1	1	CLASE DE PRUEBA 3 PARA MODULO 1 PARA CURSO 1	DESCRIPCION CLASE DE PRUEBA 3 PARA MODULO 1 PARA CURSO 1	clase3modulo1curso3240	20
1	2	1	CLASE DE PRUEBA 1 PARA MODULO 2 PARA CURSO 1	DESCRIPCION CLASE DE PRUEBA 1 PARA MODULO 2 PARA CURSO 1	clase1modulo2curso3240	20
2	2	1	CLASE DE PRUEBA 2 PARA MODULO 2 PARA CURSO 1	DESCRIPCION CLASE DE PRUEBA 2 PARA MODULO 2 PARA CURSO 1	clase2modulo2curso3240	20
3	2	1	CLASE DE PRUEBA 3 PARA MODULO 2 PARA CURSO 1	DESCRIPCION CLASE DE PRUEBA 3 PARA MODULO 2 PARA CURSO 1	clase3modulo2curso3240	20
1	3	1	CLASE DE PRUEBA 1 PARA MODULO 3 PARA CURSO 1	DESCRIPCION CLASE DE PRUEBA 1 PARA MODULO 3 PARA CURSO 1	clase1modulo3curso3240	20
2	3	1	CLASE DE PRUEBA 2 PARA MODULO 3 PARA CURSO 1	DESCRIPCION CLASE DE PRUEBA 2 PARA MODULO 3 PARA CURSO 1	clase2modulo3curso3240	20
3	3	1	CLASE DE PRUEBA 3 PARA MODULO 3 PARA CURSO 1	DESCRIPCION CLASE DE PRUEBA 3 PARA MODULO 3 PARA CURSO 1	clase3modulo3curso3240	20
1	1	2	CLASE DE PRUEBA 1 PARA MODULO 1 PARA CURSO 2	DESCRIPCION CLASE DE PRUEBA 1 PARA MODULO 1 PARA CURSO 2	clase1modulo1curso2240	20
2	1	2	CLASE DE PRUEBA 2 PARA MODULO 1 PARA CURSO 2	DESCRIPCION CLASE DE PRUEBA 2 PARA MODULO 1 PARA CURSO 2	clase2modulo1curso2240	20
3	1	2	CLASE DE PRUEBA 3 PARA MODULO 1 PARA CURSO 2	DESCRIPCION CLASE DE PRUEBA 3 PARA MODULO 1 PARA CURSO 2	clase3modulo1curso2240	20
1	2	2	CLASE DE PRUEBA 1 PARA MODULO 2 PARA CURSO 2	DESCRIPCION CLASE DE PRUEBA 1 PARA MODULO 2 PARA CURSO 2	clase1modulo2curso2240	20
2	2	2	CLASE DE PRUEBA 2 PARA MODULO 2 PARA CURSO 2	DESCRIPCION CLASE DE PRUEBA 2 PARA MODULO 2 PARA CURSO 2	clase2modulo2curso2240	20
3	2	2	CLASE DE PRUEBA 3 PARA MODULO 2 PARA CURSO 2	DESCRIPCION CLASE DE PRUEBA 3 PARA MODULO 2 PARA CURSO 2	clase3modulo2curso2240	20
1	3	2	CLASE DE PRUEBA 1 PARA MODULO 3 PARA CURSO 2	DESCRIPCION CLASE DE PRUEBA 1 PARA MODULO 3 PARA CURSO 2	clase1modulo3curso2240	20
2	3	2	CLASE DE PRUEBA 2 PARA MODULO 3 PARA CURSO 2	DESCRIPCION CLASE DE PRUEBA 2 PARA MODULO 3 PARA CURSO 2	clase2modulo3curso2240	20
3	3	2	CLASE DE PRUEBA 3 PARA MODULO 3 PARA CURSO 2	DESCRIPCION CLASE DE PRUEBA 3 PARA MODULO 3 PARA CURSO 2	clase3modulo3curso2240	20
\.


--
-- Data for Name: comentario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comentario (idcomentario, clavecurso, rutcomun, comentario) FROM stdin;
\.


--
-- Data for Name: comun; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comun (rutcomun, nombres, apellidos, pais, ciudad, telefono) FROM stdin;
223334445	USUARIO COMUN	PRUEBA PRUEBA	Chile	Valparaiso	+56911223344
\.


--
-- Data for Name: curso; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.curso (clavecurso, rutpro, nombrecurso, descripcion, duracioncurso, publicado, cerrado) FROM stdin;
1	112223334	CURSO DE PRUEBA 1	DESCRIPCION CURSO DE PRUEBA 1	180	f	f
2	112223334	CURSO DE PRUEBA 2	DESCRIPCION CURSO DE PRUEBA 2	180	t	f
\.


--
-- Data for Name: empresa; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.empresa (rutempresa, nombreempresa, logo, pais, ciudad, telefono, descripcion) FROM stdin;
99999999999	PROYECTOSING	logoPROYECTOSING.png	Chile	Valparaiso	+56955223311	Empresa de Prueba
22222222222	LAPRUEBA	logoLAPRUEBA.png	Chile	Valparaiso	+56244778899	Empresa de Prueba 2
11111111111	CHIMBOMBO	logoCHIMBOMBO.png	Chile	Valparaiso	+56213457893	Empresa de Prueba 3
\.


--
-- Data for Name: etiqueta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.etiqueta (idetiqueta, etiqueta) FROM stdin;
\.


--
-- Data for Name: etiquetacurso; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.etiquetacurso (idetiqueta, clavecurso) FROM stdin;
\.


--
-- Data for Name: etiquetamodulo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.etiquetamodulo (idetiqueta, idmodulo, clavecurso) FROM stdin;
\.


--
-- Data for Name: etiquetaoferta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.etiquetaoferta (idoferta, idetiqueta) FROM stdin;
\.


--
-- Data for Name: modulo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.modulo (clavecurso, idmodulo, nombremodulo, descripcionmodulo, duracionmodulo) FROM stdin;
1	1	MODULO DE PRUEBA PARA CURSO 1	DESCRIPCION DE MODULO DE PRUEBA 1 CURSO 1	60
1	2	MODULO DE PRUEBA 2 PARA CURSO 1	DESCRIPCION DE MODULO DE PRUEBA 2 CURSO 1	60
1	3	MODULO DE PRUEBA 3 PARA CURSO 1	DESCRIPCION DE MODULO DE PRUEBA 3 CURSO 1	60
2	1	MODULO DE PRUEBA 1 PARA CURSO 2	DESCRIPCION DE MODULO DE PRUEBA 1 CURSO 2	60
2	2	MODULO DE PRUEBA 2 PARA CURSO 2	DESCRIPCION DE MODULO DE PRUEBA 2 CURSO 2	60
2	3	MODULO DE PRUEBA 3 PARA CURSO 2	DESCRIPCION DE MODULO DE PRUEBA 3 CURSO 2	60
\.


--
-- Data for Name: ofertalaboral; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ofertalaboral (idoferta, rutempresa, fechapublicacion, descripcion, ubicacion, cargo, cerrada) FROM stdin;
1	22222222222	2021-11-30 23:47:54.65488	OFERTA LABORAL DE PRUEBA EMPRESA LAPRUEBA	Valparaiso,Chile	CARGO PRUEBA	f
2	22222222222	2021-11-30 23:47:54.65488	OFERTA LABORAL DE PRUEBA EMPRESA LAPRUEBA 2	Valparaiso,Chile	CARGO PRUEBA 2	f
3	22222222222	2021-11-30 23:47:54.65488	OFERTA LABORAL DE PRUEBA EMPRESA LAPRUEBA 3	Valparaiso,Chile	CARGO PRUEBA 3	f
4	11111111111	2021-11-30 23:47:54.65488	OFERTA LABORAL DE PRUEBA EMPRESA LAPRUEBA	Valparaiso,Chile	CARGO PRUEBA	f
5	11111111111	2021-11-30 23:47:54.65488	OFERTA LABORAL DE PRUEBA EMPRESA CHIMBOMBO 2	Valparaiso,Chile	CARGO PRUEBA 2	f
6	11111111111	2021-11-30 23:47:54.65488	OFERTA LABORAL DE PRUEBA EMPRESA CHIMBOMBO 3	Valparaiso,Chile	CARGO PRUEBA 3	f
7	99999999999	2021-11-30 23:47:54.65488	OFERTA LABORAL DE PRUEBA EMPRESA CHIMBOMBO 	Valparaiso,Chile	CARGO PRUEBA 	f
8	99999999999	2021-11-30 23:47:54.65488	OFERTA LABORAL DE PRUEBA EMPRESA PROYECTOSING 2	Valparaiso,Chile	CARGO PRUEBA 2	f
9	99999999999	2021-11-30 23:47:54.65488	OFERTA LABORAL DE PRUEBA EMPRESA PROYECTOSING 3	Valparaiso,Chile	CARGO PRUEBA 3	f
\.


--
-- Data for Name: participante; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.participante (clavecurso, rutcomun, tiempoestudio, finalizado, fechafin) FROM stdin;
\.


--
-- Data for Name: profesional; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.profesional (rutpro, nombres, apellidos, pais, ciudad, telefono, anoegreso, casaestudio) FROM stdin;
112223334	JUAN IGNACIO	PEREZ GONZALEZ	Chile	Valparaiso	+56911223344	2020	PUCV
\.


--
-- Data for Name: solicitudempleo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.solicitudempleo (idsolicitud, rut, idoferta) FROM stdin;
\.


--
-- Data for Name: tasaavance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tasaavance (rut, clavecurso, idmodulo, idclase) FROM stdin;
\.


--
-- Data for Name: tipousuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipousuario (idtipo, tipo) FROM stdin;
1	comun
2	profesional
3	empresa
\.


--
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (rut, clave, email, idtipo) FROM stdin;
223334445	abc123	comun@gmail.com	1
112223334	abc123	pro@gmail.com	2
99999999999	abc123	empresa@gmail.com	3
11111111111	abc123	empresa2@gmail.com	3
22222222222	abc123	empresa3@gmail.com	3
\.


--
-- Name: comentario_idcomentario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comentario_idcomentario_seq', 1, false);


--
-- Name: curso_clavecurso_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.curso_clavecurso_seq', 2, true);


--
-- Name: etiqueta_idetiqueta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.etiqueta_idetiqueta_seq', 1, false);


--
-- Name: etiquetacurso_idetiqueta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.etiquetacurso_idetiqueta_seq', 1, false);


--
-- Name: etiquetamodulo_idetiqueta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.etiquetamodulo_idetiqueta_seq', 1, false);


--
-- Name: ofertalaboral_idoferta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ofertalaboral_idoferta_seq', 9, true);


--
-- Name: solicitudempleo_idsolicitud_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.solicitudempleo_idsolicitud_seq', 1, false);


--
-- Name: tipousuario_idtipo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipousuario_idtipo_seq', 3, true);


--
-- Name: clase pk_clase; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clase
    ADD CONSTRAINT pk_clase PRIMARY KEY (idclase, idmodulo, clavecurso);


--
-- Name: comentario pk_comentario; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentario
    ADD CONSTRAINT pk_comentario PRIMARY KEY (idcomentario, clavecurso, rutcomun);


--
-- Name: comun pk_comun; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comun
    ADD CONSTRAINT pk_comun PRIMARY KEY (rutcomun);


--
-- Name: curso pk_curso; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.curso
    ADD CONSTRAINT pk_curso PRIMARY KEY (clavecurso);


--
-- Name: empresa pk_empresa; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresa
    ADD CONSTRAINT pk_empresa PRIMARY KEY (rutempresa);


--
-- Name: etiqueta pk_etiqueta; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etiqueta
    ADD CONSTRAINT pk_etiqueta PRIMARY KEY (idetiqueta);


--
-- Name: etiquetacurso pk_etiqueta_curso; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etiquetacurso
    ADD CONSTRAINT pk_etiqueta_curso PRIMARY KEY (idetiqueta, clavecurso);


--
-- Name: etiquetamodulo pk_etiqueta_modulo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etiquetamodulo
    ADD CONSTRAINT pk_etiqueta_modulo PRIMARY KEY (idetiqueta, idmodulo, clavecurso);


--
-- Name: etiquetaoferta pk_etiqueta_oferta; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etiquetaoferta
    ADD CONSTRAINT pk_etiqueta_oferta PRIMARY KEY (idoferta, idetiqueta);


--
-- Name: modulo pk_modulo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modulo
    ADD CONSTRAINT pk_modulo PRIMARY KEY (idmodulo, clavecurso);


--
-- Name: ofertalaboral pk_oferta; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ofertalaboral
    ADD CONSTRAINT pk_oferta PRIMARY KEY (idoferta);


--
-- Name: participante pk_participante; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participante
    ADD CONSTRAINT pk_participante PRIMARY KEY (clavecurso, rutcomun);


--
-- Name: profesional pk_pro; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profesional
    ADD CONSTRAINT pk_pro PRIMARY KEY (rutpro);


--
-- Name: solicitudempleo pk_solicitud; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.solicitudempleo
    ADD CONSTRAINT pk_solicitud PRIMARY KEY (idsolicitud, rut, idoferta);


--
-- Name: tasaavance pk_tasaavance; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasaavance
    ADD CONSTRAINT pk_tasaavance PRIMARY KEY (rut, clavecurso);


--
-- Name: tipousuario pk_tipo_usuario; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipousuario
    ADD CONSTRAINT pk_tipo_usuario PRIMARY KEY (idtipo);


--
-- Name: usuarios pk_usuarios; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT pk_usuarios PRIMARY KEY (rut);


--
-- Name: clase tr_duracionmodulo; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tr_duracionmodulo AFTER INSERT ON public.clase FOR EACH ROW EXECUTE FUNCTION public.ftr_duraciones();


--
-- Name: participante tr_tasaavance; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tr_tasaavance AFTER INSERT ON public.participante FOR EACH ROW EXECUTE FUNCTION public.ftr_tasaavance();


--
-- Name: clase fk_clase_modulo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clase
    ADD CONSTRAINT fk_clase_modulo FOREIGN KEY (idmodulo, clavecurso) REFERENCES public.modulo(idmodulo, clavecurso);


--
-- Name: comentario fk_comentario_curso; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentario
    ADD CONSTRAINT fk_comentario_curso FOREIGN KEY (clavecurso) REFERENCES public.curso(clavecurso);


--
-- Name: comentario fk_comentario_rut; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentario
    ADD CONSTRAINT fk_comentario_rut FOREIGN KEY (rutcomun) REFERENCES public.comun(rutcomun);


--
-- Name: comun fk_comun_rut; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comun
    ADD CONSTRAINT fk_comun_rut FOREIGN KEY (rutcomun) REFERENCES public.usuarios(rut);


--
-- Name: ofertalaboral fk_empresa_oferta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ofertalaboral
    ADD CONSTRAINT fk_empresa_oferta FOREIGN KEY (rutempresa) REFERENCES public.empresa(rutempresa);


--
-- Name: usuarios fk_empresa_rut; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT fk_empresa_rut FOREIGN KEY (idtipo) REFERENCES public.tipousuario(idtipo);


--
-- Name: empresa fk_empresa_rut; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresa
    ADD CONSTRAINT fk_empresa_rut FOREIGN KEY (rutempresa) REFERENCES public.usuarios(rut);


--
-- Name: etiquetacurso fk_etiqueta_curso; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etiquetacurso
    ADD CONSTRAINT fk_etiqueta_curso FOREIGN KEY (clavecurso) REFERENCES public.curso(clavecurso);


--
-- Name: etiquetacurso fk_etiqueta_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etiquetacurso
    ADD CONSTRAINT fk_etiqueta_id FOREIGN KEY (idetiqueta) REFERENCES public.etiqueta(idetiqueta);


--
-- Name: etiquetamodulo fk_etiqueta_idem; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etiquetamodulo
    ADD CONSTRAINT fk_etiqueta_idem FOREIGN KEY (idetiqueta) REFERENCES public.etiqueta(idetiqueta);


--
-- Name: etiquetamodulo fk_etiqueta_modulo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etiquetamodulo
    ADD CONSTRAINT fk_etiqueta_modulo FOREIGN KEY (idmodulo, clavecurso) REFERENCES public.modulo(idmodulo, clavecurso);


--
-- Name: etiquetaoferta fk_etiqueta_oferta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etiquetaoferta
    ADD CONSTRAINT fk_etiqueta_oferta FOREIGN KEY (idetiqueta) REFERENCES public.etiqueta(idetiqueta);


--
-- Name: participante fk_participante_clavecurso; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participante
    ADD CONSTRAINT fk_participante_clavecurso FOREIGN KEY (clavecurso) REFERENCES public.curso(clavecurso);


--
-- Name: participante fk_participante_rutcomun; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participante
    ADD CONSTRAINT fk_participante_rutcomun FOREIGN KEY (rutcomun) REFERENCES public.comun(rutcomun);


--
-- Name: profesional fk_pro_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profesional
    ADD CONSTRAINT fk_pro_user FOREIGN KEY (rutpro) REFERENCES public.usuarios(rut);


--
-- Name: solicitudempleo fk_solicitud_oferta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.solicitudempleo
    ADD CONSTRAINT fk_solicitud_oferta FOREIGN KEY (idoferta) REFERENCES public.ofertalaboral(idoferta);


--
-- Name: solicitudempleo fk_solicitud_rut; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.solicitudempleo
    ADD CONSTRAINT fk_solicitud_rut FOREIGN KEY (rut) REFERENCES public.usuarios(rut);


--
-- Name: tasaavance fk_tasaavance; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasaavance
    ADD CONSTRAINT fk_tasaavance FOREIGN KEY (clavecurso, idmodulo, idclase) REFERENCES public.clase(clavecurso, idmodulo, idclase);


--
-- Name: tasaavance fk_tasaavance_cursorut; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasaavance
    ADD CONSTRAINT fk_tasaavance_cursorut FOREIGN KEY (clavecurso, rut) REFERENCES public.participante(clavecurso, rutcomun);


--
-- Name: tasaavance fk_tasaavance_modulo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasaavance
    ADD CONSTRAINT fk_tasaavance_modulo FOREIGN KEY (clavecurso, idmodulo) REFERENCES public.modulo(clavecurso, idmodulo);


--
-- Name: modulo pk_modulocurso; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modulo
    ADD CONSTRAINT pk_modulocurso FOREIGN KEY (clavecurso) REFERENCES public.curso(clavecurso);


--
-- PostgreSQL database dump complete
--

