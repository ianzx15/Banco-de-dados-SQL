--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3 (Debian 15.3-1.pgdg120+1)
-- Dumped by pg_dump version 15.4 (Ubuntu 15.4-1.pgdg22.04+1)

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

ALTER TABLE ONLY public.farmacias DROP CONSTRAINT farmacias_tipo_farmacia_excl;
ALTER TABLE ONLY public.farmacias DROP CONSTRAINT farmacias_pkey;
ALTER TABLE ONLY public.farmacias DROP CONSTRAINT farmacias_bairro_key;
DROP TABLE public.farmacias;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: farmacias; Type: TABLE; Schema: public; Owner: ianer
--

CREATE TABLE public.farmacias (
    id_farmacia INTEGER PRIMARY KEY,
    tipo_farmacia character(1),
    bairro character varying(50),
    cidade character varying(50),
    estado public.estados,
    CONSTRAINT farmacias_tipo_farmacia_check CHECK ((tipo_farmacia = ANY (ARRAY['F'::bpchar, 'S'::bpchar])))
);


ALTER TABLE public.farmacias OWNER TO ianer;

--
-- Data for Name: farmacias; Type: TABLE DATA; Schema: public; Owner: ianer
--

INSERT INTO public.farmacias (id_farmacia, tipo_farmacia, bairro, cidade, estado) VALUES (8, NULL, NULL, NULL, 'PB');


--
-- Name: farmacias farmacias_bairro_key; Type: CONSTRAINT; Schema: public; Owner: ianer
--

ALTER TABLE ONLY public.farmacias
    ADD CONSTRAINT farmacias_bairro_key UNIQUE (bairro);


--
-- Name: farmacias farmacias_pkey; Type: CONSTRAINT; Schema: public; Owner: ianer
--

ALTER TABLE ONLY public.farmacias
    ADD CONSTRAINT farmacias_pkey PRIMARY KEY (id_farmacia);


--
-- Name: farmacias farmacias_tipo_farmacia_excl; Type: CONSTRAINT; Schema: public; Owner: ianer
--

ALTER TABLE ONLY public.farmacias
    ADD CONSTRAINT farmacias_tipo_farmacia_excl EXCLUDE USING gist (tipo_farmacia WITH =) WHERE ((tipo_farmacia = 'S'::bpchar));


--
-- PostgreSQL database dump complete
--

