CREATE TABLE terreno_loot (
    id_terreno_loot SERIAL PRIMARY KEY,
    FOREIGN KEY (id_terreno) REFERENCES terreno(id_terreno),
    FOREIGN KEY (id_loot) REFERENCES loot(id_loot)
);