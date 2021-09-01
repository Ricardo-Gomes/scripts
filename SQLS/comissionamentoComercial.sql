--Os selects abaixo extraem as informações do banco de dados que são utilizadas para medir o desempenho da área de negócio
​
--01. Extraindo o número de CP ativadas no mês avaliado e o números de primeiros depósitos realizados
--Considerar as contas de pagamento que RECEBERAM O PRIMEIRO DEPÒSITO NO MÊS AVALIADO , cujas contas sejam VINCULADAS A CONTRATOS ATIVADOS HÁ ATÉ 3 MESES, considerado o mês avaliado. Exemplo de CP NOVA em abril 2019: Com primeiro depósito em abril 2019, se o contrato foi ativado entre os meses de Fevereiro e Abril de 2019;
select grt.nm_grt as gerente, emp.nm_emp as empresa, 
       to_char(ctr.dt_ctr, 'mm/yyyy') as mes_ativacao_contrato,
       crt.cd_crt as cartao, cun.nm_cun as nome, cun.nr_cpf_cnpj_cun as cpf,
       to_char(crt.dt_pri_dps_crt, 'dd/MM/yyyy') as data_primeiro_deposito, count(distinct rdp.cd_rdp) as qtde_depositos
from sc_cad.tbl_ctr ctr
     inner join sc_cad.tbl_grt grt on ctr.cd_grt = grt.cd_grt
     inner join sc_cad.tbl_emp emp on ctr.cd_emp = emp.cd_emp
     inner join sc_opr.tbl_crt crt on ctr.cd_ctr = crt.cd_ctr
     inner join sc_cad.tbl_fnc fnc on crt.cd_fnc = fnc.cd_fnc
     inner join sc_cad.tbl_cun cun on fnc.cd_cun = cun.cd_cun
     inner join sc_adp.tbl_rdp rdp on crt.cd_crt = rdp.cd_crt and rdp.st_rdp = 5
     inner join sc_adp.tbl_hfe hfe on rdp.cd_hfe = hfe.cd_hfe
where ctr.dt_ctr >= to_date('01/11/2019', 'dd/MM/yyyy') - interval '2 month'
  and crt.dt_pri_dps_crt >= to_date('01/11/2019', 'dd/MM/yyyy')
  and crt.dt_pri_dps_crt < to_date('01/11/2019', 'dd/MM/yyyy') + interval '1 month'
  and hfe.dt_dps_hfe >= to_date('01/11/2019', 'dd/MM/yyyy')
  and hfe.dt_dps_hfe < to_date('01/11/2019', 'dd/MM/yyyy') + interval '1 month'
group by grt.nm_grt, emp.nm_emp, ctr.dt_ctr, crt.cd_crt, cun.nm_cun, cun.nr_cpf_cnpj_cun, crt.dt_pri_dps_crt
order by gerente, empresa, nome;
​
select * from sc_cad.tbl_dmn where nm_cmp_dmn ilike '%ST_RDP%'
​
--02. Extraindo o valor faturado de 1ª via de cartão e tarifa de depósito
--Considerar o Valor da "parcela" relativa à cobrança da tarifa de emissão da 1ª via do Cartão, constante da fatura paga no mês de avaliação, desde que seja a PRIMEIRA FATURA PAGA PELA CONVENIADA à SOMA;
select grt.nm_grt as gerente, emp.nm_emp as empresa, fem.nm_fem as filial,
       to_char(pfe.dt_pgt_pfe, 'dd/MM/yyyy') as data_pagamento_fatura_empresa,
       sum(case when fep_sfe.cd_sfe = 1 then fep_sfe.qtd_fep_sfe else 0 end) as qtde_primeira_via,
       sum(case when fep_sfe.cd_sfe = 1 then fep_sfe.vl_ttl_fep_sfe else 0 end) as valor_primeira_via,
       sum(case when fep_sfe.cd_sfe <> 1 then fep_sfe.qtd_fep_sfe else 0 end) as qtde_tarifa_deposito,
       sum(case when fep_sfe.cd_sfe <> 1 then fep_sfe.vl_ttl_fep_sfe else 0 end) as valor_tarifa_deposito
