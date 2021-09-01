--relatorio de cadastro 
select n1.nome_coluna_1, n1.nome_coluna_2, n1.nome_coluna_3, n2.nome_coluna_1 as alias_name,
	n3.nome_coluna_1 as alias_name, 
	n1.nome_coluna_4, n1.nome_coluna_5, n1.nome_coluna_6, n1.nome_coluna_7, n1.nome_coluna_8, n1.nome_coluna_9, n1.nome_coluna_10, n1.nome_coluna_12
from nome_tabela_1 n1
left join nome_tabela_2 n2 on n1.nome_tabela_2 = n2.id
left join nome_tabela_3 n3 on n1.id_nome_tabela_3 = n3.id;