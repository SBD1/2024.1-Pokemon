CREATE TABLE pokemon (
    id_pokemon SERIAL PRIMARY KEY,
    FOREIGN KEY (tipo_elemental) REFERENCES tipo_elemental(nome)
);