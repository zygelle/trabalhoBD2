-- Tabela Condominio
CREATE TABLE Condominio (
    cnpj VARCHAR(14) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cep VARCHAR(8) NOT NULL,
    data_criacao DATE NOT NULL,
    telefone_principal VARCHAR(15) NOT NULL,
    email_principal VARCHAR(100) NOT NULL,
    logradouro VARCHAR(100) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    complemento VARCHAR(50),
    bairro VARCHAR(50) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    estado VARCHAR(2) NOT NULL
);

-- Tabela Pessoa
CREATE TABLE Pessoa (
    cpf VARCHAR(11) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefone_principal VARCHAR(15) NOT NULL
);

-- Tabela Proprietario
CREATE TABLE Proprietario (
    cpf VARCHAR(11) PRIMARY KEY REFERENCES Pessoa(cpf) ON DELETE CASCADE
);

-- Tabela Unidade
CREATE TABLE Unidade (
    id_unidade SERIAL PRIMARY KEY,
    cnpj_condominio VARCHAR(14) REFERENCES Condominio(cnpj) ON DELETE CASCADE,
    cpf_proprietario VARCHAR(11) REFERENCES Proprietario(cpf) ON DELETE CASCADE,
    numero VARCHAR(10) NOT NULL,
    bloco VARCHAR(10) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    tamanho NUMERIC(10, 2) NOT NULL,
    status VARCHAR(20) NOT NULL,
    data_aquisicao DATE NOT NULL
);

-- Tabela Morador
CREATE TABLE Morador (
    cpf VARCHAR(11) PRIMARY KEY REFERENCES Pessoa(cpf) ON DELETE CASCADE,
    id_unidade INT REFERENCES Unidade(id_unidade) ON DELETE CASCADE
);

-- Tabela CargoSalario
CREATE TABLE CargoSalario (
    nome_cargo VARCHAR(50) PRIMARY KEY,
    salario NUMERIC(10, 2) NOT NULL
);

-- Tabela Funcionario
CREATE TABLE Funcionario (
    cpf VARCHAR(11) PRIMARY KEY REFERENCES Pessoa(cpf) ON DELETE CASCADE,
    cargo VARCHAR(50) REFERENCES CargoSalario(nome_cargo) NOT NULL,
    data_admissao DATE NOT NULL,
    terceirizado BOOLEAN NOT NULL
);

-- Tabela CondominioFuncionario
CREATE TABLE CondominioFuncionario (
    cpf VARCHAR(11) REFERENCES Funcionario(cpf) ON DELETE CASCADE,
    cnpj_condominio VARCHAR(14) REFERENCES Condominio(cnpj) ON DELETE CASCADE,
    PRIMARY KEY (cpf, cnpj_condominio)
);

-- Tabela Manutencao
CREATE TABLE Manutencao (
    id_manutencao SERIAL PRIMARY KEY,
    data_inicio DATE NOT NULL,
    data_fim DATE,
    descricao TEXT NOT NULL,
    valor NUMERIC(10, 2) NOT NULL,
    cpf_responsavel VARCHAR(11) REFERENCES Funcionario(cpf) ON DELETE SET NULL,
    local VARCHAR(100) NOT NULL
);

-- Tabela ManutencaoFuncionario
CREATE TABLE ManutencaoFuncionario (
    id_manutencao INT,
    cpf_funcionario VARCHAR(11),
    PRIMARY KEY (id_manutencao, cpf_funcionario),
    FOREIGN KEY (id_manutencao) REFERENCES Manutencao(id_manutencao) ON DELETE CASCADE,
    FOREIGN KEY (cpf_funcionario) REFERENCES Funcionario(cpf) ON DELETE CASCADE
);

-- Tabela Pagamento
CREATE TABLE Pagamento (
    id_pagamento SERIAL PRIMARY KEY,
    data_pagamento DATE,
    descricao TEXT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    forma_pagamento VARCHAR(50) NOT NULL,
    data_vencimento DATE NOT NULL,
    valor NUMERIC(10, 2) NOT NULL,
    status VARCHAR(20) NOT NULL,
    cpf_morador VARCHAR(11) REFERENCES Morador(cpf) ON DELETE SET NULL,
    cnpj_condominio VARCHAR(14) REFERENCES Condominio(cnpj) ON DELETE CASCADE
);

-- Tabela AreaComum
CREATE TABLE AreaComum (
    nome_area VARCHAR(100) PRIMARY KEY,
    descricao TEXT NOT NULL,
    horario_funcionamento VARCHAR(50) NOT NULL,
    cnpj_condominio VARCHAR(14) REFERENCES Condominio(cnpj) ON DELETE CASCADE
);

-- Tabela ManutencaoAreaComum
CREATE TABLE ManutencaoAreaComum (
    nome_area VARCHAR(100) NOT NULL REFERENCES AreaComum(nome_area) ON DELETE CASCADE,
    id_manutencao INT NOT NULL REFERENCES Manutencao(id_manutencao) ON DELETE CASCADE,
    PRIMARY KEY (nome_area, id_manutencao)
);

-- Tabela Reserva
CREATE TABLE Reserva (
    id_reserva SERIAL PRIMARY KEY,
    data_reserva DATE NOT NULL,
    hora_inicial TIME NOT NULL,
    hora_final TIME NOT NULL,
    qtde_convidados INT NOT NULL,
    cpf_morador VARCHAR(11) REFERENCES Morador(cpf) ON DELETE CASCADE,
    nome_area VARCHAR(100) REFERENCES AreaComum(nome_area) ON DELETE CASCADE
);

-- Tabela Fornecedor
CREATE TABLE Fornecedor (
    cnpj VARCHAR(14) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone_principal VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL,
    tipo_servico VARCHAR(50) NOT NULL
);

-- Tabela Contrato
CREATE TABLE Contrato (
    id_contrato SERIAL PRIMARY KEY,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    valor NUMERIC(10, 2) NOT NULL,
    descricao_servico TEXT NOT NULL,
    cnpj_condominio VARCHAR(14) REFERENCES Condominio(cnpj) ON DELETE CASCADE,
    cnpj_fornecedor VARCHAR(14) REFERENCES Fornecedor(cnpj) ON DELETE CASCADE
);

-- Tabela Assembleia
CREATE TABLE Assembleia (
    id_assembleia SERIAL PRIMARY KEY,
    data DATE NOT NULL,
    descricao TEXT NOT NULL,
    presenca_obrigatoria BOOLEAN NOT NULL,
    conteudo_ata TEXT NOT NULL,
    cnpj_condominio VARCHAR(14) REFERENCES Condominio(cnpj) ON DELETE CASCADE
);

-- Tabela Comunicado
CREATE TABLE Comunicado (
    id_comunicado SERIAL PRIMARY KEY,
    data_comunicado DATE NOT NULL,
    descricao TEXT NOT NULL,
    cnpj_condominio VARCHAR(14) REFERENCES Condominio(cnpj) ON DELETE CASCADE
);