select * from sc_job.tbl_job where cmd_job = 'sc_rdc.confirma_transacao_cielo()';

select sc_rdc.confirma_transacao_cielo();

SELECT * FROM SC_RDC.TBL_RQS WHERE CD_RQS IN (535328, 535333);

SELECT * FROM SC_OPR.TBL_OPR WHERE CD_OPR = 5300954;

SELECT * FROM SC_RDC.TBL_FET WHERE CD_FET = 100;

select max(bit127)
from sc_iso8583.tbl_msg8583
where bit011 = trim(substring('0200      1202180004323585',21,6))
  and bit001 = '0x210'
  and bit042 = '000001077723757' --garantindo que é do mesmo estabelecimento
  and bit004 = '000000015607'; --garantindo que é do mesmo valor

select * from sc_rdc.tbl_rqs where cd_rqs = 535977

select * from sc_cad.tbl_dmn where nm_cmp_dmn = 'ST_OPR'
update sc_opr.tbl_opr set st_opr = 1 where cd_opr in (5626358, 5626367);

select * 
from sc_rdc.processar_requisicao_rdc('000001077723757', --codigo estabelecimento
	  			     '423586'::numeric, -- NSU DO TEF
				     '79067407', -- IDENTIFICACAO DO TERMINAL
				     null,-- PLASTICO 
				     3,
				     null, 
				     null,--codigo seguranca 
				     null, 
				     null,
				     '535333'::numeric);

--listando as mensagens de um determinado período e estabelecimento				   
select cd_msg, dt_msg, bit001, bit002, bit003, bit004, bit007, bit011, bit012, bit013, bit018, bit019, bit022, bit032,
       bit035, bit037, bit038, bit039, bit041, bit042, bit043, bit048, bit049, bit052, bit060, bit062, bit090,
       bit127, cd_pai_msg
from sc_iso8583.tbl_msg8583 
where bit042 = '000001077723757' 
  and dt_msg >= '2019-12-02' 
  and dt_msg < '2019-12-03' 
order by cd_msg;

--listando as mensagens de entrada e saída de desfazimento que tiveram um determinado erro
--listando as mensagens de um determinado período				   
select me.cd_msg, me.dt_msg, me.bit001, me.bit002, me.bit003, me.bit004, me.bit007, me.bit011, me.bit012, me.bit013, me.bit018, me.bit019, 
       me.bit022, me.bit032, me.bit035, me.bit037, me.bit038, me.bit039, me.bit041, me.bit042, me.bit043, me.bit048, me.bit049, me.bit052, 
       me.bit060, me.bit062, me.bit090, me.bit127, me.cd_pai_msg,
       ms.cd_msg, ms.dt_msg, ms.bit001, ms.bit002, ms.bit003, ms.bit004, ms.bit007, ms.bit011, ms.bit012, ms.bit013, ms.bit018, ms.bit019,
       ms.bit022, ms.bit032, ms.bit035, ms.bit037, ms.bit038, ms.bit039, ms.bit041, ms.bit042, ms.bit043, ms.bit048, ms.bit049, ms.bit052, 
       ms.bit060, ms.bit062, ms.bit090, ms.bit127, ms.cd_pai_msg
from sc_iso8583.tbl_msg8583 me
     inner join sc_iso8583.tbl_msg8583 ms on me.cd_msg = ms.cd_pai_msg
where me.bit001 = '0x420'
  and ms.bit001 = '0x430'
  and ms.bit039 = '53'
  --and me.dt_msg >= '2019-12-02' 
  --and me.dt_msg < '2019-12-03' 
order by me.cd_msg;

select opr.cd_opr
                from sc_opr.tbl_opr opr
                where opr.cd_top = 27
                  and opr.st_opr = 1
                  and opr.vl_opr > 1
                  and opr.dt_opr < current_date
                  order by opr.cd_opr
                  
select * from sc_opr.tbl_opr where cd_opr in (5629611, 5629607);
select * from sc_rdc.tbl_rqs where cd_opr in (5629611, 5629607);
select substr(msg.bit011, 2)::numeric, msg.bit041, msg.bit042, msg.bit001 from sc_iso8583.tbl_msg8583 msg where cd_msg = 11069643;

TIPO_REQUISICAO_DESFAZ_COMPRA constant numeric := 3;

select msg.cd_msg, msg.bit042, msg.bit011, msg.bit041, rqs.cd_rqs as nsu_transacao_original
from sc_opr.tbl_opr opr
     inner join sc_rdc.tbl_rqs rqs on opr.cd_opr = rqs.cd_opr
     inner join sc_iso8583.tbl_msg8583 msg on rqs.nr_nsu_org = substr(msg.bit011, 2)::numeric and rqs.nsu_eqp_rqs = msg.bit041 and rqs.nr_lgc_fet_rqs = msg.bit042 and msg.bit001 = '0x420'
