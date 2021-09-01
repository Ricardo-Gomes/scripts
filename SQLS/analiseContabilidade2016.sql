--analisar todos os lançamentos do sistema operacional ocorridos do dia 01/01/2016 e 31/01/2019, que foram exportados para a contabilidade nas seguintes contas.
--1.01.01.04.01.0001 - Diferença de ATM (OK)
--1.01.03.02.01.0001 - A Receber de Usuário (OK)
--1.01.03.02.02.0001 - Saque Arredondado (OK)
--1.01.03.02.03.0001 - Limite de Crédito Contratado (OK)
--1.01.03.02.04.0001 - Direitos Creditórios Adquiridos a Receber (OK)
--1.01.04.01.01.0001 - Fernando Soares Gurgel (OK)
--1.01.04.01.01.0004 - Saqcard Administração e Participação (Não encontrei nenhum lançamento)
--1.01.04.06.02.0001 – Gaiacred Companhia Securitizadora (OK)
--1.01.05.01.09.0001 - Adiantamento a Correspondente (OK)
--2.01.01.02.03.0003 – Mandatário Gaia (OK)
--2.01.01.05.01.0001 - Cheques a Compensar (OK)
--2.01.01.07.02.0001 - Cobr Por Ordem de Terceiro (OK)
--2.01.09.02.01.0001 - Credores Diversos Por Cobrança (OK)
--2.01.09.02.01.0002 - Valor em Transito de Terceiros (Jrs e Multa) (OK)

select * from sc_cnt.tbl_cnt where cd_cnt = 67182;
select * from sc_cnt.tbl_cnt where cd_scn = 271;

--select para descobrir código e contas fortes
select cnt.cd_cnt, cnt.nm_cnt, scn.cd_cnt_ctb1 as conta_subgrupo_2016, scn.cd_cnt_ctb as conta_subgrupo_nova, cnt.cd_cnt_ctb1 as conta_2016, cnt.cd_cnt_ctb as conta_nova
from sc_cnt.tbl_cnt cnt
     inner join sc_cnt.tbl_scn scn on cnt.cd_scn = scn.cd_scn
where cnt.cd_cnt in (132562, 116308);

--listando os lançamentos de um determinado valor que ocorreram em uma determinada data, e tem um determinado tipo
select --lcn.cd_lcn, tlc.cd_tlc, tlc.ds_tlc, cnt.cd_cnt, cnt.nm_cnt, lcn.vl_lcn as valor, lcn.*
      lcn.dt_ref_lcn::date as data_ref, cnt.cd_scn, lcn.cd_tlc, lcn.fg_dcr_lcn,
      count(*) as qtde, sum(lcn.vl_lcn) as valor
from sc_cnt.tbl_lcn lcn
     inner join sc_cnt.tbl_cnt cnt on lcn.cd_cnt = cnt.cd_cnt
     inner join sc_cnt.tbl_tlc tlc on lcn.cd_tlc = tlc.cd_tlc
     left join sc_cnt.tbl_lcn lcn_ctp on lcn.cd_ctp_lcn = lcn_ctp.cd_lcn
     left join sc_cnt.tbl_cnt cnt_ctp on lcn_ctp.cd_cnt = cnt_ctp.cd_cnt
where lcn.cd_tlc in (15, 16, 1295, 1414, 1452, 1192, 1402, 1401, 1200) 
  --and lcn.fg_dcr_lcn = 'D'
  --and lcn.cd_cnt = 116308
  and cnt.cd_scn in (1, 195)
  and lcn.dt_ref_lcn >= '2018-12-12'
  and lcn.dt_ref_lcn < '2018-12-13'
group by lcn.dt_ref_lcn::date, lcn.cd_tlc, lcn.fg_dcr_lcn, cnt.cd_scn
order by data_ref, valor;

--selecionando todos os dados de uma determinada conta
select * from sc_cnt.tbl_cnt where cd_cnt = 31296;

--selecionando todos os dados de um determinado subgrupo de conta
select * from sc_cnt.tbl_scn where cd_scn = 10;

--gerar a lista de todos os lancamentos sintetico por data, conta, e contra_partida dos lançamentos realizados com o tipo: 11 em contas do subgrupo: 10.
--justificando lançamentos na conta: 1.01.01.04.01.0001 - Diferença de ATM
select to_char(lcn.dt_ref_lcn::date, 'dd/mm/yyyy') as data_ref, cnt.cd_cnt || ' - ' || cnt.nm_cnt as conta, 
       case when lcn.fg_dcr_lcn = 'D' then 'Débito' else 'Crédito' end as "D/C", 
       cnt_ctp.cd_cnt || ' - ' || cnt_ctp.nm_cnt as contra_partida,
       sum(lcn.vl_lcn) as valor
from sc_cnt.tbl_lcn lcn
     inner join sc_cnt.tbl_cnt cnt on lcn.cd_cnt = cnt.cd_cnt
     left join sc_cnt.tbl_lcn lcn_ctp on lcn.cd_ctp_lcn = lcn_ctp.cd_lcn
     left join sc_cnt.tbl_cnt cnt_ctp on lcn_ctp.cd_cnt = cnt_ctp.cd_cnt
where cnt.cd_scn = 10
  --and lcn.cd_tlc in (11, 12)
  and lcn.dt_ref_lcn >= '2016-01-01'
  and lcn.dt_ref_lcn < '2017-01-01'
group by lcn.dt_ref_lcn::date, cnt.cd_cnt, cnt.nm_cnt, lcn.fg_dcr_lcn, cnt_ctp.cd_cnt, cnt_ctp.nm_cnt
order by lcn.dt_ref_lcn::date, conta, "D/C", contra_partida;

