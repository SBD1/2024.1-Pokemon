## Dicionário de dados

---
O dicionário de dados consiste numa lista organizada de todos os elementos de dados que são pertinentes para o sistema. 



## Entidade: Player

**Descrição**: A entidade player descreve as informações ligadas ao personagem jogável, como:

**Observação**: Essa tabela possui chaves estrangeiras das entidades...

| Nome Variável |    Tipo     |             Descrição              | Valores permitidos | Permite valores nulos? | É chave? | 
| :-----------: | :---------: | :--------------------------------: | :----------------: | :--------------------: | :------: | 
|  xxx   |     int     | Código de identificação do jogador |       1-5000       |          não           |    PK    |                   
|     xxx      | varchar[50] |          Nome do jogador           |      a-z, A-Z      |          não           |          |                   
| xxx |      int    |   Itdentificador do equipado       |      1-5000        |          sim           |    FK    |                   
| xxx |      int    |   Itdentificador do inventário |      1-5000      |         não     |    FK    |                   
|  xxx  |     int  |      Identificador do diálogo     |       1-5000       |          sim           |    FK    |                   
| xxx |     int     |   Identificador do cenario-atual   |       1-5000       |          não           |    FK    |                   
| xxx  |     int     |   Identificador da missao-atual    |       1-5000       |          sim           |    FK    | 
| xxx    |     int     |   Identificador da afinidade       |       1-5000       |          sim           |    FK    |                    
|    xxx     |     int     |          Nível do jogador          |       1-100        |          não           |          |                   
|    xxx    |     int     | Quantidade de experiência do jogador  |       1-100        |          não           |          |                   
|   xxx  |     int     |    Limite de vida do jogador      |       1-100        |          não           |          |                   


## Entidade: Missão
**Descrição**: A entidade Missão relaciona o número de identificação da missão, mapa, loot.

| Nome Variável |     Tipo     |             Descrição              | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :----------: | :--------------------------------: | :----------------: | :--------------------: | :------: |
|   id_missao   |     int      | Código de identificação da missão  |       1-5000       |          não           |    PK    |                   |
|    id_mapa      | int  |         Código de identificação do mapa           |     1-5000      |          não           |    FK      |                   |
|   id_loot   | int |       Código de identificação do loot         |      1-5000      |          não           |   FK       |                   |
|   dificuldade   | int |  Nível de dificuldade da missão              |      1-5000      |          não           |         |                   |
|   objetivo   | xx |       xx         |      xx      |          xx           |   xx       |                   |
|   tipo_missao   | xx |      xx        |      xx      |          xx         |   xx       |                   |

## Entidade: Inventário

**Descrição**: A entidade Inventário relaciona...

**Observação**: Essa tabela possui chave estrangeira da entidade `Item`.

| Nome Variável | Tipo |        Descrição         | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :--: | :----------------------: | :----------------: | :--------------------: | :------: |
|    id-inventario    | int  | Identificador do inventário |       1-5000       |          não           |    PK    |                   |




## Entidade: NPC

**Descrição**: A entidade NPC guarda as informações relacionada...

**Observação**: Essa tabela possui chaves estrangeiras das entidade...

| Nome Variável |     Tipo     |                Descrição                | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :----------: | :-------------------------------------: | :----------------: | :--------------------: | :------: |
|    xx    |     xx      |    xx     |       xx      |          xx           |    xx   |                   |




## Entidade: Item

**Descrição**: A entidade Item armazena as informações de identificação do item, nome e quantidade de itens.

| Nome Variável |    Tipo     |            Descrição            | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :---------: | :-----------------------------: | :----------------: | :--------------------: | :------: |
|    id-item    |     int     | Código de Identificação do item |       1-5000       |          não           |    PK    |                   |
|     nome      | varchar[50]  |           Nome do item           |      a-z, A-Z      |          não           |          |
|   quantidade   | int |        Descrição do item         |      a-z, A-Z      |          sim           |          |                   |




## Entidade: Habilidade

**Descrição**: Descreve as habilidades disponíveis no jogo, o identificador da habilidade, seu nome, dano e a acurácia.

**Observação**: xxxx

| Nome Variável |     Tipo     |                  Descrição                  | Valores permitidos | Permite valores nulos? | É chave? |
| :-----------: | :----------: | :-----------------------------------------: | :----------------: | :--------------------: | :------: |
|  id-habilidade  |     int      |          Identificador da habilidade           |       1-5000       |          não           |    PK    |                   |
|     nome      | varchar[50]  |               Nome da habilidade              |      a-z, A-Z      |          não           |          |                   |
|    tipo       |  int         | Dano que a habilidade causa                             |       1-5000       |          não           |        |                   |
|   acuracia   | int |        Precisão do dano             |      1-5000     |          sim           |          |                   |



## Histórico de Versão
| Versão | Data | Descrição | Autor(es) |
| :-: | :-: | :-: | :-: | 
| `1.0`  | 22/04/2024 | Primeira versão  do dicionário de dados    | [Gabriel Marcolino](https://github.com/GabrielMR360) e [Shaíne Oliveira](ttps://github.com/ShaineOliveira) |                                                              