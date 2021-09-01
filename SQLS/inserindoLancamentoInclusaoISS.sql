
select * from sc_fep.tbl_fep_sfe where cd_fep = 28196;

insert into sc_fep.tbl_fep_Sfe(cd_fep_Sfe, cd_fep, cd_sfe, vl_und_fep_sfe, qtd_fep_Sfe, vl_ttl_fep_sfe, cd_emp, fg_dcr_fep_sfe)
values(nextval('sc_fep.sq_fep_sfe'), 28196, 6, 6.86, 1, 6.86, 929, 'D');

update sc_fep.tbl_fep set vl_fep = vl_fep - 6.86, vl_org_fep = vl_org_fep - 6.86 where cd_fep = 28196;

select sc_cbr.gerar_boleto(1, 1, 28196);