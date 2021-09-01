--consultas todas as ccbs repassadas em um determinado período
select to_char(ccb.dt_inc_ccb, 'dd/MM/yyyy') as data_geracao,
       ccb.cd_ccb as codigo, ccb.vlr_ccb as valor_ccb, opr.vl_iof_opr as valor_iof, opr.vl_jrs_opr as valor_juros,
       opr.vl_trf_opr as valor_tarifa, ccb.vlr_lib_ccb - opr.vl_trf_opr as valor_liquido,
       ccb.vlr_slc_ccb as valor_compra, to_char(ccb.dt_vnc_ccb, 'dd/MM/yyyy') as data_vencimento,
       cun.nm_cun as sacado, edr.logradouro, edr.bairro, edr.localidade, edr.uf, edr.cep_edr,
       to_char(ccb.dt_rps_ccb, 'dd/MM/yyyy') as data_repasse, ccb.vl_pgt_ccb as valor_pagamento,
       ccb.vl_pgt_jrs_ccb as mora, ccb.vl_pgt_mlt_ccb as multa, dmn.nm_vlr_dmn as situacao,
       cun.nr_cpf_cnpj_cun as cpf, csn.nm_csn as cessionaria
from sc_ccb.tbl_ccb ccb
     inner join sc_ccb.tbl_csn csn on ccb.cd_csn = csn.cd_csn
     inner join sc_opr.tbl_opr opr on ccb.cd_opr = opr.cd_opr
     inner join sc_opr.tbl_pls pls on opr.cd_pls = pls.cd_pls
     inner join sc_opr.tbl_crt crt on pls.cd_crt = crt.cd_crt
     inner join sc_cad.tbl_fnc fnc on crt.cd_fnc = fnc.cd_fnc
     inner join sc_cad.tbl_cun cun on fnc.cd_cun = cun.cd_cun
     inner join sc_cad.tbl_dmn dmn on ccb.st_ccb = dmn.vl_cmp_dmn and dmn.nm_cmp_dmn = 'ST_CCB'
     left join (select max(edr.cd_edr) as cd_edr, edr.cd_cun
                from sc_cad.tbl_edr edr
                group by edr.cd_cun) edr_max on cun.cd_cun = edr_max.cd_cun
     left join sc_cad.vw_edr edr on edr_max.cd_edr = edr.cd_edr
where ccb.dt_rps_ccb >= '2019-12-01' --data inicial de repasse
  and ccb.dt_rps_ccb < '2020-01-01' --data final de repasse
  and ccb.st_ccb = 2 --situação liquidado
order by codigo;

--consultas todas as ccbs geradas em um determinado período
select to_char(ccb.dt_inc_ccb, 'dd/MM/yyyy') as data_geracao,
       ccb.cd_ccb as codigo, ccb.vlr_ccb as valor_ccb, opr.vl_iof_opr as valor_iof, opr.vl_jrs_opr as valor_juros,
       opr.vl_trf_opr as valor_tarifa, ccb.vlr_lib_ccb - opr.vl_trf_opr as valor_liquido,
       ccb.vlr_slc_ccb as valor_compra, to_char(ccb.dt_vnc_ccb, 'dd/MM/yyyy') as data_vencimento,
       cun.nm_cun as sacado, edr.logradouro, edr.bairro, edr.localidade, edr.uf, edr.cep_edr,
       to_char(ccb.dt_rps_ccb, 'dd/MM/yyyy') as data_repasse, ccb.vl_pgt_ccb as valor_pagamento,
       ccb.vl_pgt_jrs_ccb as mora, ccb.vl_pgt_mlt_ccb as multa, dmn.nm_vlr_dmn as situacao,
       cun.nr_cpf_cnpj_cun as cpf, csn.nm_csn as cessionaria
from sc_ccb.tbl_ccb ccb
     inner join sc_ccb.tbl_csn csn on ccb.cd_csn = csn.cd_csn
     inner join sc_opr.tbl_opr opr on ccb.cd_opr = opr.cd_opr
     inner join sc_opr.tbl_pls pls on opr.cd_pls = pls.cd_pls
     inner join sc_opr.tbl_crt crt on pls.cd_crt = crt.cd_crt
     inner join sc_cad.tbl_fnc fnc on crt.cd_fnc = fnc.cd_fnc
     inner join sc_cad.tbl_cun cun on fnc.cd_cun = cun.cd_cun
     inner join sc_cad.tbl_dmn dmn on ccb.st_ccb = dmn.vl_cmp_dmn and dmn.nm_cmp_dmn = 'ST_CCB'
     left join (select max(edr.cd_edr) as cd_edr, edr.cd_cun
                from sc_cad.tbl_edr edr
                group by edr.cd_cun) edr_max on cun.cd_cun = edr_max.cd_cun
     left join sc_cad.vw_edr edr on edr_max.cd_edr = edr.cd_edr
where ccb.dt_inc_ccb >= '2019-12-01' --data inicial de geração
  and ccb.dt_inc_ccb < '2020-01-01' --data final de geração
  --and ccb.st_ccb = 1 --situação cadastrado
  --AND coalesce(ccb.vl_pgt_ccb, 0) = 0 --que não possuem pagamento
order by codigo;