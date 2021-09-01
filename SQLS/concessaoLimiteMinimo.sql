--testando a consulta que verifica o tempo de trabalho do funcionario e se a empresa
--tem carência ou não
select count(*)
from sc_opr.tbl_crt crt
  inner join sc_cad.tbl_fnc fnc on fnc.cd_fnc = crt.cd_fnc
  inner join sc_cad.tbl_ctr ctr on crt.cd_ctr = ctr.cd_ctr
where coalesce(fnc.dt_adm_fnc, crt.dt_pri_dps_crt) > current_date - interval '90 day'
 and ctr.fg_car_lmt_ctr = 'S'
 and crt.cd_crt = 60586897404891;

--comando para atualizar o limite de todos os contratos
 select sc_opr.atualiza_limite_todos_contratos();

--consulta que mostra os percentuais de limite de uma determinada empresa        
select ctr.cd_ctr,  tc.cd_tlt, tc.pr_lmt, ctr.fg_car_lmt_ctr, f.cd_fem, f.cd_emp
from sc_cad.tbl_fem_ctr f 
     inner join sc_cad.tbl_ctr ctr on ctr.cd_ctr = f.cd_ctr
     left join sc_cad.tbl_tlt_ctr tc on tc.cd_fem_ctr = f.cd_fem_ctr
where /*f.cd_ctr = 780
  and*/ f.fg_atv_fem_ctr = 'S'
  and ctr.cd_emp = 750;
                       
select * from sc_opr.tbl_tlt;
select * from sc_opr.tbl_lmt where cd_crt = 60586878246890

--testando a alteração de limite de um cartão
select sc_opr.atualiza_limite_cartao(60586878246890, 2, 17.5);

--atualizando o limite de um contrato
select sc_opr.atualiza_limite_contrato(801, null);

--selecionando todos os cartões que receberam limite minimo
select emp.cd_emp || ' - ' || emp.nm_emp as empresa, 
       count(*) as qtde, sum(hlm.vl_cnc_lmt_atl) as valor_limite 
from sc_opr.tbl_hlm hlm
     inner join sc_opr.tbl_crt crt on hlm.cd_crt = crt.cd_crt
     inner join sc_cad.tbl_fnc fnc on crt.cd_fnc = fnc.cd_fnc
     inner join sc_cad.tbl_emp emp on fnc.cd_emp = emp.cd_emp
where hlm.dt_inc_usr >= current_date 
  and hlm.vl_cnc_lmt_atl = 200 
  and hlm.vl_cnc_lmt_ant = 0
group by emp.cd_emp, emp.nm_emp
order by qtde desc;

--listando todos os cartões selecionados para a alteração de limite
select hfe.cd_emp, hfe.cd_fem, crt.cd_crt, count(*) as qtde
from sc_adp.tbl_hfe hfe
     inner join sc_adp.tbl_rdp rdp on hfe.cd_hfe = rdp.cd_hfe
     inner join sc_opr.tbl_crt crt on rdp.cd_crt = crt.cd_crt
     inner join sc_cad.tbl_ctr ctr on crt.cd_ctr = ctr.cd_ctr
     inner join sc_cad.tbl_fnc fnc on fnc.cd_fnc = crt.cd_fnc
     left join sc_opr.tbl_lmt lmt on lmt.cd_crt = crt.cd_crt and lmt.cd_tlt = 1
where lmt.fg_alt_lmt = 'S'
  --and hfe.cd_ctr = vp_codigo_contrato
  and hfe.cd_emp = 750
  --and hfe.cd_fem = 1 
  --and hfe.cd_fem = vl_rg_ctr.cd_fem
  and hfe.st_hfe = 5
  and rdp.st_rdp = 5
  and rdp.cd_tdp in (1, 8)
  and hfe.dt_dps_hfe >= '2019-12-01'
  and hfe.dt_dps_hfe < current_date
  and (COALESCE(fnc.dt_adm_fnc, crt.dt_pri_dps_crt) > current_date - interval '90 day' and ctr.fg_car_lmt_ctr = 'S')
group by hfe.cd_emp, hfe.cd_fem, crt.cd_crt;