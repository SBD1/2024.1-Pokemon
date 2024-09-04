
-- Inserindo dados na tabela 'mapa'
INSERT INTO mapa (nome, quantidade_andares)
VALUES ('Cidade', 1);
INSERT INTO mapa (nome, quantidade_andares)
VALUES ('Floresta Sombra', 1);
INSERT INTO mapa (nome, quantidade_andares)
VALUES ('Caverna Cristal', 1);
INSERT INTO mapa (nome, quantidade_andares)
VALUES ('Montanha fire', 3);
 
-- Inserindo dados na tabela 'andar'
INSERT INTO andar (nome_mapa, numero_andar)
VALUES ('Floresta Sombra', 1);
INSERT INTO andar (nome_mapa, numero_andar)
VALUES ('Caverna Cristal', 1);
INSERT INTO andar (nome_mapa, numero_andar)
VALUES ('Montanha fire', 1);
INSERT INTO andar (nome_mapa, numero_andar)
VALUES ('Montanha fire', 2);
INSERT INTO andar (nome_mapa, numero_andar)
VALUES ('Montanha fire', 3);
INSERT INTO andar (nome_mapa, numero_andar)
VALUES ('Cidade', 1);

-- Inserindo dados na tabela 'tipo_terreno'
INSERT INTO tipo_terreno (descricao, movimento)
VALUES ('Chão', true);
INSERT INTO tipo_terreno (descricao, movimento)
VALUES ('Água', false);
INSERT INTO tipo_terreno (descricao, movimento)
VALUES ('Parede', false);
INSERT INTO tipo_terreno (descricao, movimento)
VALUES ('Árvore', false);
INSERT INTO tipo_terreno (descricao, movimento)
VALUES ('Escada', true);
INSERT INTO tipo_terreno (descricao, movimento)
VALUES ('Grama', true);

-- Inserindo dados na tabela 'terreno'
INSERT INTO terreno (x, y, id_tipo_terreno, id_andar)
VALUES (1, 1, 1, 1);
INSERT INTO terreno (x, y, id_tipo_terreno, id_andar)
VALUES (2, 3, 2, 2);
INSERT INTO terreno (x, y, id_tipo_terreno, id_andar)
VALUES (4, 5, 3, 3);

-- Inserindo dados na tabela 'efeito'
INSERT INTO efeito (nome, dano)
VALUES ('queimadura', 50);
INSERT INTO efeito (nome, dano)
VALUES ('confusão', 30);
INSERT INTO efeito (nome, dano)
VALUES ('paralisia', 60);

-- Inserindo dados na tabela 'tipo_elemental'
INSERT INTO tipo_elemental (nome)
VALUES
    ('fire'),
    ('water'),
    ('grass'),
    ('electric'),
    ('ground'),
    ('rock'),
    ('ice'),
    ('psychic'),
    ('dark'),
    ('fairy'),
    ('dragon'),
    ('ghost'),
    ('bug'),
    ('flying'),
    ('steel'),
    ('fighting'),
    ('poison'),
    ('normal');


-- Inserindo dados na tabela 'habilidade'
INSERT INTO habilidade (nome, dano, acuracia, nome_efeito, tipo_elemental)
VALUES ('Lança Chamas', 70, 90, 'queimadura', 'fire');
INSERT INTO habilidade (nome, dano, acuracia, nome_efeito, tipo_elemental)
VALUES ('Hidro Bomba', 80, 85, 'confusão', 'water');
INSERT INTO habilidade (nome, dano, acuracia, nome_efeito, tipo_elemental)
VALUES ('Choque do Trovão', 60, 95, 'paralisia', 'electric');

