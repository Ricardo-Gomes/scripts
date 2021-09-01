--solicitado pelo Germano no dia 15/12/2019, referente ao ano de 2018
--analisar todos os lançamentos do sistema operacional ocorridos do dia 01/01/2016 e 31/01/2019, que foram exportados para a contabilidade nas seguintes contas.
--1.01.02.05.09      – Pendências a Regularizar (OK)
--2.01.01.16.03.01   – Valor Bruto das Transações (OK)
--2.01.01.17.90.01   – Valores a Repassar – Pague Menos (OK)
--2.01.01.18.03      – Depósitos Bancários a Identificar (OK)
--2.01.01.18.99      – Diversos (OK)

--listando os lançamentos de um determinado valor que ocorreram em uma determinada data, e tem um determinado tipo
select --lcn.cd_lcn, tlc.cd_tlc, tlc.ds_tlc, cnt.cd_cnt, cnt.nm_cnt, lcn.vl_lcn as valor, lcn.*
      lcn.dt_ref_lcn::date as data_ref, cnt.cd_scn, cnt.cd_cnt, lcn.cd_tlc, lcn.fg_dcr_lcn, 
      case when lcn.cd_tlc = 1 then null else cnt_ctp.cd_cnt end as contra_partida,
      count(*) as qtde, sum(lcn.vl_lcn) as valor
from sc_cnt.tbl_lcn lcn
     inner join sc_cnt.tbl_cnt cnt on lcn.cd_cnt = cnt.cd_cnt
     inner join sc_cnt.tbl_tlc tlc on lcn.cd_tlc = tlc.cd_tlc
     left join sc_cnt.tbl_lcn lcn_ctp on lcn.cd_ctp_lcn = lcn_ctp.cd_lcn
     left join sc_cnt.tbl_cnt cnt_ctp on lcn_ctp.cd_cnt = cnt_ctp.cd_cnt
where lcn.cd_tlc in (1, 101, 102, 108, 1010) 
  --and lcn.fg_dcr_lcn = 'D'
  and lcn.cd_cnt in (6376)
  --and cnt.cd_scn in (54, 192)
  and lcn.dt_ref_lcn >= '2018-12-20'
  and lcn.dt_ref_lcn < '2018-12-21'
group by lcn.dt_ref_lcn::date, lcn.cd_tlc, lcn.fg_dcr_lcn, cnt.cd_scn, cnt.cd_cnt, case when lcn.cd_tlc = 1 then null else cnt_ctp.cd_cnt end
order by data_ref, valor;

--selecionando todos os dados de uma determinada conta
select * from sc_cnt.tbl_cnt where cd_cnt = 31296;

--selecionando todos os dados de um determinado subgrupo de conta
select * from sc_cnt.tbl_scn where cd_scn = 10;

--gerar a lista de todos os lancamentos sintetico por data, conta, e contra_partida dos lançamentos realizados com o tipo: 15, 16, 1000, 1295, 1414, 1452, 1192, 1402, 1401, 1200 em contas do subgrupo: 1 e 195.
--justificando lançamentos na conta: 1.01.02.05.09 – Pendências a Regularizar
select to_char(lcn.dt_ref_lcn::date, 'dd/mm/yyyy') as data_ref, scn.cd_scn || ' - ' || scn.ds_scn as sub_grupo_conta, 
       case when lcn.fg_dcr_lcn = 'D' then 'Débito' else 'Crédito' end as "D/C",
       tlc.cd_tlc || ' - ' || tlc.ds_tlc as tipo_lancamento,
       scn_ctp.cd_scn || ' - ' || scn_ctp.ds_scn as sub_grupo_contra_partida,
       sum(lcn.vl_lcn) as valor
from sc_cnt.tbl_lcn lcn
     inner join sc_cnt.tbl_cnt cnt on lcn.cd_cnt = cnt.cd_cnt
     inner join sc_cnt.tbl_scn scn on cnt.cd_scn = scn.cd_scn
     inner join sc_cnt.tbl_tlc tlc on lcn.cd_tlc = tlc.cd_tlc
     left join sc_cnt.tbl_lcn lcn_ctp on lcn.cd_ctp_lcn = lcn_ctp.cd_lcn
     left join sc_cnt.tbl_cnt cnt_ctp on lcn_ctp.cd_cnt = cnt_ctp.cd_cnt
     left join sc_cnt.tbl_scn scn_ctp on cnt_ctp.cd_scn = scn_ctp.cd_scn
where lcn.cd_tlc in (15, 16, 1000, 1295, 1414, 1452, 1192, 1402, 1401, 1200) 
  and cnt.cd_scn in (1, 195)
  and lcn.dt_ref_lcn >= '2018-01-01'
  and lcn.dt_ref_lcn < '2019-01-01'
