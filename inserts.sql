-- Populando a tabela Condominio
INSERT INTO Condominio (cnpj, nome, cep, data_criacao, telefone_principal, email_principal, logradouro, numero, complemento, bairro, cidade, estado)
VALUES
('12345678000101', 'Condomínio Solar', '12345678', '2010-05-20', '11987654321', 'solar@condominio.com', 'Rua das Flores', '100', 'Apto 1', 'Centro', 'São Paulo', 'SP'),
('98765432000145', 'Residencial Aurora', '87654321', '2012-08-15', '11987651234', 'aurora@condominio.com', 'Av. Central', '500', '', 'Jardim', 'Rio de Janeiro', 'RJ'),
('56473829000190', 'Condomínio Verdes Campos', '45678912', '2015-11-10', '11987650000', 'verdescampos@condominio.com', 'Alameda Verde', '300', 'Bloco B', 'Vila Nova', 'Belo Horizonte', 'MG'),
('11223344556677', 'Edifício Azul', '11223344', '2018-03-01', '11999999999', 'azul@condominio.com', 'Rua Azul', '45', '', 'Centro', 'Curitiba', 'PR'),
('22334455667788', 'Condomínio Marítimo', '33445566', '2020-01-05', '11888888888', 'maritimo@condominio.com', 'Praça do Porto', '12', 'Cobertura', 'Centro', 'Porto Alegre', 'RS');

-- Populando a tabela Pessoa
INSERT INTO Pessoa (cpf, nome, data_nascimento, email, telefone_principal)
VALUES
('77777777777', 'Gyselle Mello', '2000-03-05', 'gyselle@exemplo.com', '1199995555'),
('11111111111', 'João Silva', '1990-05-15', 'joao@exemplo.com', '1199991111'),
('22222222222', 'Maria Oliveira', '1985-07-20', 'maria@exemplo.com', '1199992222'),
('33333333333', 'Pedro Santos', '1995-09-25', 'pedro@exemplo.com', '1199993333'),
('44444444444', 'Ana Costa', '1988-12-10', 'ana@exemplo.com', '1199994444'),
('55555555555', 'Lucas Pereira', '2000-03-05', 'lucas@exemplo.com', '1199995555');

-- Populando a tabela Proprietario
INSERT INTO Proprietario (cpf)
VALUES
('11111111111'), ('22222222222'), ('33333333333'), ('44444444444'), ('55555555555');

-- Populando a tabela Unidade
INSERT INTO Unidade (cnpj_condominio, cpf_proprietario, numero, bloco, tipo, tamanho, status, data_aquisicao)
VALUES
('12345678000101', '11111111111', '105', 'A', 'Apartamento', 75.5, 'Ocupado', '2015-02-20'),
('12345678000101', '11111111111', '101', 'A', 'Apartamento', 75.5, 'Ocupado', '2015-02-20'),
('12345678000101', '22222222222', '102', 'A', 'Apartamento', 80.0, 'Ocupado', '2016-03-15'),
('98765432000145', '33333333333', '201', 'B', 'Apartamento', 65.3, 'Disponível', '2017-06-10'),
('56473829000190', '44444444444', '301', 'C', 'Casa', 120.0, 'Ocupado', '2018-09-05'),
('11223344556677', '55555555555', '401', 'D', 'Cobertura', 200.0, 'Ocupado', '2020-01-10');

-- Populando a tabela Morador
INSERT INTO Morador (cpf, id_unidade)
VALUES
('11111111111', 1), ('22222222222', 2), ('33333333333', 3), ('44444444444', 4), ('55555555555', 5);

-- Populando a tabela CargoSalario
INSERT INTO CargoSalario (nome_cargo, salario)
VALUES
('Zelador', 2500.00),
('Porteiro', 2000.00),
('Faxineiro', 1800.00),
('Supervisor', 3500.00),
('Jardineiro', 2200.00);

