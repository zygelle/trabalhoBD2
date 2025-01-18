-- Índices

-- 1. Índice para Consultas sobre Áreas Comuns em Manutenção
CREATE INDEX idx_manutencao_local_data_fim ON Manutencao(local, data_fim);

-- 2. Índice para Consultas sobre Unidades Disponíveis e Ocupadas
CREATE INDEX idx_unidade_cnpj_status ON Unidade(cnpj_condominio, status);

-- 3. Índice para Consultas sobre Moradores e suas Reservas
CREATE INDEX idx_pessoa_cpf ON Pessoa(cpf);
CREATE INDEX idx_unidade_id_unidade ON Unidade(id_unidade);
CREATE INDEX idx_reserva_id_reserva ON Reserva(id_reserva);

-- 4. Índice para Consultas sobre Pagamentos Atrasados por Morador
CREATE INDEX idx_pagamento_status_cpf ON Pagamento(cpf_morador, status);

-- 5. Índice para Consultas sobre Total de Pagamentos Atrasados por Condomínio
CREATE INDEX idx_pagamento_status_cnpj ON Pagamento(cnpj_condominio, status);

-- 6. Índice para Consultas sobre Fornecedores e seus Contratos
CREATE INDEX idx_contrato_cnpj_fornecedor ON Contrato(cnpj_fornecedor);

-- 7. Índice para Consultas sobre Contratos Vencidos
CREATE INDEX idx_contrato_data_fim ON Contrato(data_fim);

-- 8. Índice para Consultas sobre Fornecedores com Contratos Vencidos
CREATE INDEX idx_contrato_data_fim_cnpj ON Contrato(data_fim, cnpj_fornecedor);

-- 9. Índice para Consultas sobre Fornecedores com Contratos para Vencer
CREATE INDEX idx_contrato_data_fim_cnpj_ativo ON Contrato(data_fim, cnpj_fornecedor);

-- 10. Índice para Consultas sobre Pessoas Maiores de 18 Anos
CREATE INDEX idx_pessoa_data_nascimento ON Pessoa(data_nascimento);