--SELECT

--consultar os dados da coluna de uma tabela.
SELECT nome_coluna_1 FROM nome_tabela;

 --consultar os dados das colunas de uma tabela.
SELECT nome_coluna_1, nome_coluna_2, nome_coluna_3, ... FROM nome_tabela; 

--consultar os dados de todas as colunas de uma tabela.
SELECT * FROM nome_tabela;

--concatenando duas colunas de uma tabela
SELECT nome_coluna_1 || ' ' || nome_coluna_2, nome_coluna_3 FROM nome_tabela;

--consultar com um alias
SELECT nome_coluna_1 AS alias_name FROM nome_tabela;

--consultar com um alias com AS opcional
SELECT nome_coluna_1 alias_name FROM nome_tabela;

--consultar com um alias com uma expressão
SELECT expressão AS alias_name FROM nome_tabela;

--concatenando duas colunas de uma tabela com Alias
SELECT nome_coluna_1 || ' ' || nome_coluna_2 AS alias_name FROM nome_tabela;

--https://www.postgresqltutorial.com/postgresql-limit/

select p.product_name , p.supplier_id , s.company_name
from public.products p, public.suppliers s
where p.supplier_id = s.supplier_id and p.supplier_id = 1
order by product_id asc

--select count (product_name) from public.products