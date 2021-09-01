--estornando tarifas de ted cobradas erradamente
select sc__buxo.estornar_tarifa_ted_que_deveriam_ser_abonadas();

--estornando as tarifas de saques cobradas erradamente
select sc__buxo.estornar_tarifa_saque_que_deveriam_ser_abonadas();

--estornando tmc cobradas com valor errado
select sc_srv.estornar_tarifa_servico_tmc_empresa(687, '2019-12-01', '2019-12-13', 'VALOR DA TARIFA FOI COBRADO ERRADO');

--gerando as novas tarifas de manutenção de conta
select sc_srv.cobrar_servico_tmc_deposito(60586824690672);
select sc_srv.cobrar_servico_tmc_deposito(60586877096321);
select sc_srv.cobrar_servico_tmc_deposito(60586865987349);
select sc_srv.cobrar_servico_tmc_deposito(60586843865957);
select sc_srv.cobrar_servico_tmc_deposito(60586811868733);
select sc_srv.cobrar_servico_tmc_deposito(60586860287338);
select sc_srv.cobrar_servico_tmc_deposito(60586874979866);
select sc_srv.cobrar_servico_tmc_deposito(60586822930013);
select sc_srv.cobrar_servico_tmc_deposito(60586889091751);
select sc_srv.cobrar_servico_tmc_deposito(60586862584530);
select sc_srv.cobrar_servico_tmc_deposito(60586878549933);
select sc_srv.cobrar_servico_tmc_deposito(60586851936807);
select sc_srv.cobrar_servico_tmc_deposito(60586819564779);
select sc_srv.cobrar_servico_tmc_deposito(60586896000528);
select sc_srv.cobrar_servico_tmc_deposito(60586876711968);
select sc_srv.cobrar_servico_tmc_deposito(60586836054220);
select sc_srv.cobrar_servico_tmc_deposito(60586867946248);
select sc_srv.cobrar_servico_tmc_deposito(60586876579989);
select sc_srv.cobrar_servico_tmc_deposito(60586866034517);
select sc_srv.cobrar_servico_tmc_deposito(60586839430192);
select sc_srv.cobrar_servico_tmc_deposito(60586891352067);
select sc_srv.cobrar_servico_tmc_deposito(60586846834166);
select sc_srv.cobrar_servico_tmc_deposito(60586839426384);
select sc_srv.cobrar_servico_tmc_deposito(60586879944540);
select sc_srv.cobrar_servico_tmc_deposito(60586879008809);
select sc_srv.cobrar_servico_tmc_deposito(60586854424260);
select sc_srv.cobrar_servico_tmc_deposito(60586895202879);
select sc_srv.cobrar_servico_tmc_deposito(60586844884401);
select sc_srv.cobrar_servico_tmc_deposito(60586899175749);
select sc_srv.cobrar_servico_tmc_deposito(60586880494676);
select sc_srv.cobrar_servico_tmc_deposito(60586815122521);
select sc_srv.cobrar_servico_tmc_deposito(60586893803552);

--debitando da conta do cartão as novas TMC geradas
select sc_srv.cobrar_tarifa_servico_tmc_por_vencimento('2019-12-01', '2019-12-13', 687);

--listando todos os cartões que tiveram valor de TMC cobradas erradas
select 'select sc_srv.cobrar_servico_tmc_deposito(' || crt.cd_crt || ');' as comando
from sc_opr.tbl_crt crt
     inner join sc_cad.tbl_fnc fnc on crt.cd_fnc = fnc.cd_fnc
where crt.fg_atv_crt = 'S' -- cartões ativos
   and fnc.cd_emp = 687
   and crt.dt_pri_dps_crt < '2019-12-01' -- que ja receberam o primeiro depósito (adaptado para simular o dia 01/05/2019)
   and crt.cd_prd = 1 -- do produto remuneração
   AND sc_cad.get_parametro_contrato_cartao(15, crt.cd_crt, 3)::numeric = 2 --que a forma de conbrança da TSM é o funcionário
   and sc_cad.get_parametro_contrato_cartao(15, crt.cd_crt, 1) <> '0,00' -- pegando só que tem valor diferente de zero (adaptado para tirar o relatório)
   --and crt.cd_crt = 60586815709207
   and exists (select 1 
               from sc_srv.tbl_tsc --que não foi cobrado ainda no mês
	       where cd_crt = crt.cd_crt 
		 and cd_srv = 12
		 AND st_tsc = 2
		 AND to_char(dt_vnc_tsc,'mm/yyyy') = to_char(current_Date,'mm/yyyy')
		 AND vl_tsc = 4.99);

--verificando se existe alguma tarifa a ser cobrada da empresa
select tsc.cd_tsc as codigo_tarifa_servico, tsc.cd_srv as servico, crt.cd_crt as cartao, cc.cd_cnt as conta_debito, 
		      tsc.vl_tsc as valor, tsc.dt_vnc_tsc as data_vencimento, srv.cd_cnt as conta_credito, srv.cd_tlc as tipo_lancamento,
		      pls.cd_pls as plastico
               from sc_srv.tbl_tsc tsc
                  inner join sc_srv.tbl_srv srv on srv.cd_srv = tsc.cd_srv
                  inner join sc_opr.tbl_crt crt on crt.cd_crt = tsc.cd_crt
                  inner join sc_cad.tbl_fnc fnc on crt.cd_fnc = fnc.cd_fnc
                  inner join sc_cad.tbl_cun cun on fnc.cd_cun = cun.cd_cun
                  inner join sc_opr.tbl_pls pls on pls.cd_crt = crt.cd_crt and pls.dt_inc_usr = (select max(dt_inc_usr) from sc_opr.tbl_pls where cd_crt = crt.cd_crt)
		  inner join sc_opr.tbl_cnt_crt cc on cc.cd_crt = crt.cd_crt and cc.fg_pdr_cnt_crt = 'S'
               where tsc.dt_vnc_tsc >= '2019-12-01'
                 and tsc.dt_vnc_tsc <= '2019-12-13'
                  and crt.cd_prd = 1
                  --and cun.nr_cpf_cnpj_cun = 91931118353
                  and tsc.cd_srv = 12
                  and tsc.st_tsc = 1
                  and crt.dt_ult_dps_crt >= '2019-12-01'
                  and fnc.cd_emp = 687
               order by tsc.dt_vnc_tsc;

               select * from sc_srv.tbl_tsc where dt_vnc_tsc >= '2019-12-01' and cd_crt = 60586824690672

               select dt_pri_dps_crt
        from sc_opr.tbl_crt 
   where cd_crt = 60586824690672;