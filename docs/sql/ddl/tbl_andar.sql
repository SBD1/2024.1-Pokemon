CREATE TABLE andar (
    id_andar SERIAL PRIMARY KEY,
    FOREIGN KEY (nome_mapa) REFERENCES mapa (nome)
);