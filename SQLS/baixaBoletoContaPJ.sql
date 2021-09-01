select * from sc_cce.tbl_tit where vl_tit = 14860.44 and dt_vnc_tit >= '2019-12-27';
select * from sc_cbr.tbl_blt where cd_blt = 48805;
select * from sc_cbr.tbl_drb where cd_drb = 44752;

--listando todas as faixas de nosso números cadastradas
select cce.cd_cce, 
       gem.cd_gem || ' - ' || gem.nm_gem as grupo_empresarial,
       emp.cd_emp || ' - ' || emp.nm_emp as empresa, 
       cnt.cd_cnt || ' - ' || cnt.nm_cnt as conta, 
       cun.nr_cpf_cnpj_cun as cnpj, cun.nm_cun as razao_social, 
       cce.ns_nmr_ini_cce || ' - ' || cce.ns_nmr_fin_cce as faixa_nosso_numero
from sc_cce.tbl_cce cce
     inner join sc_cad.tbl_cun cun on cce.cd_cun = cun.cd_cun
     inner join sc_cad.tbl_fem fem on cun.cd_cun = fem.cd_cun and fem.cd_fem = 1
     inner join sc_cad.tbl_emp emp on fem.cd_emp = emp.cd_emp
     inner join sc_cad.tbl_gem gem on emp.cd_gem = gem.cd_gem
     inner join sc_cnt.tbl_cnt cnt on cce.cd_cnt = cnt.cd_cnt
order by faixa_nosso_numero asc;

select * from sc_cbr.tbl_harcg order by cd_harcg desc limit 10

--listando todas as baixas de boleto de conta PJ de um determinado período
select blt.cd_doc_blt as nosso_numero, blt.cd_blt as codigo_boleto, 
       blt.nr_nsu_org_blt as numero_titulo,
       blt.dt_vnc_blt as data_vencimento, blt.vl_blt as valor_boleto,
       blt.nm_sac_blt as sacado, blt.nr_cpfcnpj_sac_blt as cnpj_sacado,
       blt.nm_avl_blt as avalista, blt.nr_cpf_cnpj_avl_blt as cnpj_avalista,
       blt.nr_lin_dgt_blt as linha_digitavel,
       darcg.vl_pgt_darcg as valor_pago, darcg.dt_ocb_darcg as data_pagamento,
       darcg.dt_crd_darcg as data_baixa, darcg.vl_jrs_darcg as vaor_juros_pago,
       ccb.cd_cnt || ' - ' || cnt.nm_cnt as conta_bancaria--, blt.*
from sc_cbr.tbl_darcg darcg
     inner join sc_cbr.tbl_harcg harcg on harcg.cd_harcg = darcg.cd_harcg
     inner join sc_cbr.tbl_blt blt on blt.cd_blt = darcg.cd_blt
     inner join sc_cbr.tbl_ccb ccb on blt.cd_ccb = ccb.cd_ccb
     inner join sc_cnt.tbl_cnt cnt on ccb.cd_cnt = cnt.cd_cnt
where darcg.st_darcg = 2
  --and harcg.cd_harcg = vp_cod_arquivo
  and harcg.st_harcg = 2
  and blt.tp_org_blt = 8 --Boleto de conta PJ
  and darcg.nr_ocr_darcg in (6, 17) --TP_OCORRENCIA_LIQUIDACAO, TP_OCORRENCIA_LIQUIDACAO_POS_BAIXA_OU_TITULO_NAO_REGISTRADO
  and harcg.nr_cdt_harcg = 4831845
  and harcg.dt_crd_harcg >= '2019-12-24' -- data inicial da baixa 
  and harcg.dt_crd_harcg <= '2019-12-27' -- data final da baixa 
  and blt.cd_doc_blt = 48318460267 --nosso numero do boleto
order by nosso_numero;

--listando todos os boletos baixados de forma errada
select cnt.cd_cnt || ' - ' || cnt.nm_cnt as conta_credito, cnt_err.cd_cnt || ' - ' || cnt_err.nm_cnt as conta_errado, 
       cce.cd_cce, tit.vl_tit as valor_titulo, tit.vl_pgt_tit as valor_pago, tit.ns_nmr_tit as nosso_numero, tit.st_tit as situacao
from sc_cce.tbl_tit tit
     inner join sc_cce.tbl_cce cce on tit.ns_nmr_tit >= cce.ns_nmr_ini_cce and tit.ns_nmr_tit <= cce.ns_nmr_fin_cce 
     inner join sc_cce.tbl_cce cce_err on tit.cd_cce = cce_err.cd_cce
     inner join sc_cnt.tbl_cnt cnt on cce.cd_cnt = cnt.cd_cnt
     inner join sc_cnt.tbl_cnt cnt_err on cce_err.cd_cnt = cnt_err.cd_cnt
where tit.st_tit = 2
  and tit.cd_cce = 3
  and cce.cd_cce = 1;  

select * from SC_PBL.TBL_UPL where cd_upl = 11;

select * 
from sc_cce.tbl_hrb hrb
     inner join sc_cce.tbl_drb drb on hrb.cd_hrb = drb.cd_hrb
where drb.nr_doc_drb = 48318460267
   --cd_cce = 3 
order by hrb.cd_hrb desc limit 10;

select max(nr_doc_drb) from sc_cce.tbl_drb drb where cd_hrb = 5031;

select * from sc_cad.tbl_dmn where nm_cmp_dmn = 'ST_TIT'
select * from sc_job.tbl_plj