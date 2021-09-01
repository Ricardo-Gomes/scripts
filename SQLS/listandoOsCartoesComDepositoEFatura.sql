--criando rotina de estorno
--executar script: sc_fcr/estorno_pagamento_arquivo.sql

--executando a rotina criada de estorno
select sc_fcr.estorno_pagamento_arquivo(170319, '2019-07-08');
select sc_fcr.estorno_pagamento_arquivo(170287, '2019-07-08');

--listando todos os estornos realizados
select crt.cd_crt as cartao, cun.nm_cun as nome, rdp.vl_dep_rdp as valor_deposito, fcr.vl_fcr as valor_fatura, pfc.vl_pfc as valor_estornado, fcr.dt_ems_fcr
from sc_adp.tbl_rdp rdp
     inner join sc_adp.tbl_hfe hfe on rdp.cd_hfe = hfe.cd_hfe
     inner join sc_opr.tbl_crt crt on rdp.cd_crt = crt.cd_crt
     inner join sc_cad.tbl_fnc fnc on crt.cd_fnc = fnc.cd_fnc
     inner join sc_cad.tbl_cun cun on cun.cd_cun = fnc.cd_cun
     inner join sc_fcr.tbl_fcr fcr on crt.cd_crt = fcr.cd_crt and fcr.dt_vnc_fcr = '2019-07-08'
     inner join sc_fcr.tbl_pfc pfc on fcr.cd_fcr = pfc.cd_fcr
where rdp.cd_hfe in (170287, 170319)
  --and pfc.cd_pfc = 587837
order by dt_vnc_fcr;
