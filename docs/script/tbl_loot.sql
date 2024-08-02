CREATE TABLE  loot(
    id_loot SERIAL PRIMARY KEY,
    FOREIGN KEY (id_terreno) REFERENCES terreno(id_terreno)
);