-- Inserindo dados na tabela 'interacao'
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'normal', 'rock');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'normal', 'steel');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.0, 'normal', 'ghost');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'fighting', 'normal');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'fighting', 'rock');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'fighting', 'steel');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'fighting', 'ice');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'fighting', 'dark');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'fighting', 'flying');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'fighting', 'poison');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'fighting', 'bug');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'fighting', 'psychic');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'fighting', 'fairy');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.0, 'fighting', 'ghost');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'flying', 'fighting');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'flying', 'bug');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'flying', 'grass');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'flying', 'rock');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'flying', 'steel');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'flying', 'electric');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'poison', 'grass');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'poison', 'fairy');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'poison', 'poison');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'poison', 'ground');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'poison', 'rock');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'poison', 'ghost');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.0, 'poison', 'steel');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'ground', 'poison');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'ground', 'rock');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'ground', 'steel');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'ground', 'fire');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'ground', 'electric');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'ground', 'bug');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'ground', 'grass');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.0, 'ground', 'flying');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'rock', 'flying');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'rock', 'bug');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'rock', 'fire');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'rock', 'ice');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'rock', 'fighting');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'rock', 'ground');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'rock', 'steel');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'bug', 'grass');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'bug', 'psychic');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'bug', 'dark');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'bug', 'fighting');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'bug', 'flying');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'bug', 'poison');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'bug', 'ghost');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'bug', 'steel');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'bug', 'fire');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'bug', 'fairy');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'ghost', 'ghost');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'ghost', 'psychic');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'ghost', 'dark');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.0, 'ghost', 'normal');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'steel', 'rock');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'steel', 'ice');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'steel', 'fairy');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'steel', 'steel');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'steel', 'fire');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'steel', 'water');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'steel', 'electric');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'fire', 'bug');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'fire', 'steel');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'fire', 'grass');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'fire', 'ice');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'fire', 'rock');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'fire', 'fire');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'fire', 'water');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'fire', 'dragon');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'water', 'ground');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'water', 'rock');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'water', 'fire');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'water', 'water');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'water', 'grass');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'water', 'dragon');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'grass', 'ground');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'grass', 'rock');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'grass', 'water');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'grass', 'flying');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'grass', 'poison');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'grass', 'bug');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'grass', 'steel');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'grass', 'fire');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'grass', 'grass');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'grass', 'dragon');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'electric', 'flying');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'electric', 'water');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'electric', 'grass');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'electric', 'electric');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'electric', 'dragon');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.0, 'electric', 'ground');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'psychic', 'fighting');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'psychic', 'poison');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'psychic', 'steel');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'psychic', 'psychic');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.0, 'psychic', 'dark');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'ice', 'flying');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'ice', 'ground');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'ice', 'grass');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'ice', 'dragon');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'ice', 'steel');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'ice', 'fire');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'ice', 'water');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'ice', 'ice');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'dragon', 'dragon');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'dragon', 'steel');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.0, 'dragon', 'fairy');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'dark', 'ghost');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'dark', 'psychic');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'dark', 'fighting');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'dark', 'dark');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'dark', 'fairy');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'fairy', 'fighting');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'fairy', 'dragon');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (2.0, 'fairy', 'dark');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'fairy', 'poison');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'fairy', 'steel');
INSERT INTO interacao (valor, tipo_atacante, tipo_defensor)
VALUES (0.5, 'fairy', 'fire');
            


-- Inserindo dados na tabela 'item'
INSERT INTO item (nome, descricao, efeito, valor)
VALUES ('Poção', 'Recupera vida', 'Recupera 50 HP', 100);
INSERT INTO item (nome, descricao, efeito, valor)
VALUES ('Elixir', 'Recupera PP', 'Recupera todos os PP', 200);
INSERT INTO item (nome, descricao, efeito, valor)
VALUES ('Reviver', 'Revive Pokémon', 'Revive com metade da vida', 300);

-- Inserindo dados na tabela 'instancia_item'
INSERT INTO instancia_item (id_item)
VALUES (1);
INSERT INTO instancia_item (id_item)
VALUES (2);
INSERT INTO instancia_item (id_item)
VALUES (3);

