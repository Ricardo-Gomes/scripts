select min(dt_vnc_tsc) as data_vencimento, cd_crt, case vl_tsc when 9.90 then 'B10' when 19.9 then 'B20' else vl_tsc::varchar end as tipo
from sc_srv.tbl_tsc 
where st_tsc = 2 
  and cd_srv = 12
group by cd_crt, case vl_tsc when 9.90 then 'B10' when 19.9 then 'B20' else vl_tsc::varchar end 
limit 10

select * from sc_cad.tbl_emp where nm_emp ilike '%excelsior%'

select pls.cd_cun, fnc.cd_cun 
from sc_opr.tbl_pls pls
     inner join sc_opr.tbl_crt crt on pls.cd_crt = crt.cd_crt
     inner join sc_cad.tbl_fnc fnc on crt.cd_fnc = fnc.cd_fnc
where cd_pls = 6058683412836994;

select min(tsc.cd_tsc) as cd_tsc, tsc.cd_crt
                 from sc_srv.tbl_tsc tsc
                      inner join sc_opr.tbl_crt crt2 on tsc.cd_crt = crt2.cd_crt
                      inner join sc_cad.tbl_ctr ctr2 on crt2.cd_ctr = ctr2.cd_ctr
                      left join sc_cad.tbl_ctr_pcs ctr_pcs2 on ctr2.cd_ctr = ctr_pcs2.cd_ctr and ctr_pcs2.fg_prd_ctr_pcs = 'S'
                 where tsc.st_tsc = 2 --tarifa foi cobrada
                   and tsc.cd_srv = 12 --tarifa de manutenção de conta
                   and tsc.dt_vnc_tsc > coalesce(crt2.dt_ads_pcs_crt, ctr_pcs2.dt_inc_usr)
                   and crt2.cd_crt = 60586818147796
                 group by tsc.cd_crt

                 select * from sc_srv.tbl_tsc where cd_tsc = 1416887
                 
select * from sc_opr.tbl_crt where cd_crt = 60586818147796;
select * from sc_cad.tbl_ctr where cd_ctr = 905;
select * from sc_cad.TBL_CTR_PCS where cd_ctr = 905;

select ctr_pce.* 
from sc_cad.tbl_ctr ctr
     inner join sc_cad.tbl_ctr_pce ctr_pce on ctr.cd_ctr = ctr_pce.cd_ctr
where ctr.cd_ctr = 905;

select * from sc_srv.tbl_srv
select * from sc_opr.tbl_crt where cd_pcs is not null
select * from sc_cad.tbl_ctr where coalesce(cd_pcs, 0) > 0 and fg_atv_ctr = 'S'

select * from sc_srv.tbl_tsc where cd_crt = 60586878088569
select * from sc_srv.tbl_tsc where cd_crt = 60586891668802;
select * from sc_opr.tbl_opr where cd_opr = 3766333

select * from sc_opr.tbl_top where cd_top = 13
select * from sc_Cad.tbl_dmn where nm_cmp_dmn = 'ST_TSC'