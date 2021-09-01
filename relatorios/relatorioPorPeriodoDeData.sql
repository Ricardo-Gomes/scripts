SELECT  n1.nome_coluna_1, 
	n2.nome_coluna_1,
	n1.nome_coluna_2,
	n1.nome_coluna_3,
	n1.nome_coluna_4,
	n1.nome_coluna_5,
	n1.nome_coluna_6,
	n1.nome_coluna_7,
	n1.nome_coluna_8,
	n1.nome_coluna_9,
	n1.nome_coluna_10,
	n1.nome_coluna_11,
	n1.nome_coluna_12,
	n1.nome_coluna_13, 
	n1.data
FROM nome_tabela_1 n1
LEFT JOIN nome_tabela_2 n2 ON n2.id = n1.nome_tabela_2_id WHERE n1.data BETWEEN '2018-01-15' AND  '2018-10-16' AND nome_coluna_13 = 'STRING'
ORDER BY n1.data;