--gerar a lista de todos os lancamentos sintetico por data, conta, e contra_partida dos lançamentos realizados com o tipo: 11 em contas do subgrupo: 10.
--justificando lançamentos na conta: 1.01.03.02.01.0001 - A Receber de Usuário
select to_char(lcn.dt_ref_lcn::date, 'dd/mm/yyyy') as data_ref, scn.cd_scn || ' - ' || scn.ds_scn as sub_grupo_conta, 
       case when lcn.fg_dcr_lcn = 'D' then 'Débito' else 'Crédito' end as "D/C",
       tlc.cd_tlc || ' - ' || tlc.ds_tlc as tipo_lancamento,
       cnt_ctp.cd_cnt || ' - ' || cnt_ctp.nm_cnt as conta_contra_partida,
       scn_ctp.cd_scn || ' - ' || scn_ctp.ds_scn as sub_grupo_contra_partida,
       replace(coalesce(scn_ctp.cd_cnt_ctb1, coalesce(cnt_ctp.cd_cnt_ctb1, cnt_ctp.cd_cnt_ctb)), '.', '') as fortes_contrapartida,
       sum(lcn_ctp.vl_lcn) as valor
from sc_cnt.tbl_lcn lcn
     inner join sc_cnt.tbl_cnt cnt on lcn.cd_cnt = cnt.cd_cnt
     inner join sc_cnt.tbl_scn scn on cnt.cd_scn = scn.cd_scn
     inner join sc_cnt.tbl_tlc tlc on lcn.cd_tlc = tlc.cd_tlc
     left join sc_cnt.tbl_lcn lcn_ctp on lcn.cd_ctp_lcn = lcn_ctp.cd_lcn or lcn_ctp.cd_ctp_lcn = lcn.cd_lcn
     left join sc_cnt.tbl_cnt cnt_ctp on lcn_ctp.cd_cnt = cnt_ctp.cd_cnt
     left join sc_cnt.tbl_scn scn_ctp on cnt_ctp.cd_scn = scn_ctp.cd_scn
where cnt.cd_scn = 1
  and cnt_ctp.cd_scn <> 1
  --and lcn.cd_tlc in (15, 16, 1218, 1192, 1196, 1194, 1198, 1200, 1375)
  and lcn.dt_ref_lcn >= '2016-01-04'
  and lcn.dt_ref_lcn < '2016-01-05'
group by lcn.dt_ref_lcn::date, scn.cd_scn, scn.ds_scn, lcn.fg_dcr_lcn, scn_ctp.cd_scn, scn_ctp.ds_scn,
         tlc.cd_tlc, tlc.ds_tlc, replace(coalesce(scn_ctp.cd_cnt_ctb1, coalesce(cnt_ctp.cd_cnt_ctb1, cnt_ctp.cd_cnt_ctb)), '.', ''),
         cnt_ctp.cd_cnt, cnt_ctp.nm_cnt
order by lcn.dt_ref_lcn::date, "D/C" desc, sub_grupo_contra_partida;

--visão agrupadas por conta
select scn.cd_scn || ' - ' || scn.ds_scn as sub_grupo_conta, 
       case when lcn.fg_dcr_lcn = 'D' then 'Débito' else 'Crédito' end as "D/C",
       tlc.cd_tlc || ' - ' || tlc.ds_tlc as tipo_lancamento,
       scn_ctp.cd_scn || ' - ' || scn_ctp.ds_scn as sub_grupo_contra_partida,
       replace(coalesce(scn_ctp.cd_cnt_ctb1, coalesce(cnt_ctp.cd_cnt_ctb1, cnt_ctp.cd_cnt_ctb)), '.', '') as fortes_contrapartida,
       sum(lcn_ctp.vl_lcn) as valor
from sc_cnt.tbl_lcn lcn
     inner join sc_cnt.tbl_cnt cnt on lcn.cd_cnt = cnt.cd_cnt
     inner join sc_cnt.tbl_scn scn on cnt.cd_scn = scn.cd_scn
     inner join sc_cnt.tbl_tlc tlc on lcn.cd_tlc = tlc.cd_tlc
     left join sc_cnt.tbl_lcn lcn_ctp on lcn.cd_ctp_lcn = lcn_ctp.cd_lcn or lcn_ctp.cd_ctp_lcn = lcn.cd_lcn
     left join sc_cnt.tbl_cnt cnt_ctp on lcn_ctp.cd_cnt = cnt_ctp.cd_cnt
     left join sc_cnt.tbl_scn scn_ctp on cnt_ctp.cd_scn = scn_ctp.cd_scn
where cnt.cd_scn = 1
  and cnt_ctp.cd_scn <> 1
  --and lcn.cd_tlc in (15, 16, 1218, 1192, 1196, 1194, 1198, 1200, 1375)
  and lcn.dt_ref_lcn >= '2016-01-01'
  and lcn.dt_ref_lcn < '2017-01-01'
group by scn.cd_scn, scn.ds_scn, lcn.fg_dcr_lcn, scn_ctp.cd_scn, scn_ctp.ds_scn,
         tlc.cd_tlc, tlc.ds_tlc, replace(coalesce(scn_ctp.cd_cnt_ctb1, coalesce(cnt_ctp.cd_cnt_ctb1, cnt_ctp.cd_cnt_ctb)), '.', '')
order by "D/C" desc, valor desc;

