--SELECT ORDENAÇÃO

--ordenacao de ordem crescente
SELECT 	nome_coluna_1, nome_coluna_2 FROM nome_tabela ORDER BY nome_coluna_1 ASC;

--ordenacao de ordem crescente ASC opcional
SELECT 	nome_coluna_1, nome_coluna_2 FROM nome_tabela ORDER BY nome_coluna_1;

--ordenacao de ordem decrescente
SELECT nome_coluna_1, nome_coluna_2 FROM nome_tabela ORDER BY nome_coluna_1 DESC;

--ordenacao de ordem crescente a nome_coluna_1 e decrescente a nome_coluna_2
SELECT nome_coluna_1, nome_coluna_2 FROM nome_tabela ORDER BY nome_coluna_1 ASC, nome_coluna_2 DESC;

--consultando o tamanho da String com o LENGTH() com ordenacao de ordem decrescente
SELECT nome_coluna_1, LENGTH(nome_coluna_1) alias_name FROM nome_tabela ORDER BY alias_name DESC;

--consultando os valores null em ordenacao crescente
SELECT nome_coluna_1 FROM nome_tabela ORDER BY nome_coluna_1 NULLS FIRST;

--consultando os valores null em ordenacao decrescente
SELECT nome_coluna_1 FROM nome_tabela ORDER BY nome_coluna_1 NULLS LAST;
