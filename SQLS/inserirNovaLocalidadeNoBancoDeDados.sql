select * from sc_crr.log_localidade where ufe_sg = 'PI' order by loc_no
select max(loc_nu_sequencial) from sc_crr.log_localidade where ufe_sg = 'PI' order by loc_no
insert into sc_crr.log_localidade values(12079, 'ANGICO BRANCO', 'ANGICO BRANCO', '64600000', 'PI', 0, 'M', null, null, 64600000);