--gerar a lista de todos os lancamentos sintetico por data, conta, e contra_partida dos lançamentos realizados com o tipo: 188, 1373 e 1375 na conta 66156.
--justificando lançamentos na conta: 1.01.03.02.03.0001 - Limite de Crédito Contratado
select to_char(lcn.dt_ref_lcn::date, 'dd/mm/yyyy') as data_ref, cnt.cd_cnt || ' - ' || cnt.nm_cnt as conta, 
       case when lcn.fg_dcr_lcn = 'D' then 'Débito' else 'Crédito' end as "D/C", 
       tlc.cd_tlc || ' - ' || tlc.ds_tlc as tipo_lancamento,
       sum(lcn.vl_lcn) as valor
from sc_cnt.tbl_lcn lcn
     inner join sc_cnt.tbl_cnt cnt on lcn.cd_cnt = cnt.cd_cnt
     inner join sc_cnt.tbl_tlc tlc on lcn.cd_tlc = tlc.cd_tlc
     left join sc_cnt.tbl_lcn lcn_ctp on lcn.cd_ctp_lcn = lcn_ctp.cd_lcn
     left join sc_cnt.tbl_cnt cnt_ctp on lcn_ctp.cd_cnt = cnt_ctp.cd_cnt
where cnt.cd_cnt = 66156
  and lcn.cd_tlc in (188, 1373, 1375)
  and lcn.dt_ref_lcn >= '2016-01-01'
  and lcn.dt_ref_lcn < '2017-01-01'
group by lcn.dt_ref_lcn::date, cnt.cd_cnt, cnt.nm_cnt, lcn.fg_dcr_lcn, tlc.cd_tlc, tlc.ds_tlc
order by lcn.dt_ref_lcn::date, conta, "D/C", tipo_lancamento;

--gerar a lista de todos os lancamentos sintetico por data, conta, e contra_partida dos lançamentos realizados com o tipo: 188, 1373 e 1375 na conta 66156.
--justificando lançamentos na conta: 1.01.03.02.03.0001 - Limite de Crédito Contratado
select to_char(lcn.dt_ref_lcn::date, 'dd/mm/yyyy') as data_ref, 
       cnt.cd_cnt || ' - ' || cnt.nm_cnt as conta, 
       case when lcn.fg_dcr_lcn = 'D' then 'Débito' else 'Crédito' end as "D/C", 
       tlc.cd_tlc || ' - ' || tlc.ds_tlc as tipo_lancamento,
       cnt_ctp.cd_cnt || ' - ' || cnt_ctp.nm_cnt as contrapartida, 
       sum(lcn.vl_lcn) as valor
from sc_cnt.tbl_lcn lcn
     inner join sc_cnt.tbl_cnt cnt on lcn.cd_cnt = cnt.cd_cnt
     inner join sc_cnt.tbl_tlc tlc on lcn.cd_tlc = tlc.cd_tlc
     left join sc_cnt.tbl_lcn lcn_ctp on lcn.cd_ctp_lcn = lcn_ctp.cd_lcn
     left join sc_cnt.tbl_cnt cnt_ctp on lcn_ctp.cd_cnt = cnt_ctp.cd_cnt
where cnt.cd_cnt = 45864
  --and lcn.cd_tlc in (145, 54, 1328, 1327)
  and lcn.dt_ref_lcn >= '2016-01-01'
  and lcn.dt_ref_lcn < '2017-01-01'
group by lcn.dt_ref_lcn::date, cnt.cd_cnt, cnt.nm_cnt, lcn.fg_dcr_lcn, tlc.cd_tlc, tlc.ds_tlc, cnt_ctp.cd_cnt, cnt_ctp.nm_cnt
order by lcn.dt_ref_lcn::date, conta, "D/C", tipo_lancamento;

--gerar a lista de todos os lancamentos sintetico por data, conta, e contra_partida dos lançamentos realizados com o tipo: 188, 1373 e 1375 na conta 66156.
--justificando lançamentos na conta: 1.01.05.01.09.0001 - Adiantamento a Correspondente
select to_char((case
               when scn_ctp.cd_scn in (20, 30) and lcn.fg_dcr_lcn = 'D' then sc_grl.get_proximo_dia_util(lcn.dt_ref_lcn)
               else lcn.dt_ref_lcn end)::date, 'dd/mm/yyyy') as data_ref, 
       (case
               when scn_ctp.cd_scn in (20, 30) and lcn.fg_dcr_lcn = 'D' then sc_grl.get_proximo_dia_util(lcn.dt_ref_lcn)
               else lcn.dt_ref_lcn end)::date as dt,
       cnt.cd_cnt || ' - ' || cnt.nm_cnt as conta, 
       case when lcn.fg_dcr_lcn = 'D' then 'Débito' else 'Crédito' end as "D/C", 
       tlc.cd_tlc || ' - ' || tlc.ds_tlc as tipo_lancamento,
       scn_ctp.cd_scn || ' - ' || scn_ctp.ds_scn as sub_grupo_contrapartida, 
       replace(coalesce(scn_ctp.cd_cnt_ctb1, cnt_ctp.cd_cnt_ctb1), '.', '') as fortes_contrapartida,
       (case when lcn.fg_dcr_lcn = 'D' then sum(lcn.vl_lcn) else 0 end) as valor_debito,
       (case when lcn.fg_dcr_lcn = 'C' then sum(lcn.vl_lcn) else 0 end) as valor_credito
