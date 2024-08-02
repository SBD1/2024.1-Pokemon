CREATE TABLE andar (
    id SERIAL PRIMARY KEY,
    FOREIGN KEY (nome_mapa) REFERENCES mapa (nome)
);