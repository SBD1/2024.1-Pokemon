CREATE TABLE interacao (
    id SERIAL PRIMARY KEY,
    valor INT NOT NULL,
    FOREIGN KEY (id_tipo_atacante) REFERENCES id_tipo_atacante(id),
    FOREIGN KEY (id_tipo_defensor) REFERENCES id_tipo_defensor(id)
);