select trim(rat.nm_rat) as ramo_atividade,
       gem.nm_gem as grupo_empresarial,
       emp.nm_emp as empresa,
       crt.cd_crt as cartao,
       cun.nr_cpf_cnpj_cun as cpf,
       to_char(hfe.dt_dps_hfe, 'mm/yyyy') as mes,
       trim(tdp.nm_tdp) as tipo_deposito,
       sum(rdp.vl_dep_rdp) as valor_depositado
from sc_opr.tbl_crt crt
     inner join sc_cad.tbl_fnc fnc on crt.cd_fnc = fnc.cd_fnc
     inner join sc_cad.tbl_cun cun on fnc.cd_cun = cun.cd_cun
     inner join sc_cad.tbl_emp emp on fnc.cd_emp = emp.cd_emp
     inner join sc_cad.tbl_gem gem on emp.cd_gem = gem.cd_gem
     inner join sc_cad.tbl_rat rat on emp.cd_rat = rat.cd_rat
     inner join sc_adp.tbl_rdp rdp on crt.cd_crt = rdp.cd_crt
     inner join sc_adp.tbl_hfe hfe on rdp.cd_hfe = hfe.cd_hfe
     inner join sc_adp.tbl_tdp tdp on rdp.cd_tdp = tdp.cd_tdp
where hfe.dt_dps_hfe >= '2019-01-01'
  and hfe.st_hfe = 5 --situação depositado do arquivo de depósito
  and rdp.st_rdp = 5 --situação depositado do registro de depósito
  --and crt.cd_crt = 60586876660144
group by trim(rat.nm_rat), gem.nm_gem, emp.nm_emp, crt.cd_crt, cun.nr_cpf_cnpj_cun, to_char(hfe.dt_dps_hfe, 'mm/yyyy'), tdp.nm_tdp
order by cartao, mes, tipo_deposito;

select *--coalesce(max(cd_hlm), -1)
  from sc_opr.tbl_hlm
  where cd_crt = 60586876660144
    and cd_tlt = 1
    --and dt_inc_usr < '2019-02-02';
order by dt_inc_usr

select sc_opr.get_limite_concedido_tempo(60586876660144, 2, '2019-02-01')
--select auxiliares
     select * from sc_opr.tbl_top order by nm_top
     select * from sc_adp.tbl_rdp limit 10
     select * from sc_fcr.tbl_fcr limit 10
     select * from sc_opr.tbl_lmt limit 10
     select * from sc_fcr.tbl_fcr_tlt where cd_fcr = 915473
     select * from sc_cad.tbl_dmn where nm_cmp_dmn like '%TSC%'
     select * from sc_adp.tbl_hfe limit 10 order by nm_top

       