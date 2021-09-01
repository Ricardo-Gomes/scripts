--SELECT DISTINCT 

--remover linhas duplicadas retornada por uma consulta de uma coluna.
SELECT DISTINCT nome_coluna_1 FROM nome_tabela;

--remover linhas duplicadas retornada por uma consulta de varias colunas.
SELECT DISTINCT nome_coluna_1, nome_coluna_2 FROM nome_tabela;

--consulta removendo linhas duplicadas somente na nome_coluna_1 com ordenação
SELECT DISTINCT ON (nome_coluna_1) nome_coluna_1, nome_coluna_2 FROM nome_tabela ORDER BY nome_coluna_1, nome_coluna_2;
























