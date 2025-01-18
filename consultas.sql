-- Consultas

-- 1. Retorna todas as áreas comuns que estão em manutenção
SELECT m.descricao, data_inicio, data_fim, local, valor AS resultado
FROM Manutencao m JOIN AreaComum ac ON m.local = ac.nome_area AND m.data_fim IS NULL;

-- 2. Quantidade de unidades disponíveis e ocupadas em cada condomínio
SELECT c.nome AS condominio_nome,
       u.status AS unidade_status,
       COUNT(u.id_unidade) AS quantidade_unidades
FROM Unidade u
JOIN Condominio c ON u.cnpj_condominio = c.cnpj
GROUP BY c.nome, u.status;

-- 3. Moradores e suas reservas
SELECT p.nome AS morador_nome,
       r.nome_area,
       r.data_reserva,
       r.hora_inicial,
       r.hora_final
FROM Morador m
JOIN Pessoa p ON m.cpf = p.cpf
JOIN Reserva r ON m.id_unidade = r.id_reserva
ORDER BY r.data_reserva, r.hora_inicial;

-- 4. Pagamentos atrasados por morador
SELECT p.nome AS morador_nome,
       pa.valor AS pagamento_valor,
       pa.data_vencimento
FROM Pagamento pa
JOIN Morador m ON pa.cpf_morador = m.cpf
JOIN Pessoa p ON m.cpf = p.cpf
WHERE pa.status = 'Atrasado'
ORDER BY pa.data_vencimento;

-- 5. Total de pagamentos atrasados por condomínio
SELECT c.nome AS condominio_nome,
       SUM(pa.valor) AS total_atrasado
FROM Pagamento pa
JOIN Condominio c ON pa.cnpj_condominio = c.cnpj
WHERE pa.status = 'Atrasado'
GROUP BY c.nome;

-- 6. Mostra fornecedores e seus contratos
SELECT f.nome AS fornecedor_nome,
       c.id_contrato,
       c.valor,
       c.data_inicio,
       c.data_fim
FROM Contrato c
JOIN Fornecedor f ON c.cnpj_fornecedor = f.cnpj
ORDER BY f.nome;

-- 7. Contratos vencidos
SELECT c.id_contrato,
       c.descricao_servico,
       c.data_inicio,
       c.data_fim
FROM Contrato c
WHERE c.data_fim < CURRENT_DATE;

-- 8. Fornecedores com contratos vencidos
SELECT f.nome AS fornecedor_nome,
       c.id_contrato,
       c.descricao_servico,
       c.data_inicio,
       c.data_fim
FROM Contrato c
JOIN Fornecedor f ON c.cnpj_fornecedor = f.cnpj
WHERE c.data_fim < CURRENT_DATE;

-- 9. Fornecedores que estão com o contrato pra vencer
SELECT f.nome AS fornecedor_nome,
       c.id_contrato,
       c.data_inicio,
       c.data_fim,
       c.valor,
       c.descricao_servico
FROM Contrato c
JOIN Fornecedor f ON c.cnpj_fornecedor = f.cnpj
WHERE c.data_fim >= CURRENT_DATE
ORDER BY c.data_fim;

-- 10. Seleciona pessoas maiores de 18 anos
SELECT
    p.nome AS nome_morador,
    p.cpf AS cpf_morador,
    p.data_nascimento,
    p.email,
    p.telefone_principal,
    u.numero AS unidade_numero,
    u.bloco AS unidade_bloco,
    u.tipo AS unidade_tipo,
    u.cnpj_condominio
FROM
    Morador m
JOIN
    Pessoa p ON m.cpf = p.cpf
JOIN
    Unidade u ON m.id_unidade = u.id_unidade
WHERE
    DATE_PART('year', AGE(p.data_nascimento)) > 18;