--
-- PostgreSQL database dump
--

-- Dumped from database version 11.13
-- Dumped by pg_dump version 11.17 (Ubuntu 11.17-1.pgdg20.04+1)

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

ALTER TABLE public.faq ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.email_brands ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.caspio_access_token ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.api_tokens ALTER COLUMN id DROP DEFAULT;
DROP TABLE public.users;
DROP TABLE public.three_six_five_coverages;
DROP TABLE public.tags;
DROP TABLE public.table_record_deletes_on_db_three_six_five;
DROP TABLE public.sessions;
DROP TABLE public.services;
DROP TABLE public.schema_migrations;
DROP TABLE public.providers;
DROP TABLE public.provider_nodes;
DROP TABLE public.provider_files;
DROP TABLE public.provider_bank_accounts;
DROP TABLE public.provider_accreditations;
DROP TABLE public.membership_coverages;
DROP TABLE public.guardian_tokens;
DROP SEQUENCE public.faq_id_seq;
DROP TABLE public.faq;
DROP SEQUENCE public.email_brands_id_seq;
DROP TABLE public.email_brands;
DROP TABLE public.document_tags;
DROP TABLE public.coverages;
DROP SEQUENCE public.caspio_access_token_id_seq;
DROP TABLE public.caspio_access_token;
DROP SEQUENCE public.api_tokens_id_seq;
DROP TABLE public.api_tokens;
DROP TABLE public._temp_com_doc_ids;
DROP FUNCTION public.func_record_deletes();
--
-- Name: func_record_deletes(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.func_record_deletes() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
  BEGIN
    IF (TG_OP = 'DELETE') THEN
      INSERT INTO table_record_deletes_on_db SELECT now(), user, OLD.id, 'three_six_five', TG_TABLE_NAME;
      RETURN OLD;
    END IF;
    RETURN NULL; -- result is ignored since this is an AFTER trigger
  END $$;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: _temp_com_doc_ids; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._temp_com_doc_ids (
    document_id uuid
);


--
-- Name: api_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.api_tokens (
    id bigint NOT NULL,
    brand character varying(255),
    token character varying(255),
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    brand_slug character varying(255) NOT NULL
);


--
-- Name: api_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.api_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: api_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.api_tokens_id_seq OWNED BY public.api_tokens.id;


--
-- Name: caspio_access_token; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.caspio_access_token (
    id bigint NOT NULL,
    access_token text,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: caspio_access_token_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.caspio_access_token_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: caspio_access_token_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.caspio_access_token_id_seq OWNED BY public.caspio_access_token.id;


--
-- Name: coverages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.coverages (
    id uuid NOT NULL,
    name character varying(255),
    description text,
    cooling_off_period text,
    towing_distance_cover text,
    towing_special_instructions text,
    battery_distance_cover text,
    battery_replacement_cover text,
    emergency_fuel_cover text,
    locksmith_distance_cover text,
    locksmith_cost_cover text,
    accomodation_cost_cover text,
    taxi_cost_cover text,
    rental_car_cost_cover text,
    trailer_cover text,
    agistment text,
    comments text,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: document_tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.document_tags (
    id uuid NOT NULL,
    document_id uuid,
    tag_id uuid,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    document_type character varying(255)
);


--
-- Name: email_brands; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.email_brands (
    id bigint NOT NULL,
    brand character varying(255),
    white_label boolean DEFAULT false NOT NULL,
    email_type jsonb,
    logo_url character varying(255),
    primary_color character varying(255),
    broker_email character varying(255),
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    sms_types jsonb,
    only_email_broker boolean
);


--
-- Name: email_brands_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.email_brands_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: email_brands_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.email_brands_id_seq OWNED BY public.email_brands.id;


--
-- Name: faq; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.faq (
    id bigint NOT NULL,
    question text,
    answer text,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: faq_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.faq_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: faq_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.faq_id_seq OWNED BY public.faq.id;


--
-- Name: guardian_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.guardian_tokens (
    jti character varying(255) NOT NULL,
    aud character varying(255) NOT NULL,
    typ character varying(255),
    iss character varying(255),
    sub character varying(255),
    exp bigint,
    jwt text,
    claims jsonb,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: membership_coverages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.membership_coverages (
    id uuid NOT NULL,
    membership_slug character varying(255),
    coverage_id uuid,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    plan_price numeric(6,2),
    job_limit_per_year integer
);


--
-- Name: provider_accreditations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.provider_accreditations (
    id uuid NOT NULL,
    question_answers jsonb,
    has_accepted_terms boolean DEFAULT false NOT NULL,
    provider_id uuid,
    reviewer_id uuid,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    insurance_details text,
    end_date_public_liability date,
    end_date_prof_indemnity date,
    end_date_hook_insurance date
);


--
-- Name: provider_bank_accounts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.provider_bank_accounts (
    id uuid NOT NULL,
    account_name character varying(255),
    bsb character varying(255),
    account_number character varying(255),
    banking_details text,
    has_xero_record boolean DEFAULT false NOT NULL,
    provider_id uuid,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: provider_files; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.provider_files (
    id uuid NOT NULL,
    file text,
    provider_id uuid,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: provider_nodes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.provider_nodes (
    id uuid NOT NULL,
    address character varying(255),
    locality character varying(255),
    postcode character varying(255),
    state character varying(255),
    country character varying(255),
    main_contact character varying(255),
    main_phone character varying(255),
    mobile character varying(255),
    email_address character varying(255),
    other_contact character varying(255),
    other_phone character varying(255),
    emergency_phone character varying(255),
    website character varying(255),
    store_type character varying(255),
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    provider_id uuid,
    latitude double precision,
    longitude double precision,
    wkt character varying(255),
    service_type character varying(255)
);


--
-- Name: providers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.providers (
    id uuid NOT NULL,
    business_name character varying(255),
    abn character varying(255),
    status character varying(255),
    priority character varying(255),
    form_completed_at date,
    started_at date,
    starter_pack_sent_at date,
    service_type character varying(255),
    vehicle_types text,
    towing_weights text,
    fees text,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tracker jsonb
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp without time zone
);


--
-- Name: services; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.services (
    id uuid NOT NULL,
    name character varying(255),
    sku character varying(255),
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sessions (
    id uuid NOT NULL,
    user_id uuid,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: table_record_deletes_on_db_three_six_five; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.table_record_deletes_on_db_three_six_five (
    time_stamp timestamp without time zone NOT NULL,
    userid text NOT NULL,
    id text NOT NULL,
    schema_name text NOT NULL,
    table_name text NOT NULL,
    status_on_warehouse text
);


--
-- Name: tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tags (
    id uuid NOT NULL,
    name character varying(255),
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    bg_color character varying(255)
);


--
-- Name: three_six_five_coverages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.three_six_five_coverages (
    id uuid,
    name character varying(255),
    description text,
    cooling_off_period text,
    towing_distance_cover text,
    towing_special_instructions text,
    battery_distance_cover text,
    battery_replacement_cover text,
    emergency_fuel_cover text,
    locksmith_distance_cover text,
    locksmith_cost_cover text,
    accomodation_cost_cover text,
    taxi_cost_cover text,
    rental_car_cost_cover text,
    trailer_cover text,
    agistment text,
    comments text,
    inserted_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password_hash character varying(255) NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    role character varying(255),
    company character varying(255),
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    is_online boolean DEFAULT false,
    mfa_secret character varying(255),
    mfa_app_enabled boolean DEFAULT false,
    last_mfa_authenticated_at timestamp without time zone
);


--
-- Name: api_tokens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.api_tokens ALTER COLUMN id SET DEFAULT nextval('public.api_tokens_id_seq'::regclass);


--
-- Name: caspio_access_token id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.caspio_access_token ALTER COLUMN id SET DEFAULT nextval('public.caspio_access_token_id_seq'::regclass);


--
-- Name: email_brands id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.email_brands ALTER COLUMN id SET DEFAULT nextval('public.email_brands_id_seq'::regclass);


--
-- Name: faq id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.faq ALTER COLUMN id SET DEFAULT nextval('public.faq_id_seq'::regclass);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: -
--

GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

