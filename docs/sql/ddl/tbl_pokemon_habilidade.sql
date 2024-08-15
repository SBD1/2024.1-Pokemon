CREATE TABLE pokemon_habilidade (
    id_pokemon_habilidade SERIAL PRIMARY KEY,
    id_pokemon INT,
    id_habilidade INT,
    FOREIGN KEY (id_pokemon) REFERENCES pokemon(id_pokemon),
    FOREIGN KEY (id_habilidade) REFERENCES habilidade(id_habilidade)
);
