CREATE TABLE interacao (
    id SERIAL PRIMARY KEY,
    valor INT NOT NULL,
    id_tipo_atacante INT,    -- Adicione a coluna id_tipo_atacante
    id_tipo_defensor INT,    -- Adicione a coluna id_tipo_defensor
    FOREIGN KEY (id_tipo_atacante) REFERENCES tipo_elemental(nome),  -- Ajuste a tabela e coluna referenciadas
    FOREIGN KEY (id_tipo_defensor) REFERENCES tipo_elemental(nome)   -- Ajuste a tabela e coluna referenciadas
);
