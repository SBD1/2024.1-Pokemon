# <b>Data Definition Language</b>

DDL (Data Definition Language), é um subconjunto da linguagem SQL (Structured Query Language) utilizado para definir e gerenciar a estrutura de bancos de dados. Os comandos DDL são usados para criar, alterar e excluir informações em um banco de dados, como tabelas, índices, esquemas, entre outros. Em resumo, DDL é essencial para a criação e gerenciamento da estrutura dos dados em um banco de dados relacional.

#### Criação da tabela mapa

```sql
CREATE TABLE mapa
(
    nome               VARCHAR(255) COLLATE pg_catalog."default" NOT NULL,
    quantidade_andares integer                                   NOT NULL,
    CONSTRAINT mapa_pkey PRIMARY KEY (nome)
);
```

#### Criação da tabela andar

```sql
CREATE TABLE andar
(
    id_andar     SERIAL PRIMARY KEY,
    nome_mapa    VARCHAR(255) NOT NULL,
    numero_andar INT          NOT NULL,

    CONSTRAINT unique_mapa_andar UNIQUE (nome_mapa, numero_andar),
    CONSTRAINT andar_nome_mapa_fkey FOREIGN KEY (nome_mapa) REFERENCES mapa (nome)
);
```

#### Criação da tabela tipo_terreno

```sql
CREATE TABLE tipo_terreno
(
    id_tipo_terreno SERIAL PRIMARY KEY,
    descricao       VARCHAR(50) NOT NULL,
    movimento       BOOLEAN     NOT NULL
);
```

#### Criação da tabela terreno

```sql
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
```

#### Criação da tabela efeito

```sql
CREATE TABLE efeito
(
    nome VARCHAR(255) PRIMARY KEY,
    dano INT NOT NULL
);
```

#### Criação da tabela tipo_elemental

```sql
CREATE TABLE tipo_elemental
(
    nome VARCHAR(255) PRIMARY KEY
);
```

#### Criação da tabela habilidade

```sql
CREATE TABLE habilidade
(
    id_habilidade  SERIAL PRIMARY KEY,
    nome           VARCHAR(255) NOT NULL,
    dano           INT          NOT NULL,
    acuracia       INT          NOT NULL,
    nome_efeito    VARCHAR,
    tipo_elemental VARCHAR,

    FOREIGN KEY (nome_efeito) REFERENCES efeito (nome),
    FOREIGN KEY (tipo_elemental) REFERENCES tipo_elemental (nome)
);
```

#### Criação da tabela interação

```sql
CREATE TABLE interacao
(
    id            SERIAL PRIMARY KEY,
    valor         INT NOT NULL,
    tipo_atacante VARCHAR(255),                                   -- Adicione a coluna id_tipo_atacante
    tipo_defensor VARCHAR(255),                                   -- Adicione a coluna id_tipo_defensor

    FOREIGN KEY (tipo_atacante) REFERENCES tipo_elemental (nome), -- Ajuste a tabela e coluna referenciadas
    FOREIGN KEY (tipo_defensor) REFERENCES tipo_elemental (nome)  -- Ajuste a tabela e coluna referenciadas
);
```

#### Criação da tabela item

```sql
CREATE TABLE item
(
    id_item   SERIAL PRIMARY KEY,
    nome      VARCHAR(255) NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    efeito    VARCHAR(255) NOT NULL,
    valor     INT          NOT NULL
);
```

#### Criação da tabela instancia_item

```sql
CREATE TABLE instancia_item
(
    id_instancia_item SERIAL PRIMARY KEY,
    id_item           INT,

    FOREIGN KEY (id_item) REFERENCES item (id_item)
);
```

#### Criação da tabela pokemón

```sql
CREATE TABLE pokemon
(
    id_pokemon      SERIAL PRIMARY KEY,
    id_tipo_pokemon INT
);
```

#### Criação da tabela correio

```sql
CREATE TABLE correio
(
    id         SERIAL PRIMARY KEY,
    jogador_id INT,
    terreno_id INT,

    FOREIGN KEY (terreno_id) REFERENCES terreno (id_terreno)
);
```

#### Criação da tabela jogador

```sql
CREATE TABLE jogador
(
    id_jogador      INT PRIMARY KEY,
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
    id_correio      INT,
    saldo           BIGINT       NOT NULL,
    tam_inventario  INT          NOT NULL,
    posicao         INT          NOT NULL,
    tipo_elemental  VARCHAR(255) NOT NULL,

    FOREIGN KEY (id_jogador) REFERENCES pokemon (id_pokemon),
    FOREIGN KEY (id_correio) REFERENCES correio (id),
    FOREIGN KEY (posicao) REFERENCES terreno (id_terreno),
    FOREIGN KEY (tipo_elemental) REFERENCES tipo_elemental (nome)
);
```

#### Criação da tabela inventário

```sql
CREATE TABLE inventario
(
    id_inventario     INT,
    id_instancia_item INT,

    PRIMARY KEY (id_inventario, id_instancia_item),
    FOREIGN KEY (id_instancia_item) REFERENCES instancia_item (id_instancia_item),
    FOREIGN KEY (id_inventario) REFERENCES jogador (id_jogador)
);
```

