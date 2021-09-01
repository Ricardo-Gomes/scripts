--SELECT WHERE

--consulta com o filtro para a nome_coluna_2 com um valor igual ao informado
SELECT nome_coluna_1, nome_coluna_2 FROM nome_tabela WHERE nome_coluna_2 = 'valor_da_coluna';

--consulta com o filtro para a nome_coluna_1 E(AND) nome_coluna_2 com um valor igual ao informado
SELECT nome_coluna_1, nome_coluna_2 FROM nome_tabela WHERE nome_coluna_1 = 'valor_da_coluna' AND nome_coluna_2 = 'valor_da_coluna';

--consulta com o filtro para a nome_coluna_1  E(AND) nome_coluna_2 com um valor igual ao informado
SELECT nome_coluna_1, nome_coluna_2 FROM nome_tabela WHERE nome_coluna_1 = 'valor_da_coluna' AND nome_coluna_2 = 'valor_da_coluna';

--consulta com o filtro para a nome_coluna_1 OU(OR) nome_coluna_2 com um valor igual ao informado
SELECT nome_coluna_1, nome_coluna_2 FROM nome_tabela WHERE nome_coluna_1 = 'valor_da_coluna' OR nome_coluna_2 = 'valor_da_coluna';

--consulta com filtro para varios valores
SELECT nome_coluna_1, nome_coluna_2 FROM nome_tabela WHERE nome_coluna_1 IN ('valor_da_coluna','valor_da_coluna','valor_da_coluna');

--consulta com o filtro para a nome_coluna_1 com LIKE
SELECT nome_coluna_1, nome_coluna_2 FROM nome_tabela WHERE nome_coluna_1 LIKE 'valor_da_coluna%'

--consulta com filtros nome_coluna_1 com LIKE e contendo de 3 a 5 caracteres usando o BETWEEN
SELECT nome_coluna_1, LENGTH(nome_coluna_1) alias_name 
FROM nome_tabela 
WHERE nome_coluna_1 LIKE 'valor_da_coluna%' AND LENGTH(nome_coluna_1) BETWEEN 3 AND 5
ORDER BY alias_name;

--consulta com filtros nome_coluna_1 com LIKE e DIFERENTE(<>) da nome_coluna_2
SELECT nome_coluna_1, nome_coluna_2 FROM nome_tabela 
WHERE nome_coluna_1 LIKE 'valor_da_coluna%' AND nome_coluna_2 <> 'valor_da_coluna';















