--verificando a data de inicio de cobrança atual
select coalesce(data_inicio_cobranca, dt_ems_fcr) as data_inicio_cobranca from sc_fcr.tbl_fcr where cd_fcr = 4107319;

--alterando a data de inicio da cobrança 
update sc_fcr.tbl_fcr set data_inicio_cobranca = '2020-01-01' where cd_fcr = 4107319;