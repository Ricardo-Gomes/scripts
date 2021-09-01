select pls.cd_crt as cartao, count(*) as qtde, sum(opr.vl_opr) as valor, min(opr.dt_opr) as menor_data, max(opr.dt_opr) as maior_data
from sc_opr.tbl_pls pls
     inner join sc_opr.tbl_opr opr on pls.cd_pls = opr.cd_pls
where opr.cd_top = 5
  and opr.st_opr = 2
group by pls.cd_crt
having count(*) > 50
order by qtde desc;

--> código da operação: 765882 - 6201554220691917 - 397,31 - 75 - SHOP PARANGABA 01 (06-01-2016)
--> código da operação: 1633882 (01-102-16)

select * from sc_opr.tbl_opr where cd_opr = 765882;
select * from sc_ccb.tbl_ccb where cd_opr in (765882, 1633882);
select min(cd_opr) from sc_ccb.tbl_ccb;

--listando todos os lancamentos de contas vinculados a uma determinada operação de saque extra - analítico
SELECT opr.cd_opr as codigo, opr.vl_opr as valor_cobrado, vl_opr - (vl_trf_opr+ vl_iof_opr+ vl_jrs_opr) as valor_sacado,
       opr.vl_trf_opr as valor_tarifa, opr.vl_iof_opr as valor_iof, opr.vl_jrs_opr as valor_juros,
       CNT.CD_CNT, CNT.NM_CNT AS CONTA, LCN.DT_REF_LCN, LCN.NM_HIS_LCN, LCN.FG_DCR_LCN, LCN.VL_LCN
FROM sc_opr.tbl_opr opr
     inner join SC_CNT.TBL_LCN LCN on lcn.cd_sst = 3 and lcn.nsu_lcn = opr.cd_opr
     INNER JOIN SC_CNT.TBL_CNT CNT ON LCN.CD_CNT = CNT.CD_CNT
WHERE opr.st_opr = 2 
  AND opr.cd_top = 5
  and opr.dt_opr >= '2016-01-01'
  and opr.dt_opr < '2017-01-01'
order by codigo
limit 100;

--listando todos os lancamentos de contas vinculados a uma determinada operação de saque extra - sintético
SELECT opr.dt_opr::Date as dt, to_char(opr.dt_opr::Date, 'dd/mm/yyyy') as data, 
       (CASE WHEN SCN.CD_SCN IN (20, 30) THEN SCN.CD_SCN ELSE CNT.CD_CNT END) AS CODIGO_CONTA,
       (CASE WHEN SCN.CD_SCN IN (20, 30) THEN SCN.DS_SCN ELSE CNT.NM_CNT END) AS nome_CONTA,
       replace(coalesce(scn.cd_cnt_ctb1, coalesce(cnt.cd_cnt_ctb1, cnt.cd_cnt_ctb)), '.', '') as conta_fortes,  
       lcn.cd_tlc as tipo_lancamento, TLC.DS_TLC AS NOME_TIPO_LANCAMENTO,
       LCN.FG_DCR_LCN as "D/C", 
       (CASE WHEN SCN_ctp.CD_SCN IN (20, 30) THEN SCN_ctp.CD_SCN ELSE CNT_ctp.CD_CNT END) AS CODIGO_CONtrapartida,
       (CASE WHEN SCN_ctp.CD_SCN IN (20, 30) THEN SCN_ctp.DS_SCN ELSE CNT_ctp.NM_CNT END) AS nome_CONTrapartida, 
       replace(coalesce(scn_ctp.cd_cnt_ctb1, coalesce(cnt_ctp.cd_cnt_ctb1, cnt_ctp.cd_cnt_ctb)), '.', '') as contrapartida_fortes,
       sum(LCN.VL_LCN) as valor
