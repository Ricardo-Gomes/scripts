select cnt.cd_cnt, cnt.nm_cnt, cnt.cd_cnt_ctb, scn.cd_cnt_ctb, lcn.dt_ref_lcn
from sc_cnt.tbl_lcn lcn
     inner join sc_cnt.tbl_cnt cnt on lcn.cd_cnt = cnt.cd_cnt
     inner join sc_cnt.tbl_scn scn on cnt.cd_scn = scn.cd_scn
where lcn.cd_lcn = 22325708 or lcn.cd_ctp_lcn = 22325708;

select *
from sc_cnt.tbl_lcn
where cd_sst = 32
  and nsu_lcn = 146

  select * from sc_cbe.tbl_rce where cd_rce = 146;

  select * from sc_cbe.tbl_bpr where cd_rce = 146;