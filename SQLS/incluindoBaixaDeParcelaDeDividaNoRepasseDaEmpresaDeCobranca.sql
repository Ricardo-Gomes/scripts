--parcela da dívida
select * from sc_cbe.tbl_prd where cd_prd = 6221;

--baixa da parcela da divida
select * from sc_cbe.tbl_bpr where cd_prd = 6221;
select sum(bpr.vl_bpr) from sc_cbe.tbl_bpr bpr inner join sc_cbe.tbl_prd prd on bpr.cd_prd = prd.cd_prd where bpr.cd_rce = 128;

--> soma dos valores de baixa: 2505.70
--> quantidade de baixas: 7

--repasse de parcela
select * from sc_cbe.tbl_rce where cd_rce = 128;

--vinculando a baixa a um repasse
update sc_cbe.tbl_bpr set cd_rce = 128 where cd_bpr = 2499;
update sc_cbe.tbl_rce 
   set vl_bpr_rce = vl_bpr_rce + 164,
       vl_rce = vl_rce + 164,
       qtd_bpr_rce = qtd_bpr_rce + 1 
where cd_rce = 128;