from sc_cad.tbl_ctr ctr
     inner join sc_cad.tbl_grt grt on ctr.cd_grt = grt.cd_grt
     inner join sc_cad.tbl_emp emp on ctr.cd_emp = emp.cd_emp
     inner join (select min(fep.cd_fep) as cd_fep, fep.cd_ctr
                 from sc_fep.tbl_fep fep
                 group by fep.cd_ctr) fep_pri on ctr.cd_ctr = fep_pri.cd_ctr
     inner join sc_fep.tbl_fep fep on fep_pri.cd_fep = fep.cd_fep
     inner join sc_fep.tbl_pfe pfe on fep.cd_fep = pfe.cd_fep and pfe.st_pfe = 1 --pagamento cadastrado, ou seja, que não tenha sido cancelado
     inner join sc_fep.tbl_fep_sfe fep_sfe on fep_sfe.cd_fep = fep.cd_fep and fep_sfe.cd_sfe in (1, 3, 9) --serviço de primeira via de cartão, tarifa de deposito, tarifa de deposito(d+2)
     left join sc_cad.tbl_fem fem on fep_sfe.cd_emp = fem.cd_emp and fep_sfe.cd_fem = fem.cd_fem
where pfe.dt_pgt_pfe >= to_date('01/11/2019', 'dd/MM/yyyy')
  and pfe.dt_pgt_pfe < to_date('01/11/2019', 'dd/MM/yyyy') + interval '1 month'
group by grt.nm_grt, emp.nm_emp, fem.nm_fem, pfe.dt_pgt_pfe
order by gerente, empresa, filial;
​
select * from sc_cad.tbl_pcs
​
--05. Extraindo o número de Pacotes de Serviços (B10 e B20)
--considerando os pacotes de serviço vinculados aos contratos
select to_char(tsc.dt_vnc_tsc, 'MM/yyyy') as mes_1_pagamento,
       grt.nm_grt as gerente, emp.nm_emp as empresa,
       pcs.dsc_pcs as pacote_servico,
       to_char(coalesce(crt.dt_ads_pcs_crt, ctr_pcs.dt_inc_usr), 'dd/MM/yyyy') as data_adesao,
       to_char(tsc.dt_vnc_tsc, 'dd/MM/yyyy') as data_1_pagamento,
       crt.cd_crt as cartao, cun.nm_cun as nome, cun.nr_cpf_cnpj_cun as cpf,
       tsc.vl_tsc as valor, case when crt.cd_pcs is null then 'novo' else 'existente' end as novo_existente
from sc_cad.tbl_ctr ctr
     left join sc_cad.tbl_ctr_pcs ctr_pcs on ctr.cd_ctr = ctr_pcs.cd_ctr and ctr_pcs.fg_prd_ctr_pcs = 'S'
     inner join sc_cad.tbl_grt grt on ctr.cd_grt = grt.cd_grt
     inner join sc_cad.tbl_emp emp on ctr.cd_emp = emp.cd_emp
     inner join sc_opr.tbl_crt crt on ctr.cd_ctr = crt.cd_ctr
     inner join sc_cad.tbl_fnc fnc on crt.cd_fnc = fnc.cd_fnc
     inner join sc_cad.tbl_cun cun on fnc.cd_cun = cun.cd_cun
     inner join (select min(tsc.cd_tsc) as cd_tsc, tsc.cd_crt
                 from sc_srv.tbl_tsc tsc
                      inner join sc_opr.tbl_crt crt2 on tsc.cd_crt = crt2.cd_crt
                      inner join sc_cad.tbl_ctr ctr2 on crt2.cd_ctr = ctr2.cd_ctr
                      left join sc_cad.tbl_ctr_pcs ctr_pcs2 on ctr2.cd_ctr = ctr_pcs2.cd_ctr and ctr_pcs2.fg_prd_ctr_pcs = 'S'
                 where tsc.st_tsc = 2 --tarifa foi cobrada
                   and tsc.cd_srv = 12 --tarifa de manutenção de conta
                   and tsc.dt_vnc_tsc > coalesce(crt2.dt_ads_pcs_crt, ctr_pcs2.dt_inc_usr)
                 group by tsc.cd_crt) tsc_pri on crt.cd_crt = tsc_pri.cd_crt
     inner join sc_srv.tbl_tsc tsc on tsc_pri.cd_tsc = tsc.cd_tsc
     inner join sc_cad.tbl_pcs pcs on coalesce(crt.cd_pcs, ctr_pcs.cd_pcs) = pcs.cd_pcs
