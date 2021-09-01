--consultando os funcionários vinculados com o cpf errado
select * from sc_cad.tbl_cun where nr_cpf_cnpj_cun = 14267162301;
select * from sc_cad.tbl_fnc where cd_cun = 118270;

--verificando se existe algum funcionario com o cpf correto
select * from sc_Cad.tbl_cun where nr_cpf_cnpj_cun = 04267162301;
select * from sc_cad.tbl_fnc where cd_cun = 44144;

--se existe funcionário deve ser transferido os seguintes registro do cadastro unico errado para o cadastro unico correto
update sc_cad.tbl_fnc set cd_cun = 44144 where cd_cun = 118270;
update sc_opr.tbl_pls set cd_cun = 44144 where cd_cun = 118270;