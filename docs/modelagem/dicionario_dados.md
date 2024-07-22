# <b>Dicionário de Dados</b>

O dicionário de dados são informações sobre os dados armazenados que são pertinentes para o banco de dados. Ele documenta a estrutura, os tipos, os relacionamentos e outras características dos dados, servindo como uma referência essencial para o desenvolvimento.

## Entidade: Pokemon

**Descrição**: A entidade representa um Pokemón podendo ser ele, um Player ou NPC.

**Observação**: Essa tabela possuí chaves estrangeiras da entidade Tipo.

|  Nome Variável  |  Tipo   |                         Descrição                         | Valores permitidos | Permite valores nulos? | É chave? |
| :-------------: | :-----: | :-------------------------------------------------------: | :----------------: | :--------------------: | :------: |
|      nome       | VARCHAR |                      Nome do Pokemón                      |      a-z, A-Z      |          não           |    PK    |
|     id_tipo     |   INT   |           Característica fundamental do Pokemón           |       1-5000       |          não           |    FK    |
|      nivel      |   INT   |                     Nível do Pokemón                      |       1-5000       |          não           |    -     |
|      vida       |   INT   |                      Vida do Pokemón                      |       1-5000       |          não           |    -     |
|  ataque_fisico  |   INT   |             Valor do ataque físico do Pokemón             |       1-5000       |          sim           |    -     |
|  defesa_fisica  |   INT   |             Valor da defesa físico do Pokemón             |       1-5000       |          sim           |    -     |
| ataque_especial |   INT   |            Valor do ataque especial do Pokemón            |       1-5000       |          sim           |    -     |
| defesa_especial |   INT   |            Valor da defesa especial do Pokemón            |       1-5000       |          sim           |    -     |
|   velocidade    |   INT   |              Valor da velocidade do Pokemón               |       1-5000       |          sim           |    -     |
|    acuracia     |   INT   |          Valor da precisão do ataque do Pokemón           |       1-5000       |          sim           |    -     |
|     evasao      |   INT   |             Capacidade de esquivar do ataque              |       1-5000       |          sim           |    -     |
|     status      | VARCHAR | Condições que podem afetar um Pokémon durante as batalhas |        a-z, A-Z        |          sim           |    -     |

## Entidade: Player

**Descrição**: A entidade player descreve as informações ligadas ao personagem jogável.

|   Nome Variável    | Tipo |        Descrição        | Valores permitidos | Permite valores nulos? | É chave? |
| :----------------: | :--: | :---------------------: | :----------------: | :--------------------: | :------: |
|         id         | INT  | Identificador do player |       1-5000       |          não           |    PK    |
| tamanho_inventario | INT  |  Tamanho do inventário  |       1-5000       |          não           |    FK    |

## Entidade: Missão

**Descrição**: A entidade Missão relaciona o número de identificação da missão, mapa, loot e npc.

**Observação**: Essa tabela possuí chaves estrangeiras das entidades Mapa, Npc e Loot.

| Nome Variável |    Tipo     |             Descrição             | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :---------: | :-------------------------------: | :----------------: | :--------------------: | :------: |
|      id       |     INT     | Código de identificação da missão |       1-5000       |          não           |    PK    |
|    id_mapa    |     INT     |  Código de identificação do mapa  |       1-5000       |          não           |    FK    |
|    id_npc     |     INT     |  Código de identificação do mapa  |       1-5000       |          não           |    FK    |
|    id_loot    |     INT     |  Código de identificação do loot  |       1-5000       |          não           |    FK    |
|  dificuldade  |     INT     |  Nível de dificuldade da missão   |       1-5000       |          não           |    -     |
|   objetivo    | VARCHAR |        Objetivo da missão         |      a-z, A-Z      |          não           |    -     |
|  tipo_missao  |     INT     | Tipo da missão(principal ou não)  |       1-5000       |          não           |    -     |

## Entidade: Inventário

**Descrição**: A entidade Inventário relaciona o loot com o player.

**Observação**: Essa tabela possui chave estrangeira da entidade `Item`.

| Nome Variável | Tipo |        Descrição        | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :--: | :---------------------: | :----------------: | :--------------------: | :------: |
|    id_item    | INT  | Identificador dos itens |       1-5000       |          não           |    FK    |

## Entidade: NPC

**Descrição**: A entidade NPC guarda as informações relacionada ao nome do personagem não jogável.

