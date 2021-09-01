select * from sc_cad.tbl_dmn where nm_cmp_dmn = 'ST_RCG';

select dt_rcg, cd_rtn_rcg, vl_rcg
from sc_rcg.tbl_rcg 
where dt_ctb_rcg >= current_date
order by dt_rcg desc;

select dt_rcg::date as dt_recarga, sum(vl_rcg) as valor
from sc_rcg.tbl_rcg 
where dt_ctb_rcg >= current_date
group by dt_rcg::date
order by dt_recarga;

SELECT sc_rcg.cancelar_contabilizacao_recargas(CURRENT_DATE);
SELECT sc_rcg.contabilizar_recargas();


SELECT sc_pgc.cancelar_contabilizacao_pagamentos(CURRENT_DATE);
SELECT sc_pgc.contabilizar_pagamentos();


select sum(pgt.vl_pgt) as valor_descontar
    from sc_pgc.tbl_pgt pgt
    where pgt.cd_crr = 3
      and pgt.st_pgt = 7
      and pgt.dt_ctb_pgt is not null
      and pgt.dt_ctb_cnc_pgt is null;

      UPDATE SC_PGC.TBL_PGT SET DT_CTB_CNC_PGT = NULL WHERE CD_PGT = 64560;

select *
FROM sc_pgc.tbl_pgt 
    where st_pgt = 7 
      and dt_ctb_cnc_pgt >= CURRENT_DATE
      and dt_ctb_cnc_pgt < CURRENT_DATE + interval '1 day'
      AND cd_crr = 3;
      
select *
from sc_rcg.tbl_rcg
where cd_rtn_rcg in ('101686461', '101686368');

SELECT RCG.CD_RCG AS CODIGO_RECARGA, RCG.DT_RCG, RCG.ST_RCG, DMN.NM_VLR_DMN AS SITUACAO, CRT.CD_CRT AS CARTAO, CNT_CRT.CD_CNT AS CONTA,
       TBC_CNT.VL_BLQ_TBC_CNT AS VALOR_BLOQUEADO, RCG.VL_RCG AS VALOR_RECARGA,
	   'update sc_cnt.tbl_tbc_cnt set vl_blq_tbc_cnt = ' || RCG.vl_RCG || ' where cd_tbc_cnt = ' || tbc_cnt.cd_tbc_cnt || ';' as comando
FROM SC_RCG.TBL_RCG RCG
     INNER JOIN SC_CAD.TBL_DMN DMN ON DMN.NM_CMP_DMN = 'ST_RCG' AND DMN.VL_CMP_DMN = RCG.ST_RCG
     INNER JOIN SC_OPR.TBL_CRT CRT ON RCG.CD_CRT = CRT.CD_CRT
     INNER JOIN SC_OPR.TBL_CNT_CRT CNT_CRT ON CRT.CD_CRT = CNT_CRT.CD_CRT
     INNER JOIN SC_CNT.TBL_TBC_CNT TBC_CNT ON CNT_CRT.CD_CNT = TBC_CNT.CD_CNT AND TBC_CNT.CD_TBC = 6 --BLOQUEIO POR PAGAMENTO DE CONTA
WHERE RCG.CD_CRR = 3 --CORRESPONDENTE CELCOIN
  AND RCG.ST_RCG = 6 --PENDENTE DE CONFIRMACAO
ORDER BY CODIGO_RECARGA;

update sc_cnt.tbl_tbc_cnt set vl_blq_tbc_cnt = 20.00 where cd_tbc_cnt = 82592;
update sc_cnt.tbl_tbc_cnt set vl_blq_tbc_cnt = 20.00 where cd_tbc_cnt = 82592;
update sc_cnt.tbl_tbc_cnt set vl_blq_tbc_cnt = 20.00 where cd_tbc_cnt = 77331;
update sc_cnt.tbl_tbc_cnt set vl_blq_tbc_cnt = 10.00 where cd_tbc_cnt = 101499;

