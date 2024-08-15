CREATE TABLE terreno (
    id_terreno SERIAL PRIMARY KEY,
    x INT NOT NULL,
    y INT NOT NULL,
    id_tipo_terreno INT,  
    id_andar INT,         
    FOREIGN KEY (id_tipo_terreno) REFERENCES tipo_terreno(id),
    FOREIGN KEY (id_andar) REFERENCES andar(id)
);