#### Alteração da tabela correio

```sql
ALTER TABLE correio
    ADD CONSTRAINT correio_id_jogador_fkey FOREIGN KEY (jogador_id) REFERENCES jogador (id_jogador);

```

#### Criação da tabela loot

```sql
CREATE TABLE loot
(
    id_loot    SERIAL PRIMARY KEY,
    id_terreno INT, -- Adicione a coluna id_terreno

    FOREIGN KEY (id_terreno) REFERENCES terreno (id_terreno)
);
```

#### Criação da tabela loot_item

```sql
CREATE TABLE loot_item
(
    id_loot_item SERIAL PRIMARY KEY, -- Adiciona uma chave primária
    id_item      INT,                -- Adiciona a coluna id_item
    id_loot      INT,                -- Adiciona a coluna id_loot
    quantidade   INT,

    FOREIGN KEY (id_item) REFERENCES item (id_item),
    FOREIGN KEY (id_loot) REFERENCES loot (id_loot)
);
```

#### Criação da tabela npc

```sql
CREATE TABLE npc
(
    id_npc      INT PRIMARY KEY,
    id_tipo_npc INT,

    FOREIGN KEY (id_npc) REFERENCES pokemon (id_pokemon)
);
```

#### Criação da tabela missoes

```sql
CREATE TABLE missao
(
    id_missao   SERIAL PRIMARY KEY,
    nome_mapa   VARCHAR(255),
    id_correio  INT,
    id_loot     INT,
    id_jogador  INT,
    dificuldade INT                   NOT NULL,
    objetivo    VARCHAR(255)          NOT NULL,
    tipo_missao BOOLEAN               NOT NULL,
    concluida   BOOLEAN DEFAULT false NOT NULL,

    FOREIGN KEY (nome_mapa) REFERENCES mapa (nome),
    FOREIGN KEY (id_correio) REFERENCES correio (id),
    FOREIGN KEY (id_jogador) REFERENCES jogador (id_jogador),
    FOREIGN KEY (id_loot) REFERENCES loot (id_loot)
);
```

#### Criação da tabela pokemom_habilidade

```sql
CREATE TABLE pokemon_habilidade
(
    id_pokemon_habilidade SERIAL PRIMARY KEY,
    id_pokemon            INT,
    id_habilidade         INT,

    FOREIGN KEY (id_pokemon) REFERENCES pokemon (id_pokemon),
    FOREIGN KEY (id_habilidade) REFERENCES habilidade (id_habilidade)
);
```

#### Criação da tabela terreno_loot

```sql
CREATE TABLE terreno_loot
(
    id_terreno_loot SERIAL PRIMARY KEY,
    id_terreno      INT,
    id_loot         INT,

    FOREIGN KEY (id_terreno) REFERENCES terreno (id_terreno),
    FOREIGN KEY (id_loot) REFERENCES loot (id_loot)
);
```

#### Criação da tabela vendedor

```sql
CREATE TABLE vendedor
(
    id_vendendor    INT PRIMARY KEY,
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
    tipo_elemental  VARCHAR(255) NOT NULL,

    FOREIGN KEY (id_vendendor) REFERENCES npc (id_npc),
    FOREIGN KEY (posicao) REFERENCES terreno (id_terreno),
    FOREIGN KEY (item_1) REFERENCES item (id_item),
    FOREIGN KEY (item_2) REFERENCES item (id_item),
    FOREIGN KEY (item_3) REFERENCES item (id_item),
    FOREIGN KEY (tipo_elemental) REFERENCES tipo_elemental (nome)
);
```

#### Criação da tabela inimigo

```sql
CREATE TABLE inimigo
(
    id_inimigo      INT PRIMARY KEY,
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
    tipo_elemental  VARCHAR(255) NOT NULL,

    FOREIGN KEY (id_inimigo) REFERENCES npc (id_npc),
    FOREIGN KEY (posicao) REFERENCES terreno (id_terreno),
    FOREIGN KEY (tipo_elemental) REFERENCES tipo_elemental (nome)
);
```

#### Criação da tabela dialogo

```sql
CREATE TABLE dialogo
(
    id         SERIAL PRIMARY KEY,
    personagem VARCHAR(50)                       NOT NULL,
    fala       text COLLATE pg_catalog."default" NOT NULL,
    ordem      INT
);
```

## Histórico de Versão

| Versão |    Data    |         Descrição          |                                                                                                Autor(es)                                                                                                 |
| :----: | :--------: | :------------------------: | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: |
| `1.0`  | 16/08/2024 |    Criação das tabelas     | [Gabriel Marcolino](https://github.com/GabrielMR360), [Shaíne Oliveira](ttps://github.com/ShaineOliveira), [José Filipi](https://github.com/JoseFilipi) e [Leonardo Bonetti](https://github.com/LeoFacB) |
| `1.1`  | 17/08/2024 | Alterando tabela de missão |                                                                           [Gabriel Marcolino](https://github.com/GabrielMR360)                                                                           |