where opr.cd_opr = 5629607
  and opr.st_opr = 1;

select msg.cd_msg, msg.bit042, msg.bit011, msg.bit041, rqs.cd_rqs as nsu_transacao_original, rqs.*
from sc_opr.tbl_opr opr
     inner join sc_rdc.tbl_rqs rqs on opr.cd_opr = rqs.cd_opr and rqs.tp_rqs = 2
     inner join sc_iso8583.tbl_msg8583 msg on rqs.nr_nsu_org = substr(msg.bit011, 2)::numeric and rqs.nsu_eqp_rqs = msg.bit041 and rqs.nr_lgc_fet_rqs = msg.bit042 and msg.bit001 = '0x202'
where opr.cd_opr in (5670203, 5670186, 5670183, 5670135, 5670120, 5670106, 5670093, 5670091, 5670089, 5670059)
  and opr.st_opr = 1;

select sc_iso8583.tentar_novamente_desfazimento(5629611);

select msg.bit042, msg.bit011, msg.bit041, rqs.cd_rqs as nsu_transacao_original,
       msg_saida.bit039
from sc_opr.tbl_opr opr
     inner join sc_rdc.tbl_rqs rqs on opr.cd_opr = rqs.cd_opr
     inner join sc_iso8583.tbl_msg8583 msg on rqs.nr_nsu_org = substr(msg.bit011, 2)::numeric and rqs.nsu_eqp_rqs = msg.bit041 and rqs.nr_lgc_fet_rqs = msg.bit042 and msg.bit001 = '0x420'
     inner join sc_iso8583.tbl_msg8583 msg_saida on msg.cd_msg = msg_saida.cd_pai_msg
where opr.cd_opr = 5629607
  and msg_saida.bit001 = '0x430' 
  and msg_saida.bit039 = '53';
  
select * 
from sc_rdc.processar_requisicao_rdc(vl_rg.bit042, --codigo estabelecimento
			   vl_rg.bit011::numeric, -- NSU DO TEF
			   vl_rg.bit041, -- IDENTIFICACAO DO TERMINAL
			   null,-- PLASTICO 
			   TIPO_REQUISICAO_DESFAZ_COMPRA,
			   null, 
			   null,--codigo seguranca 
			   null, 
			   null,
			   vl_rg.nsu_trans_original);

select *
from sc_opr.tbl_opr
where cd_opr in (534767, 534859, 534877, 535017, 535038, 535182, 535247, 535248, 535253,
                 535276, 535330, 535336, 535376, 535377, 535432, 535433, 535474, 535741,
                 535769, 535770, 535771);


6058685838104854
6058685838104854D09220922109221000000\

select * from sc_cad.tbl_dmn where nm_cmp_dmn like '%BIT%';

select * from sc_rdc.tbl


0200      1105180511053164

-> 498234

select coalesce(max(bit127), 'nulo')
from sc_iso8583.tbl_msg8583
where bit011 = '053164'
  and bit001 = '0x210'
  and bit127 < '498234'
  and bit042 = '000001011282752';

select r2.cd_rqs
from sc_rdc.tbl_rqs r
     inner join sc_iso8583.tbl_msg8583 m on m.bit011::numeric = r.nr_nsu_org and m.bit001='0x420'and m.dt_msg::date=r.dt_rqs::date
     inner join sc_iso8583.tbl_msg8583 m2 on m2.bit001 = '0x210' and m2.bit011 = trim(substring(m.bit090,21,6))   
     --inner join sc_rdc.tbl_rqs r2 on m2.bit011::numeric = r2.nr_nsu_org and m2.bit001='0x210'and m2.dt_msg=r2.dt_rqs
     inner join sc_rdc.tbl_rqs r2 on m2.bit011::numeric = r2.nr_nsu_org and m2.bit001='0x210' and m2.bit032::numeric=r2.nsu_rede_rqs and m2.dt_msg::date = r2.dt_rqs::date
     inner join sc_opr.tbl_opr opr on opr.cd_opr = r2.cd_opr
--  left join sc_rdc.tbl_rqs r2 on r2.cd_rqs = 
where r.tp_rqs = 3
  --and r.cd_opr is null
  --and opr.st_opr = 1
  and m.dt_msg >= '2019-12-02' 
  and m.dt_msg < '2019-12-03'
  --and m.bit032 is not null
order by m.bit002,r.dt_rqs