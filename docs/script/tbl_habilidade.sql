CREATE TABLE habilidade (
    id_habilidade SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    dano INT NOT NULL,
    acuracia INT NOT NULL,
    FOREIGN KEY (nome_tipo) REFERENCES nome_tipo(nome)
);