from sc_cnt.tbl_lcn lcn
     inner join sc_cnt.tbl_cnt cnt on lcn.cd_cnt = cnt.cd_cnt
     inner join sc_cnt.tbl_tlc tlc on lcn.cd_tlc = tlc.cd_tlc
     left join sc_cnt.tbl_lcn lcn_ctp on lcn.cd_ctp_lcn = lcn_ctp.cd_lcn
     left join sc_cnt.tbl_cnt cnt_ctp on lcn_ctp.cd_cnt = cnt_ctp.cd_cnt
     left join sc_cnt.tbl_scn scn_ctp on cnt_ctp.cd_scn = scn_ctp.cd_scn
where cnt.cd_cnt = 67182
  --and lcn.cd_tlc in (188, 1003)
  and lcn.dt_ref_lcn >= '2016-01-01'
  and lcn.dt_ref_lcn < '2017-01-01'
group by (case
               when scn_ctp.cd_scn in (20, 30) and lcn.fg_dcr_lcn = 'D' then sc_grl.get_proximo_dia_util(lcn.dt_ref_lcn)
               else lcn.dt_ref_lcn end), cnt.cd_cnt, cnt.nm_cnt, lcn.fg_dcr_lcn, tlc.cd_tlc, tlc.ds_tlc, scn_ctp.cd_scn, scn_ctp.ds_scn, coalesce(scn_ctp.cd_cnt_ctb1, cnt_ctp.cd_cnt_ctb1)
order by dt, "D/C" desc, tipo_lancamento;

--visão agrupadas
select cnt.cd_cnt || ' - ' || cnt.nm_cnt as conta, 
       case when lcn.fg_dcr_lcn = 'D' then 'Débito' else 'Crédito' end as "D/C", 
       tlc.cd_tlc || ' - ' || tlc.ds_tlc as tipo_lancamento,
       scn_ctp.cd_scn || ' - ' || scn_ctp.ds_scn as sub_grupo_contrapartida, 
       replace(coalesce(scn_ctp.cd_cnt_ctb1, cnt_ctp.cd_cnt_ctb1), '.', '') as fortes_contrapartida,
       sum(lcn.vl_lcn) as valor
from sc_cnt.tbl_lcn lcn
     inner join sc_cnt.tbl_cnt cnt on lcn.cd_cnt = cnt.cd_cnt
     inner join sc_cnt.tbl_tlc tlc on lcn.cd_tlc = tlc.cd_tlc
     left join sc_cnt.tbl_lcn lcn_ctp on lcn.cd_ctp_lcn = lcn_ctp.cd_lcn
     left join sc_cnt.tbl_cnt cnt_ctp on lcn_ctp.cd_cnt = cnt_ctp.cd_cnt
     left join sc_cnt.tbl_scn scn_ctp on cnt_ctp.cd_scn = scn_ctp.cd_scn
where cnt.cd_cnt = 67182
  --and lcn.cd_tlc in (188, 1003)
  and lcn.dt_ref_lcn >= '2016-01-01'
  and lcn.dt_ref_lcn < '2017-01-01'
group by cnt.cd_cnt, cnt.nm_cnt, lcn.fg_dcr_lcn, tlc.cd_tlc, tlc.ds_tlc, scn_ctp.cd_scn, scn_ctp.ds_scn, coalesce(scn_ctp.cd_cnt_ctb1, cnt_ctp.cd_cnt_ctb1)
order by "D/C" desc, valor desc;

--gerar a lista de todos os lancamentos sintetico por data, conta, e contra_partida dos lançamentos realizados com o tipo: 188, 1373 e 1375 na conta 66156.
--justificando lançamentos na conta: 2.01.01.05.01.0001 - Cheques a Compensar
select to_char(lcn.dt_ref_lcn::date, 'dd/mm/yyyy') as data_ref, 
       cnt.cd_cnt || ' - ' || cnt.nm_cnt as conta, 
       case when lcn.fg_dcr_lcn = 'D' then 'Débito' else 'Crédito' end as "D/C", 
       tlc.cd_tlc || ' - ' || tlc.ds_tlc as tipo_lancamento,
       coalesce(cnt_ctp.cd_cnt, 1208) || ' - ' || coalesce(cnt_ctp.nm_cnt, 'GEM PG ALICES 71') as contrapartida, 
       sum(lcn.vl_lcn) as valor
from sc_cnt.tbl_lcn lcn
     inner join sc_cnt.tbl_cnt cnt on lcn.cd_cnt = cnt.cd_cnt
     inner join sc_cnt.tbl_tlc tlc on lcn.cd_tlc = tlc.cd_tlc
     left join sc_cnt.tbl_lcn lcn_ctp on lcn.cd_ctp_lcn = lcn_ctp.cd_lcn
     left join sc_cnt.tbl_cnt cnt_ctp on lcn_ctp.cd_cnt = cnt_ctp.cd_cnt
     left join sc_cnt.tbl_scn scn_ctp on cnt_ctp.cd_scn = scn_ctp.cd_scn
where cnt.cd_cnt = 7
  and lcn.cd_tlc in (1, 45, 1008, 1009, 1010)
  and lcn.dt_ref_lcn >= '2016-01-01'
  and lcn.dt_ref_lcn < '2017-01-01'
group by lcn.dt_ref_lcn::date, cnt.cd_cnt, cnt.nm_cnt, lcn.fg_dcr_lcn, tlc.cd_tlc, tlc.ds_tlc, coalesce(cnt_ctp.cd_cnt, 1208), coalesce(cnt_ctp.nm_cnt, 'GEM PG ALICES 71')
order by lcn.dt_ref_lcn::date, conta, "D/C", tipo_lancamento;

