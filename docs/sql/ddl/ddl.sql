CREATE TABLE mapa
(
    nome               VARCHAR(255) COLLATE pg_catalog."default" NOT NULL,
    quantidade_andares integer                                   NOT NULL,
    CONSTRAINT mapa_pkey PRIMARY KEY (nome)
);

CREATE TABLE andar
(
    id_andar  SERIAL PRIMARY KEY,
    nome_mapa VARCHAR(255) NOT NULL,

    FOREIGN KEY (nome_mapa) REFERENCES mapa (nome)
);

CREATE TABLE tipo_terreno
(
    id_tipo_terreno SERIAL PRIMARY KEY,
    descricao       VARCHAR(50) NOT NULL,
    movimento       BOOLEAN     NOT NULL
);

CREATE TABLE terreno
(
    id_terreno      SERIAL PRIMARY KEY,
    x               INT NOT NULL,
    y               INT NOT NULL,
    id_tipo_terreno INT,
    id_andar        INT,

    FOREIGN KEY (id_tipo_terreno) REFERENCES tipo_terreno (id_tipo_terreno),
    FOREIGN KEY (id_andar) REFERENCES andar (id_andar)
);

CREATE TABLE efeito
(
    nome VARCHAR(255) PRIMARY KEY,
    dano INT NOT NULL
);

CREATE TABLE tipo_elemental
(
    nome VARCHAR(255) PRIMARY KEY
);

CREATE TABLE habilidade
(
    id_habilidade  SERIAL PRIMARY KEY,
    nome           VARCHAR(255) NOT NULL,
    dano           INT          NOT NULL,
    acuracia       INT          NOT NULL,
    nome_efeito    VARCHAR,
    tipo_elemental VARCHAR,

    FOREIGN KEY (nome) REFERENCES efeito (nome),
    FOREIGN KEY (tipo_elemental) REFERENCES tipo_elemental (nome)
);

CREATE TABLE interacao
(
    id            SERIAL PRIMARY KEY,
    valor         INT NOT NULL,
    tipo_atacante VARCHAR(255),                                   -- Adicione a coluna id_tipo_atacante
    tipo_defensor VARCHAR(255),                                   -- Adicione a coluna id_tipo_defensor

    FOREIGN KEY (tipo_atacante) REFERENCES tipo_elemental (nome), -- Ajuste a tabela e coluna referenciadas
    FOREIGN KEY (tipo_defensor) REFERENCES tipo_elemental (nome)  -- Ajuste a tabela e coluna referenciadas
);

CREATE TABLE item
(
    id_item    SERIAL PRIMARY KEY,
    nome       VARCHAR(255) NOT NULL,
    descricao  VARCHAR(255) NOT NULL,
    efeito     VARCHAR(255) NOT NULL,
    quantidade INT          NOT NULL,
    valor      INT          NOT NULL
);

CREATE TABLE inventario
(
    id_inventario SERIAL PRIMARY KEY, -- Defina a coluna id_inventario como chave primária
    id_item       INT,
    quantidade    INT,

    FOREIGN KEY (id_item) REFERENCES item (id_item)
);

CREATE TABLE correio
(
    id         SERIAL PRIMARY KEY,
    jogador_id INT,
    terreno_id INT,

    FOREIGN KEY (terreno_id) REFERENCES terreno (id_terreno)
);

CREATE TABLE pokemon
(
    id_pokemon      SERIAL PRIMARY KEY,
    id_tipo_pokemon INT
);

CREATE TABLE jogador
(
    id_jogador      SERIAL PRIMARY KEY,
    nivel           INT          NOT NULL,
    vida            INT          NOT NULL,
    ataque_fisico   INT          NOT NULL,
    defesa_fisica   INT          NOT NULL,
    ataque_especial INT          NOT NULL,
    velocidade      INT          NOT NULL,
    acuracia        INT          NOT NULL,
    evasao          INT          NOT NULL,
    status          VARCHAR(255) NOT NULL,
    nome            VARCHAR(255) NOT NULL,
    id_pokemon      INT,
    id_inventario   INT,
    id_correio      INT,
    saldo           BIGINT       NOT NULL,
    FOREIGN KEY (id_pokemon) REFERENCES pokemon (id_pokemon),
    FOREIGN KEY (id_inventario) REFERENCES inventario (id_inventario),
    FOREIGN KEY (id_correio) REFERENCES correio (id)
);

ALTER TABLE correio
    ADD CONSTRAINT correio_id_jogador_fkey FOREIGN KEY (jogador_id) REFERENCES jogador (id_jogador);

