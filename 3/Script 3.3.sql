-- Task: Crie queries para estruturar tabelas necessárias para o arquivo csv.

-- Criando banco de dados, caso nao exista
CREATE DATABASE IF NOT EXISTS cadop;

-- Selecionando schema como ativo 
USE cadop;

-- Criando a primeira tabela, para os dados cadastrais das operadoras ativas na ANS (tarefa 3.2)
CREATE TABLE IF NOT EXISTS operadoras_ativas (
	Registro_ANS INT PRIMARY KEY,
    CNPJ CHAR(14) NOT NULL,
    Razao_Social VARCHAR(255) NOT NULL,
    Nome_Fantasia VARCHAR(255),
    Modalidade VARCHAR(255) NOT NULL,
    Logradouro VARCHAR(255) NOT NULL,
    Numero VARCHAR(20) NOT NULL,
    Complemento VARCHAR(100),
    Bairro VARCHAR(100) NOT NULL,
    Cidade VARCHAR(100) NOT NULL,
    UF CHAR(2) NOT NULL,
    CEP CHAR(8) NOT NULL,
    DDD CHAR(2),
    Telefone VARCHAR(20),
    Fax VARCHAR(15),
    Endereco_eletronico VARCHAR(255),
    Representante VARCHAR(255) NOT NULL,
    Cargo_Representante VARCHAR(255) NOT NULL,
    Regiao_de_Comercializacao CHAR(1) NOT NULL,
    Data_Registro_ANS DATE NOT NULL
);

-- Criando segunda tabela para as operações contidas no repositório (tarefa 3.1) 
CREATE TABLE IF NOT EXISTS operacoes_contabeis (
	Data_Fechamento DATE,
    Registro_ANS INT,
    Cod_Conta_Contabil VARCHAR(15),
    Descricao VARCHAR(255),
    Val_Saldo_Inicial DECIMAL(18,2),
    Val_Saldo_Final DECIMAL(18,2),
    Val_Saldo_Inicial_RAW VARCHAR(255),
    Val_Saldo_Final_RAW VARCHAR(255),
    PRIMARY KEY (Data_Fechamento, Registro_ANS, Cod_Conta_Contabil)
);