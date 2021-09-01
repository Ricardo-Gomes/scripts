select to_char(opr.dt_opr::date, 'dd/mm/yyyy') as data_compra, 
       to_char(prc.dt_vnc_prc, 'dd/mm/yyyy') as data_vencimento,
       to_char(pfc_prc.dt_pagto, 'dd/mm/yyyy') as data_pagamento, 
       sum(prc.vl_prc) as valor,
       sum(coalesce(prc.vl_pgt_prc, 0)) as valor_pago,
       sum(prc.vl_prc - coalesce(prc.vl_pgt_prc, 0)) as valor_a_pagar
from sc_fcr.tbl_prc prc
     inner join sc_opr.tbl_opr opr on opr.cd_opr = prc.cd_opr
     left join (select min(pfc.dt_pgt_pfc)::date as dt_pagto, pfc_prc.cd_prc
                from sc_fcr.tbl_pfc_prc pfc_prc
                     inner join sc_fcr.tbl_pfc pfc on pfc_prc.cd_pfc = pfc.cd_pfc
                group by pfc_prc.cd_prc) pfc_prc on prc.cd_prc = pfc_prc.cd_prc
where opr.cd_top = 27
group by opr.dt_opr::date, prc.dt_vnc_prc, pfc_prc.dt_pagto
order by data_compra;


select * from sc_fcr.tbl_prc limit 10

select * from sc_fcr.tbl_pfc_prc where cd_prc = 12737;
select * from sc_fcr.tbl_pfc where cd_pfc = 8967;