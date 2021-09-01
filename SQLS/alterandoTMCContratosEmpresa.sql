select * from sc_cad.tbl_pce where cd_pce = 15 order by nm_pce;

update sc_cad.tbl_pce set vl_pad_pce = '5.90' where cd_pce = 15;

select emp.nm_emp as empresa, ctr_pce.*
from sc_cad.tbl_ctr ctr
     inner join sc_cad.tbl_emp emp on ctr.cd_emp = emp.cd_emp
     inner join sc_cad.tbl_pce_ctr ctr_pce on ctr.cd_ctr = ctr_pce.cd_ctr
where ctr.fg_atv_ctr = 'S'
  and ctr_pce.cd_pce = 15
  and ctr_pce.vl_pce_ctr in ('4,99', '5,00')
order by ctr_pce.vl_pce_ctr, empresa;

update sc_cad.tbl_pce_ctr set vl_pce_ctr = '5,90' where cd_pce_ctr in (1609, 4297, 2449, 1301, 6089, 8133, 12301, 12263, 7937, 601, 14404, 5193);