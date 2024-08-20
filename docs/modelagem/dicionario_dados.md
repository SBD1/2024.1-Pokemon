# <b>Dicionário de Dados</b>

O dicionário de dados são informações sobre os dados armazenados que são pertinentes para o banco de dados. Ele documenta a estrutura, os tipos, os relacionamentos e outras características dos dados, servindo como uma referência essencial para o desenvolvimento.

## Entidade: Pokemon

**Descrição**: A entidade representa um Pokemón podendo ser ele, um Player ou NPC.

**Observação**: Essa tabela possuí chaves estrangeiras da entidade Tipo.

|  Nome Variável  |  Tipo   |                         Descrição                         | Valores permitidos | Permite valores nulos? | É chave? |
| :-------------: | :-----: | :-------------------------------------------------------: | :----------------: | :--------------------: | :------: |
|     id    |   INT   |           Característica fundamental do Pokemón           |       1-5000       |          não           |    PK    |
|     tipo_pokemon      | VARCHAR | Pode ser NPC ou playes |        a-z, A-Z        |          não           |    FK    |

## Entidade: Player

**Descrição**: A entidade player descreve as informações ligadas ao personagem jogável.

|   Nome Variável    | Tipo |        Descrição        | Valores permitidos | Permite valores nulos? | É chave? |
| :----------------: | :--: | :---------------------: | :----------------: | :--------------------: | :------: |
|         id         | INT  | Identificador do player |       1-5000       |          não           |    PK    |
| id_inventario | INT  |  Tamanho do inventário  |       1-5000       |          não           |    FK    |
|     id_pokemon     |   INT   |           Característica fundamental do Pokemón           |       1-5000       |          não           |    FK    |
|     tipo_elemental      | VARCHAR | Condições que podem afetar um Pokémon durante as batalhas |        a-z, A-Z        |          não           |   FK     |
|      nivel      |   INT   |                     Nível do Pokemón                      |       1-5000       |          não           |    -     |
|      nome       | VARCHAR |                      Nome do Pokemón                      |      a-z, A-Z      |          não           |   -    |
|      vida       |   INT   |                      Vida do Pokemón                      |       1-5000       |          não           |    -     |
|  ataque_fisico  |   INT   |             Valor do ataque físico do Pokemón             |       1-5000       |          sim           |    -     |
|  defesa_fisica  |   INT   |             Valor da defesa físico do Pokemón             |       1-5000       |          sim           |    -     |
| ataque_especial |   INT   |            Valor do ataque especial do Pokemón            |       1-5000       |          sim           |    -     |
| defesa_especial |   INT   |            Valor da defesa especial do Pokemón            |       1-5000       |          sim           |    -     |
|   velocidade    |   INT   |              Valor da velocidade do Pokemón               |       1-5000       |          sim           |    -     |
|    acuracia     |   INT   |          Valor da precisão do ataque do Pokemón           |       1-5000       |          sim           |    -     |
|     evasao      |   INT   |             Capacidade de esquivar do ataque              |       1-5000       |          sim           |    -     |
|     status      | VARCHAR | Condições que podem afetar um Pokémon durante as batalhas |        a-z, A-Z        |          sim           |    -     |
|     saldo      | INT | Dinheiro que o jogador possui para gastar nas lojas |        1-5000        |          sim           |    -     |


## Entidade: Dialogo

**Descrição**: A entidade dialogo armazena as falas desencadeadas com a interação com um vendedor.

|   Nome Variável    | Tipo |        Descrição        | Valores permitidos | Permite valores nulos? | É chave? |
| :----------------: | :--: | :---------------------: | :----------------: | :--------------------: | :------: |
|         id         | INT  | Identificador do dialogo |       1-5000       |          não           |    PK    |
| personagem | VARCHAR  |  Nome do personagem que fala  |       A-Z,a-z       |          não           |   -   |
| fala | VARCHAR  |  Texto da conversa  |       A-Z,a-z       |          não           |    FK    |
| ordem | INT |  Ordem que esta fala vai aparecer para o jogador  |       1-5000       |          não           |  -    |
| id_vendedor | INT  |  Codigo de identificação do vendedor  |       1-5000       |          não           |    FK    |

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
|    id_correio    | INT  | Código do correio |       1-5000       |          não           |    FK    |

