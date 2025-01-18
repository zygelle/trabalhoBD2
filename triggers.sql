-- Funções de triggers

-- 1. Atualizar status da unidade ao inserir morador
CREATE OR REPLACE FUNCTION AtualizarStatusUnidade()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Unidade
    SET status = 'Ocupado'
    WHERE id_unidade = NEW.id_unidade;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_atualizar_status_unidade
AFTER INSERT ON Morador
FOR EACH ROW
EXECUTE FUNCTION AtualizarStatusUnidade();

-- 2. Atualiza o status do pagamento
CREATE OR REPLACE FUNCTION AtualizarStatusPagamento()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.data_pagamento IS NOT NULL AND (NEW.status = 'Em aberto' OR NEW.status = 'Atrasado') THEN
        UPDATE Pagamento
        SET status = 'Pago'
        WHERE id_pagamento = NEW.id_pagamento;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_atualizar_status_pagamento
AFTER UPDATE ON Pagamento
FOR EACH ROW
EXECUTE FUNCTION AtualizarStatusPagamento();