| Nome Variável |    Tipo     |      Descrição       | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :---------: | :------------------: | :----------------: | :--------------------: | :------: |
|      id       |     INT     | Identificação do NPC |       1-5000       |          Não           |    PK    |
|     nome      | VARCHAR |     Nome do NPC      |      a-z, A-Z      |          Não           |     -     |

## Entidade: Item

**Descrição**: A entidade Item armazena as informações relacionadas aos itens que podem ter no iventário do player.

| Nome Variável |    Tipo     |            Descrição            | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :---------: | :-----------------------------: | :----------------: | :--------------------: | :------: |
|      id       |     INT     | Código de Identificação do item |       1-5000       |          não           |    PK    |
|     nome      | VARCHAR |          Nome do item           |      a-z, A-Z      |          não           |     -     |
|  quantidade   |     INT     |        Descrição do item        |      1-5000      |          sim           |     -     |

## Entidade: Habilidade

**Descrição**: Descreve as habilidades disponíveis no jogo, o identificador da habilidade, seu nome, dano, tipo, efeito e a acurácia.

| Nome Variável |    Tipo     |          Descrição          | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :---------: | :-------------------------: | :----------------: | :--------------------: | :------: |
|      id       |     INT     | Identificador da habilidade |       1-5000       |          não           |    PK    |
|     nome      | VARCHAR |     Nome da habilidade      |      a-z, A-Z      |          não           |     -     |
|    id_tipo    |     INT     | Dano que a habilidade causa |       1-5000       |          não           |    FK    |
|   acuracia    |     INT     |      Precisão do dano       |       1-5000       |          sim           |     -     |
|     dano      |     INT     |       Dano causado pelo pokemón                      |      1-5000              |          sim              |     -     |
|   id_efeito   |     INT     |         Identicador de efeito para a entidade Efeito                    |      1-5000              |          não           |    FK    |

## Entidade: Pokemon-Habilidade

**Descrição**: Tabela auxiliar para armazernar as habilidades relacionadas ao pokemon.

**Observação**: Essa tabela possui chaves estrangeiras das entidades `Habilidade` e `Pokemon`.

| Nome Variável | Tipo |          Descrição          | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :--: | :-------------------------: | :----------------: | :--------------------: | :------: |
| id_habilidade | INT  | Identificador da habilidade |       1-5000       |          não           |    PK    |
|  id_pokemon   | INT  |  Identificador de pokemon   |       1-5000       |          não           |    FK    |

## Entidade: Andar

**Descrição**: Descreve a entidade, que se refere ao andar do mapa.

**Observação**: Essa tabela possui chave estrangeira da entidade `Mapa`.

| Nome Variável | Tipo |       Descrição        | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :--: | :--------------------: | :----------------: | :--------------------: | :------: |
|      id       | INT  | Identificador do andar |       1-5000       |          não           |    PK    |
|    id_mapa    | INT  | Identificador do mapa  |       1-5000       |          não           |    FK    |

## Entidade: Tipo_Terreno

**Descrição**: Descreve o tipo de terreno.

| Nome Variável |    Tipo     |        Descrição         | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :---------: | :----------------------: | :----------------: | :--------------------: | :------: |
|      id       |     INT     | Identificador de terreno |       1-5000       |          não           |    PK    |
|   descricao   | VARCHAR[50] |   Descrição de terreno   |       1-5000       |          não           |     -     |
|   movimento   |      INT       | Identificador da possibilidade de se mover em um terreno |       0-1         |            não            |     -     |

## Entidade: Terreno

**Descrição**: Descreve a entidade terreno, que são as coordenadas do player.

**Observação**: Essa tabela possui chave estrangeira da entidade `Tipo_Terreno`.

|  Nome Variável  | Tipo |            Descrição             | Valores permitidos | Permite valores nulos? | É chave? |
| :-------------: | :--: | :------------------------------: | :----------------: | :--------------------: | :------: |
|       id        | INT  |     Identificador do terreno     |       1-5000       |          não           |    PK    |
|        x        | INT  |      Coordenada do terreno       |       1-5000       |          não           |    -     |
|        y        | INT  |      Coordenada do terreno       |       1-5000       |          não           |    -     |
| id_tipo_terreno | INT  | Identificador do tipo de terreno |       1-5000       |          não           |    FK    |
| id_andar | INT  | Identificador do andar onde o terreno está inserido |       1-5000       |          não           |    FK    |