## Entidade: Correio

**Descrição**: A entidade Correio armazena as missões aceitas pelo jogador.

| Nome Variável | Tipo |        Descrição        | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :--: | :---------------------: | :----------------: | :--------------------: | :------: |
|    id_correio    | INT  | Identificador do correio |       1-5000       |          não           |    PK    |


## Entidade: Inventário

**Descrição**: A entidade Inventário relaciona o loot com o player.

**Observação**: Essa tabela possui chave estrangeira da entidade `Item`.

| Nome Variável | Tipo |        Descrição        | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :--: | :---------------------: | :----------------: | :--------------------: | :------: |
|    id    | INT  | Identificador do inventário |       1-5000       |          não           |    PK   |
|    id_item    | INT  | Identificador dos itens |       1-5000       |          não           |    FK    |
|    quantidade  | INT  | Quantidade de itens |       1-5000       |          sim           |      |

## Entidade: NPC

**Descrição**: A entidade NPC guarda as informações relacionada ao nome do personagem não jogável.

| Nome Variável |    Tipo     |      Descrição       | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :---------: | :------------------: | :----------------: | :--------------------: | :------: |
|         id         | INT  | Identificador do player |       1-5000       |          não           |    PK    |
|     id_pokemon     |   INT   |           Característica fundamental do Pokemón           |       1-5000       |          não           |    FK    |
|     tipo_elemental      | VARCHAR | Condições que podem afetar um Pokémon durante as batalhas |        a-z, A-Z        |          não           |   FK     |
|      nivel      |   INT   |                     Nível do Pokemón                      |       1-5000       |          não           |    -     |
|      nome       | VARCHAR |                      Nome do Pokemón                      |      a-z, A-Z      |          não           |   -    |
|      vida       |   INT   |                      Vida do Pokemón                      |       1-5000       |          não           |    -     |
|  ataque_fisico  |   INT   |             Valor do ataque físico do Pokemón             |       1-5000       |          sim           |    -     |
|  defesa_fisica  |   INT   |             Valor da defesa físico do Pokemón             |       1-5000       |          sim           |    -     |
| ataque_especial |   INT   |            Valor do ataque especial do Pokemón            |       1-5000       |          sim           |    -     |
|   velocidade    |   INT   |              Valor da velocidade do Pokemón               |       1-5000       |          sim           |    -     |
|    acuracia     |   INT   |          Valor da precisão do ataque do Pokemón           |       1-5000       |          sim           |    -     |
|     evasao      |   INT   |             Capacidade de esquivar do ataque              |       1-5000       |          sim           |    -     |
|     status      | VARCHAR | Condições que podem afetar um Pokémon durante as batalhas |        a-z, A-Z        |          sim           |    -     |

## Entidade: Item

**Descrição**: A entidade Item armazena as informações relacionadas aos itens que podem ter no iventário do player.

| Nome Variável |    Tipo     |            Descrição            | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :---------: | :-----------------------------: | :----------------: | :--------------------: | :------: |
|      id       |     INT     | Código de Identificação do item |       1-5000       |          não           |    PK    |
|     descricao      | VARCHAR |          Nome do item           |      a-z, A-Z      |          não           |     -     |


## Entidade: Habilidade

**Descrição**: Descreve as habilidades disponíveis no jogo, o identificador da habilidade, seu nome, dano, tipo, efeito e a acurácia.

| Nome Variável |    Tipo     |          Descrição          | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :---------: | :-------------------------: | :----------------: | :--------------------: | :------: |
|      id       |     INT     | Identificador da habilidade |       1-5000       |          não           |    PK    |
|    tipo_elemental    |     INT     | Condições que podem afetar um Pokémon durante as batalhas |       1-5000       |          não           |    FK    |
|     nome      | VARCHAR |     Nome da habilidade      |      a-z, A-Z      |          não           |     -     |
|   acuracia    |     INT     |      Precisão do dano       |       1-5000       |          sim           |     -     |
|     dano      |     INT     |       Dano causado pelo pokemón                      |      1-5000              |          sim              |     -     |

