select trim(rat.nm_rat) as ramo_atividade,
       gem.nm_gem as grupo_empresarial,
       emp.nm_emp as empresa,
       crt.cd_crt as cartao,
       cun.nr_cpf_cnpj_cun as cpf,
       to_char(crt.dt_inc_usr, 'dd/MM/yyyy') as data_inclusao_cartao,
       to_char(crt.dt_pri_dps_crt, 'dd/MM/yyyy') as data_primeiro_deposito,
       to_char(crt.dt_ult_dps_crt, 'dd/MM/yyyy') as data_ultimo_deposito,
       case when crt.fg_atv_crt = 'S' then 'Ativo' else 'Inativo' end as status,
       mes.descricao as mes,
       coalesce(sc_opr.get_limite_concedido_tempo(crt.cd_crt, 1, (to_date('01/' || mes.descricao, 'dd/mm/yyyy') + interval '1 month')::date), 0) as limite_concedido_saque_extra,
       coalesce(opr.valor_saque_extra, 0) as valor_faturado_saque_extra,
       coalesce(opr.valor_pago_saque_extra, 0) as valor_pago_saque_extra,
       coalesce(sc_opr.get_limite_concedido_tempo(crt.cd_crt, 2, (to_date('01/' || mes.descricao, 'dd/mm/yyyy') + interval '1 month')::date), lmt.vl_cnc_lmt) as limite_concedido_compra,
       coalesce(opr.valor_compra, 0) as valor_faturado_compra,
       coalesce(opr.valor_pago_compra, 0) as valor_pago_compra,
       coalesce(dps.valor_depositado, 0) as valor_depositado,
       coalesce(trf.valor_tmc, 0) as valor_tmc
from sc_opr.tbl_crt crt
     left join sc_opr.tbl_lmt lmt on crt.cd_crt = lmt.cd_crt and lmt.cd_tlt = 2
     inner join sc_analise.tbl_mes mes on 1 = 1 and mes.ano = 2019 and mes.mes <= 12 
     inner join sc_cad.tbl_fnc fnc on crt.cd_fnc = fnc.cd_fnc
     inner join sc_cad.tbl_cun cun on fnc.cd_cun = cun.cd_cun
     inner join sc_cad.tbl_emp emp on fnc.cd_emp = emp.cd_emp
     inner join sc_cad.tbl_gem gem on emp.cd_gem = gem.cd_gem
     inner join sc_cad.tbl_rat rat on emp.cd_rat = rat.cd_rat
     left join (select sum(case when fcr_tlt.cd_tlt = 1 then fcr_tlt.vl_ttl_fcr_tlt else 0 end) as valor_saque_extra,
                       sum(case when fcr_tlt.cd_tlt = 2 then fcr_tlt.vl_ttl_fcr_tlt else 0 end) as valor_compra,
                       sum(case when fcr_tlt.cd_tlt = 1 then fcr_tlt.vl_ttl_fcr_tlt - fcr_tlt.vl_rst_fcr_tlt else 0 end) as valor_pago_saque_extra,
                       sum(case when fcr_tlt.cd_tlt = 2 then fcr_tlt.vl_ttl_fcr_tlt - fcr_tlt.vl_rst_fcr_tlt else 0 end) as valor_pago_compra,
                       fcr.cd_crt, to_char(fcr.dt_vnc_fcr, 'mm/yyyy') as mes
                from sc_fcr.tbl_fcr fcr
                     inner join sc_fcr.tbl_fcr_tlt fcr_tlt on fcr.cd_fcr = fcr_tlt.cd_fcr
                where fcr.dt_vnc_fcr >= '2019-01-01'
                  and fcr.st_fcr <> 3 --situação diferente de cancelada
                group by fcr.cd_crt, to_char(fcr.dt_vnc_fcr, 'mm/yyyy')) opr on crt.cd_crt = opr.cd_crt and mes.descricao = opr.mes
     left join (select sum(rdp.vl_dep_rdp) as valor_depositado,
                       rdp.cd_crt, to_char(hfe.dt_dps_hfe, 'mm/yyyy') as mes
                from sc_adp.tbl_rdp rdp
                     inner join sc_adp.tbl_hfe hfe on rdp.cd_hfe = hfe.cd_hfe
                where hfe.dt_dps_hfe >= '2019-01-01'
                  and hfe.st_hfe = 5 --situação depositado do arquivo de depósito
                  and rdp.st_rdp = 5 --situação depositado do registro de depósito
                group by rdp.cd_crt, to_char(hfe.dt_dps_hfe, 'mm/yyyy')) dps on crt.cd_crt = dps.cd_crt and mes.descricao = dps.mes
     left join (select sum(tsc.vl_tsc) as valor_tmc,
                       tsc.cd_crt, to_char(tsc.dt_pgto_tsc, 'mm/yyyy') as mes
                from sc_srv.tbl_tsc tsc
                where tsc.dt_pgto_tsc >= '2019-01-01'
                  and tsc.cd_srv = 12 -- tarifa de manutenção de conta
                  and tsc.st_tsc = 2 --situação cobrado
                group by tsc.cd_crt, to_char(tsc.dt_pgto_tsc, 'mm/yyyy')) trf on crt.cd_crt = trf.cd_crt and mes.descricao = trf.mes
where crt.dt_ult_dps_crt >= '2019-01-01';
  --and crt.fg_atv_crt = 'S'
  --and crt.cd_crt = 60586876660144;

  --separar app

select * from sc_cad.tbl_pce order by nm_pce;

select * from sc_cad.tbl_ctr where cd_emp = 29; 
select * from sc_cad.tbl_fem_ctr where cd_ctr = 33;
select * from sc_cad.tbl_tlt_ctr where cd_fem_ctr = 566;

select sc_cad.get_parametro_contrato_cartao(46, 60586876660144)
    vp_parametro numeric,
    vp_cartao numeric,

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

--conferindo tarifas tmc cobradas
select sum(tsc.vl_tsc) as valor_tmc,
                       tsc.cd_crt, to_char(tsc.dt_pgto_tsc, 'mm/yyyy') as mes
                from sc_srv.tbl_tsc tsc
                where tsc.dt_pgto_tsc >= '2019-01-01'
                  and tsc.cd_srv = 12 -- tarifa de manutenção de conta
                  and tsc.st_tsc = 2 --situação cobrado
                  and tsc.cd_crt in (62015564162526)
                group by tsc.cd_crt, to_char(tsc.dt_pgto_tsc, 'mm/yyyy')