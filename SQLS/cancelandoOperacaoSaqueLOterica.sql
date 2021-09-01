SELECT * FROM SC_OPR.TBL_TOP WHERE CD_TOP = 26;
SELECT * FROM SC_CNT.TBL_TLC WHERE DS_TLC LIKE '%SAQUE%';


SELECT sc_rdc.cancelar_operacao_compra(5771523);
SELECT sc_rdc.cancelar_operacao_compra(5729579);
SELECT sc_rdc.cancelar_operacao_compra(5729569);
SELECT sc_rdc.cancelar_operacao_compra(5729530);
SELECT sc_rdc.cancelar_operacao_compra(5729515);
SELECT sc_rdc.cancelar_operacao_compra(5729190);
SELECT sc_rdc.cancelar_operacao_compra(5729187);
SELECT sc_rdc.cancelar_operacao_compra(5728709);
SELECT sc_rdc.cancelar_operacao_compra(5728703);
SELECT sc_rdc.cancelar_operacao_compra(5723530);

select opr.st_opr, opr.cd_top, opr.vl_opr, coalesce(opr.vl_crd_opr, 0), opr.dt_opr, pls.cd_crt, pls.cd_pls, opr.cd_fet, cnt_crt.cd_cnt, etb.cd_cnt
  from sc_opr.tbl_opr opr
       inner join sc_opr.tbl_pls pls on pls.cd_pls = opr.cd_pls
       inner join sc_opr.tbl_cnt_crt cnt_crt on pls.cd_crt = cnt_crt.cd_crt
       inner join sc_rdc.tbl_fet fet on fet.cd_fet = opr.cd_fet
       inner join sc_rdc.tbl_etb etb on etb.cd_etb = fet.cd_etb
  where opr.cd_opr = 5771523;