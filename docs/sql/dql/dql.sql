--Consulta de missões no correio

SELECT m.id_missao,
       m.objetivo,
       m.dificuldade,
       m.tipo_missao,
       ma.nome AS mapa_nome,
       c.id AS correio_id
FROM missao m
JOIN mapa ma ON m.nome_mapa = ma.nome
JOIN correio c ON m.id_correio = c.id
WHERE m.concluida = false;


--Consulta que associa o item ao vendedor com valor e quantidade

SELECT
    v.id_vendendor,
    v.nome AS vendedor_nome,
    i1.nome AS item_1_nome,
    i1.valor AS item_1_valor,
    i1.quantidade AS item_1_quantidade,
    i2.nome AS item_2_nome,
    i2.valor AS item_2_valor,
    i2.quantidade AS item_2_quantidade,
    i3.nome AS item_3_nome,
    i3.valor AS item_3_valor,
    i3.quantidade AS item_3_quantidade
FROM
    vendedor v
LEFT JOIN
    item i1 ON v.item_1 = i1.id_item
LEFT JOIN
    item i2 ON v.item_2 = i2.id_item
LEFT JOIN
    item i3 ON v.item_3 = i3.id_item;


--Consulta que associa o item ao vendedor
SELECT
    v.id_vendendor,
    v.nome AS vendedor_nome,
    i1.nome AS item_1_nome,
    i2.nome AS item_2_nome,
    i3.nome AS item_3_nome
FROM
    vendedor v
LEFT JOIN
    item i1 ON v.item_1 = i1.id_item
LEFT JOIN
    item i2 ON v.item_2 = i2.id_item
LEFT JOIN
    item i3 ON v.item_3 = i3.id_item;


--  Consulta para ver os itens do jogador
SELECT
    i.id_jogador,
    ii.id_item,
    it.nome AS nome_item,
    it.descricao AS descricao_item,
    it.efeito AS efeito_item,
    it.valor AS valor_item
FROM
    inventario i
JOIN
    instancia_item ii ON i.id_instancia_item = ii.id_instancia_item
JOIN
    item it ON ii.id_item = it.id_item
WHERE
    i.id_jogador = id_jogador;  


-- Consulta para recuperar a posição do pokemon
SELECT
    j.id_jogador,
    t.x,
    t.y,
    a.nome AS nome_andar,
    m.nome AS nome_mapa
FROM
    jogador j
JOIN
    terreno t ON j.id_posicao = t.id_terreno
JOIN
    andar a ON t.id_andar = a.id_andar
JOIN
    mapa m ON a.nome_mapa = m.nome
WHERE
    j.id_jogador = id_jogador;  -- Usando como exemplo o jogador

-- Consulta para obter status-base do pokemon

SELECT
    nivel,
    vida,
    ataque_fisico,
    defesa_fisica,
    ataque_especial,
    velocidade,
    acuracia,
    evasao,
    status,
    saldo
FROM
    jogador
WHERE
    id_jogador = id_jogador;  -- Usando como exemplo jogador


-- Atualização de status-base do pokemon
UPDATE jogador
SET
    nivel = ?,
    vida = ?,
    ataque_fisico = ?,
    defesa_fisica = ?,
    ataque_especial = ?,
    velocidade = ?,
    acuracia = ?,
    evasao = ?,
    status = ?,
    saldo = ?
WHERE
    id_jogador = id_jogador;  -- Usando como exemplo jogador

-- Script para a compra de um item
SELECT saldo FROM jogador WHERE id_jogador = id_jogador;  


INSERT INTO instancia_item (id_item) VALUES (?);
INSERT INTO inventario (id_inventario, id_instancia_item) VALUES (id_jogador, (SELECT currval(pg_get_serial_sequence('instancia_item', 'id_instancia_item')))); 

UPDATE jogador
SET saldo = saldo - (SELECT valor FROM item WHERE id_item = id_item_valor)
WHERE id_jogador = id_jogador;  


-- Script para a venda de um item
SELECT COUNT(*) FROM inventario WHERE id_jogador = id_do_jogador AND id_instancia_item = id_da_instancia_item;  

DELETE FROM inventario WHERE id_jogador = id_do_jogador AND id_instancia_item = id_da_instancia_item;  

UPDATE jogador
SET saldo = saldo + (SELECT valor FROM item WHERE id_item = (SELECT id_item FROM instancia_item WHERE id_instancia_item = id_da_instancia_item))
WHERE id_jogador = id_do_jogador;

-- Atualização da posição do jogador
UPDATE jogador
SET posicao = id_terreno 
WHERE id_jogador = id_do_jogador;  
