-- agendamento de depositado

select st_hfe from sc_adp.tbl_hfe where cd_hfe = 202767
update sc_adp.tbl_hfe set st_hfe = 4 where cd_hfe = 202767
SELECT sc_adp.processa_arquivo_deposito (202767);

-- situação 8 - erro | 4 - agendado | 5 