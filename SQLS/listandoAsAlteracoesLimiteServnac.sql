--alteracao de limite - visao sintetica
select gem.cd_gem as codigo_grupo, gem.nm_gem as grupo, 
       grt.cd_grt as codigo_gerente, grt.nm_grt as gerente, 
       emp.cd_emp as codigo_empresa, emp.nm_emp as empresa, 
       tlt.cd_tlt as codigo_tipo_limite, tlt.nm_tlt as tipo_limite, 
       count(distinct crt.cd_crt) as qtde, 
       sum(case when hlm.vl_cnc_lmt_atl = 0 and gem.cd_gem = 249 and hlm.dt_inc_usr >= to_date('2019-08-30', 'yyyy-mm-dd') + interval '18 hours' then hlm.vl_cnc_lmt_ant - hlm.vl_cnc_lmt_atl else 0 end) as reducao_zerados, 
       sum(case when hlm.vl_cnc_lmt_atl > 0 or gem.cd_gem <> 249 or hlm.dt_inc_usr < to_date('2019-08-30', 'yyyy-mm-dd') + interval '18 hours' then hlm.vl_cnc_lmt_ant - hlm.vl_cnc_lmt_atl else 0 end) as reducao_contratos,
       sum(hlm.vl_cnc_lmt_ant - hlm.vl_cnc_lmt_atl) as reducao_total
from  sc_opr.tbl_hlm hlm
      inner join sc_opr.tbl_crt crt on hlm.cd_crt = crt.cd_crt
      inner join sc_cad.tbl_ctr ctr on crt.cd_ctr = ctr.cd_ctr
      inner join sc_cad.tbl_emp emp on ctr.cd_emp = emp.cd_emp
      inner join sc_cad.tbl_gem gem on emp.cd_gem = gem.cd_gem
      inner join sc_cad.tbl_grt grt on ctr.cd_grt = grt.cd_grt
      inner join sc_opr.tbl_tlt tlt on tlt.cd_tlt = hlm.cd_tlt
where hlm.dt_inc_usr >= '2019-08-30'
  --and hlm.vl_cnc_lmt_atl > 0
group by gem.cd_gem, grt.cd_grt, emp.cd_emp, tlt.cd_tlt, grt.nm_grt, gem.nm_gem, emp.nm_emp, tlt.nm_tlt
having sum(hlm.vl_cnc_lmt_atl) - sum(hlm.vl_cnc_lmt_ant) < 0
order by grupo, gerente, empresa;

--alteracao de limite - visao analitica
select gem.cd_gem as codigo_grupo, gem.nm_gem as grupo, 
       grt.cd_grt as codigo_gerente, grt.nm_grt as gerente, 
       emp.cd_emp as codigo_empresa, emp.nm_emp as empresa, 
       tlt.cd_tlt as codigo_tipo_limite, tlt.nm_tlt as tipo_limite, 
       crt.cd_crt as cartao,
       hlm.dt_usr_inc as data_alteracao, 
       hlm.vl_cnc_lmt_ant as limite_anterior,
       hlm.vl_cnc_lmt_atl as novo_limite
from  sc_opr.tbl_hlm hlm
      inner join sc_opr.tbl_crt crt on hlm.cd_crt = crt.cd_crt
      inner join sc_cad.tbl_ctr ctr on crt.cd_ctr = ctr.cd_ctr
      inner join sc_cad.tbl_emp emp on ctr.cd_emp = emp.cd_emp
      inner join sc_cad.tbl_gem gem on emp.cd_gem = gem.cd_gem
      inner join sc_cad.tbl_grt grt on ctr.cd_grt = grt.cd_grt
      inner join sc_opr.tbl_tlt tlt on tlt.cd_tlt = hlm.cd_tlt
where hlm.dt_inc_usr >= '2019-08-30'
  and hlm.vl_cnc_lmt_atl < hlm.vl_cnc_lmt_ant
order by grupo, gerente, empresa, cartao;
