CREATE TABLE inventario (
    id_inventario SERIAL PRIMARY KEY,  -- Defina a coluna id_inventario como chave primária
    id_item INT,
    quantidade INT,
    FOREIGN KEY (id_item) REFERENCES item(id_item)
);
