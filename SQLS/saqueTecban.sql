SELECT CD_MSG, DT_MSG, BIT001, bit002, bit003, bit004, bit007, bit011, bit012, bit013,
       bit019, bit022, BIT032, bit035, bit037, BIT038, BIT039, bit041, bit042, bit048, 
       bit049, bit052, BIT060, bit062, bit090, bit127
       --dt_msg, *
FROM SC_ISO8583.TBL_MSG8583 
WHERE BIT032 LIKE '%1572'
  --bit035 like '%6058688858034081%' 
  --and 
  --and bit001 = '0x100'
  and cd_msg >= 11872460 -- 10000
  --AND DT_MSG >= CURRENT_dATE
ORDER BY CD_MSG;


"6058685486082770=02240224102241000000"
"6058682093042091=09240924109241000000"

select min(cd_msg) from sc_iso8583.tbl_msg8583 where DT_MSG >= CURRENT_dATE + interval '18 hours';
select * from sc_iso8583.tbl_msg8583 where cd_MSG = 11749829;

""

select max(bit127)
      from sc_iso8583.tbl_msg8583
      where bit011 = trim(substring('0200      1226163056101544',21,6))
        and bit001 = '0x210'
        and bit042 = '051427102000129' --garantindo que é do mesmo estabelecimento
        and bit004 = '000000002000';
        
select substring('0200      1226163056101544',5,6), substring('0200      1226163056101544',11,10), substring('0200      1226163056101544',21,6)

select count(*) from sc_iso8583.tbl_msg8583 where cd_msg >= 11745010 - 500 and bit001 = '0x100';

update sc_iso8583.tbl_msg8583 set bit001 = '0x100', bit052 = '8C776EF5E991AE9A' where cd_msg = 11653381;


SELECT SC_ISO8583.EXECUTAR(11865880);

select * from sc_rdc.tbl_rqs where cd_pls = 6058681265405442 and dt_rqs >= current_Date;

select * from sc_rdc.tr_consulta_saldo(6058681265405442, vl_codigo_filial, vp_codigo_requisicao)

select cd_msg, bit001, bit003, bit004, bit007, bit011, bit012, bit013, 
       bit018, bit019, bit022, bit032, bit035, bit037, bit039, bit041, bit042, 
       bit043, bit048, bit049, bit052, bit060, dt_msg 
from sc_iso8583.tbl_msg8583 
where cd_msg in (11653381, 11687090, 11687103, 11687158);

select * from sc_opr.tbl_top order by cd_top

insert into sc_iso8583.tbl_msg8583(cd_msg, bit001, bit003, bit004, bit007, bit011, bit012, bit013, bit018, bit019, bit022, bit032, bit035,
                                   bit037, bit041, bit042, bit043, bit048, bit049, bit052, bit060, dt_msg)
values(11653381, '0x100', '002000', '000000002000', '1223110840', '101508', '090840', '1223', '0000', '076', '021', '00000001572', '6058681265405442=07240724107241000000', 
       '010009101508', '01240009', '051427102000129', '0501', '*CNP01451427102000129*CDT002T0', '986', '0AAD6088BFAF80CB', '05000', now());

select rqs.cd_rqs
from sc_opr.tbl_opr opr
     inner join sc_rdc.tbl_rqs rqs on opr.cd_opr = rqs.cd_opr
where opr.cd_top = 4
  and opr.cd_fet = 1841
  and opr.st_opr = 1;

  select sc_rdc.tr_confirma_compra_rdc(567256);

select rqs.cd_rqs
from sc_opr.tbl_opr opr
    inner join sc_rdc.tbl_rqs rqs on opr.cd_opr = rqs.cd_opr
where opr.cd_top = 4
 and opr.cd_fet = 1841
 and opr.st_opr = 1
 and opr.dt_opr < now() - (5 * interval '1 minute')

select sc_iso8583.valida_senha('6058681265405442', '8C776EF5E991AE9A', '99', '99');

select substring('6058681265405442', 4, 12)

update sc_opr.tbl_pls set nm_snh_pls = md5('1234') where cd_pls = 6058681265405442;

select sc_rdc.decripta3des('0000868126540544', '8C776EF5E991AE9A', 'BF121B4FCE210940C8250040EF0C0045BF121B4FCE210940');

select *
    from sc_iso8583.tbl_wkey
    where vrs_wkey = 99
      and idc_wkey = 99; 

select * from sc_iso8583.tbl_msg8583 where cd_msg = 11661658;
SELECT SC_ISO8583.EXECUTAR(11661197);

SELECT * FROM SC_RDC.TBL_FET WHERE DT_INC_USR >= CURRENT_dATE;
UPDATE SC_RDC.TBL_FET SET NR_LGC_FET = '051427102000129', NR_LGC_CEL_FET = NULL WHERE CD_FET = 1841;


select sc_job.executar_java_job('atualizarSituacaoSaqueLoterica', null);
