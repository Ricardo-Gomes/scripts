select * from sc_tem.tbl_rqs where dt_rqs >= current_date - interval '2 day' and xml_rqs like '%TransacReq%068010%' limit 10;

select * from sc_cnt.tbl_tlc where cd_tlc = 93;

select md5('2150'), nm_snh_pls
from sc_opr.tbl_pls
where cd_pls = 6058686169081409;

"24917db15c4e37e421866448c9ab23d8"
"24917db15c4e37e421866448c9ab23d8"

select * from SC_RDS.TBL_PDA;

SELECT SUBSTRING(CAST(CPF.NR_RG_CPF AS text) FROM 1 FOR 3) 
FROM SC_OPR.TBL_PLS PLS 
     INNER JOIN SC_CAD.TBL_CPF CPF ON PLS.CD_CUN = CPF.CD_CUN 
WHERE PLS.CD_PLS = 6058686169081409;

select * from sc_opr.tbl_cnt_crt where cd_crt = 60586861690814;
select cd_cnt from sc_opr.tbl_crt where cd_crt = 60586861690814;

select * from sc_tem.tbl_chv;

select * from sc_cnt.tbl_lcn where cd_ctp_lcn = 5053043;
select * from sc_cnt.tbl_cnt where cd_cnt in (116311, 116310, 116309, 116312);
select * from sc_cnt.tbl_scn where cd_scn = 272;

select * from sc_cnt.tbl_tlc where cd_tlc = 1452

SELECT * FROM SC_RDS.TBL_ATM;

select * from sc_opr.tbl_top where cd_cnt is not null;

19441, 19442, 19444, 4079, 40568, 40569, 66155, 201772

select * from sc_cad.tbl_dmn where nm_cmp_dmn like 'ST_RDP%';


select cnt.cd_cnt, cnt.nm_cnt, scn.cd_cnt_ctb1 as conta_subgrupo_2016, scn.cd_cnt_ctb as conta_subgrupo_nova, cnt.cd_cnt_ctb1 as conta_2016, cnt.cd_cnt_ctb as conta_nova
from sc_cnt.tbl_cnt cnt
     inner join sc_cnt.tbl_scn scn on cnt.cd_scn = scn.cd_scn
where cnt.cd_cnt in (117529);

2010102020001
2010102020001
select * from sc_cnt.tbl_cnt where cd_scn = 9;