group by lcn.dt_ref_lcn::date, scn.cd_scn, scn.ds_scn, lcn.fg_dcr_lcn, scn_ctp.cd_scn, scn_ctp.ds_scn,
         tlc.cd_tlc, tlc.ds_tlc
order by lcn.dt_ref_lcn::date, "D/C" desc, sub_grupo_contra_partida;


--gerar a lista de todos os lancamentos sintetico por data, conta, e contra_partida dos lançamentos realizados com o tipo: 13, 92, 93, 1446, 1451 em contas do subgrupo: 281 e 282.
--justificando lançamentos na conta: 2.01.01.16.03.01   – Valor Bruto das Transações
select to_char(lcn.dt_ref_lcn::date, 'dd/mm/yyyy') as data_ref, scn.cd_scn || ' - ' || scn.ds_scn as sub_grupo_conta, 
       case when lcn.fg_dcr_lcn = 'D' then 'Débito' else 'Crédito' end as "D/C",
       tlc.cd_tlc || ' - ' || tlc.ds_tlc as tipo_lancamento,
       scn_ctp.cd_scn || ' - ' || scn_ctp.ds_scn as sub_grupo_contra_partida,
       sum(lcn.vl_lcn) as valor
from sc_cnt.tbl_lcn lcn
     inner join sc_cnt.tbl_cnt cnt on lcn.cd_cnt = cnt.cd_cnt
     inner join sc_cnt.tbl_scn scn on cnt.cd_scn = scn.cd_scn
     inner join sc_cnt.tbl_tlc tlc on lcn.cd_tlc = tlc.cd_tlc
     left join sc_cnt.tbl_lcn lcn_ctp on lcn.cd_ctp_lcn = lcn_ctp.cd_lcn
     left join sc_cnt.tbl_cnt cnt_ctp on lcn_ctp.cd_cnt = cnt_ctp.cd_cnt
     left join sc_cnt.tbl_scn scn_ctp on cnt_ctp.cd_scn = scn_ctp.cd_scn
where lcn.cd_tlc in (13, 92, 93, 1446, 1451) 
  and cnt.cd_scn in (281, 282)
  and lcn.dt_ref_lcn >= '2018-01-01'
  and lcn.dt_ref_lcn < '2019-01-01'
group by lcn.dt_ref_lcn::date, scn.cd_scn, scn.ds_scn, lcn.fg_dcr_lcn, scn_ctp.cd_scn, scn_ctp.ds_scn,
         tlc.cd_tlc, tlc.ds_tlc
order by lcn.dt_ref_lcn::date, "D/C" desc, sub_grupo_contra_partida;


--gerar a lista de todos os lancamentos sintetico por data, conta, e contra_partida dos lançamentos realizados com o tipo: 13, 93, 1410 em contas do subgrupo: 55.
--justificando lançamentos na conta: 2.01.01.17.90.01   – Valores a Repassar – Pague Menos
select to_char(lcn.dt_ref_lcn::date, 'dd/mm/yyyy') as data_ref, scn.cd_scn || ' - ' || scn.ds_scn as sub_grupo_conta, 
       case when lcn.fg_dcr_lcn = 'D' then 'Débito' else 'Crédito' end as "D/C",
       tlc.cd_tlc || ' - ' || tlc.ds_tlc as tipo_lancamento,
       scn_ctp.cd_scn || ' - ' || scn_ctp.ds_scn as sub_grupo_contra_partida,
       sum(lcn.vl_lcn) as valor
from sc_cnt.tbl_lcn lcn
     inner join sc_cnt.tbl_cnt cnt on lcn.cd_cnt = cnt.cd_cnt
     inner join sc_cnt.tbl_scn scn on cnt.cd_scn = scn.cd_scn
     inner join sc_cnt.tbl_tlc tlc on lcn.cd_tlc = tlc.cd_tlc
     left join sc_cnt.tbl_lcn lcn_ctp on lcn.cd_ctp_lcn = lcn_ctp.cd_lcn
     left join sc_cnt.tbl_cnt cnt_ctp on lcn_ctp.cd_cnt = cnt_ctp.cd_cnt
     left join sc_cnt.tbl_scn scn_ctp on cnt_ctp.cd_scn = scn_ctp.cd_scn
where lcn.cd_tlc in (13, 93, 1410) 
  and cnt.cd_scn in (55)
  and lcn.dt_ref_lcn >= '2018-01-01'
  and lcn.dt_ref_lcn < '2019-01-01'
group by lcn.dt_ref_lcn::date, scn.cd_scn, scn.ds_scn, lcn.fg_dcr_lcn, scn_ctp.cd_scn, scn_ctp.ds_scn,
         tlc.cd_tlc, tlc.ds_tlc