-- Populando a tabela Funcionario
INSERT INTO Funcionario (cpf, cargo, data_admissao, terceirizado)
VALUES
('44444444444', 'Zelador', '2019-02-01', FALSE),
('33333333333', 'Porteiro', '2020-04-15', TRUE),
('55555555555', 'Faxineiro', '2021-01-20', FALSE),
('11111111111', 'Supervisor', '2022-05-10', FALSE),
('22222222222', 'Jardineiro', '2023-03-25', TRUE);

-- Populando a tabela CondominioFuncionario
INSERT INTO CondominioFuncionario (cpf, cnpj_condominio)
VALUES
('44444444444', '12345678000101'),
('33333333333', '12345678000101'),
('55555555555', '98765432000145'),
('11111111111', '56473829000190'),
('22222222222', '11223344556677');

-- Populando a tabela Manutencao
INSERT INTO Manutencao (data_inicio, data_fim, descricao, valor, cpf_responsavel, local)
VALUES
('2023-10-01', '2023-10-05', 'Troca de lâmpadas', 500.00, '44444444444', 'Garagem'),
('2023-09-15', '2023-09-20', 'Pintura de paredes', 1500.00, '33333333333', 'Hall de entrada'),
('2023-08-10', NULL, 'Manutenção de elevador', 3000.00, NULL, 'Bloco A'),
('2023-07-05', '2023-07-07', 'Troca de portas', 800.00, '55555555555', 'Corredores'),
('2023-06-25', '2023-06-28', 'Conserto de vazamento', 1200.00, '11111111111', 'Área comum');

-- Populando a tabela ManutencaoFuncionario
INSERT INTO ManutencaoFuncionario (id_manutencao, cpf_funcionario)
VALUES
(1, '44444444444'),
(2, '33333333333'),
(3, '55555555555'),
(4, '11111111111'),
(5, '22222222222');

-- Populando a tabela Pagamento
INSERT INTO Pagamento (data_pagamento, descricao, nome, forma_pagamento, data_vencimento, valor, status, cpf_morador, cnpj_condominio)
VALUES
('2023-11-10', 'Taxa de condomínio', 'João Silva', 'Cartão de Crédito', '2023-11-10', 500.00, 'Pago', '11111111111', '12345678000101'),
('2023-11-15', 'Taxa de condomínio', 'Maria Oliveira', 'Boleto', '2023-11-15', 520.00, 'Pago', '22222222222', '12345678000101'),
(null, 'Taxa de condomínio', 'Pedro Santos', 'Pix', '2023-11-20', 480.00, 'Em aberto', '33333333333', '98765432000145'),
('2023-11-25', 'Reparos gerais', 'Ana Costa', 'Cartão de Crédito', '2023-11-25', 300.00, 'Pago', '44444444444', '56473829000190'),
(null, 'Taxa de condomínio', 'Lucas Pereira', 'Boleto', '2023-11-30', 550.00, 'Em aberto', '55555555555', '11223344556677');

-- Populando a tabela AreaComum
INSERT INTO AreaComum (nome_area, descricao, horario_funcionamento, cnpj_condominio)
VALUES
('Piscina', 'Piscina externa para recreação', '08:00-20:00', '12345678000101'),
('Academia', 'Espaço com equipamentos de ginástica', '06:00-22:00', '12345678000101'),
('Salão de Festas', 'Espaço para eventos', '09:00-23:00', '98765432000145'),
('Quadra Poliesportiva', 'Quadra para esportes diversos', '07:00-22:00', '56473829000190'),
('Playground', 'Área para crianças', '08:00-18:00', '11223344556677');

-- Populando a tabela ManutencaoAreaComum
INSERT INTO ManutencaoAreaComum (nome_area, id_manutencao)
VALUES
('Piscina', 1),
('Academia', 2),
('Salão de Festas', 3),
('Quadra Poliesportiva', 4),
('Playground', 5);

