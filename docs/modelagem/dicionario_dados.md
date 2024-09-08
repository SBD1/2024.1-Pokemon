# <b>Dicionário de Dados</b>

O dicionário de dados são informações sobre os dados armazenados que são pertinentes para o banco de dados. Ele documenta a estrutura, os tipos, os relacionamentos e outras características dos dados, servindo como uma referência essencial para o desenvolvimento.

## Entidade: Pokemon

**Descrição**: A entidade representa um Pokemón podendo ser ele, um Player ou NPC.

**Observação**: Essa tabela possuí chaves estrangeiras da entidade Tipo.

| Nome Variável |  Tipo   |        Descrição         | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :-----: | :----------------------: | :----------------: | :--------------------: | :------: |
|  id_pokemon   |   INT   | Identificador do Pokemón |       1-5000       |          não           |    PK    |
| tipo_pokemon  | VARCHAR |  Pode ser NPC ou playes  |       1-5000       |          não           |    -     |

## Entidade: Jogador

**Descrição**: A entidade Jogador descreve as informações ligadas ao personagem jogável.

|  Nome Variável  |  Tipo   |                         Descrição                         | Valores permitidos | Permite valores nulos? | É chave? |
| :-------------: | :-----: | :-------------------------------------------------------: | :----------------: | :--------------------: | :------: |
|   id_jogador    |   INT   |                  Identificador do player                  |       1-5000       |          não           |    PK    |
|   id_correio    |   INT   |                   Tamanho do inventário                   |       1-5000       |          não           |    FK    |
| tipo_elemental  | VARCHAR | Condições que podem afetar um Pokémon durante as batalhas |      a-z, A-Z      |          não           |    FK    |
|     posicao     |   INT   |              Poisição do jogador no terreno               |       1-5000       |          não           |    FK    |
|      nivel      |   INT   |                     Nível do Pokemón                      |       1-5000       |          não           |    -     |
|      nome       | VARCHAR |                      Nome do Pokemón                      |      a-z, A-Z      |          não           |    -     |
|      vida       |   INT   |                      Vida do Pokemón                      |       1-5000       |          não           |    -     |
|  ataque_fisico  |   INT   |             Valor do ataque físico do Pokemón             |       1-5000       |          sim           |    -     |
|  defesa_fisica  |   INT   |             Valor da defesa físico do Pokemón             |       1-5000       |          sim           |    -     |
| ataque_especial |   INT   |            Valor do ataque especial do Pokemón            |       1-5000       |          sim           |    -     |
|   velocidade    |   INT   |              Valor da velocidade do Pokemón               |       1-5000       |          sim           |    -     |
|    acuracia     |   INT   |          Valor da precisão do ataque do Pokemón           |       1-5000       |          sim           |    -     |
|     evasao      |   INT   |             Capacidade de esquivar do ataque              |       1-5000       |          sim           |    -     |
|     status      | VARCHAR | Condições que podem afetar um Pokémon durante as batalhas |      a-z, A-Z      |          sim           |    -     |
|      saldo      |   INT   |    Dinheiro que o jogador possui para gastar nas lojas    |       1-5000       |          sim           |    -     |
| tam_inventario  |   INT   |       Representa o tamanho do inventário do jogador       |         20         |          não           |    -     |

## Entidade: Dialogo

**Descrição**: A entidade dialogo armazena as falas desencadeadas com a interação com um vendedor.

| Nome Variável |  Tipo   |                    Descrição                    | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :-----: | :---------------------------------------------: | :----------------: | :--------------------: | :------: |
|      id       |   INT   |            Identificador do dialogo             |       1-5000       |          não           |    PK    |
|  personagem   | VARCHAR |           Nome do personagem que fala           |      a-z, A-Z      |          não           |    -     |
|     fala      | VARCHAR |                Texto da conversa                |      a-z, A-Z      |          não           |    -     |
|     ordem     |   INT   | Ordem que esta fala vai aparecer para o jogador |       1-5000       |          não           |    -     |