--gerar a lista de todos os lancamentos sintetico por data, conta, e contra_partida dos lançamentos realizados com o tipo: 188, 1373 e 1375 na conta 66156.
--justificando lançamentos na conta: 2.01.01.07.02.0001 - Cobr Por Ordem de Terceiro
select to_char(lcn.dt_ref_lcn::date, 'dd/mm/yyyy') as data_ref, 
       cnt.cd_cnt || ' - ' || cnt.nm_cnt as conta, 
       case when lcn.fg_dcr_lcn = 'D' then 'Débito' else 'Crédito' end as "D/C", 
       tlc.cd_tlc || ' - ' || tlc.ds_tlc as tipo_lancamento,
       cnt_ctp.cd_cnt || ' - ' || cnt_ctp.nm_cnt as contrapartida, 
       sum(lcn.vl_lcn) as valor
from sc_cnt.tbl_lcn lcn
     inner join sc_cnt.tbl_cnt cnt on lcn.cd_cnt = cnt.cd_cnt
     inner join sc_cnt.tbl_tlc tlc on lcn.cd_tlc = tlc.cd_tlc
     left join sc_cnt.tbl_lcn lcn_ctp on lcn.cd_ctp_lcn = lcn_ctp.cd_lcn
     left join sc_cnt.tbl_cnt cnt_ctp on lcn_ctp.cd_cnt = cnt_ctp.cd_cnt
     left join sc_cnt.tbl_scn scn_ctp on cnt_ctp.cd_scn = scn_ctp.cd_scn
where cnt.cd_cnt = 68007
  and lcn.cd_tlc in (1373, 1375)
  and lcn.dt_ref_lcn >= '2016-01-01'
  and lcn.dt_ref_lcn < '2017-01-01'
group by lcn.dt_ref_lcn::date, cnt.cd_cnt, cnt.nm_cnt, lcn.fg_dcr_lcn, tlc.cd_tlc, tlc.ds_tlc, cnt_ctp.cd_cnt, cnt_ctp.nm_cnt
order by lcn.dt_ref_lcn::date, conta, "D/C", tipo_lancamento;

--gerar a lista de todos os lancamentos sintetico por data, conta, e contra_partida dos lançamentos realizados com o tipo: 188, 1373 e 1375 na conta 66156.
--justificando lançamentos na conta: 2.01.09.02.01.0001 - Credores Diversos Por Cobrança
select to_char(lcn.dt_ref_lcn::date, 'dd/mm/yyyy') as data_ref, 
       cnt.cd_cnt || ' - ' || cnt.nm_cnt as conta, 
       case when lcn.fg_dcr_lcn = 'D' then 'Débito' else 'Crédito' end as "D/C", 
       tlc.cd_tlc || ' - ' || tlc.ds_tlc as tipo_lancamento,
       --cnt_ctp.cd_cnt || ' - ' || cnt_ctp.nm_cnt as contrapartida, 
       sum(lcn.vl_lcn) as valor
from sc_cnt.tbl_lcn lcn
     inner join sc_cnt.tbl_cnt cnt on lcn.cd_cnt = cnt.cd_cnt
     inner join sc_cnt.tbl_tlc tlc on lcn.cd_tlc = tlc.cd_tlc
     left join sc_cnt.tbl_lcn lcn_ctp on lcn.cd_ctp_lcn = lcn_ctp.cd_lcn
     left join sc_cnt.tbl_cnt cnt_ctp on lcn_ctp.cd_cnt = cnt_ctp.cd_cnt
     left join sc_cnt.tbl_scn scn_ctp on cnt_ctp.cd_scn = scn_ctp.cd_scn
where cnt.cd_cnt = 117356
  and lcn.cd_tlc in (1414, 1415)
  and lcn.dt_ref_lcn >= '2016-01-01'
  and lcn.dt_ref_lcn < '2017-01-01'
group by lcn.dt_ref_lcn::date, cnt.cd_cnt, cnt.nm_cnt, lcn.fg_dcr_lcn, tlc.cd_tlc, tlc.ds_tlc--, cnt_ctp.cd_cnt, cnt_ctp.nm_cnt
order by lcn.dt_ref_lcn::date, conta, "D/C", tipo_lancamento;

--gerar a lista de todos os lancamentos sintetico por data, conta, e contra_partida dos lançamentos realizados com o tipo: 188, 1373 e 1375 na conta 66156.
--justificando lançamentos na conta: 2.01.09.02.01.0001 - Credores Diversos Por Cobrança
select to_char(lcn.dt_ref_lcn::date, 'dd/mm/yyyy') as data_ref, 
       cnt.cd_cnt || ' - ' || cnt.nm_cnt as conta, 
       case when lcn.fg_dcr_lcn = 'D' then 'Débito' else 'Crédito' end as "D/C", 
       tlc.cd_tlc || ' - ' || tlc.ds_tlc as tipo_lancamento,
       --cnt_ctp.cd_cnt || ' - ' || cnt_ctp.nm_cnt as contrapartida, 
       sum(lcn.vl_lcn) as valor
from sc_cnt.tbl_lcn lcn
     inner join sc_cnt.tbl_cnt cnt on lcn.cd_cnt = cnt.cd_cnt
     inner join sc_cnt.tbl_tlc tlc on lcn.cd_tlc = tlc.cd_tlc
     left join sc_cnt.tbl_lcn lcn_ctp on lcn.cd_ctp_lcn = lcn_ctp.cd_lcn
     left join sc_cnt.tbl_cnt cnt_ctp on lcn_ctp.cd_cnt = cnt_ctp.cd_cnt
     left join sc_cnt.tbl_scn scn_ctp on cnt_ctp.cd_scn = scn_ctp.cd_scn
