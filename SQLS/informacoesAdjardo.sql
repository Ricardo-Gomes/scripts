--Quantidade de cartões ativos em 08/2018: 22.431
--Quantidade de cpfs ativos em 08/2018: 22.369

--Quantidade de cartões ativos em 08/2018, com limite de saque extra: 15.517
--Quantidade de cpfs ativos em 08/2018, com limite de saque extra: 15.509

--Quantidade de cartões ativos em 08/2019: 24.528
--Quantidade de cpfs ativos em 08/2019: 24.455

--Quantidade de cartões ativos em 08/2018, com limite de saque extra: 16.484
--Quantidade de cpfs ativos em 08/2018, com limite de saque extra: 16.470
select count(distinct crt.cd_crt) as qtde_cartoes,
       count(distinct fnc.cd_cun) as qtde_cadastro_unico,
       avg(cm.qtde_mes_deposito) as media_meses_deposito
from sc_analise.tbl_cartoes_mes cm
     inner join sc_opr.tbl_crt crt on cm.cartao = crt.cd_crt
     inner join sc_cad.tbl_fnc fnc on crt.cd_fnc = fnc.cd_fnc
where mes = 8 
  and ano = 2019 
  and ativo = 'S'
  and sc_opr.get_limite_concedido_tempo(crt.cd_crt, 1, '2019-08-31') > 0;

--Quantidade de novos cartoes emitidos de 01/09/2018 a 31/08/2019: 14.685
--Quantidade de novos cpfs emitidos de 01/09/2018 a 31/08/2019: 14.308
select count(distinct crt.cd_crt) as qtde_cartoes,
       count(distinct fnc.cd_cun) as qtde_cadastro_unico
from sc_opr.tbl_crt crt
     inner join sc_cad.tbl_fnc fnc on crt.cd_fnc = fnc.cd_fnc
where crt.dt_inc_usr >= '2018-09-01' 
  and crt.dt_inc_usr < '2019-09-01'
  and not exists (select 1 
                  from sc_cad.tbl_fnc fnc2
                  where fnc2.cd_cun = fnc.cd_cun
                    and fnc2.dt_inc_usr < '2018-09-01');
                    
--Quantidade de novos cartoes emitidos e ativados de 01/09/2018 a 31/08/2019: 13.688
--Quantidade de novos cpfs emitidos e ativados de 01/09/2018 a 31/08/2019: 13.411
select count(distinct crt.cd_crt) as qtde_cartoes,
       count(distinct fnc.cd_cun) as qtde_cadastro_unico
from sc_opr.tbl_crt crt
     inner join sc_cad.tbl_fnc fnc on crt.cd_fnc = fnc.cd_fnc
where crt.dt_inc_usr >= '2018-09-01' 
  and crt.dt_inc_usr < '2019-09-01'
  and crt.dt_pri_dps_crt is not null
  and not exists (select 1 
                  from sc_cad.tbl_fnc fnc2
                  where fnc2.cd_cun = fnc.cd_cun
                    and fnc2.dt_inc_usr < '2018-09-01');

--Quantidade de novos cartoes emitidos, ativados e com limite de saque extra de 01/09/2018 a 31/08/2019: 7.498
--Quantidade de novos cpfs emitidos, ativados e com limite de saque extra de 01/09/2018 a 31/08/2019: 7.397
select count(distinct crt.cd_crt) as qtde_cartoes,
       count(distinct fnc.cd_cun) as qtde_cadastro_unico
from sc_opr.tbl_crt crt
     inner join sc_cad.tbl_fnc fnc on crt.cd_fnc = fnc.cd_fnc
where crt.dt_inc_usr >= '2018-09-01' 
  and crt.dt_inc_usr < '2019-09-01'
  and crt.dt_pri_dps_crt is not null
  and exists (select 1 
              from sc_opr.tbl_hlm hlm
              where crt.cd_crt = hlm.cd_crt
                and hlm.cd_tlt = 1
                and hlm.vl_cnc_lmt_atl > 0)
  and not exists (select 1 
                  from sc_cad.tbl_fnc fnc2
                  where fnc2.cd_cun = fnc.cd_cun
                    and fnc2.dt_inc_usr < '2018-09-01');

--Quantidade de novos cartoes emitidos, ativados, com limite de saque extra e que realizaram operação de 01/09/2018 a 31/08/2019: 3.456
--Quantidade de novos cpfs emitidos, ativados e com limite de saque extra e que realizaram operação de 01/09/2018 a 31/08/2019: 3.432
select count(distinct crt.cd_crt) as qtde_cartoes,
       count(distinct fnc.cd_cun) as qtde_cadastro_unico
