--listando todas as baixas realizadas no dia 12/11/2019
select fcr.cd_crt as cartao, emp.nm_emp as empresa, cun.nm_cun as nome, cun.nr_cpf_cnpj_cun as cpf, 
       tpc.ds_tpc as tipo_pagamento,
       sum(pfc.vl_pfc) as valor
from sc_fcr.tbl_fcr fcr
     inner join sc_fcr.tbl_pfc pfc on fcr.cd_fcr = pfc.cd_fcr
     inner join sc_fcr.tbl_tpc tpc on pfc.cd_tpc = tpc.cd_tpc
     inner join sc_opr.tbl_crt crt on pfc.cd_crt = crt.cd_crt
     inner join sc_cad.tbl_fnc fnc on crt.cd_fnc = fnc.cd_fnc
     inner join sc_cad.tbl_cun cun on fnc.cd_cun = cun.cd_cun
     inner join sc_cad.tbl_emp emp on fnc.cd_emp = emp.cd_emp
where emp.cd_gem = 249
  and pfc.dt_rcb_pfc >= '2019-11-10'
  and pfc.dt_rcb_pfc < '2019-11-13'
  and pfc.st_pfc = 1 --pagamento cadastrado
  --and pfc.cd_tpc = 1 --pagamento via boleto
  and pfc.cd_tpc not in (4) --pagamento via boleto
group by tpc.ds_tpc, fcr.cd_crt, emp.nm_emp, cun.nm_cun, cun.nr_cpf_cnpj_cun
order by cartao, empresa, nome;

select * from sc_fcr.tbl_pfc where dt_rcb_pfc >= current_Date and cd_crt = 60586814087030
select * from sc_fcr.tbl_tpc
  
--gerando os comandos de baixa de estorno
select 'select sc_fcr.contabilizar_baixar_cartao(' || fcr.cd_crt || '::numeric, ' || fcr.vl_sld_dvd_fcr || '::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);' as comando_baixa
from sc_fcr.tbl_fcr fcr
     inner join sc_opr.tbl_crt crt on fcr.cd_fcr = crt.cd_fcr
     inner join sc_cad.tbl_fnc fnc on crt.cd_fnc = fnc.cd_fnc
     inner join sc_cad.tbl_emp emp on fnc.cd_emp = emp.cd_emp
where emp.cd_gem = 249
  and fcr.dt_ult_pgt_fcr >= '2019-11-12'
  and fcr.dt_vnc_fcr = '2019-11-12'
  and fcr.vl_sld_dvd_fcr > 0
  and fcr.cd_crt <> 60586873507111;

