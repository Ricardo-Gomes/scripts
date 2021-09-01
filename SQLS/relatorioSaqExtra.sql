--consulta de atm
select * from sc_rds.tbl_atm order by nm_atm;

--saque extra, compras, pagamento de contas e recarga de celular
select to_char(dt_opr, 'mm/yyyy') as mes,
           atm.nm_atm as atm,
       count(*) as qtde,
       sum(vl_opr - coalesce(vl_trf_opr + vl_jrs_opr + vl_iof_opr, 0)) as valor_principal,
       sum(vl_trf_opr) as valor_tarifa,
       sum(vl_jrs_opr) as valor_juros,
       sum(vl_iof_opr) as valor_iof
from sc_opr.tbl_opr opr
     inner join sc_opr.tbl_top top on opr.cd_top = top.cd_top
     inner join sc_rds.tbl_atm atm on opr.cd_atm = atm.cd_atm
where opr.dt_opr >= '2019-01-01'
  and opr.dt_opr < '2020-01-01'
  and opr.cd_top in (5) -- tipo de operação de SAQUE EXTRA
  and opr.st_opr = 2
  and opr.cd_atm in (61, 77, 43, 42) --adicionar os atms das lojas
group by to_char(dt_opr, 'mm/yyyy'), atm.nm_atm
order by mes, atm; 





