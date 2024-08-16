CREATE TABLE correio
(
    id SERIAL PRIMARY KEY,
    jogador_id INT,
    terreno_id INT,
    FOREIGN KEY (jogador_id) REFERENCES jogador (id_jogador),
    FOREIGN KEY (terreno_id) REFERENCES terreno (id_terreno)
);