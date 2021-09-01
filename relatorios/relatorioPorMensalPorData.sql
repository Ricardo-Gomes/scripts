--relatorio mensal por data 
SELECT 
n1.data as alias_name,
n1.data2 as alias_name,
n1.nome_coluna_1 as alias_name,
n1.nome_coluna_2 as alias_name,
n1.nome_coluna_3 as alias_name,
n3.placa as alias_name,
n2.nome_coluna_1 as alias_name,
n1.nome_coluna_4 as alias_name,
n2.nome_coluna_2 as alias_name,
n1.nome_coluna_5 as alias_name,
n1.nome_coluna_6 as alias_name, 
n1.nome_coluna_7 as alias_name,
n1.nome_coluna_8 as alias_name, 
n1.nome_coluna_9 as alias_name, 
n1.nome_coluna_10 as alias_name,
n1.nome_coluna_11 as alias_name,
n1.nome_coluna_12 as alias_name,
n1.nome_coluna_13 as alias_name, 
n1.nome_coluna_14 as alias_name, 
n1.nome_coluna_15 as alias_name
FROM nome_tabela_1 as n1 
INNER JOIN nome_tabela_2 as n2 ON (n1.id_nome_tabela_2 = n2.id)
INNER JOIN nome_tabela_3 as n3 ON (n1.nome_tabela_3 = n3.id)
WHERE n1.data BETWEEN '2020-07-01' AND '2020-07-15' and nome_coluna ='STRING' order by n1.data;