where cnt.cd_cnt = 117529
  and lcn.cd_tlc in (1415)
  and lcn.dt_ref_lcn >= '2016-01-01'
  and lcn.dt_ref_lcn < '2017-01-01'
group by lcn.dt_ref_lcn::date, cnt.cd_cnt, cnt.nm_cnt, lcn.fg_dcr_lcn, tlc.cd_tlc, tlc.ds_tlc--, cnt_ctp.cd_cnt, cnt_ctp.nm_cnt
order by lcn.dt_ref_lcn::date, conta, "D/C", tipo_lancamento;

--gerar a lista de todos os lancamentos sintetico por data, conta, e contra_partida dos lançamentos realizados com o tipo: 172 e 174 nas contas do grupo 259.
--justificando lançamentos na conta: 1.01.03.02.02.0001 - Saque Arredondado
select to_char(lcn.dt_ref_lcn::date, 'dd/mm/yyyy') as data_ref, 
       scn.cd_scn || ' - ' || scn.ds_scn as sub_grupo_conta, 
       case when lcn.fg_dcr_lcn = 'D' then 'Débito' else 'Crédito' end as "D/C", 
       tlc.cd_tlc || ' - ' || tlc.ds_tlc as tipo_lancamento,
       scn_ctp.cd_scn || ' - ' || scn_ctp.ds_scn as sub_grupo_contrapartida, 
       sum(lcn.vl_lcn) as valor
from sc_cnt.tbl_lcn lcn
     inner join sc_cnt.tbl_cnt cnt on lcn.cd_cnt = cnt.cd_cnt
     inner join sc_cnt.tbl_scn scn on cnt.cd_scn = scn.cd_scn
     inner join sc_cnt.tbl_tlc tlc on lcn.cd_tlc = tlc.cd_tlc
     left join sc_cnt.tbl_lcn lcn_ctp on lcn.cd_ctp_lcn = lcn_ctp.cd_lcn
     left join sc_cnt.tbl_cnt cnt_ctp on lcn_ctp.cd_cnt = cnt_ctp.cd_cnt
     left join sc_cnt.tbl_scn scn_ctp on cnt_ctp.cd_scn = scn_ctp.cd_scn
where cnt.cd_scn = 259
  and lcn.cd_tlc in (172, 174)
  and lcn.dt_ref_lcn >= '2016-01-01'
  and lcn.dt_ref_lcn < '2017-01-01'
group by lcn.dt_ref_lcn::date, scn.cd_scn, scn.ds_scn, lcn.fg_dcr_lcn, tlc.cd_tlc, tlc.ds_tlc, scn_ctp.cd_scn, scn_ctp.ds_scn
order by lcn.dt_ref_lcn::date, sub_grupo_conta, "D/C", tipo_lancamento;


--gerar a lista de todos os lancamentos sintetico por data, conta, e contra_partida dos lançamentos realizados com o tipo: 172 e 174 nas contas do grupo 259.
--justificando lançamentos na conta: 1.01.03.02.04.0001 - Direitos Creditórios Adquiridos a Receber
select to_char(lcn.dt_ref_lcn::date, 'dd/mm/yyyy') as data_ref, 
       cnt.cd_cnt || ' - ' || cnt.nm_cnt as conta, 
       case when lcn.fg_dcr_lcn = 'D' then 'Débito' else 'Crédito' end as "D/C", 
       tlc.cd_tlc || ' - ' || tlc.ds_tlc as tipo_lancamento,
       cnt_ctp.cd_cnt || ' - ' || cnt_ctp.nm_cnt as contrapartida, 
       sum(lcn.vl_lcn) as valor
from sc_cnt.tbl_lcn lcn
     inner join sc_cnt.tbl_cnt cnt on lcn.cd_cnt = cnt.cd_cnt
     inner join sc_cnt.tbl_scn scn on cnt.cd_scn = scn.cd_scn
     inner join sc_cnt.tbl_tlc tlc on lcn.cd_tlc = tlc.cd_tlc
     left join sc_cnt.tbl_lcn lcn_ctp on lcn.cd_ctp_lcn = lcn_ctp.cd_lcn
     left join sc_cnt.tbl_cnt cnt_ctp on lcn_ctp.cd_cnt = cnt_ctp.cd_cnt
     left join sc_cnt.tbl_scn scn_ctp on cnt_ctp.cd_scn = scn_ctp.cd_scn
where cnt.cd_cnt = 132729
  and lcn.cd_tlc in (1414, 1415)
  and lcn.dt_ref_lcn >= '2016-01-01'
  and lcn.dt_ref_lcn < '2017-01-01'
group by lcn.dt_ref_lcn::date, cnt.cd_cnt, cnt.nm_cnt, lcn.fg_dcr_lcn, tlc.cd_tlc, tlc.ds_tlc, cnt_ctp.cd_cnt, cnt_ctp.nm_cnt
order by lcn.dt_ref_lcn::date, conta, "D/C", tipo_lancamento;

--gerar a lista de todos os lancamentos sintetico por data, conta, e contra_partida dos lançamentos realizados com o tipo: 1412 na conta 116312.
--justificando lançamentos na conta: 1.01.04.06.02.0001 – Gaiacred Companhia Securitizadora
select to_char(lcn.dt_ref_lcn::date, 'dd/mm/yyyy') as data_ref, 
       cnt.cd_cnt || ' - ' || cnt.nm_cnt as conta, 
       case when lcn.fg_dcr_lcn = 'D' then 'Débito' else 'Crédito' end as "D/C", 
       tlc.cd_tlc || ' - ' || tlc.ds_tlc as tipo_lancamento,
       cnt_ctp.cd_cnt || ' - ' || cnt_ctp.nm_cnt as contrapartida, 
       replace(coalesce(scn_ctp.cd_cnt_ctb1, cnt_ctp.cd_cnt_ctb1), '.', '') as fortes_contrapartida,
       sum(lcn.vl_lcn) as valor
