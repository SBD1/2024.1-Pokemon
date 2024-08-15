CREATE TABLE missoes (
    id_missao SERIAL PRIMARY KEY,
    id_mapa VARCHAR,       -- Adicione a coluna id_mapa
    id_npc INT,        -- Adicione a coluna id_npc
    id_loot INT,       -- Adicione a coluna id_loot
    dificuldade INT NOT NULL,
    objetivo VARCHAR(255) NOT NULL,
    tipo_missao INT NOT NULL,
    FOREIGN KEY (id_mapa) REFERENCES mapa(nome),
    FOREIGN KEY (id_npc) REFERENCES npc(id_npc),
    FOREIGN KEY (id_loot) REFERENCES loot(id_loot)
);