## Entidade: Missão

**Descrição**: A entidade Missão relaciona o número de identificação da missão, mapa e loot.

**Observação**: Essa tabela possuí chaves estrangeiras das entidades Mapa, Npc e Loot.

| Nome Variável |  Tipo   |               Descrição               | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :-----: | :-----------------------------------: | :----------------: | :--------------------: | :------: |
|   id_missao   |   INT   |   Código de identificação da missão   |       1-5000       |          não           |    PK    |
|   nome_mapa   | VARCHAR |             Nome do mapa              |      a-z, A-Z      |          não           |    FK    |
|    id_loot    |   INT   |    Código de identificação do loot    |       1-5000       |          não           |    FK    |
|  id_correio   |   INT   |           Código do correio           |       1-5000       |          não           |    FK    |
|  dificuldade  |   INT   |    Nível de dificuldade da missão     |       1-5000       |          não           |    -     |
|   objetivo    | VARCHAR |          Objetivo da missão           |      a-z, A-Z      |          não           |    -     |
|   principal   | BOOLEAN | Indica se a missão é principal ou não |   true ou false    |          não           |    -     |

## Entidade: Correio

**Descrição**: A entidade Correio armazena as missões aceitas pelo jogador.

| Nome Variável | Tipo |                        Descrição                        | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :--: | :-----------------------------------------------------: | :----------------: | :--------------------: | :------: |
|      id       | INT  |                Identificador do correio                 |       1-5000       |          não           |    PK    |
|  jogador_id   | INT  |                Identificador do jogador                 |       1-5000       |          não           |    FK    |
|  terreno_id   | INT  | Identificador do terreno onde o correio está localizado |       1-5000       |          não           |    FK    |

## Entidade: Inventário

**Descrição**: A entidade Inventário relaciona o loot com o player.

**Observação**: Essa tabela possui chave estrangeira da entidade `instancia_item`.

|   Nome Variável   | Tipo |          Descrição          | Valores permitidos | Permite valores nulos? | É chave? |
| :---------------: | :--: | :-------------------------: | :----------------: | :--------------------: | :------: |
|   id_inventario   | INT  | Identificador do inventário |       1-5000       |          não           |    PK    |
| id_instancia_item | INT  |   Identificador dos itens   |       1-5000       |          não           |    FK    |

## Entidade: NPC

**Descrição**: A entidade NPC guarda as informações relacionada ao nome do personagem não jogável.

| Nome Variável | Tipo |          Descrição           | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :--: | :--------------------------: | :----------------: | :--------------------: | :------: |
|    id_npc     | INT  |     Identificador do NPC     |       1-5000       |          não           |    PK    |
|  id_tipo_npc  | INT  | Identificador do tipo do NPC |       1-5000       |          não           |    -     |

## Entidade: Item

**Descrição**: A entidade Item armazena as informações relacionadas aos itens que podem ter no iventário do player.

| Nome Variável |  Tipo   |            Descrição            | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :-----: | :-----------------------------: | :----------------: | :--------------------: | :------: |
|    id_item    |   INT   | Código de Identificação do item |       1-5000       |          não           |    PK    |
|     nome      | VARCHAR |          Nome do item           |      a-z, A-Z      |          não           |    -     |
|   descricao   | VARCHAR |        Descrição do item        |      a-z, A-Z      |          não           |    -     |
|    efeito     | VARCHAR |  Efeito que o item pode causar  |      a-z, A-Z      |          não           |    -     |
|     valor     |   INT   |     Valor de compra do item     |       1-5000       |          não           |    -     |

## Entidade: Habilidade

**Descrição**: Descreve as habilidades disponíveis no jogo, o identificador da habilidade, seu nome, dano, tipo, efeito e a acurácia.