from sc_cnt.tbl_lcn lcn
     inner join sc_cnt.tbl_cnt cnt on lcn.cd_cnt = cnt.cd_cnt
     inner join sc_cnt.tbl_scn scn on cnt.cd_scn = scn.cd_scn
     inner join sc_cnt.tbl_tlc tlc on lcn.cd_tlc = tlc.cd_tlc
     left join sc_cnt.tbl_lcn lcn_ctp on lcn.cd_ctp_lcn = lcn_ctp.cd_lcn
     left join sc_cnt.tbl_cnt cnt_ctp on lcn_ctp.cd_cnt = cnt_ctp.cd_cnt
     left join sc_cnt.tbl_scn scn_ctp on cnt_ctp.cd_scn = scn_ctp.cd_scn
where cnt.cd_cnt in (116311, 116310, 116309, 116312)
  --and lcn.cd_tlc in (1412)
  and lcn.dt_ref_lcn >= '2016-01-01'
  and lcn.dt_ref_lcn < '2017-01-01'
group by lcn.dt_ref_lcn::date, cnt.cd_cnt, cnt.nm_cnt, lcn.fg_dcr_lcn, tlc.cd_tlc, tlc.ds_tlc, cnt_ctp.cd_cnt, cnt_ctp.nm_cnt, replace(coalesce(scn_ctp.cd_cnt_ctb1, cnt_ctp.cd_cnt_ctb1), '.', '')
order by lcn.dt_ref_lcn::date, conta, "D/C", tipo_lancamento;

--gerar a lista de todos os lancamentos sintetico por data, conta, e contra_partida dos lançamentos realizados com o tipo: 1412 na conta 116308.
--justificando lançamentos na conta: 2.01.01.02.03.0003 – Mandatário Gaia
select to_char(lcn.dt_ref_lcn::date, 'dd/mm/yyyy') as data_ref, 
       cnt.cd_cnt || ' - ' || cnt.nm_cnt as conta, 
       case when lcn.fg_dcr_lcn = 'D' then 'Débito' else 'Crédito' end as "D/C", 
       tlc.cd_tlc || ' - ' || tlc.ds_tlc as tipo_lancamento,
       cnt_ctp.cd_cnt || ' - ' || cnt_ctp.nm_cnt as contrapartida, 
       replace(coalesce(scn_ctp.cd_cnt_ctb1, coalesce(cnt_ctp.cd_cnt_ctb1, cnt_ctp.cd_cnt_ctb)), '.', '') as fortes_contrapartida,
       sum(lcn_ctp.vl_lcn) as valor
from sc_cnt.tbl_lcn lcn
     inner join sc_cnt.tbl_cnt cnt on lcn.cd_cnt = cnt.cd_cnt
     inner join sc_cnt.tbl_scn scn on cnt.cd_scn = scn.cd_scn
     inner join sc_cnt.tbl_tlc tlc on lcn.cd_tlc = tlc.cd_tlc
     left join sc_cnt.tbl_lcn lcn_ctp on lcn.cd_ctp_lcn = lcn_ctp.cd_lcn or lcn_ctp.cd_ctp_lcn = lcn.cd_lcn
     left join sc_cnt.tbl_cnt cnt_ctp on lcn_ctp.cd_cnt = cnt_ctp.cd_cnt
     left join sc_cnt.tbl_scn scn_ctp on cnt_ctp.cd_scn = scn_ctp.cd_scn
where cnt.cd_cnt = 116308
  --and lcn.cd_tlc in (1412)
  and lcn.dt_ref_lcn >= '2016-01-01'
  and lcn.dt_ref_lcn < '2017-01-01'
group by lcn.dt_ref_lcn::date, cnt.cd_cnt, cnt.nm_cnt, lcn.fg_dcr_lcn, tlc.cd_tlc, tlc.ds_tlc, cnt_ctp.cd_cnt, cnt_ctp.nm_cnt, 
         replace(coalesce(scn_ctp.cd_cnt_ctb1, coalesce(cnt_ctp.cd_cnt_ctb1, cnt_ctp.cd_cnt_ctb)), '.', '')
order by lcn.dt_ref_lcn::date, conta, "D/C", tipo_lancamento;

lcn.cd_tlc in (1412) 
  --and lcn.fg_dcr_lcn = 'D'
  and lcn.cd_cnt = 116308

  
--consultando a tabela de exportação de lancamentos (não esta registrado)
select min(lcn.dt_ref_lcn) --count(*)
from sc_ctb.tbl_ext_lcn ext_lcn
     inner join sc_cnt.tbl_lcn lcn on ext_lcn.cd_lcn = lcn.cd_lcn
where ext_lcn.cd_cnt_ctb = '1010302010001'
  and lcn.dt_ref_lcn >= '2016-01-01'
  and lcn.dt_ref_lcn < '2016-02-01';

--consultando a tabela de detalhe de arquivo de exportacao de contabilidade (não esta registrado)
select count(*)
from sc_ctb.tbl_daec daec
where /*(daec.cnt_dbt_daec = '1010302010001' or daec.cnt_crd_daec = '1010302010001') 
  and*/ daec.dt_rfr_daec >= '2016-01-01'
  and daec.dt_rfr_daec < '2016-02-01';

