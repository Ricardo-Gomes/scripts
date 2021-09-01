--transferencias bancárias
select to_char(dt_env_tba, 'mm/yyyy') as mes,
       count(*) as qtde_total, 
       sum(vl_tba) as valor_total,
       sum(case when vl_trf_tba > 0 then 1 else 0 end) as qtde_cobrada,
       sum(case when vl_trf_tba > 0 then vl_tba else 0 end) as vl_transferido_cobrada,
       sum(case when vl_trf_tba > 0 then vl_trf_tba else 0 end) as vl_tarifa,
       sum(case when vl_trf_tba > 0 then 0 else 1 end) as qtde_abonada,
       sum(case when vl_trf_tba > 0 then 0 else vl_tba end) as vl_transferido_abonado
from sc_atb.tbl_tba tba
where dt_env_tba >= '2019-01-01'
  and cd_sst = 11 -- sistema de transferencia bancária
group by to_char(dt_env_tba, 'mm/yyyy')
order by mes;

--saques
select to_char(dt_opr, 'mm/yyyy') as mes,
       (case when opr.cd_atm = 3 then 'SAQUE E PAGUE' when opr.cd_atm is null then 'TEF' else 'ATM PROPRIO' end) as origem, 
       count(*) as qtde_total,
       sum(vl_opr) as valor_total,
       sum(case when vl_trf_opr > 0 then 1 else 0 end) as qtde_cobrada,
       sum(case when vl_trf_opr > 0 then vl_opr else 0 end) as vl_sacado_cobrada,
       sum(case when vl_trf_opr > 0 then vl_trf_opr else 0 end) as vl_tarifa,
       sum(case when vl_trf_opr > 0 then 0 else 1 end) as qtde_abonada,
       sum(case when vl_trf_opr > 0 then 0 else vl_opr end) as vl_sacadodo_abonado
from sc_opr.tbl_opr opr
where dt_opr >= '2019-01-01'
  and cd_top = 4 -- tipo de operação de SAQUE
  and st_opr = 2
group by to_char(dt_opr, 'mm/yyyy'), (case when opr.cd_atm = 3 then 'SAQUE E PAGUE' when opr.cd_atm is null then 'TEF' else 'ATM PROPRIO' end)
order by mes, origem;

--cobrança de pacote de serviço
select to_char(tsc.dt_pgto_tsc, 'mm/yyyy') as mes, 
       count(*) as qtde_total, sum(tsc.vl_tsc) as valor_total,
       sum(case when tsc.vl_tsc = 3.5 then 1 else 0 end) as qtde_3_50,
       sum(case when tsc.vl_tsc = 3.5 then tsc.vl_tsc else 0 end) as valor_3_50,
       sum(case when tsc.vl_tsc = 4.99 then 1 else 0 end) as qtde_4_99,
       sum(case when tsc.vl_tsc = 4.99 then tsc.vl_tsc else 0 end) as valor_4_99,
       sum(case when tsc.vl_tsc = 5 then 1 else 0 end) as qtde_5_00,
       sum(case when tsc.vl_tsc = 5 then tsc.vl_tsc else 0 end) as valor_5_00,
       sum(case when tsc.vl_tsc = 5.90 then 1 else 0 end) as qtde_5_90,
       sum(case when tsc.vl_tsc = 5.90 then tsc.vl_tsc else 0 end) as valor_5_90,
       sum(case when tsc.vl_tsc = 5.99 then 1 else 0 end) as qtde_5_99,
       sum(case when tsc.vl_tsc = 5.99 then tsc.vl_tsc else 0 end) as valor_5_99,
       sum(case when tsc.vl_tsc = 9.9 then 1 else 0 end) as qtde_9_90,
       sum(case when tsc.vl_tsc = 9.9 then tsc.vl_tsc else 0 end) as valor_9_90,
       sum(case when tsc.vl_tsc = 9.99 then 1 else 0 end) as qtde_9_99,
       sum(case when tsc.vl_tsc = 9.99 then tsc.vl_tsc else 0 end) as valor_9_99,
       sum(case when tsc.vl_tsc = 12.9 then 1 else 0 end) as qtde_12_90,
       sum(case when tsc.vl_tsc = 12.9 then tsc.vl_tsc else 0 end) as valor_12_90,
       sum(case when tsc.vl_tsc = 19.9 then 1 else 0 end) as qtde_19_90,
       sum(case when tsc.vl_tsc = 19.9 then tsc.vl_tsc else 0 end) as valor_19_90
