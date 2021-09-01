select * from sc_rds.tbl_atm where cd_atm = 80;
select * from sc_cad.tbl_dmn where nm_cmp_dmn = 'TP_DSP_PGT';
select * from sc_sgr.tbl_usr where cd_usr = 52
select * from sc_cad.tbl_prm where nm_prm = 'USUARIO_CARTAO'

select * from sc_opr.tbl_top where cd_top = 4;
select count(*) as qtde, cd_top from sc_opr.tbl_opr where cd_atm = 80 and dt_opr >= '2019-06-01' group by cd_top

--relacao de utilização do app
select v.mes, v.tipo, v.qtde, v.valor  
from (
	--acessos do app pelos usuários de cartão
	select to_char(spl.dt_inc_spl, 'mm/yyyy') as mes, 'acesso' as tipo, count(*) as qtde, null as valor
	from sc_sgr.tbl_spl spl
	where spl.dt_inc_spl >= '2019-01-01'
	  --and spl.tp_nsu_org_spl = 1
	group by to_char(spl.dt_inc_spl, 'mm/yyyy')

	union all

	--saque extra
	select to_char(opr.dt_opr, 'mm/yyyy') as mes, 'saque extra' as tipo, count(*) as qtde, sum(opr.vl_opr) as valor
	from sc_opr.tbl_opr opr
	     inner join sc_opr.tbl_pls pls on opr.cd_pls = pls.cd_pls
	where opr.cd_atm = 80 
	  and opr.dt_opr >= '2019-01-01'
	  and opr.cd_top = 5
	group by to_char(opr.dt_opr, 'mm/yyyy')

	union all

	--pagamentos de contas
	select to_char(pgt.dt_pgt, 'mm/yyyy') as mes, 'pagamento' as tipo, count(*) as qtde, sum(pgt.vl_pgt) as valor
	from sc_pgc.tbl_pgt pgt
	where pgt.dt_pgt >= '2019-01-01'
	  and pgt.tp_dsp_pgt = 2
	  and pgt.tp_org_pgt = 1
	group by to_char(pgt.dt_pgt, 'mm/yyyy')

	union all

	--recargas
	select to_char(rcg.dt_rcg, 'mm/yyyy') as mes, 'recarga' as tipo, count(*) as qtde, sum(rcg.vl_rcg) as valor
	from sc_rcg.tbl_rcg rcg
	where rcg.dt_rcg >= '2019-01-01'
	  and rcg.tp_dsp_pgt = 2
	group by to_char(rcg.dt_rcg, 'mm/yyyy')

	union all

	--transferencias
	select to_char(tba.dt_aut_usr, 'mm/yyyy') as mes, 'transferência' as tipo, count(*) as qtde, sum(tba.vl_tba) as valor
	from sc_atb.tbl_tba tba
	where tba.dt_aut_usr >= '2019-01-01'
	  and tba.cd_inc_usr = 52
	group by to_char(tba.dt_aut_usr, 'mm/yyyy')) v
	
order by mes, tipo;

--select * from sc_cad.tbl_dmn where nm_cmp_dmn = 'TP_DSP_PGT'