-- Task: Desenvolva uma query analítica para responder:

-- Utilizando o schema
USE cadop;

-- Quais as 10 operadoras com maiores despesas em "EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR" no último trimestre?
SELECT op.Razao_Social, oc.Descricao, oc.Data_Fechamento, oc.Val_Saldo_Inicial - oc.Val_Saldo_Final AS "Despesa"
FROM operadoras_ativas as op
JOIN operacoes_contabeis as oc ON op.Registro_ANS = oc.Registro_ANS
WHERE oc.Descricao LIKE 'EVENTOS/%' AND oc.Descricao LIKE '%SINISTROS CONHECIDOS%' AND oc.Descricao LIKE '%ASSISTÊNCIA A SAÚDE MEDICO%' 
AND oc.Data_Fechamento BETWEEN '2024-10-01' AND '2024-12-31'
ORDER BY oc.Val_Saldo_Inicial - oc.Val_Saldo_Final DESC
LIMIT 10;

-- Quais as 10 operadoras com maiores despesas nessa categoria no último ano?
SELECT op.Razao_Social, oc.Descricao, oc.Data_Fechamento, oc.Val_Saldo_Inicial - oc.Val_Saldo_Final AS "Despesa"
FROM operadoras_ativas as op
JOIN operacoes_contabeis as oc ON op.Registro_ANS = oc.Registro_ANS
WHERE oc.Descricao LIKE 'EVENTOS/%' AND oc.Descricao LIKE '%SINISTROS CONHECIDOS%' AND oc.Descricao LIKE '%ASSISTÊNCIA A SAÚDE MEDICO%' 
AND oc.Data_Fechamento BETWEEN '2024-01-01' AND '2024-12-31'
ORDER BY oc.Val_Saldo_Inicial - oc.Val_Saldo_Final DESC
LIMIT 10;