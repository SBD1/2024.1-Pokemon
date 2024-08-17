--Consulta de missões no correio

SELECT m.id_missao,
       m.objetivo,
       m.dificuldade,
       m.tipo_missao,
       ma.nome AS mapa_nome,
       c.id AS correio_id
FROM missao m
JOIN mapa ma ON m.id_mapa = ma.nome
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