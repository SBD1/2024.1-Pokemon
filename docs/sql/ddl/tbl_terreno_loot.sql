CREATE TABLE terreno_loot (
    id_terreno_loot SERIAL PRIMARY KEY,
    id_terreno INT,
    id_loot INT,
    FOREIGN KEY (id_terreno) REFERENCES terreno(id_terreno),
    FOREIGN KEY (id_loot) REFERENCES loot(id_loot)
);
