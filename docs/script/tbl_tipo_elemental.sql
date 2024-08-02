CREATE TABLE tipo_elemental (
    nome SERIAL PRIMARY KEY,
    FOREIGN KEY (id_interacao) REFERENCES interacao(id_interacao)
);