| Nome Variável  |  Tipo   |                         Descrição                         | Valores permitidos | Permite valores nulos? | É chave? |
| :------------: | :-----: | :-------------------------------------------------------: | :----------------: | :--------------------: | :------: |
| id_habilidade  |   INT   |                Identificador da habilidade                |       1-5000       |          não           |    PK    |
| tipo_elemental |   INT   | Condições que podem afetar um Pokémon durante as batalhas |       1-5000       |          não           |    FK    |
|  nome_efeito   | VARCHAR |      Identificação do efeito que a habilidade causa       |      a-z, A-Z      |          não           |    FK    |
|      nome      | VARCHAR |                    Nome da habilidade                     |      a-z, A-Z      |          não           |    -     |
|    acuracia    |   INT   |                     Precisão do dano                      |       1-5000       |          sim           |    -     |
|      dano      |   INT   |                 Dano causado pelo pokemón                 |       1-5000       |          sim           |    -     |
|      pp      |   INT   |                 Numero de vezes que uma habilidade pode ser usada por um pokemon ate precisar recarregar                 |       1-5000       |          não           |    -     |

## Entidade: Pokemon-Habilidade

**Descrição**: Tabela auxiliar para armazernar as habilidades relacionadas ao pokemon.

**Observação**: Essa tabela possui chaves estrangeiras das entidades `Habilidade` e `Pokemon`.

|     Nome Variável     | Tipo |          Descrição          | Valores permitidos | Permite valores nulos? | É chave? |
| :-------------------: | :--: | :-------------------------: | :----------------: | :--------------------: | :------: |
| id_pokemon_habilidade | INT  |  Identificador da Entidade  |       1-5000       |          não           |    PK    |
|      pp_restante       | INT  |  Quantidade de cargas da habilidade  |       1-5000       |          não          |    -   |
|     id_habilidade     | INT  | Identificador da habilidade |       1-5000       |          não           |    FK    |
|      id_pokemon       | INT  |  Identificador de pokemon   |       1-5000       |          não           |    FK    |

## Entidade: Andar

**Descrição**: Descreve a entidade, que se refere ao andar do mapa.

**Observação**: Essa tabela possui chave estrangeira da entidade `Mapa`.

| Nome Variável |  Tipo   |        Descrição         | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :-----: | :----------------------: | :----------------: | :--------------------: | :------: |
|   id_andar    |   INT   | Identificador de terreno |       1-5000       |          não           |    PK    |
|   nome_mapa   | VARCHAR |       Nome do mapa       |      a-z, A-Z      |          não           |    -     |
| numero_andar  |   INT   |     Número do andar      |        1 -         |          não           |    -     |

## Entidade: Tipo_Terreno

**Descrição**: Descreve o tipo de terreno.

|  Nome Variável  |  Tipo   |                     Descrição                      | Valores permitidos | Permite valores nulos? | É chave? |
| :-------------: | :-----: | :------------------------------------------------: | :----------------: | :--------------------: | :------: |
| id_tipo_terreno |   INT   |          Identificador do tipo de terreno          |       1-5000       |          não           |    PK    |
|    descricao    | VARCHAR |                Descrição do terreno                |      a-z, A-Z      |          não           |    -     |
|    movimento    |   INT   | Indica se pode se movimentar nesse tipo de terreno |   true ou false    |          não           |    -     |

## Entidade: Terreno

**Descrição**: Descreve a entidade terreno, que são as coordenadas do player.

**Observação**: Essa tabela possui chave estrangeira da entidade `Tipo_Terreno`.

|  Nome Variável  | Tipo |                      Descrição                      | Valores permitidos | Permite valores nulos? | É chave? |
| :-------------: | :--: | :-------------------------------------------------: | :----------------: | :--------------------: | :------: |
|   id_terreno    | INT  |              Identificador do terreno               |       1-5000       |          não           |    PK    |
| id_tipo_terreno | INT  |          Identificador do tipo de terreno           |       1-5000       |          não           |    FK    |
|    id_andar     | INT  | Identificador do andar onde o terreno está inserido |       1-5000       |          não           |    FK    |
|        x        | INT  |                Coordenada do terreno                |       1-5000       |          não           |    -     |
|        y        | INT  |                Coordenada do terreno                |       1-5000       |          não           |    -     |

