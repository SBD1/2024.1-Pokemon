CREATE TABLE IF NOT EXISTS public.dialogo
(
    id integer NOT NULL DEFAULT nextval('dialogo_id_seq'::regclass),
    personagem character varying(50) COLLATE pg_catalog."default" NOT NULL,
    fala text COLLATE pg_catalog."default" NOT NULL,
    contexto character varying(100) COLLATE pg_catalog."default",
    ordem integer,
    CONSTRAINT dialogo_pkey PRIMARY KEY (id)
)