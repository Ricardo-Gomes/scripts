
-- consulta funcionario ligado ao cpf
select sc_cad.tbl_fnc from nr_idt_fnc = 95 WHERE cd_emp = 29 and cd_fem = 1 and cd_cun (select cd_cun from sc_cad.tbl_cun where nr_cpf_cnpj_cun = 96120258353 );
select sc_cad.tbl_fnc from nr_idt_fnc = '95' where cd_emp = 29 and cd_fem = 1 
select * from sc_cad.tbl_fnc where cd_emp = 29 and cd_fem = 1 and nr_idt_fnc like '95%'


select * from sc_cad.tbl_cpf where nr_rg_cpf = 96120258353
select * from sc_opr.tbl_pls where cd_pls = 6058684372521136 

select * from sc_cad.tbl_fnc  cd_fnc = 145200 and st_fnc = 1

--mudança de status do funcionario 1 - ativo 2 - demitido
--update sc_cad.tbl_fnc set st_fnc = 1 where cd_fnc = 145200;