## Entidade: Pokemon-Habilidade

**Descrição**: Tabela auxiliar para armazernar as habilidades relacionadas ao pokemon.

**Observação**: Essa tabela possui chaves estrangeiras das entidades `Habilidade` e `Pokemon`.

| Nome Variável | Tipo |          Descrição          | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :--: | :-------------------------: | :----------------: | :--------------------: | :------: |
| id | INT  | Identificador da Entidade |       1-5000       |          não           |    PK    |
| id_habilidade | INT  | Identificador da habilidade |       1-5000       |          não           |    FK    |
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
| id_tipo_terreno | INT  | Identificador do tipo de terreno |       1-5000       |          não           |    FK    |
| id_andar | INT  | Identificador do andar onde o terreno está inserido |       1-5000       |          não           |    FK    |
|        x        | INT  |      Coordenada do terreno       |       1-5000       |          não           |    -     |
|        y        | INT  |      Coordenada do terreno       |       1-5000       |          não           |    -     |

## Entidade: Tipo_Elemental

**Descrição**: Característica fundamental que define suas habilidades, forças e fraquezas do Pokemón.

**Observação**: Essa tabela possui chave estrangeira da entidade `Interação`.

| Nome Variável |    Tipo     |             Descrição              | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :---------: | :--------------------------------: | :----------------: | :--------------------: | :------: |
| nome |     INT     | Indetificador da interação do tipo |       1-5000       |          não           |    PK    |

## Entidade: Interacao

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
|     nome      | VARCHAR |    Nome do efeito       |      a-z, A-Z      |          não           |    PK    |
|     dano      |     INT     |      Dano causado pelo efeito     |       1-5000       |          não           |     -     |

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




## Entidade: Loot

**Descrição**: Tabela que representa a recompensa da missão ou do terreno.

**Observação**: Essa tabela possui chaves estrangeiras das entidades `Terreno`.

| Nome Variável | Tipo | Descrição | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :--: | :-------: | :----------------: | :--------------------: | :------: |
|      id       | INT  |     Identificador do loot     |       1-5000       |          não           |    PK    |
|  id_terreno   | INT  |     Identificador do terreno onde o loot está      |       1-5000       |          não           |    FK    |

## Histórico de Versão

| Versão |    Data    |                  Descrição                   |                                                 Autor(es)                                                  |
| :----: | :--------: | :------------------------------------------: | :--------------------------------------------------------------------------------------------------------: |
| `1.0`  | 22/04/2024 |    Primeira versão do dicionário de dados    | [Gabriel Marcolino](https://github.com/GabrielMR360) e [Shaíne Oliveira](ttps://github.com/ShaineOliveira) |
| `1.1`  | 27/06/2024 | Ajustando e corrigindo o dinionário de dados | [Gabriel Marcolino](https://github.com/GabrielMR360) e [Shaíne Oliveira](ttps://github.com/ShaineOliveira) |
| `1.2`  | 12/07/2024 |       Adicionando atributos e tabelas        | [Gabriel Marcolino](https://github.com/GabrielMR360) e [Shaíne Oliveira](ttps://github.com/ShaineOliveira) |
| `1.3`  | 20/07/2024 |       Correção de valores permitidos e descrição        | [Gabriel Marcolino](https://github.com/GabrielMR360) e [Shaíne Oliveira](ttps://github.com/ShaineOliveira) |
| `1.4`  | 20/07/2024 |       Adição de tabelas e correção de chaves estrangeiras        | [Leonardo Bonetti](https://github.com/LeoFacB)|
| `1.5`  | 05/08/2024 |       Correção das entidades        | [Gabriel Marcolino](https://github.com/GabrielMR360) e [Shaíne Oliveira](ttps://github.com/ShaineOliveira) |