## Entidade: Tipo_Elemental

**Descrição**: Característica fundamental que define suas habilidades, forças e fraquezas do Pokemón.

**Observação**: Essa tabela possui chave estrangeira da entidade `Interação`.

| Nome Variável |  Tipo   |             Descrição              | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :-----: | :--------------------------------: | :----------------: | :--------------------: | :------: |
|     nome      | VARCHAR | Indetificador da interação do tipo |      a-z, A-Z      |          não           |    PK    |

## Entidade: Interacao

**Descrição**: A entidade Interação armazena as relações de eficácia entre diferentes tipos de ataques e defesas do Pokémon.

|  Nome Variável   | Tipo |                Descrição                 | Valores permitidos | Permite valores nulos? | É chave? |
| :--------------: | :--: | :--------------------------------------: | :----------------: | :--------------------: | :------: |
|        id        | INT  |        Identificador da interação        |       1-5000       |          não           |    PK    |
| id_tipo_atacante | INT  | Tipo elemental da habilidade do atacante |       1-5000       |          não           |    FK    |
| id_tipo_defensor | INT  |    Tipo elemental do pokemon defensor    |       1-5000       |          não           |    FK    |
|      valor       | INT  |       Fator multiplicativo do dano       |       1-5000       |          não           |    -     |

## Entidade: Efeito

**Descrição**: Representa o efeito que uma habilidade pode causar

| Nome Variável |  Tipo   |        Descrição         | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :-----: | :----------------------: | :----------------: | :--------------------: | :------: |
|     nome      | VARCHAR |      Nome do efeito      |      a-z, A-Z      |          não           |    PK    |
|     dano      |   INT   | Dano causado pelo efeito |       1-5000       |          não           |    -     |

## Entidade: Terreno_Loot

**Descrição**: Tabela auxiliar para indicar qual loot está no terreno.

**Observação**: Essa tabela possui chaves estrangeiras das entidades `Terreno` e `Loot`.

|  Nome Variável  | Tipo |                 Descrição                 | Valores permitidos | Permite valores nulos? | É chave? |
| :-------------: | :--: | :---------------------------------------: | :----------------: | :--------------------: | :------: |
| id_terreno_loot | INT  |  Identificador do local onde está o loot  |       1-5000       |          não           |    PK    |
|   id_terreno    | INT  | Identificador do terreno onde o loot está |       1-5000       |          não           |    FK    |
|     id_loot     | INT  | Identificador do loot que está no terreno |       1-5000       |          não           |    FK    |

## Entidade: Loot

**Descrição**: Tabela que representa a recompensa da missão ou do terreno.

**Observação**: Essa tabela possui chaves estrangeiras das entidades `Terreno`.

| Nome Variável | Tipo |                 Descrição                 | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :--: | :---------------------------------------: | :----------------: | :--------------------: | :------: |
|    id_loot    | INT  |           Identificador do loot           |       1-5000       |          não           |    PK    |
|  id_terreno   | INT  | Identificador do terreno onde o loot está |       1-5000       |          não           |    FK    |

## Entidade: Inimigo

**Descrição**: A entidade Inimigo descreve as informações ligadas aos inimigos do jogo.

