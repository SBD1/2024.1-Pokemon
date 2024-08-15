CREATE TABLE andar (
    id SERIAL PRIMARY KEY,
    nome_mapa VARCHAR(255), 
    FOREIGN KEY (nome_mapa) REFERENCES mapa (nome) 
);
