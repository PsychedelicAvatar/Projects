--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2
-- Dumped by pg_dump version 14.2

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
-- Name: tablefunc; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS tablefunc WITH SCHEMA public;


--
-- Name: EXTENSION tablefunc; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION tablefunc IS 'functions that manipulate whole tables, including crosstab';


--
-- Name: incc; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.incc
    START WITH 500
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.incc OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: books; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.books (
    id integer DEFAULT nextval('public.incc'::regclass) NOT NULL,
    name character varying,
    author character varying,
    subject character varying,
    price numeric,
    isbn bigint
);


ALTER TABLE public.books OWNER TO postgres;

--
-- Name: copies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.copies (
    id integer NOT NULL,
    book_id integer,
    rack integer,
    status text DEFAULT 'available'::text
);


ALTER TABLE public.copies OWNER TO postgres;

--
-- Name: copies_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.copies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.copies_id_seq OWNER TO postgres;

--
-- Name: copies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.copies_id_seq OWNED BY public.copies.id;


--
-- Name: issuecard; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.issuecard (
    id integer NOT NULL,
    copyid integer,
    memberid integer,
    issuedate date DEFAULT CURRENT_DATE,
    return_due_date date DEFAULT (CURRENT_DATE + 7),
    return_date date
);


ALTER TABLE public.issuecard OWNER TO postgres;

--
-- Name: issuecard_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.issuecard_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.issuecard_seq OWNER TO postgres;

--
-- Name: issuecard_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.issuecard_seq OWNED BY public.issuecard.id;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payments (
    id integer NOT NULL,
    user_id integer,
    amount numeric,
    type character varying,
    transaction_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    next_payment_duedate date DEFAULT (CURRENT_DATE + 7)
);


ALTER TABLE public.payments OWNER TO postgres;

--
-- Name: payment_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payment_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payment_seq OWNER TO postgres;

--
-- Name: payment_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payment_seq OWNED BY public.payments.id;


--
-- Name: test; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.test (
    id integer NOT NULL,
    name text
);


ALTER TABLE public.test OWNER TO postgres;

--
-- Name: testseq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.testseq
    START WITH 50
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.testseq OWNER TO postgres;

--
-- Name: testseq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.testseq OWNED BY public.test.id;


--
-- Name: user1; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user1 (
    id integer NOT NULL,
    name character varying,
    email character varying,
    phone_no bigint,
    password character varying,
    role character varying
);


ALTER TABLE public.user1 OWNER TO postgres;

--
-- Name: user1_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user1_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user1_seq OWNER TO postgres;

--
-- Name: user1_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user1_seq OWNED BY public.user1.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying,
    email character varying,
    phone_no bigint,
    password character varying,
    role character varying
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: copies id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.copies ALTER COLUMN id SET DEFAULT nextval('public.copies_id_seq'::regclass);


--
-- Name: issuecard id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.issuecard ALTER COLUMN id SET DEFAULT nextval('public.issuecard_seq'::regclass);


--
-- Name: payments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments ALTER COLUMN id SET DEFAULT nextval('public.payment_seq'::regclass);


--
-- Name: user1 id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user1 ALTER COLUMN id SET DEFAULT nextval('public.user1_seq'::regclass);


--
-- Data for Name: books; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.books (id, name, author, subject, price, isbn) FROM stdin;
7	ms dhoni untold story	msd	motivation	445.0	53465464
8	harry potter	j.k.rowling	fantasy	1000	6546465
9	avatar	amit	fantasy	1040	6446465
10	dunes	amey	fantasy	6546	465465
11	adam and eve	\N	\N	\N	\N
\.


--
-- Data for Name: copies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.copies (id, book_id, rack, status) FROM stdin;
1	7	1	available
2	7	1	available
3	7	1	not available
5	8	1	not available
6	8	1	available
8	9	1	not available
11	10	1	not available
12	10	1	not available
4	8	1	not available
7	9	1	available
10	10	1	not available
\.


--
-- Data for Name: issuecard; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.issuecard (id, copyid, memberid, issuedate, return_due_date, return_date) FROM stdin;
1	1	2	2022-06-12	2022-06-19	\N
3	4	1	2022-06-12	2022-06-19	2022-06-29
8	10	2	2022-06-24	2022-07-01	\N
9	\N	2	2022-06-24	2022-07-01	\N
10	\N	2	2022-06-24	2022-07-01	\N
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payments (id, user_id, amount, type, transaction_time, next_payment_duedate) FROM stdin;
1	2	500	cash	2022-06-24 00:40:48.282834	\N
2	2	500.0	cash	2022-06-24 00:45:07.968061	\N
3	2	500.0	cash	2022-06-24 00:55:01.422094	\N
\.


--
-- Data for Name: test; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.test (id, name) FROM stdin;
55	amit
56	adi
57	abhi
58	abu
59	amey
\.


--
-- Data for Name: user1; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user1 (id, name, email, phone_no, password, role) FROM stdin;
1	amit	amit.com	6546532	sing	member
2	abu	abu@gmail.com	981495654	shaikh	member
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, phone_no, password, role) FROM stdin;
\.


--
-- Name: copies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.copies_id_seq', 2, true);


--
-- Name: incc; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.incc', 11, true);


--
-- Name: issuecard_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.issuecard_seq', 10, true);


--
-- Name: payment_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payment_seq', 3, true);


--
-- Name: testseq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.testseq', 89, true);


--
-- Name: user1_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user1_seq', 2, true);


--
-- Name: books books_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_pkey PRIMARY KEY (id);


--
-- Name: copies copies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.copies
    ADD CONSTRAINT copies_pkey PRIMARY KEY (id);


--
-- Name: issuecard issuecard_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.issuecard
    ADD CONSTRAINT issuecard_pkey PRIMARY KEY (id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: user1 user1_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user1
    ADD CONSTRAINT user1_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: issuecard copies_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.issuecard
    ADD CONSTRAINT copies_fkey FOREIGN KEY (copyid) REFERENCES public.copies(id);


--
-- Name: copies fk_copies_book_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.copies
    ADD CONSTRAINT fk_copies_book_id FOREIGN KEY (book_id) REFERENCES public.books(id);


--
-- Name: payments payment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payment_fkey FOREIGN KEY (user_id) REFERENCES public.user1(id);


--
-- Name: issuecard user1_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.issuecard
    ADD CONSTRAINT user1_fkey FOREIGN KEY (memberid) REFERENCES public.user1(id);


--
-- Name: TABLE books; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.books TO abu;


--
-- Name: TABLE user1; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.user1 TO amit;
GRANT ALL ON TABLE public.user1 TO abu;


--
-- PostgreSQL database dump complete
--