|  Nome Variável  |  Tipo   |                         Descrição                         | Valores permitidos | Permite valores nulos? | É chave? |
| :-------------: | :-----: | :-------------------------------------------------------: | :----------------: | :--------------------: | :------: |
|   id_inimigo    |   INT   |                 Identificador do inimigo                  |       1-5000       |          não           |    PK    |
| tipo_elemental  | VARCHAR | Condições que podem afetar um Pokémon durante as batalhas |      a-z, A-Z      |          não           |    FK    |
|     posicao     |   INT   |              Poisição do inimigo no terreno               |       1-5000       |          não           |    FK    |
|      nivel      |   INT   |                     Nível do inimigo                      |       1-5000       |          não           |    -     |
|      nome       | VARCHAR |                      Nome do inimigo                      |      a-z, A-Z      |          não           |    -     |
|      vida       |   INT   |                      Vida do inimigo                      |       1-5000       |          não           |    -     |
|  ataque_fisico  |   INT   |             Valor do ataque físico do inimigo             |       1-5000       |          sim           |    -     |
|  defesa_fisica  |   INT   |             Valor da defesa físico do inimigo             |       1-5000       |          sim           |    -     |
| ataque_especial |   INT   |            Valor do ataque especial do inimigo            |       1-5000       |          sim           |    -     |
|   velocidade    |   INT   |              Valor da velocidade do inimigo               |       1-5000       |          sim           |    -     |
|    acuracia     |   INT   |          Valor da precisão do ataque do inimigo           |       1-5000       |          sim           |    -     |
|     evasao      |   INT   |             Capacidade de esquivar do ataque              |       1-5000       |          sim           |    -     |
|     status      | VARCHAR | Condições que podem afetar um Pokémon durante as batalhas |      a-z, A-Z      |          sim           |    -     |

## Entidade: instancia_item

**Descrição**: A entidade instancia_item relaciona o item com ao inventário do jogador.

**Observação**: Essa tabela possui chave estrangeira da entidade `item`.

|   Nome Variável   | Tipo |             Descrição              | Valores permitidos | Permite valores nulos? | É chave? |
| :---------------: | :--: | :--------------------------------: | :----------------: | :--------------------: | :------: |
| id_instancia_item | INT  | Identificador da instância do item |       1-5000       |          não           |    PK    |
|      id_item      | INT  |      Identificador dos itens       |       1-5000       |          não           |    FK    |

## Entidade: loot_item

**Descrição**: A entidade instancialoot_item_item relaciona os itens com loot.

**Observação**: Essa tabela possui chave estrangeira das entidades `item` e `loot`.

| Nome Variável | Tipo |                   Descrição                    | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :--: | :--------------------------------------------: | :----------------: | :--------------------: | :------: |
| id_loot_item  | INT  |       Identificador da instância do item       |       1-5000       |          não           |    PK    |
|    id_item    | INT  |            Identificador dos itens             |       1-5000       |          não           |    FK    |
|    id_loot    | INT  | Identificador do loot ao qual o item faz parte |       1-5000       |          não           |    FK    |
|  quantidade   | INT  |    Quantidade de itens que o loot armazena     |       1-5000       |          não           |    -     |

## Entidade: vendedor

**Descrição**: A entidade vendedor descreve as informações ligadas aos vendedores do jogo.

|  Nome Variável  |  Tipo   |                         Descrição                         | Valores permitidos | Permite valores nulos? | É chave? |
| :-------------: | :-----: | :-------------------------------------------------------: | :----------------: | :--------------------: | :------: |
|   id_vendedor   |   INT   |                 Identificador do vendedor                 |       1-5000       |          não           |    PK    |
| tipo_elemental  | VARCHAR | Condições que podem afetar um Pokémon durante as batalhas |      a-z, A-Z      |          não           |    FK    |
|     posicao     |   INT   |              Poisição do vendedor no terreno              |       1-5000       |          não           |    FK    |
|      nivel      |   INT   |                     Nível do vendedor                     |       1-5000       |          não           |    -     |
|      nome       | VARCHAR |                     Nome do vendedor                      |      a-z, A-Z      |          não           |    -     |
|      vida       |   INT   |                     Vida do vendedor                      |       1-5000       |          não           |    -     |
|  ataque_fisico  |   INT   |            Valor do ataque físico do vendedor             |       1-5000       |          sim           |    -     |
|  defesa_fisica  |   INT   |            Valor da defesa físico do vendedor             |       1-5000       |          sim           |    -     |
| ataque_especial |   INT   |           Valor do ataque especial do vendedor            |       1-5000       |          sim           |    -     |
|   velocidade    |   INT   |              Valor da velocidade do vendedor              |       1-5000       |          sim           |    -     |
|    acuracia     |   INT   |          Valor da precisão do ataque do vendedor          |       1-5000       |          sim           |    -     |
|     evasao      |   INT   |             Capacidade de esquivar do ataque              |       1-5000       |          sim           |    -     |
|     status      | VARCHAR | Condições que podem afetar um Pokémon durante as batalhas |      a-z, A-Z      |          sim           |    -     |

