## Dicionário de dados

---

O dicionário de dados consiste numa lista organizada de todos os elementos de dados que são pertinentes para o sistema.

## Entidade: Pokemon

**Descrição**: A entidade representa um Pokemón podendo ser ele, um Player ou NPC:

**Observação**:

|  Nome Variável  |  Tipo   |    Descrição    | Valores permitidos | Permite valores nulos? | É chave? |
| :-------------: | :-----: | :-------------: | :----------------: | :--------------------: | :------: |
|      nome       | VARCHAR | Nome do Pokemón |         -          |           -            |    PK    |
|     id_tipo     |   INT   |        -        |         -          |           -            |    FK    |
|      nivel      |   INT   |        -        |         -          |           -            |    -     |
|      vida       |   INT   |        -        |         -          |           -            |    -     |
|  ataque_fisico  |   INT   |        -        |         -          |           -            |    -     |
|  defesa_fisica  |   INT   |        -        |         -          |           -            |    -     |
| ataque_especial |   INT   |        -        |         -          |           -            |    -     |
| defesa_especial |   INT   |        -        |         -          |           -            |    -     |
|   velocidade    |   INT   |        -        |         -          |           -            |    -     |
|    acuracia     |   INT   |        -        |         -          |           -            |    -     |
|     evasao      |   INT   |        -        |         -          |           -            |    -     |
|     status      | VARCHAR |        -        |         -          |           -            |    -     |

## Entidade: Player

**Descrição**: A entidade player descreve as informações ligadas ao personagem jogável, como:

**Observação**: Essa tabela possui chaves estrangeiras das entidades...

| Nome Variável |    Tipo     |              Descrição               | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :---------: | :----------------------------------: | :----------------: | :--------------------: | :------: |
| id_inventario |     int     |     Identificador do inventário      |       1-5000       |          não           |    FK    |
|      xxx      | varchar[50] |           Nome do jogador            |      a-z, A-Z      |          não           |          |
|      xxx      |     int     |      Itdentificador do equipado      |       1-5000       |          sim           |    FK    |
|      xxx      |     int     |     Itdentificador do inventário     |       1-5000       |          não           |    FK    |
|      xxx      |     int     |       Identificador do diálogo       |       1-5000       |          sim           |    FK    |
|      xxx      |     int     |    Identificador do cenario-atual    |       1-5000       |          não           |    FK    |
|      xxx      |     int     |    Identificador da missao-atual     |       1-5000       |          sim           |    FK    |
|      xxx      |     int     |      Identificador da afinidade      |       1-5000       |          sim           |    FK    |
|      xxx      |     int     |           Nível do jogador           |       1-100        |          não           |          |
|      xxx      |     int     | Quantidade de experiência do jogador |       1-100        |          não           |          |
|      xxx      |     int     |      Limite de vida do jogador       |       1-100        |          não           |          |

## Entidade: Missão

**Descrição**: A entidade Missão relaciona o número de identificação da missão, mapa, loot.

| Nome Variável |    Tipo     |             Descrição             | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :---------: | :-------------------------------: | :----------------: | :--------------------: | :------: |
|      id       |     INT     | Código de identificação da missão |       1-5000       |          não           |    PK    |
|    id_mapa    |     INT     |  Código de identificação do mapa  |       1-5000       |          não           |    FK    |
|    id_npc     |     INT     |  Código de identificação do mapa  |       1-5000       |          não           |    FK    |
|    id_loot    |     INT     |  Código de identificação do loot  |       1-5000       |          não           |    FK    |
|  dificuldade  |     INT     |  Nível de dificuldade da missão   |       1-5000       |          não           |    -     |
|   objetivo    | VARCHAR[50] |                xx                 |         xx         |           xx           |    -     |
|  tipo_missao  |     INT     |                xx                 |         xx         |           xx           |    -     |

## Entidade: Inventário

**Descrição**: A entidade Inventário relaciona...

**Observação**: Essa tabela possui chave estrangeira da entidade `Item`.

| Nome Variável | Tipo |        Descrição        | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :--: | :---------------------: | :----------------: | :--------------------: | :------: |
|    id_item    | int  | Identificador dos itens |       1-5000       |          não           |    FK    |

## Entidade: NPC

**Descrição**: A entidade NPC guarda as informações relacionada...

**Observação**: Essa tabela possui chaves estrangeiras das entidade...

