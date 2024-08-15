CREATE TABLE jogador (
    id_jogador SERIAL PRIMARY KEY,
    nivel INT NOT NULL,
    vida INT NOT NULL,
    ataque_fisico INT NOT NULL,
    defesa_fisica INT NOT NULL,
    ataque_especial INT NOT NULL,
    velocidade INT NOT NULL,
    acuracia INT NOT NULL,
    evasao INT NOT NULL,
    status VARCHAR(255) NOT NULL,
    nome VARCHAR(255) NOT NULL,
    id_pokemon INT,
    id_inventario INT,    
    FOREIGN KEY (id_pokemon) REFERENCES pokemon(id_pokemon),
    FOREIGN KEY (id_inventario) REFERENCES inventario(id_inventario)
);
