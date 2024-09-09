-- Validar a alteração do tamanho do inventário
CREATE FUNCTION before_update_tam_inventario() RETURNS TRIGGER AS
$$
BEGIN
    IF NEW.tam_inventario != OLD.tam_inventario THEN
        RAISE EXCEPTION 'A coluna tam_inventario não pode ser alterada diretamente.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS before_update_tam_inventario ON jogador;
CREATE TRIGGER before_update_tam_inventario
    BEFORE UPDATE
    ON jogador
    FOR EACH ROW
EXECUTE FUNCTION before_update_tam_inventario();

-- Trigger para verificar se o inventário do jogador está cheio antes de adicionar um novo item
CREATE OR REPLACE FUNCTION verificar_tam_inventario() RETURNS TRIGGER AS
$$
DECLARE
    qtd_itens      INT;
    tamanho_inventario INT;
BEGIN
    SELECT count(*)
    INTO qtd_itens
    FROM inventario i
             JOIN jogador j on i.id_inventario = j.id_jogador
             JOIN instancia_item ii on i.id_instancia_item = ii.id_instancia_item
    WHERE j.id_jogador = NEW.id_inventario;

    SELECT tam_inventario INTO tamanho_inventario FROM jogador WHERE id_jogador = NEW.id_inventario;

    IF qtd_itens < tamanho_inventario THEN
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'Inventário cheio! Não é possível adicionar mais itens.';
    END IF;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS before_insert_instancia_item ON inventario;
CREATE TRIGGER before_insert_instancia_item
    BEFORE INSERT
    ON inventario
    FOR EACH ROW
EXECUTE FUNCTION verificar_tam_inventario();

--Move o jogador para a cidade quando a vida dele for igual a zero
CREATE OR REPLACE FUNCTION verifica_vida_jogador()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.vida <= 0 THEN
        NEW.posicao := 6;
		RAISE NOTICE 'Jogador % retornou para a cidade.', NEW.id_jogador;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE TRIGGER trigger_verifica_vida_jogador
BEFORE UPDATE OF vida ON jogador
FOR EACH ROW
WHEN (NEW.vida <= 0)
EXECUTE FUNCTION verifica_vida_jogador();


--Garante a integridade da total exclusiva


CREATE OR REPLACE FUNCTION check_npc() RETURNS trigger
AS 
$$
BEGIN
   PERFORM * FROM npc WHERE id_npc = NEW.id_jogador;
   IF FOUND THEN
		RAISE EXCEPTION 'Este pokemon já é um npc';
   END IF;
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_check_npc
BEFORE UPDATE OR INSERT ON jogador
FOR EACH ROW EXECUTE PROCEDURE check_npc();


CREATE OR REPLACE FUNCTION check_jogador() RETURNS trigger
AS
$$
BEGIN
   PERFORM * FROM jogador WHERE id_jogador = NEW.id_npc;
   IF FOUND THEN
		RAISE EXCEPTION 'Este pokemon já é um jogador';
   END IF;
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_check_jogador
BEFORE UPDATE OR INSERT ON npc
FOR EACH ROW EXECUTE PROCEDURE check_jogador();


-- Trigger para verificar apos o movimento se o jogador está envenenado e se ele se moveu e diminuir a vida
CREATE OR REPLACE FUNCTION verifica_movimento_veneno()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.status = 'Envenenado' THEN
        IF (NEW.posicao <> OLD.posicao) THEN
            UPDATE jogador j SET vida = vida-1 WHERE j.id_jogador = NEW.id_jogador;
            RAISE NOTICE 'Jogador % perdeu 1 de vida por estar envenenado.', NEW.id_jogador;
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trigger_verifica_movimento_veneno
AFTER UPDATE OF posicao ON jogador
FOR EACH ROW
EXECUTE FUNCTION verifica_movimento_veneno();

--Trigger para verificar antes de usar um golpe se a habilidade tem PP suficiente
CREATE OR REPLACE FUNCTION verifica_pp_habilidade()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.pp_restante < 0 THEN
        RAISE EXCEPTION 'Habilidade sem PP suficiente para ser usada.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trigger_verifica_pp_habilidade
BEFORE UPDATE OF pp_restante ON pokemon_habilidade
FOR EACH ROW
EXECUTE FUNCTION verifica_pp_habilidade();

--Trigger para verificar se o pp_restante ultrapassou que o pp máximo da habilidade
CREATE OR REPLACE FUNCTION verifica_pp_habilidade_maximo() RETURNS TRIGGER AS
$$
DECLARE
    pp_maximo INT;
BEGIN
    SELECT pp
    INTO pp_maximo 
    FROM pokemon_habilidade ph
    JOIN habilidade h ON h.id_habilidade = ph.id_habilidade 
    WHERE ph.id_habilidade = NEW.id_habilidade;
    IF NEW.pp_restante > pp_maximo THEN
        RAISE EXCEPTION 'Não é possível adicionar mais PP do que o máximo.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trigger_verifica_pp_habilidade_maximo
