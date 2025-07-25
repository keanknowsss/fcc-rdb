--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(22) NOT NULL,
    games_played integer DEFAULT 0,
    best_game integer
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES (2, 'Maria', 0, 0);
INSERT INTO public.users VALUES (3, '5', 0, 0);
INSERT INTO public.users VALUES (4, 'user_1753015580172', 0, 0);
INSERT INTO public.users VALUES (5, 'user_1753015580171', 0, 0);
INSERT INTO public.users VALUES (7, 'user_1753017182955', 0, 639);
INSERT INTO public.users VALUES (6, 'user_1753017182956', 0, 769);
INSERT INTO public.users VALUES (8, 'user_1753017226681', 0, 919);
INSERT INTO public.users VALUES (9, 'user_1753017226680', 0, 954);
INSERT INTO public.users VALUES (10, 'user_1753017463968', 0, 837);
INSERT INTO public.users VALUES (26, 'user_1753018761056', 2, 0);
INSERT INTO public.users VALUES (11, 'user_1753017463967', 0, 661);
INSERT INTO public.users VALUES (12, 'Bea', 0, 3);
INSERT INTO public.users VALUES (25, 'user_1753018761057', 5, 0);
INSERT INTO public.users VALUES (14, 'user_1753018011557', 2, 0);
INSERT INTO public.users VALUES (13, 'user_1753018011558', 5, 0);
INSERT INTO public.users VALUES (28, 'user_1753018877056', 2, 155);
INSERT INTO public.users VALUES (16, 'user_1753018313542', 2, 0);
INSERT INTO public.users VALUES (27, 'user_1753018877057', 5, 49);
INSERT INTO public.users VALUES (15, 'user_1753018313543', 5, 0);
INSERT INTO public.users VALUES (1, 'John', 4, 2);
INSERT INTO public.users VALUES (18, 'user_1753018503079', 2, 0);
INSERT INTO public.users VALUES (29, 'Justine', 1, 1);
INSERT INTO public.users VALUES (17, 'user_1753018503080', 5, 0);
INSERT INTO public.users VALUES (20, 'user_1753018520251', 2, 0);
INSERT INTO public.users VALUES (19, 'user_1753018520252', 5, 0);
INSERT INTO public.users VALUES (22, 'user_1753018588669', 2, 0);
INSERT INTO public.users VALUES (31, 'user_1753021194578', 2, 810);
INSERT INTO public.users VALUES (21, 'user_1753018588670', 5, 0);
INSERT INTO public.users VALUES (30, 'user_1753021194579', 5, 120);
INSERT INTO public.users VALUES (24, 'user_1753018631556', 2, 0);
INSERT INTO public.users VALUES (23, 'user_1753018631557', 5, 0);
INSERT INTO public.users VALUES (33, 'user_1753021235568', 2, 72);
INSERT INTO public.users VALUES (32, 'user_1753021235569', 5, 377);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.users_user_id_seq', 33, true);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- PostgreSQL database dump complete
--

