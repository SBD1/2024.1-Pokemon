    CREATE TABLE tipo_terreno (
        id_tipo_terreno SERIAL PRIMARY KEY,
        descricao VARCHAR(50) NOT NULL,
        movimento BOOLEAN NOT NULL
    );