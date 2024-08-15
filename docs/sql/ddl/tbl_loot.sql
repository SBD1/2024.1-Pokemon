CREATE TABLE loot (
    id_loot SERIAL PRIMARY KEY,
    id_terreno INT,  -- Adicione a coluna id_terreno
    FOREIGN KEY (id_terreno) REFERENCES terreno(id_terreno)
);
