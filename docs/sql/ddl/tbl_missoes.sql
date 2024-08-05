CREATE TABLE missoes (
    id_missao SERIAL PRIMARY KEY,
    FOREIGN KEY (id_mapa) REFERENCES mapa(id_mapa),
    FOREIGN KEY (id_npc) REFERENCES npc(id_npc),
    FOREIGN KEY (id_loot) REFERENCES loot(id_loot),
    dificuldade INT NOT NULL,
    objetivo VARCHAR(255) NOT NULL,
    tipo_missao int NOT NULL
);