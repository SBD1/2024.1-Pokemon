CREATE TABLE andar (
    id_andar SERIAL PRIMARY KEY,
    nome_mapa VARCHAR(255) NOT NULL,
    num_andar INT NOT NULL,
    CONSTRAINT unique_mapa_andar UNIQUE (nome_mapa, num_andar),
    CONSTRAINT andar_nome_mapa_fkey FOREIGN KEY (nome_mapa)
        REFERENCES mapa (nome)
);