FROM sc_opr.tbl_opr opr
     inner join SC_CNT.TBL_LCN LCN on lcn.cd_sst = 3 and lcn.nsu_lcn = opr.cd_opr and lcn.fg_dcr_lcn = 'D'
     INNER JOIN SC_CNT.TBL_TLC TLC ON LCN.CD_TLC = TLC.CD_TLC
     INNER JOIN SC_CNT.TBL_CNT CNT ON LCN.CD_CNT = CNT.CD_CNT
     INNER JOIN SC_CNT.TBL_SCN SCN ON CNT.CD_SCN = SCN.CD_SCN
     inner join SC_CNT.TBL_LCN LCN_ctp on lcn.cd_ctp_lcn = lcn_ctp.cd_lcn
     INNER JOIN SC_CNT.TBL_CNT CNT_ctp ON LCN_ctp.CD_CNT = CNT_ctp.CD_CNT
     INNER JOIN SC_CNT.TBL_SCN SCN_ctp ON CNT_ctp.CD_SCN = SCN_ctp.CD_SCN
WHERE opr.st_opr = 2 
  AND opr.cd_top = 5
  and opr.dt_opr >= '2016-01-01'
  and opr.dt_opr < '2017-01-01'
group by opr.dt_opr::Date, 
        (CASE WHEN SCN.CD_SCN IN (20, 30) THEN SCN.DS_SCN ELSE CNT.NM_CNT END), 
        (CASE WHEN SCN.CD_SCN IN (20, 30) THEN SCN.CD_SCN ELSE CNT.CD_CNT END), lcn.cd_tlc, LCN.FG_DCR_LCN, TLC.DS_TLC,
        (CASE WHEN SCN_ctp.CD_SCN IN (20, 30) THEN SCN_ctp.DS_SCN ELSE CNT_ctp.NM_CNT END), 
        (CASE WHEN SCN_ctp.CD_SCN IN (20, 30) THEN SCN_ctp.CD_SCN ELSE CNT_ctp.CD_CNT END),
        replace(coalesce(scn_ctp.cd_cnt_ctb1, coalesce(cnt_ctp.cd_cnt_ctb1, cnt_ctp.cd_cnt_ctb)), '.', ''),
        replace(coalesce(scn.cd_cnt_ctb1, coalesce(cnt.cd_cnt_ctb1, cnt.cd_cnt_ctb)), '.', '')

union all

SELECT lcn.dt_ref_lcn::Date as dt, to_char(lcn.dt_ref_lcn::Date, 'dd/mm/yyyy') as data, 
       (CASE WHEN SCN.CD_SCN IN (20, 30) THEN SCN.CD_SCN ELSE CNT.CD_CNT END) AS CODIGO_CONTA,
       (CASE WHEN SCN.CD_SCN IN (20, 30) THEN SCN.DS_SCN ELSE CNT.NM_CNT END) AS nome_CONTA,
       replace(coalesce(scn.cd_cnt_ctb1, coalesce(cnt.cd_cnt_ctb1, cnt.cd_cnt_ctb)), '.', '') as conta_fortes,  
       lcn.cd_tlc as tipo_lancamento, TLC.DS_TLC AS NOME_TIPO_LANCAMENTO,
       LCN.FG_DCR_LCN as "D/C", 
       (CASE WHEN SCN_ctp.CD_SCN IN (20, 30) THEN SCN_ctp.CD_SCN ELSE CNT_ctp.CD_CNT END) AS CODIGO_CONtrapartida,
       (CASE WHEN SCN_ctp.CD_SCN IN (20, 30) THEN SCN_ctp.DS_SCN ELSE CNT_ctp.NM_CNT END) AS nome_CONTrapartida, 
       replace(coalesce(scn_ctp.cd_cnt_ctb1, coalesce(cnt_ctp.cd_cnt_ctb1, cnt_ctp.cd_cnt_ctb)), '.', '') as contrapartida_fortes,
       sum(LCN.VL_LCN) as valor
