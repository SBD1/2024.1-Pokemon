# <b>Data Manipulation Language</b>

DML (Data Manipulation Language), é um subconjunto da SQL utilizado para manipular e gerenciar dados em um banco de dados. Essas operações DML são essenciais para a administração e a manutenção de dados em um banco de dados relacional, permitindo aos usuários adicionar, modificar e remover dados conforme necessário.

#### Inserindo dados na tabela 'mapa'
~~~sql
INSERT INTO mapa (nome, quantidade_andares) VALUES ('Floresta Sombra', 10);
INSERT INTO mapa (nome, quantidade_andares) VALUES ('Caverna Cristal', 15);
INSERT INTO mapa (nome, quantidade_andares) VALUES ('Montanha Fogo', 20);
~~~
 
#### Inserindo dados na tabela 'andar'
~~~sql
INSERT INTO andar (nome_mapa, numero_andar) VALUES ('Floresta Sombra', 1);
INSERT INTO andar (nome_mapa, numero_andar) VALUES ('Caverna Cristal', 2);
INSERT INTO andar (nome_mapa, numero_andar) VALUES ('Montanha Fogo', 3);
~~~

#### Inserindo dados na tabela 'tipo_terreno'
~~~sql
INSERT INTO tipo_terreno (descricao, movimento) VALUES ('Gramado', true);
INSERT INTO tipo_terreno (descricao, movimento) VALUES ('Água', false);
INSERT INTO tipo_terreno (descricao, movimento) VALUES ('Rocha', true);
~~~

#### Inserindo dados na tabela 'terreno'
~~~sql
INSERT INTO terreno (x, y, id_tipo_terreno, id_andar) VALUES (1, 1, 1, 1);
INSERT INTO terreno (x, y, id_tipo_terreno, id_andar) VALUES (2, 3, 2, 2);
INSERT INTO terreno (x, y, id_tipo_terreno, id_andar) VALUES (4, 5, 3, 3);
~~~

#### Inserindo dados na tabela 'efeito'
~~~sql
INSERT INTO efeito (nome, dano) VALUES ('Chamas', 50);
INSERT INTO efeito (nome, dano) VALUES ('Vento Cortante', 30);
INSERT INTO efeito (nome, dano) VALUES ('Trovão', 60);
~~~

#### Inserindo dados na tabela 'tipo_elemental'
~~~sql
INSERT INTO tipo_elemental (nome) VALUES ('Fogo');
INSERT INTO tipo_elemental (nome) VALUES ('Água');
INSERT INTO tipo_elemental (nome) VALUES ('Elétrico');
~~~

#### Inserindo dados na tabela 'habilidade'
~~~sql
INSERT INTO habilidade (nome, dano, acuracia, nome_efeito, tipo_elemental) VALUES ('Lança Chamas', 70, 90, 'Chamas', 'Fogo');
INSERT INTO habilidade (nome, dano, acuracia, nome_efeito, tipo_elemental) VALUES ('Hidro Bomba', 80, 85, 'Vento Cortante', 'Água');
INSERT INTO habilidade (nome, dano, acuracia, nome_efeito, tipo_elemental) VALUES ('Choque do Trovão', 60, 95, 'Trovão', 'Elétrico');
~~~

Inserindo dados na tabela 'interacao'
~~~sql
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor) VALUES (2, 'Fogo', 'Água');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor) VALUES (1, 'Água', 'Elétrico');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor) VALUES (3, 'Elétrico', 'Fogo');
~~~

Inserindo dados na tabela 'item'
~~~sql
INSERT INTO item (nome, descricao, efeito, valor) VALUES ('Poção', 'Recupera vida', 'Recupera 50 HP', 100);
INSERT INTO item (nome, descricao, efeito, valor) VALUES ('Elixir', 'Recupera PP', 'Recupera todos os PP', 200);
INSERT INTO item (nome, descricao, efeito, valor) VALUES ('Reviver', 'Revive Pokémon', 'Revive com metade da vida', 300);
~~~

### Inserindo dados na tabela 'instancia_item'
~~~sql
INSERT INTO instancia_item (id_item) VALUES (1);
INSERT INTO instancia_item (id_item) VALUES (2);
INSERT INTO instancia_item (id_item) VALUES (3);
~~~

#### Inserindo dados na tabela 'pokemon'
~~~sql
INSERT INTO pokemon (id_tipo_pokemon) VALUES (1); -- Player
INSERT INTO pokemon (id_tipo_pokemon) VALUES (1); -- Player
INSERT INTO pokemon (id_tipo_pokemon) VALUES (1); -- Player
INSERT INTO pokemon (id_tipo_pokemon) VALUES (2); -- NPC
INSERT INTO pokemon (id_tipo_pokemon) VALUES (2); -- NPC
INSERT INTO pokemon (id_tipo_pokemon) VALUES (2);
~~~

#### Inserindo dados na tabela 'correio'
~~~sql
INSERT INTO correio (jogador_id, terreno_id) VALUES (1, 1);
INSERT INTO correio (jogador_id, terreno_id) VALUES (2, 2);
INSERT INTO correio (jogador_id, terreno_id) VALUES (3, 3);
~~~

#### Inserindo dados na tabela 'jogador'
~~~sql
INSERT INTO jogador (id_jogador, nivel, vida, ataque_fisico, defesa_fisica, ataque_especial, velocidade, acuracia,
                     evasao, status, nome, id_correio, saldo, tam_inventario, posicao)