where tsc.dt_vnc_tsc >= to_date('01/11/2019', 'dd/MM/yyyy')
  and tsc.dt_vnc_tsc < to_date('01/11/2019', 'dd/MM/yyyy') + interval '1 month'
  and coalesce(crt.cd_pcs, ctr_pcs.cd_pcs) in (4, 5) --Pacote de serviço BONUS10 e BONUS20
  --and crt.cd_crt = 60586818147796
order by mes_1_pagamento, gerente, empresa, pacote_servico, nome;
​
--Quantidade de CP cujos PRIMEIROS PAGAMENTOS (Débito de R$ 9,90, para B10, e R$ 19,90, para o B20) ocorreram no mês avaliado. Nesse caso, não interessa se a CONTA DE PAGAMENTO é nova. O pacote é que deve ter sido IMPLANTADO no mês avaliado.  A informação  deve se dada assim: Vendedora e quantidade por tipo de pacote.
--primeira consulta realizada, desconsiderar, armazenada apenas para caso se tenha alguma dúvida a tirar
select to_char(tsc.dt_vnc_tsc, 'MM/yyyy') as mes_1_pagamento,
       grt.nm_grt as gerente, emp.nm_emp as empresa,
       pcs.dsc_pcs as pacote_servico,
       to_char(crt.dt_ads_pcs_crt, 'dd/MM/yyyy') as data_adesao,
       to_char(tsc.dt_vnc_tsc, 'dd/MM/yyyy') as data_1_pagamento,
       crt.cd_crt as cartao, cun.nm_cun as nome, cun.nr_cpf_cnpj_cun as cpf,
       tsc.vl_tsc as valor
from sc_cad.tbl_ctr ctr
     inner join sc_cad.tbl_grt grt on ctr.cd_grt = grt.cd_grt
     inner join sc_cad.tbl_emp emp on ctr.cd_emp = emp.cd_emp
     inner join sc_opr.tbl_crt crt on ctr.cd_ctr = crt.cd_ctr
     inner join sc_cad.tbl_fnc fnc on crt.cd_fnc = fnc.cd_fnc
     inner join sc_cad.tbl_cun cun on fnc.cd_cun = cun.cd_cun
     inner join (select min(tsc.cd_tsc) as cd_tsc, tsc.cd_crt
                 from sc_srv.tbl_tsc tsc
                      inner join sc_opr.tbl_crt crt2 on tsc.cd_crt = crt2.cd_crt
                 where tsc.st_tsc = 2 --tarifa foi cobrada
                   and tsc.cd_srv = 12 --tarifa de manutenção de conta
                   and tsc.dt_vnc_tsc > crt2.dt_ads_pcs_crt
                 group by tsc.cd_crt) tsc_pri on crt.cd_crt = tsc_pri.cd_crt
     inner join sc_srv.tbl_tsc tsc on tsc_pri.cd_tsc = tsc.cd_tsc
     inner join sc_cad.tbl_pcs pcs on crt.cd_pcs = pcs.cd_pcs
where tsc.dt_vnc_tsc >= to_date('01/06/2019', 'dd/MM/yyyy')
  and tsc.dt_vnc_tsc < to_date('01/06/2019', 'dd/MM/yyyy') + interval '1 month'
  and crt.cd_pcs in (4, 5) --Pacote de serviço BONUS10 e BONUS20
order by mes_1_pagamento, gerente, empresa, pacote_servico, nome;