# <b>Triggers e Stored Procedures</b>

### Trigger para verificar se o inventário do jogador está cheio antes de adicionar um novo item
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

## Histórico de Versão

| Versão |    Data    |      Descrição      |                                                                                                Autor(es)                                                                                                 |
| :----: | :--------: | :-----------------: | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: |
| `1.0`  | 07/09/2024 | Adicionando triggers | [Gabriel Marcolino](https://github.com/GabrielMR360), [Shaíne Oliveira](ttps://github.com/ShaineOliveira), [José Filipi](https://github.com/JoseFilipi) e [Leonardo Bonetti](https://github.com/LeoFacB) |
