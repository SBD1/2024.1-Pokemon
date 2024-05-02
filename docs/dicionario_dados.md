## Dicionário de dados

---

O dicionário de dados consiste numa lista organizada de todos os elementos de dados que são pertinentes para o sistema.

## Entidade: Pokemon

**Descrição**: A entidade representa um Pokemón podendo ser ele, um Player ou NPC:

**Observação**:

|  Nome Variável  |  Tipo   |               Descrição                | Valores permitidos | Permite valores nulos? | É chave? |
| :-------------: | :-----: | :------------------------------------: | :----------------: | :--------------------: | :------: |
|      nome       | VARCHAR |            Nome do Pokemón             |      a-z, A-Z      |          não           |    PK    |
|     id_tipo     |   INT   |                   -                    |       1-5000       |          não           |    FK    |
|      nivel      |   INT   |            Nível do Pokemón            |       1-5000       |          não           |    -     |
|      vida       |   INT   |            Vida do Pokemón             |       1-5000       |          não           |    -     |
|  ataque_fisico  |   INT   |   Valor do ataque físico do Pokemón    |       1-5000       |          sim           |    -     |
|  defesa_fisica  |   INT   |   Valor da defesa físico do Pokemón    |       1-5000       |          sim           |    -     |
| ataque_especial |   INT   |  Valor do ataque especial do Pokemón   |       1-5000       |          sim           |    -     |
| defesa_especial |   INT   |  Valor da defesa especial do Pokemón   |       1-5000       |          sim           |    -     |
|   velocidade    |   INT   |     Valor da velocidade do Pokemón     |       1-5000       |          sim           |    -     |
|    acuracia     |   INT   | Valor da precisão do ataque do Pokemón |       1-5000       |          sim           |    -     |
|     evasao      |   INT   |                   -                    |       1-5000       |          sim           |    -     |
|     status      | VARCHAR |                   -                    |       1-5000       |          sim           |    -     |

## Entidade: Player

**Descrição**: A entidade player descreve as informações ligadas ao personagem jogável, como:

**Observação**: Essa tabela possui chaves estrangeiras das entidades...

| Nome Variável |    Tipo     |              Descrição               | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :---------: | :----------------------------------: | :----------------: | :--------------------: | :------: |
| id_player |     INT     |     Identificador do player      |       1-5000       |          não           |    FK    |
|      tamanho_inventario      | INT |           Tamanho do inventário            |      1-5000      |          não           |     FK     |


## Entidade: Missão

**Descrição**: A entidade Missão relaciona o número de identificação da missão, mapa, loot.

| Nome Variável |    Tipo     |             Descrição             | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :---------: | :-------------------------------: | :----------------: | :--------------------: | :------: |
|      id       |     INT     | Código de identificação da missão |       1-5000       |          não           |    PK    |
|    id_mapa    |     INT     |  Código de identificação do mapa  |       1-5000       |          não           |    FK    |
|    id_npc     |     INT     |  Código de identificação do mapa  |       1-5000       |          não           |    FK    |
|    id_loot    |     INT     |  Código de identificação do loot  |       1-5000       |          não           |    FK    |
|  dificuldade  |     INT     |  Nível de dificuldade da missão   |       1-5000       |          não           |    -     |
|   objetivo    | VARCHAR[50] |        Objetivo da missão         |      a-z, A-Z      |          não           |    -     |
|  tipo_missao  |     INT     | Tipo da missão(principal ou não)  |       1-5000       |          não           |    -     |

## Entidade: Inventário

**Descrição**: A entidade Inventário relaciona...

**Observação**: Essa tabela possui chave estrangeira da entidade `Item`.

| Nome Variável | Tipo |        Descrição        | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :--: | :---------------------: | :----------------: | :--------------------: | :------: |
|    id_item    | INT  | Identificador dos itens |       1-5000       |          não           |    FK    |

## Entidade: NPC

**Descrição**: A entidade NPC guarda as informações relacionada...

**Observação**: Essa tabela possui chaves estrangeiras das entidade...

| Nome Variável | Tipo | Descrição | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :--: | :-------: | :----------------: | :--------------------: | :------: |
|      id      |  INT  |   Identificação do NPC     |        1-5000         |           Não           |    PK    |
|      nome      |  VARCHAR[50]  |   Nome do NPC     |      a-z, A-Z             |           Não           |        |

## Entidade: Item

**Descrição**: A entidade Item armazena as informações de identificação do item, nome e quantidade de itens.

| Nome Variável |    Tipo     |            Descrição            | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :---------: | :-----------------------------: | :----------------: | :--------------------: | :------: |
|    id-item    |     INT     | Código de Identificação do item |       1-5000       |          não           |    PK    |
|     nome      | VARCHAR[50] |          Nome do item           |      a-z, A-Z      |          não           |          |
|  quantidade   |     INT     |        Descrição do item        |      a-z, A-Z      |          sim           |          |

## Entidade: Habilidade

**Descrição**: Descreve as habilidades disponíveis no jogo, o identificador da habilidade, seu nome, dano e a acurácia.

**Observação**: xxxx

| Nome Variável |    Tipo     |          Descrição          | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :---------: | :-------------------------: | :----------------: | :--------------------: | :------: |
| id-habilidade |     INT     | Identificador da habilidade |       1-5000       |          não           |    PK    |
|     nome      | VARCHAR[50] |     Nome da habilidade      |      a-z, A-Z      |          não           |          |
|     tipo      |     INT     | Dano que a habilidade causa |       1-5000       |          não           |          |
|   acuracia    |     INT     |      Precisão do dano       |       1-5000       |          sim           |          |

## Entidade: Pokemon-Habilidade

**Descrição**: Descreve as habilidades disponíveis no jogo, o identificador da habilidade, seu nome, dano e a acurácia.

**Observação**: xxxx

| Nome Variável | Tipo |          Descrição          | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :--: | :-------------------------: | :----------------: | :--------------------: | :------: |
| id_habilidade | INT  | Identificador da habilidade |       1-5000       |          não           |    PK    |
|  id_pokemon   | INT  |  Identificador de pokemon   |       1-5000       |          não           |    FK    |

## Entidade: Andar

**Descrição**: Descreve a entidade andar.

**Observação**: xxxx

| Nome Variável | Tipo |       Descrição        | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :--: | :--------------------: | :----------------: | :--------------------: | :------: |
|      id    | INT  | Identificador do andar |       1-5000       |          não           |    PK    |
|    id_mapa    | INT  | Identificador do mapa  |       1-5000       |          não           |    FK    |

## Entidade: Tipo-Terreno

**Descrição**: Descreve o tipo de terreno.

**Observação**: xxxx

| Nome Variável |    Tipo     |        Descrição         | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :---------: | :----------------------: | :----------------: | :--------------------: | :------: |
|  id   |     INT     | Identificador de terreno |       1-5000       |          não           |    PK    |
|   descricao   | VARCHAR[50] |   Descrição de terreno   |       1-5000       |          não           |    FK    |

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
