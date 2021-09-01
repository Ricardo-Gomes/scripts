select * from sc_atb.tbl_tba where cd_tba = 334969;

select * from sc_atb.tbl_dtb where cd_dtb = 292578;
select * from sc_atb.tbl_dtb where cd_atb = 2741 order by vl_dtb;

select * from sc_cad.tbl_dmn where nm_cmp_dmn = 'CD_MTV_INV_DRT';

select ds_rdz_ort
    from sc_atb.tbl_ort
    where cd_ort = 'BN';

SELECT sc_atb.cancela_transferencia(292578,'Data da efetivação anterior a do processamento',null);  

select * from sc_atb.tbl_drt where nr_doc_drt in (292578) limit 10;


select * 
from sc_atb.tbl_art 
where st_art = 2 
  and dt_prc_art >= current_date - 1 
  and dt_prc_art < current_date
order by cd_art 