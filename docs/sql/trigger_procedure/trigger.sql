-- Validar a alteração do tamanho do inventário
CREATE FUNCTION before_update_tam_inventario() RETURNS TRIGGER AS
$$
BEGIN
    IF NEW.tam_inventario != OLD.tam_inventario THEN
        RAISE EXCEPTION 'A coluna tam_inventario não pode ser alterada diretamente.';
    END IF;
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
        NEW.posicao := (SELECT id_terreno FROM terreno WHERE x = 0 AND y = 0);
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

DROP TRIGGER trigger_check_npc ON jogador;
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


DROP TRIGGER trigger_check_jogador ON npc;
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