from sc_opr.tbl_crt crt
     inner join sc_cad.tbl_fnc fnc on crt.cd_fnc = fnc.cd_fnc
     inner join sc_opr.tbl_pls pls on crt.cd_crt = pls.cd_crt
     inner join sc_opr.tbl_opr opr on pls.cd_pls = opr.cd_pls and opr.cd_top = 5 and opr.st_opr = 2
where crt.dt_inc_usr >= '2018-09-01' 
  and crt.dt_inc_usr < '2019-09-01'
  and crt.dt_pri_dps_crt is not null
  and exists (select 1 
              from sc_opr.tbl_hlm hlm
              where crt.cd_crt = hlm.cd_crt
                and hlm.cd_tlt = 1
                and hlm.vl_cnc_lmt_atl > 0)
  and not exists (select 1 
                  from sc_cad.tbl_fnc fnc2
                  where fnc2.cd_cun = fnc.cd_cun
                    and fnc2.dt_inc_usr < '2018-09-01');

--Quantidade de transações PRÉ-PAGO de 01/09/2018 a 31/08/2019: 516.349
--Quantidade de cartões com transações de 01/09/2018 a 31/08/2019: 34.908
--Quantidade de cpfs com transações de 01/09/2018 a 31/08/2019: 32.683
--Quantidade de operações por cartão: 15
--Valor médio das operacoes: 534,35
--Tipos de operações consideradas: SAQUE, COMPRA A DÉBITO e COMPRA A VISTA
select count(distinct crt.cd_crt) as qtde_cartoes,
       count(distinct fnc.cd_cun) as qtde_cpfs,
       count(distinct opr.cd_opr) as qtde_operacoes,
       count(distinct opr.cd_opr) / count(distinct crt.cd_crt) as qtde_transacoes_por_cartao,
       count(distinct opr.cd_opr) / count(distinct fnc.cd_cun) as qtde_transacoes_por_cpf,
       avg(opr.vl_opr) as valor_medio_operacoes
from sc_opr.tbl_crt crt
     inner join sc_cad.tbl_fnc fnc on crt.cd_fnc = fnc.cd_fnc
     inner join sc_opr.tbl_pls pls on crt.cd_crt = pls.cd_crt
     inner join sc_opr.tbl_opr opr on opr.cd_pls = pls.cd_pls
where opr.dt_opr >= '2018-09-01' 
  and opr.dt_opr < '2019-09-01'
  and opr.cd_top in (4, 25, 27);

--Quantidade de transações SAQUE EXTRA de 01/09/2018 a 31/08/2019: 120.639
--Quantidade de cartões com transações de 01/09/2018 a 31/08/2019: 16.181
--Quantidade de cpfs com transações de 01/09/2018 a 31/08/2019: 15.878
--Quantidade de operações por cartão: 7
--Valor médio das operacoes: 365,57
--Tipos de operações consideradas: SAQUE EXTRA
select count(distinct crt.cd_crt) as qtde_cartoes,
       count(distinct fnc.cd_cun) as qtde_cpfs,
       count(distinct opr.cd_opr) as qtde_operacoes,
       count(distinct opr.cd_opr) / count(distinct crt.cd_crt) as qtde_transacoes_por_cartao,
       count(distinct opr.cd_opr) / count(distinct fnc.cd_cun) as qtde_transacoes_por_cpf,
       avg(vl_opr - (vl_jrs_opr + vl_trf_opr + vl_iof_opr)) as valor_medio_operacoes
from sc_opr.tbl_crt crt
     inner join sc_cad.tbl_fnc fnc on crt.cd_fnc = fnc.cd_fnc
     inner join sc_opr.tbl_pls pls on crt.cd_crt = pls.cd_crt
     inner join sc_opr.tbl_opr opr on opr.cd_pls = pls.cd_pls
where opr.dt_opr >= '2018-09-01' 
  and opr.dt_opr < '2019-09-01'
  and opr.cd_top in (5);


select count(distinct crt.cd_crt) as qtde_cartoes,
       count(distinct fnc.cd_cun) as qtde_cadastro_unico
from sc_opr.tbl_crt crt
     inner join sc_cad.tbl_fnc fnc on crt.cd_fnc = fnc.cd_fnc
     inner join sc_analise.tbl_cartoes_mes cm on crt.cd_crt = cm.cartao and cm.mes = 8 and cm.ano = 2019
where crt.dt_inc_usr >= '2018-09-01' 
  and crt.dt_inc_usr < '2019-09-01'
  and cm.ativo = 'S'
  and crt.dt_pri_dps_crt is not null
  and not exists (select 1 
                  from sc_cad.tbl_fnc fnc2
                  where fnc2.cd_cun = fnc.cd_cun
                    and fnc2.dt_inc_usr < '2018-09-01');


