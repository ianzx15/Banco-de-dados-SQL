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

ALTER TABLE ONLY public.funcionario DROP CONSTRAINT funcionario_superior_cpf_fkey;
ALTER TABLE ONLY public.tarefas DROP CONSTRAINT tarefas_pkey;
ALTER TABLE ONLY public.funcionario DROP CONSTRAINT funcionario_pkey;
DROP TABLE public.tarefas;
DROP TABLE public.funcionario;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: funcionario; Type: TABLE; Schema: public; Owner: ianer
--

CREATE TABLE public.funcionario (
    cpf character varying(11) NOT NULL,
    data_nasc date NOT NULL,
    nome character varying(30) NOT NULL,
    funcao character varying(12),
    nivel character(1),
    superior_cpf character varying(11),
    CONSTRAINT funcionario_check CHECK ((((funcao)::text = 'SUP_LIMPEZA'::text) AND (superior_cpf IS NULL))),
    CONSTRAINT funcionario_cpf_check CHECK ((char_length((cpf)::text) = 11)),
    CONSTRAINT funcionario_funcao_check CHECK (((funcao)::text = ANY ((ARRAY['LIMPEZA'::character varying, 'SUP_LIMPEZA'::character varying])::text[]))),
    CONSTRAINT funcionario_nivel_check CHECK ((nivel = ANY (ARRAY['J'::bpchar, 'P'::bpchar, 'S'::bpchar])))
);


ALTER TABLE public.funcionario OWNER TO ianer;

--
-- Name: tarefas; Type: TABLE; Schema: public; Owner: ianer
--

CREATE TABLE public.tarefas (
    id bigint NOT NULL,
    descriacao character varying(50),
    func_resp_cpf character varying(11),
    prioridade integer,
    status character(1),
    CONSTRAINT func_resp_cpf_chk CHECK ((char_length((func_resp_cpf)::text) = 11)),
    CONSTRAINT prioridade_chk CHECK ((prioridade < 32768)),
    CONSTRAINT prioridade_chk2 CHECK ((prioridade = ANY (ARRAY[0, 1, 2, 3, 4, 5]))),
    CONSTRAINT status_chk CHECK ((status = ANY (ARRAY['P'::bpchar, 'E'::bpchar, 'C'::bpchar])))
);


ALTER TABLE public.tarefas OWNER TO ianer;

--
-- Data for Name: funcionario; Type: TABLE DATA; Schema: public; Owner: ianer
--

INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678910', '1980-04-09', 'joao da SIlva', 'SUP_LIMPEZA', 'J', NULL);


--
-- Data for Name: tarefas; Type: TABLE DATA; Schema: public; Owner: ianer
--

INSERT INTO public.tarefas (id, descriacao, func_resp_cpf, prioridade, status) VALUES (2147483653, 'limpar portasa do 1o andar', '32323232911', 2, 'P');
INSERT INTO public.tarefas (id, descriacao, func_resp_cpf, prioridade, status) VALUES (9147483653, 'limpar portasa do 1o andar', '12345678901', 2, 'E');
INSERT INTO public.tarefas (id, descriacao, func_resp_cpf, prioridade, status) VALUES (9147483659, 'limpar portasa do 1o andar', '12345678901', 5, 'E');


--
-- Name: funcionario funcionario_pkey; Type: CONSTRAINT; Schema: public; Owner: ianer
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_pkey PRIMARY KEY (cpf);


--
-- Name: tarefas tarefas_pkey; Type: CONSTRAINT; Schema: public; Owner: ianer
--

ALTER TABLE ONLY public.tarefas
    ADD CONSTRAINT tarefas_pkey PRIMARY KEY (id);


--
-- Name: funcionario funcionario_superior_cpf_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ianer
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_superior_cpf_fkey FOREIGN KEY (superior_cpf) REFERENCES public.funcionario(cpf);


--
-- PostgreSQL database dump complete
--

