CREATE TABLE loot_item (
    id_loot_item SERIAL PRIMARY KEY,  -- Adiciona uma chave primária
    id_item INT,                      -- Adiciona a coluna id_item
    id_loot INT,                      -- Adiciona a coluna id_loot
    quantidade INT,
    FOREIGN KEY (id_item) REFERENCES item(id_item),
    FOREIGN KEY (id_loot) REFERENCES loot(id_loot)
);