## Entidade: Tipo

**Descrição**: Característica fundamental que define suas habilidades, forças e fraquezas do Pokemón.

**Observação**: Essa tabela possui chave estrangeira da entidade `Interação`.

| Nome Variável |    Tipo     |             Descrição              | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :---------: | :--------------------------------: | :----------------: | :--------------------: | :------: |
|     nome      | VARCHAR |            Nome do tipo            |      a-z, A-Z      |          não           |    PK    |
| id_interacao  |     INT     | Indetificador da interação do tipo |       1-5000       |          não           |    FK    |

## Entidade: Interação

**Descrição**: A entidade Interação armazena as relações de eficácia entre diferentes tipos de ataques e defesas do Pokémon.

|  Nome Variável   | Tipo |         Descrição          | Valores permitidos | Permite valores nulos? | É chave? |
| :--------------: | :--: | :------------------------: | :----------------: | :--------------------: | :------: |
|        id        | INT  | Identificador da interação |       1-5000       |          não           |    PK    |
| id_tipo_atacante | INT  | Tipo elemental da habilidade do atacante |       1-5000       |          não           |    FK    |
| id_tipo_defensor | INT  | Tipo elemental do pokemon defensor |       1-5000       |          não           |    FK    |
|      valor       | INT  | Fator multiplicativo do dano |       1-5000       |          não           |    -      |

## Entidade: Efeito

**Descrição**: Representa o efeito que uma habilidade pode causar

| Nome Variável |    Tipo     | Descrição | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :---------: | :-------: | :----------------: | :--------------------: | :------: |
|     nome      | VARCHAR |           |      a-z, A-Z      |          não           |    PK    |
|     dano      |     INT     |           |       1-5000       |          não           |     -     |

## Entidade: Terreno_NPC

**Descrição**: Tabela auxiliar para indicar onde o npc está no terreno.

**Observação**: Essa tabela possui chaves estrangeiras das entidades `Terreno` e `NPC`.

| Nome Variável | Tipo | Descrição | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :--: | :-------: | :----------------: | :--------------------: | :------: |
|      id       | INT  |     Identificador do local do NPC      |       1-5000       |          não           |    PK    |
|  id_terreno   | INT  |     Identificador do terreno onde o NPC está      |       1-5000       |          não           |    FK    |
|    id_npc     | INT  |     Identificador do NPC que está no terreno      |       1-5000       |          não           |    FK    |

## Entidade: Terreno_Loot

**Descrição**: Tabela auxiliar para indicar qual loot está no terreno.

**Observação**: Essa tabela possui chaves estrangeiras das entidades `Terreno` e `Loot`.

| Nome Variável | Tipo | Descrição | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :--: | :-------: | :----------------: | :--------------------: | :------: |
|      id       | INT  |     Identificador do local onde está o loot      |       1-5000       |          não           |    PK    |
|  id_terreno   | INT  |     Identificador do terreno onde o loot está      |       1-5000       |          não           |    FK    |
|    id_loot    | INT  |     Identificador do loot que está no terreno      |       1-5000       |          não           |    FK    |

## Histórico de Versão

| Versão |    Data    |                  Descrição                   |                                                 Autor(es)                                                  |
| :----: | :--------: | :------------------------------------------: | :--------------------------------------------------------------------------------------------------------: |
| `1.0`  | 22/04/2024 |    Primeira versão do dicionário de dados    | [Gabriel Marcolino](https://github.com/GabrielMR360) e [Shaíne Oliveira](ttps://github.com/ShaineOliveira) |
| `1.1`  | 27/06/2024 | Ajustando e corrigindo o dinionário de dados | [Gabriel Marcolino](https://github.com/GabrielMR360) e [Shaíne Oliveira](ttps://github.com/ShaineOliveira) |
| `1.2`  | 12/07/2024 |       Adicionando atributos e tabelas        | [Gabriel Marcolino](https://github.com/GabrielMR360) e [Shaíne Oliveira](ttps://github.com/ShaineOliveira) |
| `1.3`  | 20/07/2024 |       Correção de valores permitidos e descrição        | [Gabriel Marcolino](https://github.com/GabrielMR360) e [Shaíne Oliveira](ttps://github.com/ShaineOliveira) |