## Entidade: instancia_missao

**Descrição**: A entidade instancia_missao relaciona o a missão ao jogador.

**Observação**: Essa tabela possui chaves estrangeiras das entidades `missao` e `jogador`.

| Nome Variável |  Tipo   |            Descrição             | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :-----: | :------------------------------: | :----------------: | :--------------------: | :------: |
|   id_missao   |   INT   |     Identificador da missão      |       1-5000       |          não           |    FK    |
|  id_jogador   |   INT   |     Identificador do jogador     |       1-5000       |          não           |    FK    |
|   concluida   | BOOLEAN | Indica se a missão foi concluída |   true ou false    |          não           |    -     |

## Entidade: mapa

**Descrição**: A entidade mapa possui as informações dos mapas do jogo.

|   Nome Variável    |  Tipo   |                Descrição                | Valores permitidos | Permite valores nulos? | É chave? |
| :----------------: | :-----: | :-------------------------------------: | :----------------: | :--------------------: | :------: |
|        nome        | VARCHAR |              Nome do mapa               |      a-z, A-Z      |          não           |    PK    |
| quantidade_andares |   INT   | Quantidade de andares que o mapa possui |       1-5000       |          não           |    -     |

## Histórico de Versão

| Versão |    Data    |                      Descrição                      |                                                 Autor(es)                                                  |
| :----: | :--------: | :-------------------------------------------------: | :--------------------------------------------------------------------------------------------------------: |
| `1.0`  | 22/04/2024 |       Primeira versão do dicionário de dados        | [Gabriel Marcolino](https://github.com/GabrielMR360) e [Shaíne Oliveira](ttps://github.com/ShaineOliveira) |
| `1.1`  | 27/06/2024 |    Ajustando e corrigindo o dinionário de dados     | [Gabriel Marcolino](https://github.com/GabrielMR360) e [Shaíne Oliveira](ttps://github.com/ShaineOliveira) |
| `1.2`  | 12/07/2024 |           Adicionando atributos e tabelas           | [Gabriel Marcolino](https://github.com/GabrielMR360) e [Shaíne Oliveira](ttps://github.com/ShaineOliveira) |
| `1.3`  | 20/07/2024 |     Correção de valores permitidos e descrição      | [Gabriel Marcolino](https://github.com/GabrielMR360) e [Shaíne Oliveira](ttps://github.com/ShaineOliveira) |
| `1.4`  | 20/07/2024 | Adição de tabelas e correção de chaves estrangeiras |                               [Leonardo Bonetti](https://github.com/LeoFacB)                               |
| `1.5`  | 05/08/2024 |               Correção das entidades                | [Gabriel Marcolino](https://github.com/GabrielMR360) e [Shaíne Oliveira](ttps://github.com/ShaineOliveira) |
| `1.6`  | 07/09/2024 |         Atualização do dicionário de dados          | [Gabriel Marcolino](https://github.com/GabrielMR360) e [Shaíne Oliveira](ttps://github.com/ShaineOliveira) |
| `1.7`  | 07/09/2024 |         Atualização do dicionário de dados          | [Leonardo Fachinello Bonetti](https://github.com/LeoFacB) |