-- Inserindo dados na tabela 'pokemon'
INSERT INTO pokemon (id_tipo_pokemon)
VALUES (1); -- Player
INSERT INTO pokemon (id_tipo_pokemon)
VALUES (1); -- Player
INSERT INTO pokemon (id_tipo_pokemon)
VALUES (1); -- Player
INSERT INTO pokemon (id_tipo_pokemon)
VALUES (2); -- NPC
INSERT INTO pokemon (id_tipo_pokemon)
VALUES (2); -- NPC
INSERT INTO pokemon (id_tipo_pokemon)
VALUES (2);

-- Inserindo dados na tabela 'correio'
INSERT INTO correio (jogador_id, terreno_id)
VALUES (1, 1);
INSERT INTO correio (jogador_id, terreno_id)
VALUES (2, 2);
INSERT INTO correio (jogador_id, terreno_id)
VALUES (3, 3);

-- Inserindo dados na tabela 'jogador'
INSERT INTO jogador (id_jogador, nivel, vida, ataque_fisico, defesa_fisica, ataque_especial, velocidade, acuracia, evasao, status, nome, saldo, tam_inventario, posicao, tipo_elemental, id_correio)
VALUES (1, 5, 100, 50, 40, 60, 70, 80, 90, 'Normal', 'Pikachu', 1000, 4, 1, 'electric', 1);
INSERT INTO jogador (id_jogador, nivel, vida, ataque_fisico, defesa_fisica, ataque_especial, velocidade, acuracia, evasao, status, nome, saldo, tam_inventario, posicao, tipo_elemental, id_correio)
VALUES (2, 10, 200, 60, 50, 70, 80, 90, 100, 'Normal', 'Charizard', 2000, 3, 2, 'fire', 1);
INSERT INTO jogador (id_jogador, nivel, vida, ataque_fisico, defesa_fisica, ataque_especial, velocidade, acuracia, evasao, status, nome, saldo, tam_inventario, posicao, tipo_elemental, id_correio)
VALUES (3, 15, 300, 70, 60, 80, 90, 100, 110, 'Normal', 'Blastoise', 3000, 7, 3, 'water', 1);

-- Inserindo dados na tabela 'inventario'
INSERT INTO inventario (id_inventario, id_instancia_item)
VALUES (1, 1);
INSERT INTO inventario (id_inventario, id_instancia_item)
VALUES (2, 2);
INSERT INTO inventario (id_inventario, id_instancia_item)
VALUES (3, 3);

-- Inserindo dados na tabela 'instancia_item'
INSERT INTO instancia_item (id_item)
VALUES (1);
INSERT INTO instancia_item (id_item)
VALUES (2);
INSERT INTO instancia_item (id_item)
VALUES (3);

-- Inserindo dados na tabela 'npc'
INSERT INTO npc (id_npc, id_tipo_npc)
VALUES (4, 1); -- Vendedor
INSERT INTO npc (id_npc, id_tipo_npc)
VALUES (5, 2); -- Inimigo
INSERT INTO npc (id_npc, id_tipo_npc)
VALUES (6, 2);
-- Inimigo

-- Atualizando o campo 'id_correio' na tabela 'jogador'
UPDATE jogador
SET id_correio = 1
WHERE id_jogador = 1;
UPDATE jogador
SET id_correio = 2
WHERE id_jogador = 2;
UPDATE jogador
SET id_correio = 3
WHERE id_jogador = 3;

-- Inserindo dados na tabela 'loot'
INSERT INTO loot (id_terreno)
VALUES (1);
INSERT INTO loot (id_terreno)
VALUES (2);
INSERT INTO loot (id_terreno)
VALUES (3);

-- Inserindo dados na tabela 'loot_item'
INSERT INTO loot_item (id_item, id_loot, quantidade)
VALUES (1, 1, 5);
INSERT INTO loot_item (id_item, id_loot, quantidade)
VALUES (2, 2, 3);
INSERT INTO loot_item (id_item, id_loot, quantidade)
VALUES (3, 3, 1);

