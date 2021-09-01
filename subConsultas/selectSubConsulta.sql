--SUB CONSULTA

--CONSULTANDO IDS COM UMA DATA DEFINIDA
SELECT nome_coluna_ID
FROM nome_tabela
WHERE CAST (nome_coluna_DATA AS DATE) = '0000-00-00'
ORDER BY nome_coluna_ID;

--CONSULTANDO IDS E OUTROS DADOS COM UMA DATA DEFINIDA CONTENDO DADOS DE 2 TABELAS
SELECT nome_coluna_ID, nome_coluna_2, nome_coluna_3
FROM nome_tabela_1
WHERE nome_coluna_ID 
	IN (
		SELECT nome_coluna_ID
		FROM nome_tabela_2
		WHERE CAST (nome_coluna_DATA AS DATE) = '0000-00-00'
	   )
ORDER BY nome_coluna_ID;