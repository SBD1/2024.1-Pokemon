# <b>Data Query Language</b>
A Data Query Language (DQL), ou Linguagem de Consulta de Dados, é um subconjunto de SQL (Structured Query Language) utilizado para recuperar dados de um banco de dados. Ao contrário da Linguagem de Manipulação de Dados (DML), que envolve a modificação de dados (como INSERT, UPDATE, DELETE), a DQL é focada em consultar os dados, normalmente através da instrução SELECT.

#### Consulta de missões no correio
~~~sql
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

~~~


#### Consulta que associa o item ao vendedor com valor

~~~sql
SELECT
    v.id_vendendor,
    v.nome AS vendedor_nome,
    i1.nome AS item_1_nome,
    i1.valor AS item_1_valor,
    i2.nome AS item_2_nome,
    i2.valor AS item_2_valor,
    i3.nome AS item_3_nome,
    i3.valor AS item_3_valor,
FROM
    vendedor v
LEFT JOIN
    item i1 ON v.item_1 = i1.id_item
LEFT JOIN
    item i2 ON v.item_2 = i2.id_item
LEFT JOIN
    item i3 ON v.item_3 = i3.id_item;

~~~

#### Consulta que associa o item ao vendedor

~~~sql
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


~~~




#### Consulta para ver os itens do jogador
~~~sql
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
~~~



#### Consulta para recuperar a posição do pokemon
~~~sql
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
    j.id_jogador = id_jogador;
~~~

#### Consulta para obter status-base do pokemon
~~~sql
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
    id_jogador = id_jogador; 
~~~

#### Atualização de status-base do pokemon

~~~sql
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
    id_jogador = id_jogador;
~~~

#### Script para a compra de um item
~~~sql
SELECT saldo FROM jogador WHERE id_jogador = id_jogador;  


INSERT INTO instancia_item (id_item) VALUES (?);
INSERT INTO inventario (id_inventario, id_instancia_item) VALUES (id_jogador, (SELECT currval(pg_get_serial_sequence('instancia_item', 'id_instancia_item')))); 

UPDATE jogador
SET saldo = saldo - (SELECT valor FROM item WHERE id_item = id_item_valor)
WHERE id_jogador = id_jogador;  
~~~


#### Script para a venda de um item
~~~sql
SELECT COUNT(*) FROM inventario WHERE id_jogador = id_do_jogador AND id_instancia_item = id_da_instancia_item;  

DELETE FROM inventario WHERE id_jogador = id_do_jogador AND id_instancia_item = id_da_instancia_item;  

UPDATE jogador
SET saldo = saldo + (SELECT valor FROM item WHERE id_item = (SELECT id_item FROM instancia_item WHERE id_instancia_item = id_da_instancia_item))
WHERE id_jogador = id_do_jogador;
~~~

#### Atualização da posição do jogador
~~~sql
UPDATE jogador
SET posicao = id_terreno 
WHERE id_jogador = id_do_jogador;  
~~~

#### Renderizar mapa pelo jogador
~~~sql
WITH jogador_posicao AS (
    SELECT posicao
    FROM jogador
    WHERE id_jogador = %s
),
andar_atual AS (
    SELECT t.id_andar
    FROM terreno t
    JOIN jogador_posicao jp ON t.id_terreno = jp.posicao
),
terrenos_no_andar AS (
    SELECT t.id_terreno, t.x, t.y, tt.descricao
    FROM terreno t
    JOIN tipo_terreno tt ON t.id_tipo_terreno = tt.id_tipo_terreno
    JOIN andar_atual aa ON t.id_andar = aa.id_andar
)
SELECT * FROM terrenos_no_andar;
~~~


#### Visualizar habilidades

~~~sql
SELECT 
    j.nome AS nome_jogador,
    h.nome AS nome_habilidade,
    h.dano,
    h.acuracia,
    h.nome_efeito,
    h.tipo_elemental
FROM 
    jogador j
JOIN 
    pokemon_habilidade ph ON j.id_jogador = ph.id_pokemon
JOIN 
    habilidade h ON ph.id_habilidade = h.id_habilidade
WHERE 
    j.id_jogador = 1;
~~~



#### Consulta para selecionar os status do pokemon do jogador

~~~sql
SELECT nome, tipo, vida_base, ataque_fisico_base, defesa_fisica_base, ataque_especial_base,
        velocidade_base, acuracia_base, evasao_base, status_base
FROM pokemon_base WHERE id_pokemon = %s;
~~~




#### Consulta para selecionar o pokemon inicial

~~~sql
SELECT id_pokemon, nome, tipo FROM pokemon_base WHERE evolui_de = 'None' AND evolui_para <> 'None';
~~~


#### Consulta para ver se já existem jogadores


~~~sql
SELECT COUNT(*) FROM jogador;
~~~



#### Consulta para encontrar o id_terreno pelas coordenadas
~~~sql
    SELECT id_terreno
    FROM terreno
    WHERE x = %s AND y = %s;
~~~

#### Consulta para encontrar fala do narrador

~~~sql
SELECT fala FROM dialogo WHERE personagem = 'Narrador' ORDER BY ordem
~~~


#### Consulta para obter o próximo andar

~~~sql
SELECT MAX(t.id_andar) FROM terreno t
~~~





## Histórico de Versão

| Versão |    Data    |      Descrição      |                                                                                                Autor(es)                                                                                                 |
| :----: | :--------: | :-----------------: | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: |
| `1.0`  | 19/08/2024 | Criação das consultas | [Gabriel Marcolino](https://github.com/GabrielMR360), [Shaíne Oliveira](ttps://github.com/ShaineOliveira), [José Filipi](https://github.com/JoseFilipi) e [Leonardo Bonetti](https://github.com/LeoFacB) |
| `1.1`  | 09/09/2024 | Adiciona novas consultas | [Gabriel Marcolino](https://github.com/GabrielMR360) e [Shaíne Oliveira](ttps://github.com/ShaineOliveira) |