| Nome Variável | Tipo | Descrição | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :--: | :-------: | :----------------: | :--------------------: | :------: |
|      id_npc      |  int  |   Identificação do NPC     |        1-5000         |           Não           |    PK    |
|      nome      |  varchar[50]  |   Nome do NPC     |      a-z, A-Z             |           Não           |        |

## Entidade: Item

**Descrição**: A entidade Item armazena as informações de identificação do item, nome e quantidade de itens.

| Nome Variável |    Tipo     |            Descrição            | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :---------: | :-----------------------------: | :----------------: | :--------------------: | :------: |
|    id-item    |     int     | Código de Identificação do item |       1-5000       |          não           |    PK    |
|     nome      | varchar[50] |          Nome do item           |      a-z, A-Z      |          não           |          |
|  quantidade   |     int     |        Descrição do item        |      a-z, A-Z      |          sim           |          |

## Entidade: Habilidade

**Descrição**: Descreve as habilidades disponíveis no jogo, o identificador da habilidade, seu nome, dano e a acurácia.

**Observação**: xxxx

| Nome Variável |    Tipo     |          Descrição          | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :---------: | :-------------------------: | :----------------: | :--------------------: | :------: |
| id-habilidade |     int     | Identificador da habilidade |       1-5000       |          não           |    PK    |
|     nome      | varchar[50] |     Nome da habilidade      |      a-z, A-Z      |          não           |          |
|     tipo      |     int     | Dano que a habilidade causa |       1-5000       |          não           |          |
|   acuracia    |     int     |      Precisão do dano       |       1-5000       |          sim           |          |

## Entidade: Pokemon-Habilidade

**Descrição**: Descreve as habilidades disponíveis no jogo, o identificador da habilidade, seu nome, dano e a acurácia.

**Observação**: xxxx

| Nome Variável | Tipo |          Descrição          | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :--: | :-------------------------: | :----------------: | :--------------------: | :------: |
| id_habilidade | int  | Identificador da habilidade |       1-5000       |          não           |    PK    |
|  id_pokemon   | int  |  Identificador de pokemon   |       1-5000       |          não           |    FK    |

## Entidade: Andar

**Descrição**: Descreve a entidade andar.

**Observação**: xxxx

| Nome Variável | Tipo |       Descrição        | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :--: | :--------------------: | :----------------: | :--------------------: | :------: |
|      id       | INT  | Identificador do andar |       1-5000       |          não           |    PK    |
|    id_mapa    | INT  | Identificador do mapa  |       1-5000       |          não           |    FK    |

## Entidade: Tipo-Terreno

**Descrição**: Descreve o tipo de terreno.

**Observação**: xxxx

| Nome Variável |    Tipo     |        Descrição         | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :---------: | :----------------------: | :----------------: | :--------------------: | :------: |
|  id_terreno   |     int     | Identificador de terreno |       1-5000       |          não           |    PK    |
|   descricao   | varchar[50] |   Descrição de terreno   |       1-5000       |          não           |    FK    |

## Entidade: Terreno

**Descrição**: Descreve a entidade terreno.

**Observação**: xxxx

|  Nome Variável  | Tipo |            Descrição             | Valores permitidos | Permite valores nulos? | É chave? |
| :-------------: | :--: | :------------------------------: | :----------------: | :--------------------: | :------: |
|       id        | INT  |     Identificador do terreno     |       1-5000       |          não           |    PK    |
|        x        | INT  |      Coordenada do terreno       |       1-5000       |          não           |    -     |
|        y        | INT  |      Coordenada do terreno       |       1-5000       |          não           |    -     |
| id_tipo_terreno | INT  | Identificador do tipo de terreno |       1-5000       |          não           |    FK    |


## Entidade: Tipo

**Descrição**: xxx

**Observação**: xxxx

| Nome Variável | Tipo |        Descrição        | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :--: | :---------------------: | :----------------: | :--------------------: | :------: |
|     nome      | INT  |      Nome do tipo       |       1-5000       |          não           |    PK    |
|   id_ataque   | INT  | Indetificador do ataque |       1-5000       |          não           |    FK    |
|   id_defesa   | INT  | Indetificador do defesa |       1-5000       |          não           |    FK    |

## Histórico de Versão

| Versão |    Data    |               Descrição                |                                                 Autor(es)                                                  |
| :----: | :--------: | :------------------------------------: | :--------------------------------------------------------------------------------------------------------: |
| `1.0`  | 22/04/2024 | Primeira versão do dicionário de dados | [Gabriel Marcolino](https://github.com/GabrielMR360) e [Shaíne Oliveira](ttps://github.com/ShaineOliveira) |
