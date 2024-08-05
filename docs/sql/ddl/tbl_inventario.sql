CREATE TABLE item (
    id_inventario SERIAL PRIMARY KEY,
    FOREIGN KEY (id_item) REFERENCES item(id_item),
    quantidade INT
); -- Removendo chave para jogador, o id do inventario agora está na tabela do jogador