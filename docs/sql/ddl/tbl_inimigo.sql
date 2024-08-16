CREATE TABLE vendedor (
    id_npc INT,
    id_inimigo SERIAL PRIMARY KEY,
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
    posicao INT, 
    FOREIGN KEY (id_pokemon) REFERENCES pokemon(id_pokemon),
    FOREIGN KEY (posicao) REFERENCES terreno(id_terreno),
    FOREIGN KEY (id_vendedor) REFERENCES npc(id_npc)
);
