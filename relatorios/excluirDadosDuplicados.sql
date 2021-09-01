--consulta de dados duplicados
select count(nome_coluna_1), nome_coluna_1 from nome_tabela_1 group by nome_coluna_1 having count(nome_coluna_1) > 1;


--DELETE FROM tablename
DELETE FROM nome_tabela_1
WHERE id IN (SELECT id
              FROM (SELECT id,
                             ROW_NUMBER() OVER (partition BY nome_coluna_1 ORDER BY id) AS alias_name
                     FROM nome_tabela_1) t
              WHERE t.alias_name > 1) AND ID IN (SELECT ID FROM nome_tabela_1 WHERE ID NOT IN (SELECT nome_tabela_1_ID FROM nome_tabela_2));

              SELECT ID FROM nome_tabela_1 WHERE ID NOT IN (SELECT nome_tabela_1_ID FROM nome_tabela_2);