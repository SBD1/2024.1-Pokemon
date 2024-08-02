CREATE TABLE pokemon_habilidade (
    id_pokemon_habilidade SERIAL PRIMARY KEY,
    FOREIGN KEY (id_pokemon) REFERENCES pokemon(id_pokemon),
    FOREIGN KEY (id_habilidade) REFERENCES terreno(id_habilidade)
);