--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: citext; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: bounties; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE bounties (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    "desc" text NOT NULL,
    price_cents integer DEFAULT 0 NOT NULL,
    price_currency character varying(255) DEFAULT 'USD'::character varying NOT NULL,
    adult_only boolean DEFAULT false NOT NULL,
    private boolean DEFAULT false NOT NULL,
    url character varying(255),
    user_id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    completed_at timestamp with time zone,
    complete_by timestamp with time zone,
    tag_line character varying(255) NOT NULL,
    artwork_file_name character varying(255),
    artwork_content_type character varying(255),
    artwork_file_size integer,
    artwork_updated_at timestamp with time zone,
    preview_file_name character varying(255),
    preview_content_type character varying(255),
    preview_file_size integer,
    preview_updated_at timestamp with time zone
);


--
-- Name: bounties_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE bounties_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bounties_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE bounties_id_seq OWNED BY bounties.id;


--
-- Name: candidacies; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE candidacies (
    id integer NOT NULL,
    bounty_id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    artist_id integer NOT NULL,
    accepted_at timestamp with time zone
);


--
-- Name: candidacies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE candidacies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: candidacies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE candidacies_id_seq OWNED BY candidacies.id;


--
-- Name: favorites; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE favorites (
    id integer NOT NULL,
    user_id integer NOT NULL,
    bounty_id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: favorites_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE favorites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: favorites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE favorites_id_seq OWNED BY favorites.id;


--
-- Name: moods; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE moods (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: moods_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE moods_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: moods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE moods_id_seq OWNED BY moods.id;


--
-- Name: personalities; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE personalities (
    id integer NOT NULL,
    mood_id integer NOT NULL,
    bounty_id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: personalities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE personalities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: personalities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE personalities_id_seq OWNED BY personalities.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    name character varying(255),
    email citext NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    "rememberToken" character varying(255),
    type character varying(255),
    bio text DEFAULT ''::text NOT NULL,
    bounty_rules text DEFAULT ''::text NOT NULL,
    approved boolean DEFAULT false NOT NULL,
    admin boolean DEFAULT false NOT NULL,
    active boolean
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: votes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE votes (
    id integer NOT NULL,
    user_id integer NOT NULL,
    bounty_id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    vote_type boolean DEFAULT false NOT NULL
);


--
-- Name: votes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE votes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: votes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE votes_id_seq OWNED BY votes.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY bounties ALTER COLUMN id SET DEFAULT nextval('bounties_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY candidacies ALTER COLUMN id SET DEFAULT nextval('candidacies_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY favorites ALTER COLUMN id SET DEFAULT nextval('favorites_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY moods ALTER COLUMN id SET DEFAULT nextval('moods_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY personalities ALTER COLUMN id SET DEFAULT nextval('personalities_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY votes ALTER COLUMN id SET DEFAULT nextval('votes_id_seq'::regclass);


--
-- Name: bounties_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY bounties
    ADD CONSTRAINT bounties_pkey PRIMARY KEY (id);


--
-- Name: candidacies_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY candidacies
    ADD CONSTRAINT candidacies_pkey PRIMARY KEY (id);


--
-- Name: favorites_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY favorites
    ADD CONSTRAINT favorites_pkey PRIMARY KEY (id);


--
-- Name: moods_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY moods
    ADD CONSTRAINT moods_pkey PRIMARY KEY (id);


--
-- Name: personalities_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY personalities
    ADD CONSTRAINT personalities_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: votes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY votes
    ADD CONSTRAINT votes_pkey PRIMARY KEY (id);


--
-- Name: index_bounties_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_bounties_on_name ON bounties USING btree (name);


--
-- Name: index_candidacies_on_bounty_id_and_artist_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_candidacies_on_bounty_id_and_artist_id ON candidacies USING btree (bounty_id, artist_id);


--
-- Name: index_favorites_on_bounty_id_and_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_favorites_on_bounty_id_and_user_id ON favorites USING btree (bounty_id, user_id);


--
-- Name: index_moods_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_moods_on_name ON moods USING btree (name);


--
-- Name: index_personalities_on_bounty_id_and_mood_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_personalities_on_bounty_id_and_mood_id ON personalities USING btree (bounty_id, mood_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_name ON users USING btree (name);


--
-- Name: index_users_on_rememberToken; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX "index_users_on_rememberToken" ON users USING btree ("rememberToken");


--
-- Name: index_votes_on_bounty_id_and_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_votes_on_bounty_id_and_user_id ON votes USING btree (bounty_id, user_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: bounties_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY bounties
    ADD CONSTRAINT bounties_user_id_fk FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: candidacies_artist_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY candidacies
    ADD CONSTRAINT candidacies_artist_id_fk FOREIGN KEY (artist_id) REFERENCES users(id);


--
-- Name: candidacies_bounty_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY candidacies
    ADD CONSTRAINT candidacies_bounty_id_fk FOREIGN KEY (bounty_id) REFERENCES bounties(id);


--
-- Name: favorites_bounty_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY favorites
    ADD CONSTRAINT favorites_bounty_id_fk FOREIGN KEY (bounty_id) REFERENCES bounties(id);


--
-- Name: favorites_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY favorites
    ADD CONSTRAINT favorites_user_id_fk FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: personalities_bounty_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY personalities
    ADD CONSTRAINT personalities_bounty_id_fk FOREIGN KEY (bounty_id) REFERENCES bounties(id);


--
-- Name: personalities_mood_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY personalities
    ADD CONSTRAINT personalities_mood_id_fk FOREIGN KEY (mood_id) REFERENCES moods(id);


--
-- Name: votes_bounty_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY votes
    ADD CONSTRAINT votes_bounty_id_fk FOREIGN KEY (bounty_id) REFERENCES bounties(id);


--
-- Name: votes_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY votes
    ADD CONSTRAINT votes_user_id_fk FOREIGN KEY (user_id) REFERENCES users(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20121208224856');

INSERT INTO schema_migrations (version) VALUES ('20121208224913');

INSERT INTO schema_migrations (version) VALUES ('20121213153053');

INSERT INTO schema_migrations (version) VALUES ('20121217025934');

INSERT INTO schema_migrations (version) VALUES ('20130111005415');

INSERT INTO schema_migrations (version) VALUES ('20130215232154');

INSERT INTO schema_migrations (version) VALUES ('20130217192054');

INSERT INTO schema_migrations (version) VALUES ('20130320214025');

INSERT INTO schema_migrations (version) VALUES ('20130329205315');

INSERT INTO schema_migrations (version) VALUES ('20130411052158');

INSERT INTO schema_migrations (version) VALUES ('20130424022906');

INSERT INTO schema_migrations (version) VALUES ('20130424030418');

INSERT INTO schema_migrations (version) VALUES ('20130428214504');

INSERT INTO schema_migrations (version) VALUES ('20130517043329');

INSERT INTO schema_migrations (version) VALUES ('20130531004603');

INSERT INTO schema_migrations (version) VALUES ('20130531045729');

INSERT INTO schema_migrations (version) VALUES ('20130531224815');

INSERT INTO schema_migrations (version) VALUES ('20130601031418');

INSERT INTO schema_migrations (version) VALUES ('20130601040216');

INSERT INTO schema_migrations (version) VALUES ('20130601041202');

INSERT INTO schema_migrations (version) VALUES ('20130601232452');

INSERT INTO schema_migrations (version) VALUES ('20130602232246');

INSERT INTO schema_migrations (version) VALUES ('20130608023501');

INSERT INTO schema_migrations (version) VALUES ('20130616205259');

INSERT INTO schema_migrations (version) VALUES ('20130621184159');

INSERT INTO schema_migrations (version) VALUES ('20130621184232');

INSERT INTO schema_migrations (version) VALUES ('20130627052728');

INSERT INTO schema_migrations (version) VALUES ('20130705031840');

INSERT INTO schema_migrations (version) VALUES ('20130706233832');

INSERT INTO schema_migrations (version) VALUES ('20130707055723');

INSERT INTO schema_migrations (version) VALUES ('20130707061659');

INSERT INTO schema_migrations (version) VALUES ('20130710183836');

INSERT INTO schema_migrations (version) VALUES ('20130710192322');

INSERT INTO schema_migrations (version) VALUES ('20130711001356');

INSERT INTO schema_migrations (version) VALUES ('20130711055659');

INSERT INTO schema_migrations (version) VALUES ('20130711195843');

INSERT INTO schema_migrations (version) VALUES ('20130712065345');

INSERT INTO schema_migrations (version) VALUES ('20130718052313');
