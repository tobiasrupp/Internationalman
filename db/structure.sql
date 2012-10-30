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
-- Name: unaccent; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA public;


--
-- Name: EXTENSION unaccent; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION unaccent IS 'text search dictionary that removes accents';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: active_admin_comments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE active_admin_comments (
    id integer NOT NULL,
    resource_id character varying(255) NOT NULL,
    resource_type character varying(255) NOT NULL,
    author_id integer,
    author_type character varying(255),
    body text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    namespace character varying(255)
);


--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE active_admin_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE active_admin_comments_id_seq OWNED BY active_admin_comments.id;


--
-- Name: admin_users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE admin_users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: admin_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE admin_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE admin_users_id_seq OWNED BY admin_users.id;


--
-- Name: article_categories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE article_categories (
    article_id integer,
    category_id integer
);


--
-- Name: article_translations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE article_translations (
    id integer NOT NULL,
    article_id integer,
    locale character varying(255),
    title character varying(255),
    short_title character varying(255),
    url_title character varying(255),
    article_type character varying(255),
    ctry character varying(255),
    language character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    web_page character varying(255),
    viewer_url character varying(255),
    embed_code text
);


--
-- Name: article_translations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE article_translations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: article_translations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE article_translations_id_seq OWNED BY article_translations.id;


--
-- Name: articles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE articles (
    id integer NOT NULL,
    title character varying(255),
    language character varying(255),
    longitude character varying(255),
    latitude character varying(255),
    article_type character varying(255),
    published_date date,
    published_in character varying(255),
    author character varying(255),
    photos_by character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    url_title character varying(255),
    embed_code text,
    short_title character varying(255),
    viewer_url character varying(255),
    teaser_image_file_name character varying(255),
    teaser_image_content_type character varying(255),
    teaser_image_file_size integer,
    teaser_image_updated_at timestamp without time zone,
    country character varying(255),
    filename character varying(255),
    ctry character varying(255),
    web_page character varying(255),
    source_file_file_name character varying(255),
    source_file_content_type character varying(255),
    source_file_file_size integer,
    source_file_updated_at timestamp without time zone,
    copyright_cleared boolean,
    teaser_image_en_file_name character varying(255),
    teaser_image_en_content_type character varying(255),
    teaser_image_en_file_size integer,
    teaser_image_en_updated_at timestamp without time zone,
    source_file_en_file_name character varying(255),
    source_file_en_content_type character varying(255),
    source_file_en_file_size integer,
    source_file_en_updated_at timestamp without time zone,
    lat double precision,
    lon double precision,
    gmaps boolean,
    address character varying(255)
);


--
-- Name: articles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE articles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: articles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE articles_id_seq OWNED BY articles.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE categories (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    display_sequence integer,
    display_section integer,
    url_name character varying(255),
    url_title character varying(255),
    language character varying(255)
);


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE categories_id_seq OWNED BY categories.id;


