CREATE TABLE terreno (
    id SERIAL PRIMARY KEY,
    x INT NOT NULL,
    y INT NOT NULL,
    FOREIGN KEY (id_tipo_terreno) REFERENCES tipo_terreno(id),
    FOREIGN KEY (id_andar) REFERENCES andar(id)
);