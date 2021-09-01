

--consultando a ocorrencia 
select * from sc_rdc.tbl_oet where cd_fet = 1858
--deletando a ocorrencia
delete from sc_rdc.tbl_oet where cd_fet = 1858

--consultando a tabela filial estabelecimento
select * from sc_rdc.tbl_fet where cd_etb = 328
select * from sc_rdc.tbl_fet where cd_fet = 1858
--deletando a filial estabelecimento
delete from sc_rdc.tbl_fet where cd_fet = 1858

--consultando o codigo da conta
select * from sc_rdc.tbl_fet where cd_cnt = 287102
--deletando o codigo da conta
delete from sc_rdc.tbl_fet where cd_cnt = 287102