from sc_srv.tbl_tsc tsc
where tsc.dt_pgto_tsc >= '2019-01-01'
  and tsc.st_tsc = 2 -- tarifas cobradas
  and tsc.cd_srv = 12 -- TSM
group by to_char(tsc.dt_pgto_tsc, 'mm/yyyy')
order by mes;

--receita fatura de PJ
select to_char(fep.dt_vnc_fep, 'mm/yyyy') as mes, 
       count(distinct fep.cd_fep) as qtde_total,
       sum(fep_sfe.vl_ttl_fep_sfe) as valor_total, 
       count(distinct (case when sfe.cd_sfe = 3 then fep.cd_fep else null end)) as qtde_trf_deposito,
       sum(case when sfe.cd_sfe = 3 then fep_sfe.vl_ttl_fep_sfe else 0 end) as valor_trf_deposito,
       count(distinct (case when sfe.cd_sfe = 9 then fep.cd_fep else null end)) as qtde_trf_deposito_2,
       sum(case when sfe.cd_sfe = 9 then fep_sfe.vl_ttl_fep_sfe else 0 end) as valor_trf_deposito_2,
       count(distinct (case when sfe.cd_sfe = 18 then fep.cd_fep else null end)) as qtde_trf_saque,
       sum(case when sfe.cd_sfe = 18 then fep_sfe.vl_ttl_fep_sfe else 0 end) as valor_trf_saque,
       count(distinct (case when sfe.cd_sfe = 4 then fep.cd_fep else null end)) as qtde_trf_liberacao_imediata,
       sum(case when sfe.cd_sfe = 4 then fep_sfe.vl_ttl_fep_sfe else 0 end) as valor_trf_liberacao_imediata,
       count(distinct (case when sfe.cd_sfe = 1 then fep.cd_fep else null end)) as qtde_trf_1_via,
       sum(case when sfe.cd_sfe = 1 then fep_sfe.vl_ttl_fep_sfe else 0 end) as valor_trf_1_via,
       count(distinct (case when sfe.cd_sfe = 5 then fep.cd_fep else null end)) as qtde_complemento_minimo,
       sum(case when sfe.cd_sfe = 5 then fep_sfe.vl_ttl_fep_sfe else 0 end) as valor_complemento_minimo
from sc_fep.tbl_sfe sfe
     inner join sc_fep.tbl_fep_sfe fep_sfe on sfe.cd_sfe = fep_sfe.cd_sfe
     inner join sc_fep.tbl_fep fep on fep.cd_fep = fep_sfe.cd_fep
where fep.dt_vnc_fep >= '2019-01-01'
  and fep.st_fep = 2 -- fatura paga
  and fep_sfe.fg_dcr_fep_sfe = 'C'
group by to_char(fep.dt_vnc_fep, 'mm/yyyy')
order by mes;


--saque extra, compras, pagamento de contas e recarga de celular
select to_char(dt_opr, 'mm/yyyy') as mes,
       (case when opr.cd_atm = 3 then 'SAQUE E PAGUE' when opr.cd_atm is null then 'TEF' else 'ATM PROPRIO' end) as origem, 
       top.nm_top as tipo_operacao,
       count(*) as qtde,
       sum(vl_opr - coalesce(vl_trf_opr + vl_jrs_opr + vl_iof_opr, 0)) as valor_principal,
       sum(vl_trf_opr) as valor_tarifa,
       sum(vl_jrs_opr) as valor_juros,
       sum(vl_iof_opr) as valor_iof,
       sum(vl_tx_adm_opr) as valor_taxa_adm
