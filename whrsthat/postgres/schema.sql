--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.1
-- Dumped by pg_dump version 9.6.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: event_photos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE event_photos (
    id integer NOT NULL,
    url character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE event_photos OWNER TO postgres;

--
-- Name: event_photos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE event_photos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE event_photos_id_seq OWNER TO postgres;

--
-- Name: event_photos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE event_photos_id_seq OWNED BY event_photos.id;


--
-- Name: event_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE event_users (
    id integer NOT NULL,
    user_id integer,
    event_id integer,
    accepted boolean,
    number character varying,
    eta character varying,
    place_id character varying
);


ALTER TABLE event_users OWNER TO postgres;

--
-- Name: event_users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE event_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE event_users_id_seq OWNER TO postgres;

--
-- Name: event_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE event_users_id_seq OWNED BY event_users.id;


--
-- Name: events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE events (
    id integer NOT NULL,
    title character varying,
    caption character varying,
    longitude double precision,
    latitude double precision,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id integer,
    event_address character varying,
    time_at timestamp without time zone,
    place_id character varying,
    scheduled boolean,
    eta character varying
);


ALTER TABLE events OWNER TO postgres;

--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE events_id_seq OWNER TO postgres;

--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE events_id_seq OWNED BY events.id;


--
-- Name: invitees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE invitees (
    id integer NOT NULL,
    attending boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    event_id integer,
    user_id integer
);


ALTER TABLE invitees OWNER TO postgres;

--
-- Name: invitees_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE invitees_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE invitees_id_seq OWNER TO postgres;

--
-- Name: invitees_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE invitees_id_seq OWNED BY invitees.id;


--
-- Name: main_images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE main_images (
    id integer NOT NULL,
    url character varying,
    format character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    event_id integer
);


ALTER TABLE main_images OWNER TO postgres;

--
-- Name: main_images_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE main_images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE main_images_id_seq OWNER TO postgres;

--
-- Name: main_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE main_images_id_seq OWNED BY main_images.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE schema_migrations OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE users (
    id integer NOT NULL,
    phone character varying,
    fname character varying,
    lname_initial character varying,
    email character varying,
    prof_img_url character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    password_digest character varying,
    local_ip character varying,
    latitude double precision,
    longitude double precision,
    bio text,
    uber_access_token character varying
);


ALTER TABLE users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: event_photos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY event_photos ALTER COLUMN id SET DEFAULT nextval('event_photos_id_seq'::regclass);


--
-- Name: event_users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY event_users ALTER COLUMN id SET DEFAULT nextval('event_users_id_seq'::regclass);


--
-- Name: events id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY events ALTER COLUMN id SET DEFAULT nextval('events_id_seq'::regclass);


--
-- Name: invitees id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY invitees ALTER COLUMN id SET DEFAULT nextval('invitees_id_seq'::regclass);


--
-- Name: main_images id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY main_images ALTER COLUMN id SET DEFAULT nextval('main_images_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: event_photos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY event_photos (id, url, created_at, updated_at) FROM stdin;
\.


--
-- Name: event_photos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('event_photos_id_seq', 1, false);


--
-- Data for Name: event_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY event_users (id, user_id, event_id, accepted, number, eta, place_id) FROM stdin;
\.


--
-- Name: event_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('event_users_id_seq', 1, false);


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY events (id, title, caption, longitude, latitude, created_at, updated_at, user_id, event_address, time_at, place_id, scheduled, eta) FROM stdin;
\.


--
-- Name: events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('events_id_seq', 1, false);


--
-- Data for Name: invitees; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY invitees (id, attending, created_at, updated_at, event_id, user_id) FROM stdin;
\.


--
-- Name: invitees_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('invitees_id_seq', 1, false);


--
-- Data for Name: main_images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY main_images (id, url, format, created_at, updated_at, event_id) FROM stdin;
\.


--
-- Name: main_images_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('main_images_id_seq', 1, false);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY schema_migrations (version) FROM stdin;
20160210195517
20160210200029
20160210200928
20160210213831
20160210214307
20160210214529
20160211030922
20160211111914
20160211164302
20160211164859
20160211184620
20160212164748
20160212172152
20160212220128
20160212220808
20160212221008
20160213170744
20160213191256
20160213222558
20160213223710
20160214165851
20160214170852
20160214173528
20160214193643
20160214194711
20160215184848
20160215185229
20160215190557
20160215193013
20160215193259
20160216022936
20160216192846
20160217002807
20160217060650
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY users (id, phone, fname, lname_initial, email, prof_img_url, created_at, updated_at, password_digest, local_ip, latitude, longitude, bio, uber_access_token) FROM stdin;
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_id_seq', 1, false);


--
-- Name: event_photos event_photos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY event_photos
    ADD CONSTRAINT event_photos_pkey PRIMARY KEY (id);


--
-- Name: event_users event_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY event_users
    ADD CONSTRAINT event_users_pkey PRIMARY KEY (id);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: invitees invitees_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY invitees
    ADD CONSTRAINT invitees_pkey PRIMARY KEY (id);


--
-- Name: main_images main_images_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY main_images
    ADD CONSTRAINT main_images_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_event_users_on_event_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_event_users_on_event_id ON event_users USING btree (event_id);


--
-- Name: index_event_users_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_event_users_on_user_id ON event_users USING btree (user_id);


--
-- Name: index_events_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_events_on_user_id ON events USING btree (user_id);


--
-- Name: index_invitees_on_event_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_invitees_on_event_id ON invitees USING btree (event_id);


--
-- Name: index_invitees_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_invitees_on_user_id ON invitees USING btree (user_id);


--
-- Name: index_main_images_on_event_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_main_images_on_event_id ON main_images USING btree (event_id);


--
-- Name: index_users_on_phone_and_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_users_on_phone_and_email ON users USING btree (phone, email);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: events fk_rails_0cb5590091; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY events
    ADD CONSTRAINT fk_rails_0cb5590091 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: invitees fk_rails_1ff1eec636; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY invitees
    ADD CONSTRAINT fk_rails_1ff1eec636 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: invitees fk_rails_2c23fd104e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY invitees
    ADD CONSTRAINT fk_rails_2c23fd104e FOREIGN KEY (event_id) REFERENCES events(id);


--
-- Name: main_images fk_rails_349bcd3dd1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY main_images
    ADD CONSTRAINT fk_rails_349bcd3dd1 FOREIGN KEY (event_id) REFERENCES events(id);


--
-- PostgreSQL database dump complete
--

