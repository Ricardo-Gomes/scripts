--selects auxiliares
select fem.nm_fem as filial, sfe.ds_sfe as servico, fep_sfe.* 
from sc_fep.tbl_fep_sfe fep_sfe
     inner join sc_fep.tbl_sfe sfe on fep_sfe.cd_sfe = sfe.cd_sfe 
     left join sc_cad.tbl_fem fem on fep_sfe.cd_emp = fem.cd_emp and fep_sfe.cd_fem = fem.cd_fem 
where fep_sfe.cd_fep = 29688
  --and cd_fem is null;
order by filial, servico;

update sc_fep.tbl_fep_sfe
   set cd_sfe = 8,
       vl_und_fep_sfe = 27.36,
       qtd_fep_sfe = 1,
       vl_ttl_fep_sfe = 27.36
where cd_fep_sfe = 73089;

update sc_fep.tbl_fep_sfe
   set vl_und_fep_sfe = 2.0,
       qtd_fep_sfe = 1,
       vl_ttl_fep_sfe = 2.0
where cd_fep_sfe = 73090;

update sc_fep.tbl_fep_sfe
   set vl_und_fep_sfe = 3.54,
       qtd_fep_sfe = 1,
       vl_ttl_fep_sfe = 3.54
where cd_fep_sfe = 73090;



select * from sc_fep.tbl_fep where cd_fep = 29705;

select * from sc_fep.tbl_sfe

--comandos para adicionar desconto de iss
update sc_fep.tbl_fep set vl_fep = 37.9, vl_nfs_fep = 39.9, vl_org_fep = 37.9 where cd_fep = 29704;

insert into sc_fep.tbl_fep_sfe(cd_fep_sfe, cd_fep, cd_sfe, vl_und_fep_sfe, qtd_fep_Sfe, vl_ttl_fep_sfe, cd_emp, cd_fem, fg_dcr_fep_sfe)
values(nextval('sc_fep.sq_fep_sfe'), 28417, 6, 4.77, 1, 4.77, 249, 5, 'D');

--comandos para adicionar descontos nas faturas
update sc_fep.tbl_fep set vl_fep = vl_fep - 280.25, vl_nfs_fep = vl_nfs_fep, vl_org_fep = vl_org_fep - 280.25 where cd_fep = 28939;


--comandos para retirar cobranca de iss
delete from sc_fep.tbl_fep_sfe where cd_fep_sfe = 70747;
update sc_fep.tbl_fep set vl_fep = vl_fep + 0.17, vl_nfs_fep = vl_nfs_fep, vl_org_fep = vl_org_fep + 0.17 where cd_fep = 28912;

--zerando cobranca de tarifa de deposito
update sc_fep.tbl_fep_sfe set vl_und_fep_sfe = 32.13 - 14.01, vl_ttl_fep_sfe = 32.13 - 14.01 where cd_fep_sfe = 71704;

--comando para atualizar o valor do boleto
select sc_cbr.gerar_boleto(1, 1, 29704);

--select auxiliares
select * from sc_fep.tbl_sfe order by ds_sfe;
--tipos de serviços de fatura
1;"1a VIA DE CARTAO"
2;"2a VIA DE CARTAO"
5;"COMPLEMENTO FAT. MINIMO"
8;"DESCONTOS CONCEDIDOS" --estorno
6;"ISS RETIDO FONTE"
3;"TRF. DE DEPOSITO"
9;"TRF. DE DEPOSITO (D+2)"
4;"TRF. DE LIBERACAO IMEDIATA"
18;"TRF. DE SAQUE"
11;"TRF. DE TRANSFERENCIA BANCARIA"
7;"TRF. SOLICITACAO DE SENHA"


select sc_fep.retira_cobranca_faturamento_minimo(27688);

delete from sc_fep.tbl_fep_sfe where cd_fep_sfe = 67520;

select cd_fep_sfe, vl_ttl_fep_sfe as valor_desconto
from sc_fep.tbl_fep_sfe
where cd_sfe = 5
  and fg_dcr_fep_sfe = 'C'
  and cd_fep = 27688;



--alterando valor de iss %5 da fatura
update sc_fep.tbl_fep_sfe
   set vl_und_fep_sfe = 2.0,
       qtd_fep_sfe = 1,
       vl_ttl_fep_sfe = 2.0
where cd_fep_sfe = 73088;

--inclusao desconto
insert into sc_fep.tbl_fep_sfe(cd_fep_sfe, cd_fep, cd_sfe, vl_und_fep_sfe, qtd_fep_Sfe, vl_ttl_fep_sfe, cd_emp, cd_fem, fg_dcr_fep_sfe) 
values (nextval('sc_fep.sq_fep_sfe'), 29688, 8, 9.90, 27, 267.30, 947, 1, 'D');

--insert into sc_fep.tbl_fep_sfe
     (cd_fep_sfe, --código (chave primaria) 
      cd_fep, --cod fatura
      cd_sfe, -- cod servico
      vl_und_fep_sfe, --vl unitario
      qtd_fep_Sfe, --qtd
      vl_ttl_fep_sfe, --vl total
      cd_emp, -- cod empresa
      cd_fem, -- cod filial
      fg_dcr_fep_sfe) -- D - desconto, C - Cobrança
--values
     (nextval('sc_fep.sq_fep_sfe'), --código (chave primaria) 
     29688, --cod fatura
     8, -- cod servico (1 - 1a VIA DE CARTAO, 2 - 2a VIA DE CARTAO, 5 - COMPLEMENTO FAT. MINIMO, 8 - DESCONTOS CONCEDIDOS (estorno)
        --              6 - ISS RETIDO FONTE, 3 - TRF. DE DEPOSITO, 9 - TRF. DE DEPOSITO (D+2), 4 - TRF. DE LIBERACAO IMEDIATA,
        --              18 - TRF. DE SAQUE, 11 - TRF. DE TRANSFERENCIA BANCARIA, 7 - TRF. SOLICITACAO DE SENHA
     9.90, --vl unitario
     27, --qtd
     267,30, --vl total
     947, -- cod empresa
     1, -- cod filial 
      'D'); -- D - desconto, C - Cobrança

--delete from sc_fep.tbl_fep_sfe where cd_fep_sfe = 73103


--inclusao cobranca faturamento minimo
insert into sc_fep.tbl_fep_sfe(cd_fep_sfe, cd_fep, cd_sfe, vl_und_fep_sfe, qtd_fep_Sfe, vl_ttl_fep_sfe, cd_emp, cd_fem, fg_dcr_fep_sfe)
values(nextval('sc_fep.sq_fep_sfe'), 29463, 5, 0.79, 1, 0,79, 694, 1, 'C');


--comando para alterar valor fatura
update sc_fep.tbl_fep set vl_fep = 673.7, vl_nfs_fep = 941.00, vl_org_fep = 673.7 where cd_fep = 29688;
update sc_fep.tbl_fep set vl_fep = vl_fep - 0.79, vl_org_fep = vl_org_fep - 0.79 where cd_fep = 29463;

--comando para atualizar o valor do boleto
select sc_cbr.gerar_boleto(1, 1, 29688);