--alterando o vencimento para evitar que seja cobrado juros na geração da próxima fatura
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3833081;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3835240;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3832347;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3835278;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3835277;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3835276;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3833224;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3833428;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3828288;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3835471;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3836528;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3840705;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3828509;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3835579;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3834145;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3833858;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3837580;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3833038;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3835070;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3833225;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3833226;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3840985;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3828623;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3835275;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3834212;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3833823;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3840704;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3841433;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3834108;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3836501;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3834646;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3832351;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3834871;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3833227;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3836519;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3838062;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3829995;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3829083;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3829188;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3829165;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3840023;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3840024;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3840022;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3833003;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3835730;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3839662;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3836078;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3833114;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3835786;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3831553;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3829072;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3833929;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3834660;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3833402;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3832950;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3839857;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3839851;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3839852;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3836499;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3839858;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3839866;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3833506;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3841246;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3829231;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3832078;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3833494;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3828413;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3840988;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3834160;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3835723;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3840499;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3832409;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3836783;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3834578;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3832819;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3834585;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3828651;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3840942;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3829016;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3829044;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3832410;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3829258;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3832408;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3832424;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3841185;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3829307;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3829308;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3833502;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3833511;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3836585;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3830144;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3829167;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3832155;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3836639;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3834265;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3833535;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3841280;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3833536;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3837059;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3840756;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3836127;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3834588;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3837305;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3829472;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3832386;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3833510;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3835415;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3832423;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3832425;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3840288;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3840286;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3714817;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3717787;
update sc_fcr.tbl_fcr set dt_vnc_fcr = current_date where cd_fcr = 3719538;

   
--baixando as faturas por estorno
select sc_fcr.contabilizar_baixar_cartao(62015590410191::numeric, 5.75::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(60586868918854::numeric, 1.00::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(60586859606308::numeric, 2.00::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(60586880873884::numeric, 7.50::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015521815850::numeric, 6.50::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015590889176::numeric, 11.75::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(60586898695045::numeric, 4.25::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(60586893509591::numeric, 10.25::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(60586871762696::numeric, 8.50::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015591042052::numeric, 3.00::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(60586883673727::numeric, 6.50::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015532409928::numeric, 4.00::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(60586847481326::numeric, 17.15::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(60586841005023::numeric, 25.90::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015573754479::numeric, 7.25::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015576456229::numeric, 6.50::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(60586884678988::numeric, 6.00::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(60586870342537::numeric, 10.85::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(60586892538921::numeric, 8.75::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015569083097::numeric, 6.25::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(60586881060915::numeric, 3.25::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015559464744::numeric, 0.50::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015563403012::numeric, 2.00::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(60586818780566::numeric, 9.25::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(60586885841111::numeric, 6.25::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(60586824695640::numeric, 10.75::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015520429462::numeric, 2.50::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015592646217::numeric, 1.25::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(60586877550155::numeric, 12.00::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015512993391::numeric, 6.75::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015581133639::numeric, 6.75::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015519227977::numeric, 4.75::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(60586865212458::numeric, 2.75::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(60586833948623::numeric, 13.75::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(60586818531712::numeric, 22.50::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(60586873568027::numeric, 17.00::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(60586846909513::numeric, 13.25::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015542790031::numeric, 11.25::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015540999042::numeric, 27.65::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015586088666::numeric, 0.75::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015594650930::numeric, 3.00::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015583456816::numeric, 2.25::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015527364463::numeric, 3.75::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015589592526::numeric, 9.00::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(60586889318528::numeric, 22.74::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015593408238::numeric, 1.00::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(60586896778398::numeric, 11.25::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(60586836070434::numeric, 18.75::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015541443762::numeric, 8.75::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015559540357::numeric, 8.75::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015584974528::numeric, 7.25::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015522564912::numeric, 11.25::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015517253317::numeric, 4.00::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015570458970::numeric, 4.75::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(60586884989099::numeric, 0.50::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(60586814087030::numeric, 9.25::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015540134615::numeric, 1.00::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015571765973::numeric, 5.25::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(60586884501125::numeric, 0.50::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015516127074::numeric, 1.02::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015556137185::numeric, 24.15::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015539907844::numeric, 19.63::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015550969712::numeric, 9.00::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015581516456::numeric, 11.00::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(60586858577031::numeric, 10.50::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015574183285::numeric, 6.25::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015557315030::numeric, 7.25::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015585314939::numeric, 8.25::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015568800323::numeric, 8.25::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015515485679::numeric, 12.00::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015582700282::numeric, 8.25::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015580282270::numeric, 9.50::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015584226725::numeric, 8.25::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015562799752::numeric, 10.00::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015562748647::numeric, 1.25::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015571027802::numeric, 9.50::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015511723908::numeric, 10.50::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015578975580::numeric, 1.00::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015546226205::numeric, 18.00::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015528500382::numeric, 7.50::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015544885323::numeric, 4.75::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015582062602::numeric, 6.75::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015593549171::numeric, 9.25::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015523066009::numeric, 5.25::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015535537452::numeric, 7.25::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015578691572::numeric, 3.50::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015512121871::numeric, 6.75::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015595491580::numeric, 9.25::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015565947851::numeric, 7.75::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015593719278::numeric, 8.50::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(60586867002014::numeric, 7.25::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015517123817::numeric, 19.15::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015554685505::numeric, 7.75::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(60586890412091::numeric, 16.50::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015568770845::numeric, 3.93::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);
select sc_fcr.contabilizar_baixar_cartao(62015527893357::numeric, 3.75::double precision, 4::numeric, now()::timestamp without time zone, 1::numeric, null::numeric);




  select * from sc_fcr.tbl_fcr limit 10

  alter table sc_fcr.tbl_fcr add eh_pra_cobrar_juros character(1);