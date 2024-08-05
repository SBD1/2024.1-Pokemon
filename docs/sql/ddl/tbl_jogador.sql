CREATE TABLE jogador (
    id_jogador SERIAL PRIMARY KEY,
    nivel int NOT NULL,
    vida int NOT NULL,
    ataque_fisico int NOT NULL,
    defesa_fisica int NOT NULL,
    ataque_especial int NOT NULL,
    velocidade int NOT NULL,
    acuracia int NOT NULL,
    evasao int NOT NULL,
    status varchar(255) NOT NULL,
    nome varchar(255) NOT NULL,
    FOREIGN KEY (id_pokemon) REFERENCES pokemon(id_pokemon),
    FOREIGN KEY (id_inventario) REFERENCES inventario(id_inventario) --Adicionando campo id_inventario na tabela inventario
);

