--comandos para gerar os cartões
select sc_rds.gerar_plastico_operador('ROBERIO DE A SANTIAGO', 'ROBERIO DE ABREU SANTIAGO');
select sc_rds.gerar_plastico_operador('ERIVELTON DO A XAVIER', 'ERIVELTON DO AMARAL XAVIER');
select sc_rds.gerar_plastico_operador('FRANCISCO P SAMPAIO', 'FRANCISCO PEREIRA SAMPAIO');
select sc_rds.gerar_plastico_operador('FABIO P BATISTA', 'FABIO PAIVA BATISTA');
select sc_rds.gerar_plastico_operador('FRANCISCO J DA SILVA', 'FRANCISCO JACQUES DA SILVA');
select sc_rds.gerar_plastico_operador('CARLOS L S PEREIRA', 'CARLOS LEANDRO SAMPAIO PEREIRA');
select sc_rds.gerar_plastico_operador('CLESIO DE M ADRIANO', 'CLESIO DE MORAIS ADRIANO');
select sc_rds.gerar_plastico_operador('JOSE J GOMES', 'JOSE JURANDIR GOMES');
select sc_rds.gerar_plastico_operador('OSTENIO F A SILVA', 'OSTENIO FRANK ARAUJO SILVA');
select sc_rds.gerar_plastico_operador('JACO P DA SILVA', 'JACO PEREIRA DA SILVA');
select sc_rds.gerar_plastico_operador('FRANCISCO J R DA SILVA', 'FRANCISCO JOSUE ROCHA DA SILVA');
select sc_rds.gerar_plastico_operador('MICHEL R M DE SOUSA', 'MICHEL ROBSON MATOS DE SOUSA');
select sc_rds.gerar_plastico_operador('FRANCISCO C M NETO', 'FRANCISCO CHAGAS MAIA NETO');
select sc_rds.gerar_plastico_operador('RICARDO V N SIQUEIRA', 'RICARDO VALERIANO NASCIMENTO SIQUEIRA');

--comando para gerar o arquivo de emissão dos cartões gerados
SELECT sc_ssp.gerar_arquivo_plastico_operador();

--alterando a validade de plástico do operador
select * from sc_rds.tbl_pop  where cd_pop = 6200004756674306;
update sc_rds.tbl_pop set dt_vld_pop = dt_vld_pop + interval '2 year' where cd_pop = 6200004756674306;