CREATE TABLE loot
(
    id_loot    SERIAL PRIMARY KEY,
    id_terreno INT, -- Adicione a coluna id_terreno

    FOREIGN KEY (id_terreno) REFERENCES terreno (id_terreno)
);


CREATE TABLE loot_item
(
    id_loot_item SERIAL PRIMARY KEY, -- Adiciona uma chave primária
    id_item      INT,                -- Adiciona a coluna id_item
    id_loot      INT,                -- Adiciona a coluna id_loot
    quantidade   INT,

    FOREIGN KEY (id_item) REFERENCES item (id_item),
    FOREIGN KEY (id_loot) REFERENCES loot (id_loot)
);

CREATE TABLE npc
(
    id_npc      SERIAL PRIMARY KEY,
    id_tipo_npc INT
);

CREATE TABLE missoes
(
    id_missao   SERIAL PRIMARY KEY,
    id_mapa     VARCHAR, -- Adicione a coluna id_mapa
    id_correio  INT,     -- Adicione a coluna id_npc
    id_loot     INT,     -- Adicione a coluna id_loot
    id_jogador  INT,
    dificuldade INT          NOT NULL,
    objetivo    VARCHAR(255) NOT NULL,
    tipo_missao INT          NOT NULL,

    FOREIGN KEY (id_mapa) REFERENCES mapa (nome),
    FOREIGN KEY (id_correio) REFERENCES correio (id),
    FOREIGN KEY (id_jogador) REFERENCES jogador (id_jogador),
    FOREIGN KEY (id_loot) REFERENCES loot (id_loot)
);

CREATE TABLE pokemon_habilidade
(
    id_pokemon_habilidade SERIAL PRIMARY KEY,
    id_pokemon            INT,
    id_habilidade         INT,

    FOREIGN KEY (id_pokemon) REFERENCES pokemon (id_pokemon),
    FOREIGN KEY (id_habilidade) REFERENCES habilidade (id_habilidade)
);

CREATE TABLE terreno_loot
(
    id_terreno_loot SERIAL PRIMARY KEY,
    id_terreno      INT,
    id_loot         INT,

    FOREIGN KEY (id_terreno) REFERENCES terreno (id_terreno),
    FOREIGN KEY (id_loot) REFERENCES loot (id_loot)
);

CREATE TABLE vendedor
(
    id_vendendor    SERIAL PRIMARY KEY,
    id_pokemon      INT,
    nivel           INT          NOT NULL,
    vida            INT          NOT NULL,
    ataque_fisico   INT          NOT NULL,
    defesa_fisica   INT          NOT NULL,
    ataque_especial INT          NOT NULL,
    velocidade      INT          NOT NULL,
    acuracia        INT          NOT NULL,
    evasao          INT          NOT NULL,
    status          VARCHAR(255) NOT NULL,
    nome            VARCHAR(255) NOT NULL,
    posicao         INT,
    item_1          INT,
    item_2          INT,
    item_3          INT,

    FOREIGN KEY (item_1) REFERENCES item (id_item),
    FOREIGN KEY (item_2) REFERENCES item (id_item),
    FOREIGN KEY (item_3) REFERENCES item (id_item),
    FOREIGN KEY (id_pokemon) REFERENCES pokemon (id_pokemon),
    FOREIGN KEY (id_vendendor) REFERENCES npc (id_npc),
    FOREIGN KEY (posicao) REFERENCES terreno (id_terreno)
);

CREATE TABLE inimigo
(
    id_inimigo      SERIAL PRIMARY KEY,
    id_npc          INT,
    nivel           INT          NOT NULL,
    vida            INT          NOT NULL,
    ataque_fisico   INT          NOT NULL,
    defesa_fisica   INT          NOT NULL,
    ataque_especial INT          NOT NULL,
    velocidade      INT          NOT NULL,
    acuracia        INT          NOT NULL,
    evasao          INT          NOT NULL,
    status          VARCHAR(255) NOT NULL,
    nome            VARCHAR(255) NOT NULL,
    id_pokemon      INT,
    posicao         INT,

    FOREIGN KEY (id_pokemon) REFERENCES pokemon (id_pokemon),
    FOREIGN KEY (posicao) REFERENCES terreno (id_terreno),
    FOREIGN KEY (id_npc) REFERENCES npc (id_npc)
);

CREATE TABLE dialogo
(
    id         SERIAL PRIMARY KEY,
    personagem VARCHAR(50)                       NOT NULL,
    fala       text COLLATE pg_catalog."default" NOT NULL,
--     contexto   character varying(100) COLLATE pg_catalog."default",
    ordem      INT
);