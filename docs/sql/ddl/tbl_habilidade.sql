CREATE TABLE habilidade (
    id_habilidade SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    dano INT NOT NULL,
    acuracia INT NOT NULL,
    tipo_elemental VARCHAR(255) NOT NULL,
    efeito VARCHAR(255) NOT NULL,
    FOREIGN KEY (efeito) REFERENCES efeito(nome)
    FOREIGN KEY (tipo_elemental) REFERENCES tipo_elemental(nome)
);