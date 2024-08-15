CREATE TABLE andar (
    id_andar SERIAL PRIMARY KEY,
    nome_mapa VARCHAR(255) NOT NULL,
    terreno_spawn INT NOT NULL,
    FOREIGN KEY (nome_mapa) REFERENCES mapa (nome),
    FOREIGN KEY (terreno_spawn) REFERENCES terreno (id_terreno)
);