-- Inserindo dados na tabela 'missoes'
INSERT INTO missao (nome_mapa, id_correio, id_loot, id_jogador, dificuldade, objetivo, tipo_missao)
VALUES ('Floresta Sombra', 1, 1, 1, 3, 'Resgatar Pokémon', true);
INSERT INTO missao (nome_mapa, id_correio, id_loot, id_jogador, dificuldade, objetivo, tipo_missao)
VALUES ('Caverna Cristal', 2, 2, 2, 5, 'Derrotar Chefão', false);
INSERT INTO missao (nome_mapa, id_correio, id_loot, id_jogador, dificuldade, objetivo, tipo_missao)
VALUES ('Montanha fire', 3, 3, 3, 7, 'Coletar Itens', true);

-- Inserindo dados na tabela 'pokemon_habilidade'
INSERT INTO pokemon_habilidade (id_pokemon, id_habilidade)
VALUES (1, 1);
INSERT INTO pokemon_habilidade (id_pokemon, id_habilidade)
VALUES (2, 2);
INSERT INTO pokemon_habilidade (id_pokemon, id_habilidade)
VALUES (3, 3);

-- Inserindo dados na tabela 'terreno_loot'
INSERT INTO terreno_loot (id_terreno, id_loot)
VALUES (1, 1);
INSERT INTO terreno_loot (id_terreno, id_loot)
VALUES (2, 2);
INSERT INTO terreno_loot (id_terreno, id_loot)
VALUES (3, 3);

-- Inserindo dados na tabela 'vendedor'
INSERT INTO vendedor (id_vendedor, nivel, vida, ataque_fisico, defesa_fisica, ataque_especial, velocidade, acuracia, evasao, status, nome, posicao, item_1, item_2, item_3, tipo_elemental)
VALUES (4, 5, 100, 50, 40, 60, 70, 80, 90, 'Disponível', 'Vendedor 1', 1, 1, 2, 3, 'fire');
INSERT INTO inimigo (id_inimigo, nivel, vida, ataque_fisico, defesa_fisica, ataque_especial, velocidade, acuracia, evasao, status, nome, posicao, tipo_elemental)
VALUES (5, 10, 200, 60, 50, 70, 80, 90, 100, 'Disponível', 'Inimigo 1', 2, 'water');
INSERT INTO inimigo (id_inimigo, nivel, vida, ataque_fisico, defesa_fisica, ataque_especial, velocidade, acuracia, evasao, status, nome, posicao, tipo_elemental)
VALUES (6, 10, 200, 60, 50, 70, 80, 90, 100, 'Disponível', 'Inimigo 2', 2, 'electric');

