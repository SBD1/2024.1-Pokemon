CREATE TABLE dialogo (
    id SERIAL PRIMARY KEY,
    personagem VARCHAR(50) NOT NULL,
    fala TEXT NOT NULL,
    contexto VARCHAR(100),
    ordem INTEGER
);
