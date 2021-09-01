select rce.*, emc.dbt_cd_cnt
from sc_cbe.tbl_rce rce
inner join sc_cbe.tbl_emc emc on emc.cd_emc = rce.cd_emc
where rce.st_rce = 4
  AND rce.dt_rce >= '2019-10-30'
  AND RCE.CD_RCE = 138;

135;"2019-10-09";2671.88;493.29;3433.00;267.83
138;"2019-10-30";1175.74;285.87;1719.40;257.79
139;"2019-11-06";767.70;97.14;999.20;134.36


SELECT RCE.CD_RCE, TO_CHAR(RCE.DT_RCE, 'DD/MM/YYYY') AS DT_REPASSE, RCE.VL_RCE AS VALOR_REPASSE, RCE.VL_CMS_RCE AS VALOR_COMISSAO, RCE.VL_BPR_RCE AS VALOR_PARCELAS_BAIXADAS, 
       RCE.VL_BPR_RCE - (RCE.VL_RCE + RCE.VL_CMS_RCE) AS DIFERENCA
FROM SC_CBE.TBL_RCE RCE
WHERE RCE.CD_EMC = 4
  AND RCE.ST_RCE = 4
  AND RCE.VL_RCE + RCE.VL_CMS_RCE < RCE.VL_BPR_RCE - 1;

SELECT * FROM SC_CBE.TBL_PRD LIMIT 10

SELECT PRD.CD_PRD, PRD.VLR_PRD, SUM(BPR.VL_BPR) AS SOMA_BAIXA
FROM SC_CBE.TBL_BPR BPR
     INNER JOIN SC_CBE.TBL_PRD PRD ON BPR.CD_PRD = PRD.CD_PRD 
WHERE BPR.CD_RCE = 135 
GROUP BY PRD.CD_PRD, PRD.VLR_PRD
ORDER BY VLR_PRD


SELECT * FROM SC_CNT.TBL_LCN WHERE CD_LCN IN (21034448)

select CD_LCN, CD_TLC, DT_LCN, FG_DCR_LCN, NM_HIS_LCN, CD_CNT, VL_LCN
from sc_cnt.tbl_lcn
where cd_sst = 32
 and nsu_lcn = 138
order by fg_dcr_lcn, cd_cnt, vl_lcn, CD_LCN;


select sc_cnt.excluir_lancamento(21034448, 'CORRECAO DA CONTABILIDADE DO DIA 31/10/2019');
select sc_cnt.excluir_lancamento(21034459, 'CORRECAO DA CONTABILIDADE DO DIA 31/10/2019');
select sc_cnt.excluir_lancamento(21034477, 'CORRECAO DA CONTABILIDADE DO DIA 31/10/2019');
select sc_cnt.excluir_lancamento(21034488, 'CORRECAO DA CONTABILIDADE DO DIA 31/10/2019');

select sc_cnt.fecha_saldo_conta_periodo(133226, '2019-10-31', '2019-11-19');
select sc_cnt.fecha_saldo_conta_periodo(133227, '2019-10-31', '2019-11-19');
select sc_cnt.fecha_saldo_conta_periodo(138179, '2019-10-31', '2019-11-19');
select sc_cnt.fecha_saldo_conta_periodo(138180, '2019-10-31', '2019-11-19');
select sc_cnt.fecha_saldo_conta_periodo(142513, '2019-10-31', '2019-11-19');
select sc_cnt.fecha_saldo_conta_periodo(157229, '2019-10-31', '2019-11-19');
select sc_cnt.fecha_saldo_conta_periodo(182921, '2019-10-31', '2019-11-19');
select sc_cnt.fecha_saldo_conta_periodo(209624, '2019-10-31', '2019-11-19');
select sc_cnt.fecha_saldo_conta_periodo(246973, '2019-10-31', '2019-11-19');
select sc_cnt.fecha_saldo_conta_periodo(19083, '2019-10-31', '2019-11-19');
select sc_cnt.fecha_saldo_conta_periodo(142512, '2019-10-31', '2019-11-19');

SELECT sc_ctb.gerar_arquivo_exportacao_periodo('2019-10-31', '2019-10-31');
