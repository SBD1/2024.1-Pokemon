# <b>Triggers e Stored Procedures</b>

#### Validar a alteração do tamanho do inventário
~~~sql
CREATE FUNCTION valida_update_tam_inventario() RETURNS TRIGGER AS
$$
BEGIN
    IF NEW.tam_inventario != OLD.tam_inventario THEN
        RAISE EXCEPTION 'A coluna tam_inventario não pode ser alterada diretamente.';
    END IF;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS valida_update_tam_inventario ON jogador;
CREATE TRIGGER valida_update_tam_inventario
    BEFORE UPDATE
    ON jogador
    FOR EACH ROW
EXECUTE FUNCTION valida_update_tam_inventario();
~~~

#### Verificar se o inventário do jogador está cheio antes de adicionar um novo item
~~~~sql
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
~~~~

#### Move o jogador para a cidade quando a vida dele for igual a zero
~~~~sql
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
~~~~

### Garante integridade
~~~~sql


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

~~~~






## Histórico de Versão

| Versão |    Data    |      Descrição      |                                                                                                Autor(es)                                                                                                 |
| :----: | :--------: | :-----------------: | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: |
| `1.0`  | 07/09/2024 | Adicionando triggers | [Gabriel Marcolino](https://github.com/GabrielMR360) e [Shaíne Oliveira](ttps://github.com/ShaineOliveira)|
| `1.1`  | 07/09/2024 | Adiciona trigger de vida | [Gabriel Marcolino](https://github.com/GabrielMR360) e [Shaíne Oliveira](ttps://github.com/ShaineOliveira) |
| `1.2`  | 08/09/2024 | Adiciona trigger de integridade | [Gabriel Marcolino](https://github.com/GabrielMR360) e [Shaíne Oliveira](ttps://github.com/ShaineOliveira) |