from sc_opr.tbl_opr opr
     inner join sc_opr.tbl_top top on opr.cd_top = top.cd_top
where opr.dt_opr >= '2019-01-01'
  and opr.cd_top in (5, 25, 27, 20, 22) -- tipo de operação de SAQUE EXTRA, COMPRA, PAGAMENTO DE CONTA, RECARGA DE CELULAR
  and opr.st_opr = 2
group by to_char(dt_opr, 'mm/yyyy'), (case when opr.cd_atm = 3 then 'SAQUE E PAGUE' when opr.cd_atm is null then 'TEF' else 'ATM PROPRIO' end), top.nm_top
order by mes, origem, tipo_operacao;

--consulta de saldo, consulta de extrato e saque arredondado
select to_char(dt_opr, 'mm/yyyy') as mes,
       (case when opr.cd_atm = 3 then 'SAQUE E PAGUE' when opr.cd_atm is null then 'TEF' else 'ATM PROPRIO' end) as origem, 
       top.nm_top as tipo_operacao,
       count(*) as qtde,
       sum(vl_opr - coalesce(vl_trf_opr + vl_jrs_opr + vl_iof_opr, 0)) as valor_principal,
       sum(vl_trf_opr) as valor_tarifa,
       sum(vl_jrs_opr) as valor_juros,
       sum(vl_iof_opr) as valor_iof
from sc_opr.tbl_opr opr
     inner join sc_opr.tbl_top top on opr.cd_top = top.cd_top
where opr.dt_opr >= '2019-01-01'
  and opr.cd_top in (1, 2, 19) -- tipo de operação de CONSULTA DE SALDO, CONSULTA DE EXTRATO, SAQUE ARREDONDADO
  and opr.st_opr = 2
group by to_char(dt_opr, 'mm/yyyy'), (case when opr.cd_atm = 3 then 'SAQUE E PAGUE' when opr.cd_atm is null then 'TEF' else 'ATM PROPRIO' end), top.nm_top
order by mes, origem, tipo_operacao;

--segunda via de cartão e solicitação de senha
select to_char(dt_opr, 'mm/yyyy') as mes,
       top.nm_top as tipo_operacao,
       count(*) as qtde,
       avg(vl_opr) as valor_medio,
       sum(vl_opr) as valor_total
from sc_opr.tbl_opr opr
     inner join sc_opr.tbl_top top on opr.cd_top = top.cd_top
where opr.dt_opr >= '2019-01-01'
  and opr.cd_top in (11, 17) -- tipo de operação de SEGUNDA VIA DE CARTÃO e SOLICITAÇÃO DE SENHA
  and opr.st_opr = 2
group by to_char(dt_opr, 'mm/yyyy'), top.nm_top
order by mes, tipo_operacao;

select * from sc_cad.tbl_dmn where nm_cmp_dmn = 'ST_FEP'
select * from sc_opr.tbl_top order by nm_top;

select * from sc_opr.tbl_opr where dt_opr >= '2019-10-01' and cd_top in (25, 27) and st_opr = 2 limit 10 

select * from sc_cnt.tbl_sst where cd_sst in (34, 11);
select * from sc_rds.tbl_atm where cd_sst in (34, 11);

select to_char(dt_env_tba, 'mm/yyyy') as mes, count(*) as qtde, sum(vl_tba) as valor_transferido, sum(vl_trf_tba) as total_tarifa, avg(vl_trf_tba) as media
from sc_atb.tbl_tba tba
where vl_trf_tba = 0
  and dt_env_tba >= '2019-01-01'
group by to_char(dt_env_tba, 'mm/yyyy')
order by mes