BEFORE UPDATE OF pp_restante ON pokemon_habilidade
FOR EACH ROW
EXECUTE FUNCTION verifica_pp_habilidade_maximo();

-- Trigger para gerar os inimigos da missao
CREATE OR REPLACE FUNCTION gerar_inimigos_missao() RETURNS TRIGGER AS
$$
DECLARE
    nome_mapa_missao  TEXT;
    id_pokemon_gerado INT;
    id_npc_gerado     INT;
BEGIN
    SELECT nome_mapa
    INTO nome_mapa_missao
    FROM instancia_missao im
             JOIN missao m ON im.id_missao = m.id_missao
    WHERE im.id_missao = NEW.id_missao
    GROUP BY nome_mapa;

    IF nome_mapa_missao = 'Floresta Sombra' THEN
        FOR i IN 1..5
            LOOP
                INSERT INTO pokemon (id_tipo_pokemon) VALUES (2) RETURNING id_pokemon INTO id_pokemon_gerado;
                -- Inserindo um novo NPC com tipo 2 (inimigo)
                INSERT INTO npc (id_npc, id_tipo_npc) VALUES (id_pokemon_gerado, 2) RETURNING id_npc INTO id_npc_gerado;

                -- Inserindo o inimigo associado ao NPC recém-criado
                INSERT INTO inimigo (id_inimigo, nivel, vida, ataque_fisico, defesa_fisica, ataque_especial, velocidade,
                                     acuracia, evasao, status, nome, posicao, tipo_elemental)
                VALUES (id_npc_gerado, 10, 100, 20, 15, 30, 10, 80, 50, 'Normal', 'Inimigo ' || i, 1,
                        CASE WHEN i % 3 = 0 THEN 'dark' WHEN i % 3 = 1 THEN 'ghost' ELSE 'psychic' END);

                INSERT INTO pokemon_habilidade (id_pokemon, id_habilidade) VALUES (id_pokemon_gerado, 4);
                INSERT INTO pokemon_habilidade (id_pokemon, id_habilidade) VALUES (id_pokemon_gerado, 101);
            END LOOP;

        -- Inserindo o BOSS para o mapa Floresta Sombra
        INSERT INTO pokemon (id_tipo_pokemon) VALUES (2) RETURNING id_pokemon INTO id_pokemon_gerado;
        INSERT INTO npc (id_npc, id_tipo_npc) VALUES (id_pokemon_gerado, 2) RETURNING id_npc INTO id_npc_gerado;
        INSERT INTO inimigo (id_inimigo, nivel, vida, ataque_fisico, defesa_fisica, ataque_especial, velocidade,
                             acuracia, evasao, status, nome, posicao, tipo_elemental)
        VALUES (id_npc_gerado, 10, 1000, 50, 50, 80, 30, 80, 50, 'Normal', 'BOSS', 1, 'dark');

        INSERT INTO pokemon_habilidade (id_pokemon, id_habilidade) VALUES (id_pokemon_gerado, 4);
        INSERT INTO pokemon_habilidade (id_pokemon, id_habilidade) VALUES (id_pokemon_gerado, 101);
        INSERT INTO pokemon_habilidade (id_pokemon, id_habilidade) VALUES (id_pokemon_gerado, 63);
        INSERT INTO pokemon_habilidade (id_pokemon, id_habilidade) VALUES (id_pokemon_gerado, 47);

    ELSIF nome_mapa_missao = 'Montanha fire' THEN
        FOR i IN 1..5
            LOOP
                INSERT INTO pokemon (id_tipo_pokemon) VALUES (2) RETURNING id_pokemon INTO id_pokemon_gerado;
                INSERT INTO npc (id_npc, id_tipo_npc) VALUES (id_pokemon_gerado, 2) RETURNING id_npc INTO id_npc_gerado;

                -- Inserindo o inimigo associado ao NPC recém-criado
                INSERT INTO inimigo (id_inimigo, nivel, vida, ataque_fisico, defesa_fisica, ataque_especial, velocidade,
                                     acuracia, evasao, status, nome, posicao, tipo_elemental)
                VALUES (id_npc_gerado, 10, 100, 20, 15, 30, 10, 80, 50, 'Normal', 'Inimigo ' || i, 3,
                        CASE WHEN i % 3 = 0 THEN 'fire' WHEN i % 3 = 1 THEN 'rock' ELSE 'flying' END);

                INSERT INTO pokemon_habilidade (id_pokemon, id_habilidade) VALUES (id_pokemon_gerado, 4);
                INSERT INTO pokemon_habilidade (id_pokemon, id_habilidade) VALUES (id_pokemon_gerado, 101);
            END LOOP;

        -- Inserindo o BOSS para o mapa Montanha fire
        INSERT INTO pokemon (id_tipo_pokemon) VALUES (2) RETURNING id_pokemon INTO id_pokemon_gerado;
        INSERT INTO npc (id_npc, id_tipo_npc) VALUES (id_pokemon_gerado, 2) RETURNING id_npc INTO id_npc_gerado;
        INSERT INTO inimigo (id_inimigo, nivel, vida, ataque_fisico, defesa_fisica, ataque_especial, velocidade,
                             acuracia, evasao, status, nome, posicao, tipo_elemental)
        VALUES (id_npc_gerado, 10, 1000, 50, 50, 80, 30, 80, 50, 'Normal', 'BOSS', 1, 'fire');

        INSERT INTO pokemon_habilidade (id_pokemon, id_habilidade) VALUES (id_pokemon_gerado, 4);
        INSERT INTO pokemon_habilidade (id_pokemon, id_habilidade) VALUES (id_pokemon_gerado, 101);
        INSERT INTO pokemon_habilidade (id_pokemon, id_habilidade) VALUES (id_pokemon_gerado, 56);
        INSERT INTO pokemon_habilidade (id_pokemon, id_habilidade) VALUES (id_pokemon_gerado, 86);

    ELSIF nome_mapa_missao = 'Caverna Cristal' THEN
        FOR i IN 1..5
            LOOP
                INSERT INTO pokemon (id_tipo_pokemon) VALUES (2) RETURNING id_pokemon INTO id_pokemon_gerado;
                INSERT INTO npc (id_npc, id_tipo_npc) VALUES (id_pokemon_gerado, 2) RETURNING id_npc INTO id_npc_gerado;

                -- Inserindo o inimigo associado ao NPC recém-criado
                INSERT INTO inimigo (id_inimigo, nivel, vida, ataque_fisico, defesa_fisica, ataque_especial, velocidade,
                                     acuracia, evasao, status, nome, posicao, tipo_elemental)
                VALUES (id_npc_gerado, 10, 100, 20, 15, 30, 10, 80, 50, 'Normal', 'Inimigo ' || i, 2,
                        CASE WHEN i % 3 = 0 THEN 'steel' WHEN i % 3 = 1 THEN 'ice' ELSE 'electric' END);

                INSERT INTO pokemon_habilidade (id_pokemon, id_habilidade) VALUES (id_pokemon_gerado, 4);
                INSERT INTO pokemon_habilidade (id_pokemon, id_habilidade) VALUES (id_pokemon_gerado, 101);
            END LOOP;

        -- Inserindo o BOSS para o mapa Caverna Cristal
        INSERT INTO pokemon (id_tipo_pokemon) VALUES (2) RETURNING id_pokemon INTO id_pokemon_gerado;
        INSERT INTO npc (id_npc, id_tipo_npc) VALUES (id_pokemon_gerado, 2) RETURNING id_npc INTO id_npc_gerado;
        INSERT INTO inimigo (id_inimigo, nivel, vida, ataque_fisico, defesa_fisica, ataque_especial, velocidade,
                             acuracia, evasao, status, nome, posicao, tipo_elemental)
        VALUES (id_npc_gerado, 10, 1000, 50, 50, 80, 30, 80, 50, 'Normal', 'BOSS', 1, 'ice');

        INSERT INTO pokemon_habilidade (id_pokemon, id_habilidade) VALUES (id_pokemon_gerado, 4);
        INSERT INTO pokemon_habilidade (id_pokemon, id_habilidade) VALUES (id_pokemon_gerado, 101);
        INSERT INTO pokemon_habilidade (id_pokemon, id_habilidade) VALUES (id_pokemon_gerado, 57);
        INSERT INTO pokemon_habilidade (id_pokemon, id_habilidade) VALUES (id_pokemon_gerado, 11);
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


