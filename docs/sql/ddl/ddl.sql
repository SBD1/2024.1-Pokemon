CREATE TABLE andar (
    id_andar SERIAL PRIMARY KEY,
    nome_mapa VARCHAR(255) NOT NULL,
    terreno_spawn INT NOT NULL,
    FOREIGN KEY (nome_mapa) REFERENCES mapa (nome),
    FOREIGN KEY (terreno_spawn) REFERENCES terreno (id_terreno)
);

CREATE TABLE IF NOT EXISTS public.dialogo
(
    id integer NOT NULL DEFAULT nextval('dialogo_id_seq'::regclass),
    personagem character varying(50) COLLATE pg_catalog."default" NOT NULL,
    fala text COLLATE pg_catalog."default" NOT NULL,
    contexto character varying(100) COLLATE pg_catalog."default",
    ordem integer,
    CONSTRAINT dialogo_pkey PRIMARY KEY (id)
);

CREATE TABLE efeito (
    nome SERIAL PRIMARY KEY,
    dano INT NOT NULL
);

CREATE TABLE habilidade (
    id_habilidade SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    dano INT NOT NULL,
    acuracia INT NOT NULL,
    FOREIGN KEY (nome_tipo) REFERENCES nome_tipo(nome)
);

CREATE TABLE interacao (
    id SERIAL PRIMARY KEY,
    valor INT NOT NULL,
    id_tipo_atacante INT,    -- Adicione a coluna id_tipo_atacante
    id_tipo_defensor INT,    -- Adicione a coluna id_tipo_defensor
    FOREIGN KEY (id_tipo_atacante) REFERENCES tipo_elemental(nome),  -- Ajuste a tabela e coluna referenciadas
    FOREIGN KEY (id_tipo_defensor) REFERENCES tipo_elemental(nome)   -- Ajuste a tabela e coluna referenciadas
);


CREATE TABLE inventario (
    id_inventario SERIAL PRIMARY KEY,  -- Defina a coluna id_inventario como chave primária
    id_item INT,
    quantidade INT,
    FOREIGN KEY (id_item) REFERENCES item(id_item)
);

CREATE TABLE item (
    id_item SERIAL PRIMARY KEY,
    descricao VARCHAR(255) NOT NULL,
    efeito VARCHAR(255) NOT NULL
);

CREATE TABLE jogador (
    id_jogador SERIAL PRIMARY KEY,
    nivel INT NOT NULL,
    vida INT NOT NULL,
    ataque_fisico INT NOT NULL,
    defesa_fisica INT NOT NULL,
    ataque_especial INT NOT NULL,
    velocidade INT NOT NULL,
    acuracia INT NOT NULL,
    evasao INT NOT NULL,
    status VARCHAR(255) NOT NULL,
    nome VARCHAR(255) NOT NULL,
    id_pokemon INT,
    id_inventario INT,    
    FOREIGN KEY (id_pokemon) REFERENCES pokemon(id_pokemon),
    FOREIGN KEY (id_inventario) REFERENCES inventario(id_inventario)
);

CREATE TABLE loot (
    id_loot SERIAL PRIMARY KEY,
    id_terreno INT,  -- Adicione a coluna id_terreno
    FOREIGN KEY (id_terreno) REFERENCES terreno(id_terreno)
);


CREATE TABLE loot_item (
    id_loot_item SERIAL PRIMARY KEY,  -- Adiciona uma chave primária
    id_item INT,                      -- Adiciona a coluna id_item
    id_loot INT,                      -- Adiciona a coluna id_loot
    quantidade INT,
    FOREIGN KEY (id_item) REFERENCES item(id_item),
    FOREIGN KEY (id_loot) REFERENCES loot(id_loot)
);

CREATE TABLE IF NOT EXISTS public.mapa
(
    nome VARCHAR(255) COLLATE pg_catalog."default" NOT NULL,
    quantidade_andares integer NOT NULL,
    CONSTRAINT mapa_pkey PRIMARY KEY (nome)
);

CREATE TABLE missoes (
    id_missao SERIAL PRIMARY KEY,
    id_mapa VARCHAR,       -- Adicione a coluna id_mapa
    id_npc INT,        -- Adicione a coluna id_npc
    id_loot INT,       -- Adicione a coluna id_loot
    dificuldade INT NOT NULL,
    objetivo VARCHAR(255) NOT NULL,
    tipo_missao INT NOT NULL,
    FOREIGN KEY (id_mapa) REFERENCES mapa(nome),
    FOREIGN KEY (id_npc) REFERENCES npc(id_npc),
    FOREIGN KEY (id_loot) REFERENCES loot(id_loot)
);

CREATE TABLE npc (
    id_npc SERIAL PRIMARY KEY,
    nivel INT NOT NULL,
    vida INT NOT NULL,
    ataque_fisico INT NOT NULL,
    defesa_fisica INT NOT NULL,
    ataque_especial INT NOT NULL,
    velocidade INT NOT NULL,
    acuracia INT NOT NULL,
    evasao INT NOT NULL,
    status VARCHAR(255) NOT NULL,
    nome VARCHAR(255) NOT NULL,
    id_pokemon INT, -- Adicione a coluna id_pokemon
    posicao INT,    -- Adicione a coluna posicao
    FOREIGN KEY (id_pokemon) REFERENCES pokemon(id_pokemon),
    FOREIGN KEY (posicao) REFERENCES terreno(id_terreno)
);

CREATE TABLE pokemon_habilidade (
    id_pokemon_habilidade SERIAL PRIMARY KEY,
    id_pokemon INT,
    id_habilidade INT,
    FOREIGN KEY (id_pokemon) REFERENCES pokemon(id_pokemon),
    FOREIGN KEY (id_habilidade) REFERENCES habilidade(id_habilidade)
);

CREATE TABLE pokemon (
    id_pokemon SERIAL PRIMARY KEY,
    id_tipo_pokemon INT
);

CREATE TABLE terreno (
    id_terreno SERIAL PRIMARY KEY,
    x INT NOT NULL,
    y INT NOT NULL,
    id_tipo_terreno INT,  
    id_andar INT,         
    FOREIGN KEY (id_tipo_terreno) REFERENCES tipo_terreno(id),
    FOREIGN KEY (id_andar) REFERENCES andar(id)
);


CREATE TABLE terreno_loot (
    id_terreno_loot SERIAL PRIMARY KEY,
    id_terreno INT,
    id_loot INT,
    FOREIGN KEY (id_terreno) REFERENCES terreno(id_terreno),
    FOREIGN KEY (id_loot) REFERENCES loot(id_loot)
);

CREATE TABLE tipo_elemental (
    nome SERIAL PRIMARY KEY
);

CREATE TABLE tipo_terreno (
    id_tipo_terreno SERIAL PRIMARY KEY,
    descricao VARCHAR(50) NOT NULL,
    movimento BOOLEAN NOT NULL
);