--obtendo o total de lancamentos, data do menor lancamento e do maior lancamento
select max(lcn.dt_ref_lcn) as maior_data, 
       min(lcn.dt_ref_lcn) as menor_data,
       sum(case when lcn.fg_dcr_lcn = 'D' then lcn.vl_lcn else 0 end) as valor_debito, 
       sum(case when lcn.fg_dcr_lcn = 'C' then lcn.vl_lcn else 0 end) as valor_credito,
       tlc.cd_tlc || ' - ' || tlc.ds_tlc as tipo_lancamento,
       lcn.cd_cnt || ' - ' || cnt.nm_cnt as conta,
       lcn_ctp.cd_cnt || ' - ' || cnt_ctp.nm_cnt as conta_contrapartida
from sc_cnt.tbl_lcn lcn
     inner join sc_cnt.tbl_cnt cnt on lcn.cd_cnt = cnt.cd_cnt
     inner join sc_cnt.tbl_tlc tlc on lcn.cd_tlc = tlc.cd_tlc
     inner join sc_cnt.tbl_lcn lcn_ctp on lcn.cd_ctp_lcn = lcn_ctp.cd_lcn
     inner join sc_cnt.tbl_cnt cnt_ctp on lcn_ctp.cd_cnt = cnt_ctp.cd_cnt
where lcn.cd_cnt = 132729
  --and lcn.cd_tlc in (1414, 1415)
  and lcn.dt_ref_lcn >= '2016-01-01'
  and lcn.dt_ref_lcn < '2017-01-01'
group by tlc.cd_tlc || ' - ' || tlc.ds_tlc, lcn.cd_cnt || ' - ' || cnt.nm_cnt, lcn_ctp.cd_cnt || ' - ' || cnt_ctp.nm_cnt
order by valor_debito desc;

--extrato sintético de lançamentos
select lcn.dt_ref_lcn::date as dt, 
       tlc.ds_tlc as tipo_lancamento,
       sum(case when lcn.fg_dcr_lcn = 'D' then lcn.vl_lcn else 0 end) as valor_debito, 
       sum(case when lcn.fg_dcr_lcn = 'C' then lcn.vl_lcn else 0 end) as valor_credito 
from sc_cnt.tbl_lcn lcn
     inner join sc_cnt.tbl_tlc tlc on lcn.cd_tlc = tlc.cd_tlc
where lcn.dt_ref_lcn >= '2016-02-01'
  and lcn.dt_ref_lcn < '2016-04-01'
  and lcn.cd_cnt = 116308
group by lcn.dt_ref_lcn::date, tlc.ds_tlc
order by dt, valor_debito desc;

--consulta de ccb antigas de forma analitica
select pls.cd_pls as cartao, cun.nm_cun as nome, cun.nr_cpf_cnpj_cun as cpf, opr.cd_opr as codigo_operacao, opr.dt_opr as data_operacao, 
       prc.dt_vnc_prc as data_vencimento, ccb.vlr_ccb as valor_ccb, ccb.vlr_sld_dvd_ccb as valor_saldo_devedor_ccb, ccb.*
from sc_ccb.tbl_ccb_ant ccb
     inner join sc_opr.tbl_opr opr on ccb.cd_opr = opr.cd_opr 
     inner join sc_opr.tbl_pls pls on opr.cd_pls = pls.cd_pls 
     inner join sc_cad.tbl_cun cun on pls.cd_cun = cun.cd_cun 
     inner join sc_fcr.tbl_prc prc on opr.cd_opr = prc.cd_opr 
where dt_rps_ccb::date = '2016-03-01';

--consulta de ccb antigas de forma sintetica
select sum(ccb.vlr_ccb) as valor_ccb, sum(ccb.vlr_sld_dvd_ccb) as valor_saldo_devedor_ccb
from sc_ccb.tbl_ccb_ant ccb
     inner join sc_opr.tbl_opr opr on ccb.cd_opr = opr.cd_opr 
     inner join sc_opr.tbl_pls pls on opr.cd_pls = pls.cd_pls 
     inner join sc_cad.tbl_cun cun on pls.cd_cun = cun.cd_cun 
     inner join sc_fcr.tbl_prc prc on opr.cd_opr = prc.cd_opr 
where dt_rps_ccb::date = '2016-03-01';

--select auxiliares
select * from sc_ctb.tbl_daec limit 10;

select min(cd_daec_cpl) 
from sc_ctb.tbl_daec_cpl 
where cnt_daec_cpl like '101030201%';

select * from sc_ctb.tbl_daec_cpl where cd_daec_cpl = 952035;

select * from sc_ctb.tbl_arq_ctb where dt_arq_ctb = '2016-01-01';
select * from sc_dwn.tbl_dwa where cd_dwa = 18648;
select * from sc_cnt.tbl_lcn limit 10;
select * from sc_ccb.tbl_rps_ant where cd_rps = 3;

select cd_cun from sc_opr.tbl_pls limit 10

select sum(vlr_ccb) from sc_ccb.tbl_ccb_ant where dt_rps_ccb::date = '2016-02-26';
1474.63

select sum(prc.vl_prc) as valor_parcela
from sc_fcr.tbl_prc prc
     inner join sc_fcr.tbl_fcr fcr on prc.cd_fcr = fcr.cd_fcr
     inner join sc_opr.tbl_opr opr on prc.cd_opr = opr.cd_opr
where fcr.dt_vnc_fcr = '2016-02-26'
  and opr.cd_top = 5;

"116308 - COBRANÇA GAIA"