--extraindo dados das contabilidade de 2015
select lcn.cd_lcn as codigo, lcn.cd_tlc || ' - ' || tlc.ds_tlc as tipo_lancamento, 
       --lcn.fg_dcr_lcn,
       to_char(lcn.dt_ref_lcn, 'dd/mm/yyyy hh24:mi:ss') as data_ref, /*lcn_d.dt_lcn, lcn_d.dt_inc_usr as dt_inc_lcn,*/
       cnt.cd_cnt || ' - ' || cnt.nm_cnt as conta, 
       cnt_ctp.cd_cnt || ' - ' || cnt_ctp.nm_cnt as conta_contra_partida,
       case when lcn.fg_dcr_lcn = 'D' then lcn.vl_lcn else 0 end as valor_debito, 
       case when lcn.fg_dcr_lcn = 'C' then lcn.vl_lcn else 0 end as valor_credito, 
       usr.nm_usr as usuario
from sc_cnt.tbl_lcn lcn
     inner join sc_cnt.tbl_cnt cnt on lcn.cd_cnt = cnt.cd_cnt
     inner join sc_cnt.tbl_tlc tlc on lcn.cd_tlc = tlc.cd_tlc
     left join sc_sgr.tbl_usr usr on lcn.cd_inc_usr = usr.cd_usr
     left join sc_cnt.tbl_lcn lcn_ctp on lcn.cd_ctp_lcn = lcn_ctp.cd_lcn 
     left join sc_cnt.tbl_cnt cnt_ctp on lcn_ctp.cd_cnt = cnt_ctp.cd_cnt 
where lcn.dt_ref_lcn >= '2015-02-01'
  and lcn.dt_ref_lcn < '2015-02-04'
  --and lcn_d.fg_dcr_lcn = 'D'
  --and lcn.cd_cnt = 35
  and cnt.cd_scn = 30
order by lcn.dt_ref_lcn;

select * from sc_cnt.tbl_cnt where cd_cnt = 499;
select * from sc_cnt.tbl_cnt where cd_scn = 30;
select * from sc_cnt.tbl_cnt where cd_cnt in (6376, 125577);