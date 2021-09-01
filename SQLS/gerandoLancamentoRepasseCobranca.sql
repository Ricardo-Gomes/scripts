select cnt_crt.cd_cnt, cnt_crt.cd_crt, cun.nm_cun as nome, fcr.vl_sld_dvd_fcr, fcr.st_fcr
from sc_cad.tbl_cun cun
     inner join sc_cad.tbl_fnc fnc on cun.cd_cun = fnc.cd_cun
     inner join sc_opr.tbl_crt crt on fnc.cd_fnc = crt.cd_fnc
     inner join sc_opr.tbl_cnt_crt cnt_crt on crt.cd_crt = cnt_crt.cd_crt
     left join sc_fcr.tbl_fcr fcr on crt.cd_fcr = fcr.cd_Fcr
where cun.nr_cpf_cnpj_cun in (03065585308, 18648460387, 02598065360, 06368221330, 68849303300, 03366524375, 35851210397)
  and fcr.st_fcr = 6
order by nome;


select sc_cnt.lancar_movimento(nextval('sc_cnt.sq_lcn'), 22112547, 1435, 92946, 'C', 204.10, '2019-12-30', 1, null, 'REPASSE DE COBRANCA EXTERNA NSU 146', 32, 146);
select sc_cnt.lancar_movimento(nextval('sc_cnt.sq_lcn'), 22112547, 1435, 165781, 'C', 434.10, '2019-12-30', 1, null, 'REPASSE DE COBRANCA EXTERNA NSU 146', 32, 146);
select sc_cnt.lancar_movimento(nextval('sc_cnt.sq_lcn'), 22112547, 1435, 240709, 'C', 179.10, '2019-12-30', 1, null, 'REPASSE DE COBRANCA EXTERNA NSU 146', 32, 146);
select sc_cnt.lancar_movimento(nextval('sc_cnt.sq_lcn'), 22112547, 1435, 98185, 'C', 374.10, '2019-12-30', 1, null, 'REPASSE DE COBRANCA EXTERNA NSU 146', 32, 146);
select sc_cnt.lancar_movimento(nextval('sc_cnt.sq_lcn'), 22112547, 1435, 267184, 'C', 172.30, '2019-12-30', 1, null, 'REPASSE DE COBRANCA EXTERNA NSU 146', 32, 146);
select sc_cnt.lancar_movimento(nextval('sc_cnt.sq_lcn'), 22112547, 1435, 138180, 'C', 190.10, '2019-12-30', 1, null, 'REPASSE DE COBRANCA EXTERNA NSU 146', 32, 146);
select sc_cnt.lancar_movimento(nextval('sc_cnt.sq_lcn'), 22112547, 1435, 65200, 'C', 214.10, '2019-12-30', 1, null, 'REPASSE DE COBRANCA EXTERNA NSU 146', 32, 146);


select * from sc_cnt.tbl_tbc_cnt where cd_cnt = 92946;
select * from sc_cnt.tbl_tbc

92946 -> 204.10 
165781 -> 434.10 
240709 -> 179.10 
98185 -> 374.10 
267184 ->  172.30 
138180 -> 190.10 
65200 -> 214.10 







