select * from sc_rds.tbl_atm where cd_atm = 80;
select * from sc_cad.tbl_dmn where nm_cmp_dmn = 'TP_DSP_PGT';
select * from sc_sgr.tbl_usr where cd_usr = 52
select * from sc_cad.tbl_prm where nm_prm = 'USUARIO_CARTAO';

select nr_nsu_org_tba from sc_atb.tbl_tba limit 10

select * from sc_opr.tbl_top where cd_top = 4;
select count(*) as qtde, cd_top from sc_opr.tbl_opr where cd_atm = 80 and dt_opr >= '2019-06-01' group by cd_top

--relação de acesso ao app
select to_char(spl.dt_inc_spl, 'dd/mm/yyyy hh24:mi:ss') as data_inicio_sessao, 
       spl.vrs_sis_spl as versao_sistema,
       spl.mrc_dsp_spl as marca_dispositivo,
       spl.mdl_dsp_spl as modelo_dispositivo,
       spl.vrs_app_spl as versao_app,
       spl.nsu_org_spl as cartao,
       cun.nr_cpf_cnpj_cun as cpf
from sc_sgr.tbl_spl spl
     inner join sc_opr.tbl_crt crt on spl.nsu_org_spl = crt.cd_crt
     inner join sc_cad.tbl_fnc fnc on crt.cd_fnc = fnc.cd_fnc
     inner join sc_cad.tbl_cun cun on fnc.cd_cun = cun.cd_cun
where spl.dt_inc_spl >= '2019-09-01'
  and spl.dt_inc_spl < '2019-12-01'
order by data_inicio_sessao
limit 10;
  
--relacao de utilização do app
select v.mes, v.tipo, v.qtde, v.valor  
from (
	--saque extra
	select to_char(opr.dt_opr, 'dd/mm/yyyy hh24:mi:ss') as data_hora, pls.cd_crt as cartao, null as cpf, 'saque extra' as tipo, opr.vl_opr as valor
	from sc_opr.tbl_opr opr
	     inner join sc_opr.tbl_pls pls on opr.cd_pls = pls.cd_pls
	where opr.cd_atm = 80 
	  and opr.dt_opr >= '2019-09-01'
	  and opr.cd_top = 5

	union all

	--pagamentos de contas
	select to_char(pgt.dt_pgt, 'dd/mm/yyyy hh24:mi:ss') as data_hora, pgt.nsu_org_pgt::numeric as cartao, null as cpf, 'pagamento' as tipo, pgt.vl_pgt as valor
	from sc_pgc.tbl_pgt pgt
	where pgt.dt_pgt >= '2019-09-01'
	  and pgt.tp_dsp_pgt = 2
	  and pgt.tp_org_pgt = 1

	union all

	--recargas
	select to_char(rcg.dt_rcg, 'dd/mm/yyyy hh24:mi:ss') as data_hora, rcg.cd_crt as cartao, null as cpf, 'recarga' as tipo, rcg.vl_rcg as valor
	from sc_rcg.tbl_rcg rcg
	where rcg.dt_rcg >= '2019-09-01'
	  and rcg.tp_dsp_pgt = 2

	union all

	--transferencias
	select to_char(tba.dt_aut_usr, 'dd/mm/yyyy hh24:mi:ss') as data_hora, null as cartao, tba.nr_cpf_cnpj_tba as cpf, 'transferência' as tipo, tba.vl_tba as valor
	from sc_atb.tbl_tba tba
	where tba.dt_aut_usr >= '2019-09-01'
	  and tba.cd_inc_usr = 52
	group by to_char(tba.dt_aut_usr, 'mm/yyyy')) v
	left join sc_opr.tbl_crt crt on v.cartao = crt.cd_crt
        left join sc_cad.tbl_fnc fnc on crt.cd_fnc = fnc.cd_fnc
        left join sc_cad.tbl_cun cun on fnc.cd_cun = cun.cd_cun
	
order by mes, tipo;

--select * from sc_cad.tbl_dmn where nm_cmp_dmn = 'TP_DSP_PGT'