--
-- Name: category_translations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE category_translations (
    id integer NOT NULL,
    category_id integer,
    locale character varying(255),
    name character varying(255),
    url_name character varying(255),
    language character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: category_translations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE category_translations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: category_translations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE category_translations_id_seq OWNED BY category_translations.id;


--
-- Name: page_translations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE page_translations (
    id integer NOT NULL,
    page_id integer,
    locale character varying(255),
    title character varying(255),
    body text,
    language character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: page_translations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE page_translations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: page_translations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE page_translations_id_seq OWNED BY page_translations.id;


--
-- Name: pages; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pages (
    id integer NOT NULL,
    page_type character varying(255),
    body text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    title character varying(255),
    language character varying(255)
);


--
-- Name: pages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pages_id_seq OWNED BY pages.id;


--
-- Name: pg_search_documents; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pg_search_documents (
    id integer NOT NULL,
    content text,
    searchable_id integer,
    searchable_type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: pg_search_documents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pg_search_documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pg_search_documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pg_search_documents_id_seq OWNED BY pg_search_documents.id;


--
-- Name: post_categories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE post_categories (
    id integer NOT NULL,
    post_id integer,
    category_id integer
);


--
-- Name: post_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE post_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: post_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE post_categories_id_seq OWNED BY post_categories.id;


--
-- Name: post_translations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE post_translations (
    id integer NOT NULL,
    post_id integer,
    locale character varying(255),
    title character varying(255),
    short_title character varying(255),
    url_title character varying(255),
    ctry character varying(255),
    language character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    text text,
    text_2 text
);


--
-- Name: post_translations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE post_translations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: post_translations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE post_translations_id_seq OWNED BY post_translations.id;


--
-- Name: posts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE posts (
    id integer NOT NULL,
    title character varying(255),
    short_title character varying(255),
    url_title character varying(255),
    language character varying(255),
    author character varying(255),
    text text,
    country character varying(255),
    latitude character varying(255),
    longitude character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    publication_state character varying(255),
    allow_comments boolean,
    image_1_file_name character varying(255),
    image_1_content_type character varying(255),
    image_1_file_size integer,
    image_1_updated_at timestamp without time zone,
    image_1_options character varying(255),
    image_2_file_name character varying(255),
    image_2_content_type character varying(255),
    image_2_file_size integer,
    image_2_updated_at timestamp without time zone,
    image_2_options character varying(255),
    text_2 text,
    ctry character varying(255),
    lat double precision,
    lon double precision,
    gmaps boolean,
    address character varying(255)
);


--
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE posts_id_seq OWNED BY posts.id;


--
-- Name: radio_track_categories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE radio_track_categories (
    id integer NOT NULL,
    radio_track_id integer,
    category_id integer
);


--
-- Name: radio_track_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE radio_track_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: radio_track_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE radio_track_categories_id_seq OWNED BY radio_track_categories.id;


--
-- Name: radio_track_translations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE radio_track_translations (
    id integer NOT NULL,
    radio_track_id integer,
    locale character varying(255),
    title character varying(255),
    short_title character varying(255),
    url_title character varying(255),
    ctry character varying(255),
    language character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    web_page character varying(255),
    source_url character varying(255)
);


--
-- Name: radio_track_translations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE radio_track_translations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: radio_track_translations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE radio_track_translations_id_seq OWNED BY radio_track_translations.id;


--
-- Name: radio_tracks; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE radio_tracks (
    id integer NOT NULL,
    title character varying(255),
    short_title character varying(255),
    url_title character varying(255),
    language character varying(255),
    country character varying(255),
    longitude character varying(255),
    latitude character varying(255),
    duration integer,
    broadcast_date date,
    broadcaster character varying(255),
    filename character varying(255),
    author character varying(255),
    source_url character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    web_page character varying(255),
    ctry character varying(255),
    copyright_cleared boolean,
    lat double precision,
    lon double precision,
    gmaps boolean,
    address character varying(255)
);


--
-- Name: radio_tracks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE radio_tracks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: radio_tracks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE radio_tracks_id_seq OWNED BY radio_tracks.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: status_message_translations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE status_message_translations (
    id integer NOT NULL,
    status_message_id integer,
    locale character varying(255),
    text character varying(255),
    language character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: status_message_translations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE status_message_translations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: status_message_translations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE status_message_translations_id_seq OWNED BY status_message_translations.id;


--
-- Name: status_messages; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE status_messages (
    id integer NOT NULL,
    text character varying(255),
    language character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tweet_id character varying(255),
    tweet_screen_name character varying(255),
    tweet_created_at timestamp without time zone
);


--
-- Name: status_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE status_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: status_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE status_messages_id_seq OWNED BY status_messages.id;


--
-- Name: video_categories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE video_categories (
    id integer NOT NULL,
    video_id integer,
    category_id integer
);


--
-- Name: video_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE video_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: video_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE video_categories_id_seq OWNED BY video_categories.id;


--
-- Name: video_translations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE video_translations (
    id integer NOT NULL,
    video_id integer,
    locale character varying(255),
    title character varying(255),
    short_title character varying(255),
    url_title character varying(255),
    ctry character varying(255),
    language character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    embed_code text,
    web_page character varying(255),
    source_url character varying(255),
    video_width character varying(255),
    video_height character varying(255),
    video_aspect_ratio character varying(255)
);


--
-- Name: video_translations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE video_translations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: video_translations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE video_translations_id_seq OWNED BY video_translations.id;


--
-- Name: videos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE videos (
    id integer NOT NULL,
    title character varying(255),
    short_title character varying(255),
    url_title character varying(255),
    language character varying(255),
    country character varying(255),
    longitude character varying(255),
    latitude character varying(255),
    duration integer,
    broadcast_date date,
    broadcaster character varying(255),
    filename character varying(255),
    author character varying(255),
    source_url character varying(255),
    web_page character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    embed_code text,
    camera_by character varying(255),
    ctry character varying(255),
    copyright_cleared boolean,
    lat double precision,
    lon double precision,
    gmaps boolean,
    address character varying(255),
    video_width character varying(255),
    video_height character varying(255),
    video_aspect_ratio character varying(255),
    teaser_image_file_name character varying(255),
    teaser_image_content_type character varying(255),
    teaser_image_file_size integer,
    teaser_image_updated_at timestamp without time zone,
    teaser_image_en_file_name character varying(255),
    teaser_image_en_content_type character varying(255),
    teaser_image_en_file_size integer,
    teaser_image_en_updated_at timestamp without time zone
);


--
-- Name: videos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE videos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: videos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE videos_id_seq OWNED BY videos.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY active_admin_comments ALTER COLUMN id SET DEFAULT nextval('active_admin_comments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY admin_users ALTER COLUMN id SET DEFAULT nextval('admin_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY article_translations ALTER COLUMN id SET DEFAULT nextval('article_translations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY articles ALTER COLUMN id SET DEFAULT nextval('articles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY categories ALTER COLUMN id SET DEFAULT nextval('categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY category_translations ALTER COLUMN id SET DEFAULT nextval('category_translations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY page_translations ALTER COLUMN id SET DEFAULT nextval('page_translations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pages ALTER COLUMN id SET DEFAULT nextval('pages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pg_search_documents ALTER COLUMN id SET DEFAULT nextval('pg_search_documents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY post_categories ALTER COLUMN id SET DEFAULT nextval('post_categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY post_translations ALTER COLUMN id SET DEFAULT nextval('post_translations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY posts ALTER COLUMN id SET DEFAULT nextval('posts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY radio_track_categories ALTER COLUMN id SET DEFAULT nextval('radio_track_categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY radio_track_translations ALTER COLUMN id SET DEFAULT nextval('radio_track_translations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY radio_tracks ALTER COLUMN id SET DEFAULT nextval('radio_tracks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY status_message_translations ALTER COLUMN id SET DEFAULT nextval('status_message_translations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY status_messages ALTER COLUMN id SET DEFAULT nextval('status_messages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY video_categories ALTER COLUMN id SET DEFAULT nextval('video_categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY video_translations ALTER COLUMN id SET DEFAULT nextval('video_translations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY videos ALTER COLUMN id SET DEFAULT nextval('videos_id_seq'::regclass);


--
-- Name: admin_notes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY active_admin_comments
    ADD CONSTRAINT admin_notes_pkey PRIMARY KEY (id);


--
-- Name: admin_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY admin_users
    ADD CONSTRAINT admin_users_pkey PRIMARY KEY (id);


--
-- Name: article_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY article_translations
    ADD CONSTRAINT article_translations_pkey PRIMARY KEY (id);


--
-- Name: articles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY articles
    ADD CONSTRAINT articles_pkey PRIMARY KEY (id);


--
-- Name: categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: category_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY category_translations
    ADD CONSTRAINT category_translations_pkey PRIMARY KEY (id);


--
-- Name: page_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY page_translations
    ADD CONSTRAINT page_translations_pkey PRIMARY KEY (id);


--
-- Name: pages_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (id);


--
-- Name: pg_search_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pg_search_documents
    ADD CONSTRAINT pg_search_documents_pkey PRIMARY KEY (id);


--
-- Name: post_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY post_categories
    ADD CONSTRAINT post_categories_pkey PRIMARY KEY (id);


--
-- Name: post_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY post_translations
    ADD CONSTRAINT post_translations_pkey PRIMARY KEY (id);


--
-- Name: posts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- Name: radio_track_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY radio_track_categories
    ADD CONSTRAINT radio_track_categories_pkey PRIMARY KEY (id);


--
-- Name: radio_track_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY radio_track_translations
    ADD CONSTRAINT radio_track_translations_pkey PRIMARY KEY (id);


--
-- Name: radio_tracks_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY radio_tracks
    ADD CONSTRAINT radio_tracks_pkey PRIMARY KEY (id);


--
-- Name: status_message_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY status_message_translations
    ADD CONSTRAINT status_message_translations_pkey PRIMARY KEY (id);


--
-- Name: status_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY status_messages
    ADD CONSTRAINT status_messages_pkey PRIMARY KEY (id);


--
-- Name: video_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY video_categories
    ADD CONSTRAINT video_categories_pkey PRIMARY KEY (id);


--
-- Name: video_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY video_translations
    ADD CONSTRAINT video_translations_pkey PRIMARY KEY (id);


--
-- Name: videos_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY videos
    ADD CONSTRAINT videos_pkey PRIMARY KEY (id);


--
-- Name: index_7294d366b6a9642970246bf3caa310a84f7ed68e; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_7294d366b6a9642970246bf3caa310a84f7ed68e ON status_message_translations USING btree (status_message_id);


--
-- Name: index_active_admin_comments_on_author_type_and_author_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_active_admin_comments_on_author_type_and_author_id ON active_admin_comments USING btree (author_type, author_id);


--
-- Name: index_active_admin_comments_on_namespace; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_active_admin_comments_on_namespace ON active_admin_comments USING btree (namespace);


--
-- Name: index_admin_notes_on_resource_type_and_resource_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_admin_notes_on_resource_type_and_resource_id ON active_admin_comments USING btree (resource_type, resource_id);


--
-- Name: index_admin_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_admin_users_on_email ON admin_users USING btree (email);


--
-- Name: index_admin_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_admin_users_on_reset_password_token ON admin_users USING btree (reset_password_token);


--
-- Name: index_article_categories_on_article_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_article_categories_on_article_id ON article_categories USING btree (article_id);


--
-- Name: index_article_categories_on_category_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_article_categories_on_category_id ON article_categories USING btree (category_id);


--
-- Name: index_article_translations_on_article_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_article_translations_on_article_id ON article_translations USING btree (article_id);


--
-- Name: index_article_translations_on_locale; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_article_translations_on_locale ON article_translations USING btree (locale);


--
-- Name: index_category_translations_on_category_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_category_translations_on_category_id ON category_translations USING btree (category_id);


--
-- Name: index_category_translations_on_locale; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_category_translations_on_locale ON category_translations USING btree (locale);


--
-- Name: index_page_translations_on_locale; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_page_translations_on_locale ON page_translations USING btree (locale);


--
-- Name: index_page_translations_on_page_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_page_translations_on_page_id ON page_translations USING btree (page_id);


--
-- Name: index_post_categories_on_category_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_post_categories_on_category_id ON post_categories USING btree (category_id);


--
-- Name: index_post_categories_on_post_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_post_categories_on_post_id ON post_categories USING btree (post_id);


--
-- Name: index_post_translations_on_locale; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_post_translations_on_locale ON post_translations USING btree (locale);


--
-- Name: index_post_translations_on_post_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_post_translations_on_post_id ON post_translations USING btree (post_id);


--
-- Name: index_radio_track_categories_on_category_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_radio_track_categories_on_category_id ON radio_track_categories USING btree (category_id);


--
-- Name: index_radio_track_categories_on_radio_track_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_radio_track_categories_on_radio_track_id ON radio_track_categories USING btree (radio_track_id);


--
-- Name: index_radio_track_translations_on_locale; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_radio_track_translations_on_locale ON radio_track_translations USING btree (locale);


--
-- Name: index_radio_track_translations_on_radio_track_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_radio_track_translations_on_radio_track_id ON radio_track_translations USING btree (radio_track_id);


--
-- Name: index_status_message_translations_on_locale; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_status_message_translations_on_locale ON status_message_translations USING btree (locale);


--
-- Name: index_video_categories_on_category_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_video_categories_on_category_id ON video_categories USING btree (category_id);


--
-- Name: index_video_categories_on_video_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_video_categories_on_video_id ON video_categories USING btree (video_id);


--
-- Name: index_video_translations_on_locale; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_video_translations_on_locale ON video_translations USING btree (locale);


--
-- Name: index_video_translations_on_video_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_video_translations_on_video_id ON video_translations USING btree (video_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

INSERT INTO schema_migrations (version) VALUES ('0');

INSERT INTO schema_migrations (version) VALUES ('20120816210514');

INSERT INTO schema_migrations (version) VALUES ('20120816211030');

INSERT INTO schema_migrations (version) VALUES ('20120816211128');

INSERT INTO schema_migrations (version) VALUES ('20120816213505');

INSERT INTO schema_migrations (version) VALUES ('20120816223512');

INSERT INTO schema_migrations (version) VALUES ('20120816223513');

INSERT INTO schema_migrations (version) VALUES ('20120817002811');

INSERT INTO schema_migrations (version) VALUES ('20120817101906');

INSERT INTO schema_migrations (version) VALUES ('20120817170226');

INSERT INTO schema_migrations (version) VALUES ('20120817172210');

INSERT INTO schema_migrations (version) VALUES ('20120817182733');

INSERT INTO schema_migrations (version) VALUES ('20120817182915');

INSERT INTO schema_migrations (version) VALUES ('20120818131341');

INSERT INTO schema_migrations (version) VALUES ('20120820161743');

INSERT INTO schema_migrations (version) VALUES ('20120820165747');

INSERT INTO schema_migrations (version) VALUES ('20120821085640');

INSERT INTO schema_migrations (version) VALUES ('20120821092329');

INSERT INTO schema_migrations (version) VALUES ('20120821231655');

INSERT INTO schema_migrations (version) VALUES ('20120822193024');

INSERT INTO schema_migrations (version) VALUES ('20120822195044');

INSERT INTO schema_migrations (version) VALUES ('20120822200559');

INSERT INTO schema_migrations (version) VALUES ('20120822201934');

INSERT INTO schema_migrations (version) VALUES ('20120823120623');

INSERT INTO schema_migrations (version) VALUES ('20120823120813');

INSERT INTO schema_migrations (version) VALUES ('20120823164151');

INSERT INTO schema_migrations (version) VALUES ('20120824082801');

INSERT INTO schema_migrations (version) VALUES ('20120824083013');

INSERT INTO schema_migrations (version) VALUES ('20120824091222');

INSERT INTO schema_migrations (version) VALUES ('20120824180525');

INSERT INTO schema_migrations (version) VALUES ('20120825100705');

INSERT INTO schema_migrations (version) VALUES ('20120825102754');

INSERT INTO schema_migrations (version) VALUES ('20120825173458');

INSERT INTO schema_migrations (version) VALUES ('20120825175348');

INSERT INTO schema_migrations (version) VALUES ('20120826141512');

INSERT INTO schema_migrations (version) VALUES ('20120828192658');

INSERT INTO schema_migrations (version) VALUES ('20120828192843');

INSERT INTO schema_migrations (version) VALUES ('20120829193519');

INSERT INTO schema_migrations (version) VALUES ('20120829193616');

INSERT INTO schema_migrations (version) VALUES ('20120829205404');

INSERT INTO schema_migrations (version) VALUES ('20120829210354');

INSERT INTO schema_migrations (version) VALUES ('20120830122827');

INSERT INTO schema_migrations (version) VALUES ('20120830130132');

INSERT INTO schema_migrations (version) VALUES ('20120830130200');

INSERT INTO schema_migrations (version) VALUES ('20120830130350');

INSERT INTO schema_migrations (version) VALUES ('20120830134203');

INSERT INTO schema_migrations (version) VALUES ('20120830141109');

INSERT INTO schema_migrations (version) VALUES ('20120830183650');

INSERT INTO schema_migrations (version) VALUES ('20120904195650');

INSERT INTO schema_migrations (version) VALUES ('20120910114100');

INSERT INTO schema_migrations (version) VALUES ('20120910114719');

INSERT INTO schema_migrations (version) VALUES ('20120910191642');

INSERT INTO schema_migrations (version) VALUES ('20120910191726');

INSERT INTO schema_migrations (version) VALUES ('20120910191751');

INSERT INTO schema_migrations (version) VALUES ('20120913161107');

INSERT INTO schema_migrations (version) VALUES ('20120913165754');

INSERT INTO schema_migrations (version) VALUES ('20120914092533');

INSERT INTO schema_migrations (version) VALUES ('20120914092755');

INSERT INTO schema_migrations (version) VALUES ('20120914105829');

INSERT INTO schema_migrations (version) VALUES ('20120915004405');

INSERT INTO schema_migrations (version) VALUES ('20120915012233');

INSERT INTO schema_migrations (version) VALUES ('20120915012440');

INSERT INTO schema_migrations (version) VALUES ('20120915230824');

INSERT INTO schema_migrations (version) VALUES ('20120915230909');

INSERT INTO schema_migrations (version) VALUES ('20120915230940');

INSERT INTO schema_migrations (version) VALUES ('20120916013932');

INSERT INTO schema_migrations (version) VALUES ('20120918225026');

INSERT INTO schema_migrations (version) VALUES ('20120918230039');

INSERT INTO schema_migrations (version) VALUES ('20120918230415');

INSERT INTO schema_migrations (version) VALUES ('20120918234244');

INSERT INTO schema_migrations (version) VALUES ('20121004202852');

INSERT INTO schema_migrations (version) VALUES ('20121004234454');

INSERT INTO schema_migrations (version) VALUES ('20121009123346');

INSERT INTO schema_migrations (version) VALUES ('20121009155718');