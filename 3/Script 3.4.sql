-- Task: Elabore queries para importar o conteúdo dos arquivos preparados, atentando para o encoding correto.

-- Essas linhas devem ser rodadas com --local-infile=1 e O CAMINHO DOS ARQUIVOS DEVEM SER ALTERADOS!!

USE cadop;

SET GLOBAL local_infile = 1;

-- Desativando o modo de segurança para updates temporariamente, visto que faremos alguns updates em todas as linhas
SET SQL_SAFE_UPDATES = 0;

LOAD DATA LOCAL INFILE '~/Repos/intuitive-care-testes/3/Relatorio_cadop.csv' -- Essa linha deve ser rodada com --local-infile=1 e o caminho do arquivo deve ser alterado
INTO TABLE operadoras_ativas
CHARACTER SET 'utf8mb4'
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(Registro_ANS, CNPJ, Razao_Social, Nome_Fantasia, Modalidade, Logradouro, Numero, Complemento, Bairro, Cidade, UF, CEP, DDD, Telefone, Fax, Endereco_eletronico, Representante, Cargo_Representante, Regiao_de_Comercializacao, Data_Registro_ANS);

LOAD DATA LOCAL INFILE '~/Repos/intuitive-care-testes/3/2023/1T2023.csv'
INTO TABLE operacoes_contabeis
CHARACTER SET 'utf8mb4'
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(Data_Fechamento, Registro_ANS, Cod_Conta_Contabil, Descricao, Val_Saldo_Inicial_RAW, Val_Saldo_Final_RAW);

ALTER TABLE operacoes_contabeis
MODIFY Data_Fechamento VARCHAR(20);

LOAD DATA LOCAL INFILE '~/Repos/intuitive-care-testes/3/2023/2t2023.csv'
INTO TABLE operacoes_contabeis
CHARACTER SET 'utf8mb4'
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(Data_Fechamento, Registro_ANS, Cod_Conta_Contabil, Descricao, Val_Saldo_Inicial_RAW, Val_Saldo_Final_RAW);

UPDATE operacoes_contabeis
SET Data_Fechamento = STR_TO_DATE(Data_Fechamento, '%d/%m/%y')
WHERE DATA_Fechamento LIKE '__/__/____';

ALTER TABLE operacoes_contabeis
MODIFY Data_Fechamento VARCHAR(20);

LOAD DATA LOCAL INFILE '~/Repos/intuitive-care-testes/3/2023/3T2023.csv'
INTO TABLE operacoes_contabeis
CHARACTER SET 'utf8mb4'
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(Data_Fechamento, Registro_ANS, Cod_Conta_Contabil, Descricao, Val_Saldo_Inicial_RAW, Val_Saldo_Final_RAW);

LOAD DATA LOCAL INFILE '~/Repos/intuitive-care-testes/3/2023/4T2023.csv'
INTO TABLE operacoes_contabeis
CHARACTER SET 'utf8mb4'
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(Data_Fechamento, Registro_ANS, Cod_Conta_Contabil, Descricao, Val_Saldo_Inicial_RAW, Val_Saldo_Final_RAW);

LOAD DATA LOCAL INFILE '~/Repos/intuitive-care-testes/3/2024/1T2024.csv'
INTO TABLE operacoes_contabeis
CHARACTER SET 'utf8mb4'
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(Data_Fechamento, Registro_ANS, Cod_Conta_Contabil, Descricao, Val_Saldo_Inicial_RAW, Val_Saldo_Final_RAW);

LOAD DATA LOCAL INFILE '~/Repos/intuitive-care-testes/3/2024/2T2024.csv'
INTO TABLE operacoes_contabeis
CHARACTER SET 'utf8mb4'
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(Data_Fechamento, Registro_ANS, Cod_Conta_Contabil, Descricao, Val_Saldo_Inicial_RAW, Val_Saldo_Final_RAW);

LOAD DATA LOCAL INFILE '~/Repos/intuitive-care-testes/3/2024/3T2024.csv'
INTO TABLE operacoes_contabeis
CHARACTER SET 'utf8mb4'
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(Data_Fechamento, Registro_ANS, Cod_Conta_Contabil, Descricao, Val_Saldo_Inicial_RAW, Val_Saldo_Final_RAW);

LOAD DATA LOCAL INFILE '~/Repos/intuitive-care-testes/3/2024/4T2024.csv'
INTO TABLE operacoes_contabeis
CHARACTER SET 'utf8mb4'
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(Data_Fechamento, Registro_ANS, Cod_Conta_Contabil, Descricao, Val_Saldo_Inicial_RAW, Val_Saldo_Final_RAW);

-- FIM da importação dos arquivos

-- Aqui é feito um casting das colunas, visto que no csv, números decimais são separados por vírgula e o tyipo DECIMAL do sql espera separação por ponto.

-- Atualizando os dados nas colunas Val_Saldo Inicial e Val_Saldo_Final
UPDATE operacoes_contabeis
SET Val_Saldo_Inicial = CAST(REPLACE(Val_Saldo_Inicial_RAW, ',', '.') AS DECIMAL(18,2)), 
Val_Saldo_Final = CAST(REPLACE(Val_Saldo_Final_RAW, ',', '.') AS DECIMAL(18,2))
WHERE Val_Saldo_Inicial IS NULL AND Val_Saldo_Inicial_RAW IS NOT NULL;

SET SQL_SAFE_UPDATES = 1;

-- Excluindo as colunas temporárias que armazenaram os dados de valores até agora
ALTER TABLE operacoes_contabeis
DROP COLUMN Val_Saldo_Inicial_RAW,
DROP COLUMN Val_Saldo_Final_RAW;

