select scn.cd_scn, scn.ds_scn, count(*) as qtde
from sc_cnt.tbl_scn scn
     inner join sc_cnt.tbl_cnt cnt on scn.cd_scn = cnt.cd_scn
group by scn.cd_scn, scn.ds_scn
order by qtde desc;


select tlc.cd_tlc as cd_tp_lanc, tlc.ds_tlc as nm_tp_lanc, 
       scn.cd_scn as cd_grp_debito, scn.ds_scn as nm_grp_debito, 
       scn_ctp.cd_scn as cd_grp_credito, scn_ctp.ds_scn as nm_grp_credito, 
       count(*) as qtde, sum(case when lcn.cd_ctp_lcn is null then lcn_ctp.vl_lcn else lcn.vl_lcn end) as valor
from sc_cnt.tbl_lcn lcn
     inner join sc_cnt.tbl_cnt cnt on lcn.cd_cnt = cnt.cd_cnt
     inner join sc_cnt.tbl_scn scn on scn.cd_scn = cnt.cd_scn
     inner join sc_cnt.tbl_lcn lcn_ctp on lcn.cd_lcn = lcn_ctp.cd_lcn or lcn_ctp.cd_lcn = lcn.cd_ctp_lcn 
     inner join sc_cnt.tbl_cnt cnt_ctp on lcn_ctp.cd_cnt = cnt_ctp.cd_cnt
     inner join sc_cnt.tbl_scn scn_ctp on scn_ctp.cd_scn = cnt_ctp.cd_scn
     inner join sc_cnt.tbl_tlc tlc on lcn.cd_tlc = tlc.cd_tlc
where lcn.dt_ref_lcn >= '2019-12-01'
  and lcn.dt_ref_lcn < '2020-01-01'
  and lcn.fg_dcr_lcn = 'D'
group by tlc.cd_tlc, tlc.ds_tlc, scn.cd_scn, scn.ds_scn, scn_ctp.cd_scn, scn_ctp.ds_scn
order by nm_tp_lanc, qtde desc