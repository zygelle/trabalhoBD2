-- Stored Procedures/Funções

-- 1. Verifica a validade do pagamento e atualiza os atrasados
CREATE OR REPLACE PROCEDURE VerificarValidadePagamento()
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Pagamento
    SET status = 'Atrasado'
    WHERE status = 'Em aberto' AND data_vencimento < CURRENT_DATE;
END;
$$;

CALL VerificarValidadePagamento();

-- 2. Registrar Manutenção com inserção condicional em ManutencaoAreaComum
CREATE OR REPLACE PROCEDURE RegistrarManutencao(
    p_data_inicio DATE,
    p_data_fim DATE,
    p_descricao TEXT,
    p_valor NUMERIC,
    p_cpf_responsavel VARCHAR,
    p_local VARCHAR
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_manutencao INT;
BEGIN
    INSERT INTO Manutencao (data_inicio, data_fim, descricao, valor, cpf_responsavel, local)
    VALUES (p_data_inicio, p_data_fim, p_descricao, p_valor, p_cpf_responsavel, p_local)
    RETURNING id_manutencao INTO v_id_manutencao;

    IF EXISTS (SELECT 1 FROM AreaComum WHERE nome_area = p_local) THEN
        INSERT INTO ManutencaoAreaComum (nome_area, id_manutencao)
        VALUES (p_local, v_id_manutencao);
    END IF;
END;
$$;

CALL RegistrarManutencao('2025-01-11', '2025-01-12', 'Mudança na iluminação', 500, '44444444444', 'Salão de Festas');

-- 3. Registrar Morador
CREATE OR REPLACE PROCEDURE RegistrarMorador(
    p_cpf VARCHAR,
    p_nome VARCHAR,
    p_data_nascimento DATE,
    p_email VARCHAR,
    p_telefone_principal VARCHAR,
    p_id_unidade INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM Proprietario p
               JOIN Unidade u ON u.cpf_proprietario = p.cpf
               WHERE u.id_unidade = p_id_unidade) THEN

        INSERT INTO Pessoa (cpf, nome, data_nascimento, email, telefone_principal)
        VALUES (p_cpf, p_nome, p_data_nascimento, p_email, p_telefone_principal)
        ON CONFLICT (cpf) DO NOTHING;

        INSERT INTO Morador (cpf, id_unidade)
        VALUES (p_cpf, p_id_unidade);

    ELSE
        RAISE NOTICE 'Nenhum proprietário associado à unidade %.', p_id_unidade;
    END IF;
END;
$$;

CALL RegistrarMorador('66666666666', 'Rachel Barino', '2025-01-12', 'email@teste.com', '21982382733', 8);

-- 4. Atualizar cargo de um funcionário
CREATE OR REPLACE PROCEDURE AtualizarFuncionario(
    cpf_funcionario VARCHAR(11),
    novo_cargo VARCHAR(50)
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM CargoSalario WHERE nome_cargo = novo_cargo) THEN
        UPDATE Funcionario
        SET cargo = novo_cargo
        WHERE cpf = cpf_funcionario;
    ELSE
        RAISE NOTICE 'O cargo "%", não existe.', novo_cargo;
    END IF;
END;
$$;

CALL AtualizarFuncionario('66666666666', 'Supervisor');

-- 5. Consultar disponibilidade de uma área comum
CREATE OR REPLACE FUNCTION ConsultarDisponibilidade(
    nome_area_comum VARCHAR(100),
    data_reserva_param DATE
)
RETURNS CHAR AS $$
DECLARE
    disponibilidade BOOLEAN;
BEGIN
    -- Verifica se já existe uma reserva para a área e data especificada
    SELECT COUNT(*) > 0 INTO disponibilidade
    FROM reserva r
    WHERE r.data_reserva = data_reserva_param AND r.nome_area = nome_area_comum;

    -- Se já houver reserva para a área, retorna 'Área indisponível'
    IF disponibilidade THEN
        RETURN 'Área indisponível';
    END IF;

    -- Verifica se a área está em manutenção no dia da reserva
    SELECT COUNT(*) > 0 INTO disponibilidade
    FROM manutencao m
    JOIN areacomum ac ON ac.nome_area = nome_area_comum
    WHERE m.local = ac.nome_area -- Aqui associamos a manutenção à área comum
    AND m.data_inicio <= data_reserva_param
    AND (m.data_fim >= data_reserva_param OR m.data_fim IS NULL); -- Verifica se a manutenção abrange a data de reserva

    -- Se a área está em manutenção, retorna 'Área indisponível'
    IF disponibilidade THEN
        RETURN 'Área indisponível';
    END IF;

    -- Se não houver conflitos, retorna 'Área disponível'
    RETURN 'Área disponível';
END;
$$ LANGUAGE plpgsql;

SELECT ConsultarDisponibilidade('Salão de Festas', '2025-01-18');

-- 6. Calcular total de pagamentos por condomínio
CREATE OR REPLACE FUNCTION TotalPagamentosCondominio(cnpj_condominio_param VARCHAR(14))
RETURNS NUMERIC(10, 2) AS $$
DECLARE
    total NUMERIC(10, 2);
BEGIN
    SELECT SUM(p.valor) INTO total
    FROM Pagamento p
    WHERE p.cnpj_condominio = cnpj_condominio_param;
    RETURN total;
END;
$$ LANGUAGE plpgsql;

SELECT TotalPagamentosCondominio('12345678000101');