FROM sc_aeo.tbl_aeop aeop
     inner join SC_CNT.TBL_LCN LCN on lcn.cd_sst = 21 and lcn.nsu_lcn = aeop.cd_aeop and lcn.fg_dcr_lcn = 'D'
     INNER JOIN SC_CNT.TBL_TLC TLC ON LCN.CD_TLC = TLC.CD_TLC
     INNER JOIN SC_CNT.TBL_CNT CNT ON LCN.CD_CNT = CNT.CD_CNT
     INNER JOIN SC_CNT.TBL_SCN SCN ON CNT.CD_SCN = SCN.CD_SCN
     inner join SC_CNT.TBL_LCN LCN_ctp on lcn.cd_ctp_lcn = lcn_ctp.cd_lcn
     INNER JOIN SC_CNT.TBL_CNT CNT_ctp ON LCN_ctp.CD_CNT = CNT_ctp.CD_CNT
     INNER JOIN SC_CNT.TBL_SCN SCN_ctp ON CNT_ctp.CD_SCN = SCN_ctp.CD_SCN
WHERE lcn.dt_ref_lcn >= '2016-01-01'
  and lcn.dt_ref_lcn < '2017-01-01'
  --and aeop.st_aeop <> 1
group by lcn.dt_ref_lcn::Date, 
        (CASE WHEN SCN.CD_SCN IN (20, 30) THEN SCN.DS_SCN ELSE CNT.NM_CNT END), 
        (CASE WHEN SCN.CD_SCN IN (20, 30) THEN SCN.CD_SCN ELSE CNT.CD_CNT END), lcn.cd_tlc, LCN.FG_DCR_LCN, TLC.DS_TLC,
        (CASE WHEN SCN_ctp.CD_SCN IN (20, 30) THEN SCN_ctp.DS_SCN ELSE CNT_ctp.NM_CNT END), 
        (CASE WHEN SCN_ctp.CD_SCN IN (20, 30) THEN SCN_ctp.CD_SCN ELSE CNT_ctp.CD_CNT END),
        replace(coalesce(scn_ctp.cd_cnt_ctb1, coalesce(cnt_ctp.cd_cnt_ctb1, cnt_ctp.cd_cnt_ctb)), '.', ''),
        replace(coalesce(scn.cd_cnt_ctb1, coalesce(cnt.cd_cnt_ctb1, cnt.cd_cnt_ctb)), '.', '')
        
order by dt, tipo_lancamento, nome_conta, nome_contrapartida


SELECT CNT.CD_CNT, CNT.NM_CNT AS CONTA, LCN.DT_REF_LCN, LCN.NM_HIS_LCN, LCN.FG_DCR_LCN, LCN.VL_LCN
FROM SC_CNT.TBL_LCN LCN
     INNER JOIN SC_CNT.TBL_CNT CNT ON LCN.CD_CNT = CNT.CD_CNT
WHERE LCN.CD_SST = 21 
  AND LCN.NSU_LCN = 164;
  
  SELECT * FROM sc_opr.tbl_eop WHERE CD_OPR = 765882;
  SELECT * FROM sc_ccb.tbl_ccb_ant WHERE CD_OPR = 765882;

  select * from sc_cad.tbl_dmn where nm_cmp_dmn = 'ST_AEOP'

  SELECT * FROM sc_aeo.tbl_aeoP WHERE CD_AEOP = 164;
  SELECT * FROM sc_aeo.tbl_eop WHERE CD_AEOP = 164;
  SELECT * FROM sc_aeo.tbl_eop WHERE CD_OPR = 765882;

  select sum(vl_opr) as valor_total, 
         sum(vl_opr - (vl_trf_opr+ vl_iof_opr+ vl_jrs_opr)) as valor_principal,
         sum(vl_trf_opr) as valor_tarifa, 
         sum(vl_iof_opr) as valor_iof, 
         sum(vl_jrs_opr) as valor_juros,
         count(*) as qtde
  from sc_opr.tbl_opr
  where st_opr = 2
  and cd_top = 5
  and dt_opr >= current_date;

  select * from sc_cnt.tbl_cnt where cd_cnt = 535
  select sum(vl_sld_cnt) as saldo from sc_cnt.tbl_cnt where cd_scn = 30;
  select nm_cnt, vl_sld_cnt as saldo from sc_cnt.tbl_cnt where cd_scn = 30;