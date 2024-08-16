CREATE TABLE IF NOT EXISTS public.mapa
(
    nome VARCHAR(255) COLLATE pg_catalog."default" NOT NULL,
    quantidade_andares integer NOT NULL,
    CONSTRAINT mapa_pkey PRIMARY KEY (nome)
);
