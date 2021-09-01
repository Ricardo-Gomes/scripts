select * from sc_opr.tbl_pls where cd_pls = '6058685840728373';
update sc_opr.tbl_pls set nm_pls = 'BRUNO O SILVA' where cd_pls = '6058685840728373';

select sc_ssp.gerar_arquivo_plastico();