DROP TRIGGER IF EXISTS trigger_gerar_inimigos_missao ON instancia_missao;
CREATE TRIGGER trigger_gerar_inimigos_missao
    AFTER INSERT
    ON instancia_missao
    FOR EACH ROW
    WHEN (NEW.concluida = false)
EXECUTE FUNCTION gerar_inimigos_missao();

--Trigger que impede novos INSERTS na tabela missao caso o jogador ja tenha uma missao ativa
CREATE OR REPLACE FUNCTION check_missao() RETURNS trigger
AS
$$
BEGIN
   PERFORM * FROM instancia_missao WHERE id_jogador = NEW.id_jogador AND concluida = false;
   IF FOUND THEN
        RAISE EXCEPTION 'Este jogador já possui uma missão ativa';
   END IF;
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_check_missao
BEFORE INSERT ON instancia_missao
FOR EACH ROW EXECUTE PROCEDURE check_missao();

--Trigger que caso seja deletado um inimigo com o nome BOSS ele irá retornar para a cidade
CREATE OR REPLACE FUNCTION verifica_deletar_boss()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.nome = 'BOSS' THEN
        UPDATE jogador j SET posicao = (SELECT id_terreno FROM terreno WHERE x = 0 AND y = 0) WHERE j.id_jogador = OLD.id_inimigo;
        RAISE NOTICE 'O BOSS foi derrotado e o jogador % retornou para a cidade.', OLD.id_inimigo;
    END IF;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trigger_verifica_deletar_boss
AFTER DELETE
ON inimigo
FOR EACH ROW
EXECUTE FUNCTION verifica_deletar_boss();





