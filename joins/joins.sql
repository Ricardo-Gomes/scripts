--JOINS

--INNER JOIN 
SELECT * FROM nome_tabela_1 
INNER JOIN nome_tabela_2 
ON nome_tabela_1_ID = nome_tabela_2_ID

--INNER JOIN COM ALIAS
SELECT e.first_name employee, m.first_name manager
FROM employee e 
INNER JOIN employee m 
ON m.employee_id = e.manager_id
ORDER BY manager;

--RIGHT JOIN
SELECT * FROM nome_tabela_1
RIGHT JOIN nome_tabela_2
ON nome_tabela_1_ID = nome_tabela_2_ID

--RIGHT JOIN ONDE O VALOR E NULL
SELECT * FROM nome_tabela_1
RIGHT JOIN nome_tabela_2
ON nome_tabela_1_ID = nome_tabela_2_ID
WHERE nome_tabela_1_ID IS NULL

--FULL JOIN
SELECT * FROM nome_tabela_1
FULL JOIN nome_tabela_2 
ON nome_tabela_1_ID = nome_tabela_2_ID

--FULL JOIN ONDE O VALOR DA PRIMEIRA TABELA OU A SEGUNDA TABELA E NULL
SELECT * FROM nome_tabela_1
FULL JOIN nome_tabela_2 
ON nome_tabela_1_ID = nome_tabela_2_ID
WHERE nome_tabela_1_ID IS NULL OR nome_tabela_2_ID IS NULL

--LEFT JOIN 
SELECT * FROM nome_tabela_1
LEFT JOIN nome_tabela_2
ON nome_tabela_1_ID = nome_tabela_2_ID

--LEFT JOIN ONDE O VALOR E NULL
SELECT * FROM nome_tabela_1
LEFT JOIN nome_tabela_2
ON nome_tabela_1_ID = nome_tabela_2_ID
WHERE nome_tabela_2_ID IS NULL


select p.product_name, p.unit_price , s.company_name
from products p
left join suppliers s
on  s.supplier_id = p.supplier_id
order by p.product_name

select v.id, v.placa, v.id_centro_distribuicao,cd.id, cd.nome, cd.bairro, cd.endereco
from veiculo v 
inner join centrodistribuicao cd
on cd.id = v.id_centro_distribuicao order by v.id


select veiculo.id_centro_distribuicao from veiculo where veiculo.id_centro_distribuicao notnull
select * from centrodistribuicao where id = 2 

select o.nomevendedor,o.datapedido, c.codigocliente, c.id
from ordem o
inner join cliente c
on c.id = o.id_cliente order by o.nomevendedor,o.datapedido

select * from ordem  

select * from cliente where razaosocial like 'BEATRIZ LIMA%'

--FAZENDO SELECTS

select * from food_lite.produto
select * from food_lite.restaurante

SELECT table1.column1, table2.column2...
FROM table1
INNER JOIN table2
ON table1.common_filed = table2.common_field;

select restaurante.id, restaurante.nome,produto.id, produto.nome
from food_lite.restaurante
inner join food_lite.produto 
on food_lite.restaurante.id = food_lite.produto.id 
where produto.nome = 'Feijão Tropeiro'

select * from food_lite.produto inner join food_lite.restaurante on food_lite.produto.id_restaurante = food_lite.restaurante.id

select restaurante.id, restaurante.nome,produto.id, produto.nome
from food_lite.restaurante
inner join food_lite.produto 
on food_lite.restaurante.id = food_lite.produto.id 
where food_lite.produto.nome 'Feijão Tropeiro'


-- Lista de restaurantes de Vendem “Feijão tropeiro”
select r.id as id_restaurante, r.nome as nome_restaurante, p.id as id_produto , p.nome as nome_produto
from food_lite.produto  
as p
inner join food_lite.restaurante 
as r on r.id = p.id_restaurante 
where p.nome = 'Feijão Tropeiro' 

-- Lista de Produtos com preço por restaurante, ordenado em ordem alfabética pelo nome do restaurante
select r.nome as nome_restaurante, p.nome 
as nome_produto, p.valor_unitario as preco
from food_lite.produto as p
inner join food_lite.restaurante 
as r on r.id = p.id_restaurante order by p.nome

--Todos os produtos cujos preços são menores que 20 reais
select * from food_lite.produto where valor_unitario < 20

--Nome de todos os clientes que fizeram pedidos no restaurante de CNPJ 40523233000193
select * from food_lite.cliente
select * from food_lite.pedido
select * from food_lite.restaurante

select c.id as id_cliente, c.nome as nome_cliente,
p.id as id_pedido,
r.id as id_restaurante, r.nome as nome_restaurante, r.cnpj as cnpj_restaurante
from food_lite.cliente as c
inner join food_lite.pedido as p on c.id = p.id_cliente
inner join food_lite.restaurante as r on r.id = p.id_restaurante
where r.cnpj = '40523233000193'

--Listagem dos pedidos que receberam pagamento em cartão de crédito
select * from food_lite.pedido
select * from food_lite.pagamento
select * from food_lite.tipo_pagamento
update food_lite.tipo_pagamento set descricao = 'cartao credito' where id = 1

select p.id as id_pedido,
pag.id as id_pagamento, pag.id_tipo_pagamento ,
tp.descricao as descricao
from food_lite.pedido as p
join food_lite.pagamento as pag on p.id = pag.id_pedido
join food_lite.tipo_pagamento as tp on tp.id = pag.id_tipo_pagamento
where tp.descricao = 'cartao credito'

select p.id as pedido,
pag.id_tipo_pagamento as tipo_pagamento,
tp.descricao as descricao
from food_lite.pedido as p
join food_lite.pagamento as pag on p.id = pag.id_pedido
join food_lite.tipo_pagamento as tp on tp.id = pag.id_tipo_pagamento
where tp.descricao = 'cartao credito'

select * from food_lite.cliente
--trazendo as iniciais e a quantidade que se repete
select substring(c.nome, 1,1) inicial, count (*) from food_lite.cliente c Group by substring (c.nome,1,1)

select nome, count(*) from food_lite.cliente group by nome

--relação de cartões ativos sem operação de pagamento de contas nos ultimos 3 meses
select gem.nm_gem as grupo_empresarial, 
       emp.nm_emp as empresa, 
       crt.cd_crt as cartao,
       cun.nm_cun as nome,
       cm.qtde_mes_deposito,
       cm.qtde_mes_ativacao
from sc_opr.tbl_crt crt
     inner join sc_cad.tbl_fnc fnc on crt.cd_fnc = fnc.cd_fnc
     inner join sc_cad.tbl_cun cun on fnc.cd_cun = cun.cd_cun
     inner join sc_cad.tbl_emp emp on fnc.cd_emp = emp.cd_emp
     inner join sc_cad.tbl_gem gem on emp.cd_gem = gem.cd_gem
     inner join sc_analise.tbl_cartoes_mes cm on crt.cd_crt = cm.cartao and cm.mes = 7 and cm.ano = 2019
where cm.ativo = 'S'
  and not exists (select 1
                  from sc_opr.tbl_opr opr
                       inner join sc_opr.tbl_pls pls on opr.cd_pls = pls.cd_pls
                  where opr.dt_opr >= current_date - interval '3 months' -- operacoes realizadas nos ultimos 3 meses
                    and opr.st_opr = 2 --operacoes confirmadas
                    and opr.cd_top = 22 -- operacoes do tipo pagamento de contas
                    and pls.cd_crt = crt.cd_crt)
order by qtde_mes_deposito desc, grupo_empresarial, empresa, nome;

















