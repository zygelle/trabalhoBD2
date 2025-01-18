-- Views

-- 1. Moradores e suas unidades
CREATE VIEW vw_moradores_unidades AS
SELECT
    m.cpf AS morador_cpf,
    p.nome AS morador_nome,
    u.id_unidade,
    u.numero AS unidade_numero,
    u.bloco AS unidade_bloco,
    u.status AS unidade_status,
    c.nome AS condominio_nome,
    c.estado AS condominio_estado
FROM
    Morador m
JOIN
    Pessoa p ON m.cpf = p.cpf
JOIN
    Unidade u ON m.id_unidade = u.id_unidade
JOIN
    Condominio c ON u.cnpj_condominio = c.cnpj;

-- 2. Pagamentos atrasados por condomínio
CREATE VIEW vw_pagamentos_atrasados AS
SELECT
    c.nome AS condominio_nome,
    c.estado AS condominio_estado,
    COUNT(p.id_pagamento) AS total_pagamentos_atrasados,
    SUM(p.valor) AS total_valor_atrasado
FROM
    Pagamento p
JOIN
    Condominio c ON p.cnpj_condominio = c.cnpj
WHERE
    p.status = 'Atrasado'
GROUP BY
    c.cnpj, c.nome, c.estado;

-- 3. Contratos vigentes e Fornecedores
CREATE OR REPLACE VIEW vw_contratos_fornecedores AS
SELECT
    c.id_contrato,
    c.data_inicio,
    c.data_fim,
    c.valor,
    c.descricao_servico,
    f.nome AS nome_fornecedor,
    f.tipo_servico
FROM
    Contrato c
JOIN
    Fornecedor f ON c.cnpj_fornecedor = f.cnpj
WHERE
    c.data_inicio <= CURRENT_DATE AND c.data_fim >= CURRENT_DATE;