-- Populando a tabela Reserva
INSERT INTO Reserva (data_reserva, hora_inicial, hora_final, qtde_convidados, cpf_morador, nome_area)
VALUES
('2023-12-01', '10:00', '14:00', 10, '11111111111', 'Salão de Festas'),
('2023-12-05', '16:00', '20:00', 5, '22222222222', 'Piscina'),
('2023-12-10', '08:00', '10:00', 3, '33333333333', 'Quadra Poliesportiva'),
('2023-12-15', '18:00', '22:00', 20, '44444444444', 'Salão de Festas'),
('2023-12-20', '14:00', '16:00', 8, '55555555555', 'Playground');

-- Populando a tabela Fornecedor
INSERT INTO Fornecedor (cnpj, nome, telefone_principal, email, tipo_servico)
VALUES
('11111111000111', 'Manutenção Elétrica LTDA', '11987654321', 'contato@manutencaoeletrica.com', 'Serviços Elétricos'),
('22222222000122', 'Jardins Perfeitos', '11988887777', 'contato@jardinsperfeitos.com', 'Manutenção de Jardins'),
('33333333000133', 'Portões Automáticos SA', '11999996666', 'suporte@portoesautomaticos.com', 'Manutenção de Portões'),
('44444444000144', 'Limpeza Rápida ME', '11977778888', 'servicos@limpezarapida.com', 'Limpeza e Conservação'),
('55555555000155', 'Pintura & Arte', '11966665555', 'pinturaearte@exemplo.com', 'Pintura Predial');

-- Populando a tabela Contrato
INSERT INTO Contrato (data_inicio, data_fim, valor, descricao_servico, cnpj_condominio, cnpj_fornecedor)
VALUES
('2023-01-01', '2023-12-31', 12000.00, 'Manutenção de sistemas elétricos', '12345678000101', '11111111000111'),
('2023-02-01', '2024-01-31', 15000.00, 'Manutenção e cuidado com jardins', '98765432000145', '22222222000122'),
('2023-03-01', '2023-12-31', 18000.00, 'Conserto e revisão de portões automáticos', '56473829000190', '33333333000133'),
('2023-04-01', '2023-09-30', 10000.00, 'Serviços de limpeza geral', '11223344556677', '44444444000144'),
('2023-05-01', '2023-11-30', 8000.00, 'Pintura das áreas comuns', '22334455667788', '55555555000155');

-- Populando a tabela Assembleia
INSERT INTO Assembleia (data, descricao, presenca_obrigatoria, conteudo_ata, cnpj_condominio)
VALUES
('2023-11-10', 'Discussão sobre aumento da taxa condominial', TRUE, 'Ata da assembleia registrada no livro oficial.', '12345678000101'),
('2023-09-15', 'Planejamento de melhorias no playground', FALSE, 'Decisões aprovadas por maioria simples.', '98765432000145'),
('2023-08-20', 'Revisão do contrato de manutenção elétrica', TRUE, 'Ata detalhada com decisões anexadas.', '56473829000190'),
('2023-07-05', 'Escolha de nova empresa de limpeza', TRUE, 'Propostas discutidas e votadas.', '11223344556677'),
('2023-06-25', 'Aprovação do orçamento anual', TRUE, 'Detalhamento de despesas e receitas futuras.', '22334455667788');

-- Populando a tabela Comunicado
INSERT INTO Comunicado (data_comunicado, descricao, cnpj_condominio)
VALUES
('2023-11-05', 'Manutenção no elevador do bloco A será realizada entre os dias 10 e 12 de novembro.', '12345678000101'),
('2023-10-15', 'Pintura da fachada do prédio começará no próximo mês.', '98765432000145'),
('2023-09-20', 'Reunião extraordinária marcada para o dia 25 de setembro.', '56473829000190'),
('2023-08-10', 'Atualização no regulamento interno do condomínio.', '11223344556677'),
('2023-07-01', 'Recolhimento de donativos para campanha do agasalho.', '22334455667788');
