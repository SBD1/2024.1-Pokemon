CREATE TABLE loot_item (
    FOREIGN KEY (id_item) REFERENCES loot(id_item),
    FOREIGN KEY (id_loot) REFERENCES loot(id_loot),
    quantidade INT
);