-- Inserindo dados na tabela 'pokemon_base'
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('bulbasaur','grass',45,49,49,65,45,100,0,'normal','None','ivysaur');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('bulbasaur','grass',45,49,49,65,45,100,0,'normal','None','ivysaur');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('ivysaur','grass',60,62,63,80,60,100,0,'normal','bulbasaur','venusaur');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('venusaur','grass',80,82,83,100,80,100,0,'normal','ivysaur','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('charmander','fire',39,52,43,60,65,100,0,'normal','None','charmeleon');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('charmeleon','fire',58,64,58,80,80,100,0,'normal','charmander','charizard');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('charizard','fire',78,84,78,109,100,100,0,'normal','charmeleon','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('squirtle','water',44,48,65,50,43,100,0,'normal','None','wartortle');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('wartortle','water',59,63,80,65,58,100,0,'normal','squirtle','blastoise');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('blastoise','water',79,83,100,85,78,100,0,'normal','wartortle','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('caterpie','bug',45,30,35,20,45,100,0,'normal','None','metapod');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('metapod','bug',50,20,55,25,30,100,0,'normal','caterpie','butterfree');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('butterfree','bug',60,45,50,90,70,100,0,'normal','metapod','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('weedle','bug',40,35,30,20,50,100,0,'normal','None','kakuna');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('kakuna','bug',45,25,50,25,35,100,0,'normal','weedle','beedrill');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('beedrill','bug',65,90,40,45,75,100,0,'normal','kakuna','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('pidgey','normal',40,45,40,35,56,100,0,'normal','None','pidgeotto');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('pidgeotto','normal',63,60,55,50,71,100,0,'normal','pidgey','pidgeot');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('pidgeot','normal',83,80,75,70,101,100,0,'normal','pidgeotto','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('rattata','normal',30,56,35,25,72,100,0,'normal','None','raticate');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('raticate','normal',55,81,60,50,97,100,0,'normal','rattata','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('spearow','normal',40,60,30,31,70,100,0,'normal','None','fearow');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('fearow','normal',65,90,65,61,100,100,0,'normal','spearow','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('ekans','poison',35,60,44,40,55,100,0,'normal','None','arbok');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('arbok','poison',60,95,69,65,80,100,0,'normal','ekans','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('pikachu','electric',35,55,40,50,90,100,0,'normal','pichu','raichu');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('raichu','electric',60,90,55,90,110,100,0,'normal','pikachu','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('sandshrew','ground',50,75,85,20,40,100,0,'normal','None','sandslash');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('sandslash','ground',75,100,110,45,65,100,0,'normal','sandshrew','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('nidoran-f','poison',55,47,52,40,41,100,0,'normal','None','nidorina');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('nidorina','poison',70,62,67,55,56,100,0,'normal','nidoran-f','nidoqueen');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('nidoqueen','poison',90,92,87,75,76,100,0,'normal','nidorina','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('nidoran-m','poison',46,57,40,40,50,100,0,'normal','None','nidorino');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('nidorino','poison',61,72,57,55,65,100,0,'normal','nidoran-m','nidoking');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('nidoking','poison',81,102,77,85,85,100,0,'normal','nidorino','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('clefairy','fairy',70,45,48,60,35,100,0,'normal','cleffa','clefable');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('clefable','fairy',95,70,73,95,60,100,0,'normal','clefairy','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('vulpix','fire',38,41,40,50,65,100,0,'normal','None','ninetales');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('ninetales','fire',73,76,75,81,100,100,0,'normal','vulpix','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('jigglypuff','normal',115,45,20,45,20,100,0,'normal','igglybuff','wigglytuff');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('wigglytuff','normal',140,70,45,85,45,100,0,'normal','jigglypuff','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('zubat','poison',40,45,35,30,55,100,0,'normal','None','golbat');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('golbat','poison',75,80,70,65,90,100,0,'normal','zubat','crobat');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('oddish','grass',45,50,55,75,30,100,0,'normal','None','gloom');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('gloom','grass',60,65,70,85,40,100,0,'normal','oddish','vileplume');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('vileplume','grass',75,80,85,110,50,100,0,'normal','gloom','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('paras','bug',35,70,55,45,25,100,0,'normal','None','parasect');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('parasect','bug',60,95,80,60,30,100,0,'normal','paras','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('venonat','bug',60,55,50,40,45,100,0,'normal','None','venomoth');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('venomoth','bug',70,65,60,90,90,100,0,'normal','venonat','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('diglett','ground',10,55,25,35,95,100,0,'normal','None','dugtrio');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('dugtrio','ground',35,100,50,50,120,100,0,'normal','diglett','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('meowth','normal',40,45,35,40,90,100,0,'normal','None','persian');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('persian','normal',65,70,60,65,115,100,0,'normal','meowth','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('psyduck','water',50,52,48,65,55,100,0,'normal','None','golduck');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('golduck','water',80,82,78,95,85,100,0,'normal','psyduck','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('mankey','fighting',40,80,35,35,70,100,0,'normal','None','primeape');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('primeape','fighting',65,105,60,60,95,100,0,'normal','mankey','annihilape');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('growlithe','fire',55,70,45,70,60,100,0,'normal','None','arcanine');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('arcanine','fire',90,110,80,100,95,100,0,'normal','growlithe','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('poliwag','water',40,50,40,40,90,100,0,'normal','None','poliwhirl');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('poliwhirl','water',65,65,65,50,90,100,0,'normal','poliwag','poliwrath');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('poliwrath','water',90,95,95,70,70,100,0,'normal','poliwhirl','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('abra','psychic',25,20,15,105,90,100,0,'normal','None','kadabra');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('kadabra','psychic',40,35,30,120,105,100,0,'normal','abra','alakazam');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('alakazam','psychic',55,50,45,135,120,100,0,'normal','kadabra','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('machop','fighting',70,80,50,35,35,100,0,'normal','None','machoke');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('machoke','fighting',80,100,70,50,45,100,0,'normal','machop','machamp');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('machamp','fighting',90,130,80,65,55,100,0,'normal','machoke','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('bellsprout','grass',50,75,35,70,40,100,0,'normal','None','weepinbell');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('weepinbell','grass',65,90,50,85,55,100,0,'normal','bellsprout','victreebel');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('victreebel','grass',80,105,65,100,70,100,0,'normal','weepinbell','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('tentacool','water',40,40,35,50,70,100,0,'normal','None','tentacruel');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('tentacruel','water',80,70,65,80,100,100,0,'normal','tentacool','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('geodude','rock',40,80,100,30,20,100,0,'normal','None','graveler');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('graveler','rock',55,95,115,45,35,100,0,'normal','geodude','golem');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('golem','rock',80,120,130,55,45,100,0,'normal','graveler','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('ponyta','fire',50,85,55,65,90,100,0,'normal','None','rapidash');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('rapidash','fire',65,100,70,80,105,100,0,'normal','ponyta','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('slowpoke','water',90,65,65,40,15,100,0,'normal','None','slowbro');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('slowbro','water',95,75,110,100,30,100,0,'normal','slowpoke','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('magnemite','electric',25,35,70,95,45,100,0,'normal','None','magneton');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('magneton','electric',50,60,95,120,70,100,0,'normal','magnemite','magnezone');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('farfetchd','normal',52,90,55,58,60,100,0,'normal','None','sirfetchd');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('doduo','normal',35,85,45,35,75,100,0,'normal','None','dodrio');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('dodrio','normal',60,110,70,60,110,100,0,'normal','doduo','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('seel','water',65,45,55,45,45,100,0,'normal','None','dewgong');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('dewgong','water',90,70,80,70,70,100,0,'normal','seel','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('grimer','poison',80,80,50,40,25,100,0,'normal','None','muk');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('muk','poison',105,105,75,65,50,100,0,'normal','grimer','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('shellder','water',30,65,100,45,40,100,0,'normal','None','cloyster');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('cloyster','water',50,95,180,85,70,100,0,'normal','shellder','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('gastly','ghost',30,35,30,100,80,100,0,'normal','None','haunter');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('haunter','ghost',45,50,45,115,95,100,0,'normal','gastly','gengar');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('gengar','ghost',60,65,60,130,110,100,0,'normal','haunter','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('onix','rock',35,45,160,30,70,100,0,'normal','None','steelix');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('drowzee','psychic',60,48,45,43,42,100,0,'normal','None','hypno');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('hypno','psychic',85,73,70,73,67,100,0,'normal','drowzee','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('krabby','water',30,105,90,25,50,100,0,'normal','None','kingler');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('kingler','water',55,130,115,50,75,100,0,'normal','krabby','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('voltorb','electric',40,30,50,55,100,100,0,'normal','None','electrode');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('electrode','electric',60,50,70,80,150,100,0,'normal','voltorb','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('exeggcute','grass',60,40,80,60,40,100,0,'normal','None','exeggutor');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('exeggutor','grass',95,95,85,125,55,100,0,'normal','exeggcute','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('cubone','ground',50,50,95,40,35,100,0,'normal','None','marowak');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('marowak','ground',60,80,110,50,45,100,0,'normal','cubone','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('hitmonlee','fighting',50,120,53,35,87,100,0,'normal','tyrogue','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('hitmonchan','fighting',50,105,79,35,76,100,0,'normal','tyrogue','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('lickitung','normal',90,55,75,60,30,100,0,'normal','None','lickilicky');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('koffing','poison',40,65,95,60,35,100,0,'normal','None','weezing');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('weezing','poison',65,90,120,85,60,100,0,'normal','koffing','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('rhyhorn','ground',80,85,95,30,25,100,0,'normal','None','rhydon');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('rhydon','ground',105,130,120,45,40,100,0,'normal','rhyhorn','rhyperior');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('chansey','normal',250,5,5,35,50,100,0,'normal','happiny','blissey');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('tangela','grass',65,55,115,100,60,100,0,'normal','None','tangrowth');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('kangaskhan','normal',105,95,80,40,90,100,0,'normal','None','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('horsea','water',30,40,70,70,60,100,0,'normal','None','seadra');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('seadra','water',55,65,95,95,85,100,0,'normal','horsea','kingdra');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('goldeen','water',45,67,60,35,63,100,0,'normal','None','seaking');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('seaking','water',80,92,65,65,68,100,0,'normal','goldeen','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('staryu','water',30,45,55,70,85,100,0,'normal','None','starmie');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('starmie','water',60,75,85,100,115,100,0,'normal','staryu','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('mr-mime','psychic',40,45,65,100,90,100,0,'normal','mime-jr','mr-rime');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('scyther','bug',70,110,80,55,105,100,0,'normal','None','scizor');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('jynx','ice',65,50,35,115,95,100,0,'normal','smoochum','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('electabuzz','electric',65,83,57,95,105,100,0,'normal','elekid','electivire');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('magmar','fire',65,95,57,100,93,100,0,'normal','magby','magmortar');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('pinsir','bug',65,125,100,55,85,100,0,'normal','None','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('tauros','normal',75,100,95,40,110,100,0,'normal','None','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('magikarp','water',20,10,55,15,80,100,0,'normal','None','gyarados');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('gyarados','water',95,125,79,60,81,100,0,'normal','magikarp','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('lapras','water',130,85,80,85,60,100,0,'normal','None','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('ditto','normal',48,48,48,48,48,100,0,'normal','None','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('eevee','normal',55,55,50,45,55,100,0,'normal','None','vaporeon');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('vaporeon','water',130,65,60,110,65,100,0,'normal','eevee','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('jolteon','electric',65,65,60,110,130,100,0,'normal','eevee','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('flareon','fire',65,130,60,95,65,100,0,'normal','eevee','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('porygon','normal',65,60,70,85,40,100,0,'normal','None','porygon2');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('omanyte','rock',35,40,100,90,35,100,0,'normal','None','omastar');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('omastar','rock',70,60,125,115,55,100,0,'normal','omanyte','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('kabuto','rock',30,80,90,55,55,100,0,'normal','None','kabutops');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('kabutops','rock',60,115,105,65,80,100,0,'normal','kabuto','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('aerodactyl','rock',80,105,65,60,130,100,0,'normal','None','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('snorlax','normal',160,110,65,65,30,100,0,'normal','munchlax','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('articuno','ice',90,85,100,95,85,100,0,'normal','None','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('zapdos','electric',90,90,85,125,100,100,0,'normal','None','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('moltres','fire',90,100,90,125,90,100,0,'normal','None','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('dratini','dragon',41,64,45,50,50,100,0,'normal','None','dragonair');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('dragonair','dragon',61,84,65,70,70,100,0,'normal','dratini','dragonite');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('dragonite','dragon',91,134,95,100,80,100,0,'normal','dragonair','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('mewtwo','psychic',106,110,90,154,130,100,0,'normal','None','None');
INSERT INTO pokemon_base (nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base, velocidade_base, acuracia_base, evasao_base, status_base, evolui_de, evolui_para)
VALUES ('mew','psychic',100,100,100,100,100,100,0,'normal','None','None');