VALUES (1, 5, 100, 50, 40, 60, 70, 80, 90, 'Normal', 'Pikachu', 1, 1000, 4, 1);
INSERT INTO jogador (id_jogador, nivel, vida, ataque_fisico, defesa_fisica, ataque_especial, velocidade, acuracia,
                     evasao, status, nome, id_correio, saldo, tam_inventario, posicao)
VALUES (2, 10, 200, 60, 50, 70, 80, 90, 100, 'Normal', 'Charizard', 2, 2000, 3, 2);
INSERT INTO jogador (id_jogador, nivel, vida, ataque_fisico, defesa_fisica, ataque_especial, velocidade, acuracia,
                     evasao, status, nome, id_correio, saldo, tam_inventario, posicao)
VALUES (3, 15, 300, 70, 60, 80, 90, 100, 110, 'Normal', 'Blastoise', 3, 3000, 7, 3);
~~~

#### Inserindo dados na tabela 'inventario'
~~~sql
INSERT INTO inventario (id_inventario, id_instancia_item) VALUES (1, 1);
INSERT INTO inventario (id_inventario, id_instancia_item) VALUES (2, 2);
INSERT INTO inventario (id_inventario, id_instancia_item) VALUES (3, 3);
~~~

#### Inserindo dados na tabela 'npc'
~~~sql
INSERT INTO npc (id_npc, id_tipo_npc) VALUES (4, 1); -- Vendedor
INSERT INTO npc (id_npc, id_tipo_npc) VALUES (5, 2); -- Inimigo
INSERT INTO npc (id_npc, id_tipo_npc) VALUES (6, 2);
~~~

#### Atualizando o campo 'id_correio' na tabela 'jogador'
~~~sql
UPDATE jogador SET id_correio = 1 WHERE id_jogador = 1;
UPDATE jogador SET id_correio = 2 WHERE id_jogador = 2;
UPDATE jogador SET id_correio = 3 WHERE id_jogador = 3;
~~~

#### Inserindo dados na tabela 'loot'
~~~sql
INSERT INTO loot (id_terreno) VALUES (1);
INSERT INTO loot (id_terreno) VALUES (2);
INSERT INTO loot (id_terreno) VALUES (3);
~~~

#### Inserindo dados na tabela 'loot_item'
~~~sql
INSERT INTO loot_item (id_item, id_loot, quantidade) VALUES (1, 1, 5);
INSERT INTO loot_item (id_item, id_loot, quantidade) VALUES (2, 2, 3);
INSERT INTO loot_item (id_item, id_loot, quantidade) VALUES (3, 3, 1);
~~~

#### Inserindo dados na tabela 'missao'
~~~sql
INSERT INTO missao (nome_mapa, id_correio, id_loot, id_jogador, dificuldade, objetivo, tipo_missao)
VALUES ('Floresta Sombra', 1, 1, 1, 3, 'Resgatar Pokémon', true);
INSERT INTO missao (nome_mapa, id_correio, id_loot, id_jogador, dificuldade, objetivo, tipo_missao)
VALUES ('Caverna Cristal', 2, 2, 2, 5, 'Derrotar Chefão', false);
INSERT INTO missao (nome_mapa, id_correio, id_loot, id_jogador, dificuldade, objetivo, tipo_missao)
VALUES ('Montanha Fogo', 3, 3, 3, 7, 'Coletar Itens', true);
~~~
-- Inserindo dados na tabela 'pokemon_habilidade'
INSERT INTO pokemon_habilidade (id_pokemon, id_habilidade) VALUES (1, 1);
INSERT INTO pokemon_habilidade (id_pokemon, id_habilidade) VALUES (2, 2);
INSERT INTO pokemon_habilidade (id_pokemon, id_habilidade) VALUES (3, 3);

-- Inserindo dados na tabela 'terreno_loot'
~~~sql
INSERT INTO terreno_loot (id_terreno, id_loot) VALUES (1, 1);
INSERT INTO terreno_loot (id_terreno, id_loot) VALUES (2, 2);
INSERT INTO terreno_loot (id_terreno, id_loot) VALUES (3, 3);
~~~

-- Inserindo dados na tabela 'vendedor'
~~~sql
INSERT INTO vendedor (id_vendendor, nivel, vida, ataque_fisico, defesa_fisica, ataque_especial, velocidade, acuracia, evasao, status, nome, posicao, item_1, item_2, item_3)
VALUES (4, 5, 100, 50, 40, 60, 70, 80, 90, 'Disponível', 'Vendedor 1', 1, 1, 2, 3);
INSERT INTO inimigo (id_inimigo, nivel, vida, ataque_fisico, defesa_fisica, ataque_especial, velocidade, acuracia, evasao, status, nome, posicao)
VALUES (5, 10, 200, 60, 50, 70, 80, 90, 100, 'Disponível', 'Inimigo 1', 2);
INSERT INTO inimigo (id_inimigo, nivel, vida, ataque_fisico, defesa_fisica, ataque_especial, velocidade, acuracia, evasao, status, nome, posicao)
VALUES (6, 10, 200, 60, 50, 70, 80, 90, 100, 'Disponível', 'Inimigo 2', 2);
~~~