order by lcn.dt_ref_lcn::date, "D/C" desc, sub_grupo_contra_partida;


--gerar a lista de todos os lancamentos sintetico por data, conta, e contra_partida dos lançamentos realizados com o tipo: 1000, 1001, 1022, 1155 em contas do subgrupo: 54 e 192.
--justificando lançamentos na conta: 2.01.01.18.99      – Diversos
select to_char(lcn.dt_ref_lcn::date, 'dd/mm/yyyy') as data_ref, scn.cd_scn || ' - ' || scn.ds_scn as sub_grupo_conta, 
       case when lcn.fg_dcr_lcn = 'D' then 'Débito' else 'Crédito' end as "D/C",
       tlc.cd_tlc || ' - ' || tlc.ds_tlc as tipo_lancamento,
       scn_ctp.cd_scn || ' - ' || scn_ctp.ds_scn as sub_grupo_contra_partida,
       sum(lcn.vl_lcn) as valor
from sc_cnt.tbl_lcn lcn
     inner join sc_cnt.tbl_cnt cnt on lcn.cd_cnt = cnt.cd_cnt
     inner join sc_cnt.tbl_scn scn on cnt.cd_scn = scn.cd_scn
     inner join sc_cnt.tbl_tlc tlc on lcn.cd_tlc = tlc.cd_tlc
     left join sc_cnt.tbl_lcn lcn_ctp on lcn.cd_ctp_lcn = lcn_ctp.cd_lcn
     left join sc_cnt.tbl_cnt cnt_ctp on lcn_ctp.cd_cnt = cnt_ctp.cd_cnt
     left join sc_cnt.tbl_scn scn_ctp on cnt_ctp.cd_scn = scn_ctp.cd_scn
where lcn.cd_tlc in (1000, 1001, 1022, 1155) 
  and cnt.cd_scn in (54, 192)
  and lcn.dt_ref_lcn >= '2018-01-01'
  and lcn.dt_ref_lcn < '2019-01-01'
group by lcn.dt_ref_lcn::date, scn.cd_scn, scn.ds_scn, lcn.fg_dcr_lcn, scn_ctp.cd_scn, scn_ctp.ds_scn,
         tlc.cd_tlc, tlc.ds_tlc
order by lcn.dt_ref_lcn::date, "D/C" desc, sub_grupo_contra_partida;


--gerar a lista de todos os lancamentos sintetico por data, conta, e contra_partida dos lançamentos realizados com o tipo: 1, 101, 102, 108, 1010 na conta: 6376.
--justificando lançamentos na conta: 2.01.01.18.03      – Depósitos Bancários a Identificar
select to_char(lcn.dt_ref_lcn::date, 'dd/mm/yyyy') as data_ref, cnt.cd_cnt || ' - ' || cnt.nm_cnt as conta, 
       case when lcn.fg_dcr_lcn = 'D' then 'Débito' else 'Crédito' end as "D/C",
       tlc.cd_tlc || ' - ' || tlc.ds_tlc as tipo_lancamento,
       scn_ctp.cd_scn || ' - ' || scn_ctp.ds_scn as sub_grupo_contra_partida,
       sum(lcn.vl_lcn) as valor
from sc_cnt.tbl_lcn lcn
     inner join sc_cnt.tbl_cnt cnt on lcn.cd_cnt = cnt.cd_cnt
     inner join sc_cnt.tbl_scn scn on cnt.cd_scn = scn.cd_scn
     inner join sc_cnt.tbl_tlc tlc on lcn.cd_tlc = tlc.cd_tlc
     left join sc_cnt.tbl_lcn lcn_ctp on lcn.cd_ctp_lcn = lcn_ctp.cd_lcn
     left join sc_cnt.tbl_cnt cnt_ctp on lcn_ctp.cd_cnt = cnt_ctp.cd_cnt
     left join sc_cnt.tbl_scn scn_ctp on cnt_ctp.cd_scn = scn_ctp.cd_scn
where lcn.cd_tlc in (1, 101, 102, 108, 1010) 
  and lcn.cd_cnt in (6376)
  and lcn.dt_ref_lcn >= '2018-01-01'
  and lcn.dt_ref_lcn < '2019-01-01'
group by lcn.dt_ref_lcn::date, cnt.cd_cnt, cnt.nm_cnt, lcn.fg_dcr_lcn, scn_ctp.cd_scn, scn_ctp.ds_scn,
         tlc.cd_tlc, tlc.ds_tlc
order by lcn.dt_ref_lcn::date, "D/C" desc, sub_grupo_contra_partida;

lcn.cd_tlc in (1, 101, 102, 108, 1010) 
  --and lcn.fg_dcr_lcn = 'D'
  and lcn.cd_cnt in (6376)
   