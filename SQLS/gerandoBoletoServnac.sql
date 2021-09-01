select * from sc_opr.tbl_crt where cd_crt = 62015539907844
select * from sc_opr.tbl_ocr where cd_crt = 62015539907844 and dt_inc_usr >= '2019-10-05';

--lista de faturas de cartões inativos selecionadas para geração de boleto
select emp.nm_emp as empresa,
       crt.cd_crt as cartao,
       cun.nm_cun as nome,
       --'select sc_cbr.gerar_boleto(1, 2, ' || fcr.cd_fcr || ');' as comando_geracao_boleto,
       --'update sc_fcr.tbl_fcr set dt_vnc_fcr = ''2019-11-10'' where cd_fcr = ' || fcr.cd_fcr || ';' as comando_alterar_vencimento,
       --'curl --header Cookie: JSESSIONID=8E2450CC030F6C377FE3EB675D8372C7 --header Connection: keep-alive http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=' || fcr.cd_fcr || ' --output ' || replace(cun.nm_cun, ' ', '_') || '.pdf' as comando_imprimir_boleto,
       (case when crt.fg_ind_crt = 'S' then current_date - crt.dt_ini_atr_crt else 0 end) dias_atraso,
       cun.nr_cpf_cnpj_cun as cpf,
       fcr.vl_sld_dvd_fcr as saldo_devedor
from sc_opr.tbl_crt crt
     inner join sc_cad.tbl_fnc fnc on crt.cd_fnc = fnc.cd_fnc
     inner join sc_cad.tbl_emp emp on fnc.cd_emp = emp.cd_emp
     inner join sc_cad.tbl_cun cun on fnc.cd_cun = cun.cd_cun
     inner join sc_fcr.tbl_fcr fcr on fcr.cd_fcr = crt.cd_fcr
where emp.cd_gem = 249
  and crt.fg_atv_crt = 'N'
  and fcr.st_fcr = 1
  and fcr.dt_ems_fcr >= '2019-08-01'
  and fcr.dt_vnc_fcr = '2019-11-10'
  and exists (select 1 from sc_opr.tbl_ocr ocr where ocr.cd_crt = crt.cd_crt and ocr.cd_toc = 6 and ocr.dt_inc_usr >= '2019-10-01')
order by empresa, nome;

--lista de faturas de cartões ativos selecionadas para geração de boleto
select emp.nm_emp as empresa,
       crt.cd_crt as cartao,
       cun.nm_cun as nome,
       --'select sc_cbr.gerar_boleto(1, 2, ' || fcr.cd_fcr || ');' as comando_geracao_boleto,
       --'update sc_fcr.tbl_fcr set dt_vnc_fcr = ''2019-11-10'' where cd_fcr = ' || fcr.cd_fcr || ';' as comando_alterar_vencimento,
       --'curl --header Cookie: JSESSIONID=8E2450CC030F6C377FE3EB675D8372C7 --header Connection: keep-alive http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=' || fcr.cd_fcr || ' --output ' || replace(cun.nm_cun, ' ', '_') || '.pdf' as comando_imprimir_boleto,
       (case when crt.fg_ind_crt = 'S' then current_date - crt.dt_ini_atr_crt else 0 end) dias_atraso,
       cun.nr_cpf_cnpj_cun as cpf,
       fcr.vl_sld_dvd_fcr as saldo_devedor
from sc_opr.tbl_crt crt
     inner join sc_cad.tbl_fnc fnc on crt.cd_fnc = fnc.cd_fnc
     inner join sc_cad.tbl_emp emp on fnc.cd_emp = emp.cd_emp
     inner join sc_cad.tbl_cun cun on fnc.cd_cun = cun.cd_cun
     inner join sc_fcr.tbl_fcr fcr on fcr.cd_fcr = crt.cd_fcr
where emp.cd_gem = 249
  and crt.fg_atv_crt = 'S'
  and fcr.st_fcr = 1
  and fcr.dt_ems_fcr >= '2019-08-01'
order by empresa, nome;

--obtendo o paramento que indica o cedente de geração padrão dos boletos
select * from sc_cad.tbl_prm where nm_prm = 'CODIGO_CONTRATO_COBRANCA_PADRAO';

--comandos para a alteração da data de vencimento da fatura
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3712433;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3714817;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3712449;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3714994;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3711922;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3725370;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3720430;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3718871;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3719054;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3721626;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3718786;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3715427;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3599330;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3714409;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3718940;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3715430;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3717014;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3720913;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3718931;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3725576;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3717264;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3715437;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3725337;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3719026;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3721093;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3720967;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3719061;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3725667;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3711849;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3711848;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3718939;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3712461;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3719666;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3718145;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3725151;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3711752;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3721382;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3718872;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3718869;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3725639;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3711698;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3724881;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3726553;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3719018;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3599346;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3718236;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3715402;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3715100;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3720381;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3718267;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3724380;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3713870;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3720012;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3722377;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3718385;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3716512;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3717501;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3712313;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3718709;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3719142;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3720081;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3724381;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3724374;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3718271;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3717611;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3719093;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3715026;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3725095;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3720824;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3725817;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3717888;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3715342;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3605723;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3720815;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3717862;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3719498;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3714722;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3725376;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3717718;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3718438;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3717865;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3721900;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3718833;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3719494;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3715890;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3719846;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3711506;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3720102;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3720850;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3716909;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3717885;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3717884;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3718373;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3608294;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3719465;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3717883;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3719497;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3719499;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3715698;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3715348;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3725089;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3719730;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3724210;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3724201;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3720817;

update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3715825;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3724668;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3724670;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3719063;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3720010;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3715439;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3717480;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3724006;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3716770;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3716700;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3717787;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3719305;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3716906;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3724196;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3724195;
update sc_fcr.tbl_fcr set dt_vnc_fcr = '2019-11-10' where cd_fcr = 3724207;


--comandos para geração dos boletos
select sc_cbr.gerar_boleto(1, 2, 3712433);
select sc_cbr.gerar_boleto(1, 2, 3714817);
select sc_cbr.gerar_boleto(1, 2, 3712449);
select sc_cbr.gerar_boleto(1, 2, 3714994);
select sc_cbr.gerar_boleto(1, 2, 3711922);
select sc_cbr.gerar_boleto(1, 2, 3725370);
select sc_cbr.gerar_boleto(1, 2, 3720430);
select sc_cbr.gerar_boleto(1, 2, 3718871);
select sc_cbr.gerar_boleto(1, 2, 3719054);
select sc_cbr.gerar_boleto(1, 2, 3721626);
select sc_cbr.gerar_boleto(1, 2, 3718786);
select sc_cbr.gerar_boleto(1, 2, 3715427);
select sc_cbr.gerar_boleto(1, 2, 3599330);
select sc_cbr.gerar_boleto(1, 2, 3714409);
select sc_cbr.gerar_boleto(1, 2, 3718940);
select sc_cbr.gerar_boleto(1, 2, 3715430);
select sc_cbr.gerar_boleto(1, 2, 3717014);
select sc_cbr.gerar_boleto(1, 2, 3720913);
select sc_cbr.gerar_boleto(1, 2, 3718931);
select sc_cbr.gerar_boleto(1, 2, 3725576);
select sc_cbr.gerar_boleto(1, 2, 3717264);
select sc_cbr.gerar_boleto(1, 2, 3715437);
select sc_cbr.gerar_boleto(1, 2, 3725337);
select sc_cbr.gerar_boleto(1, 2, 3719026);
select sc_cbr.gerar_boleto(1, 2, 3721093);
select sc_cbr.gerar_boleto(1, 2, 3720967);
select sc_cbr.gerar_boleto(1, 2, 3719061);
select sc_cbr.gerar_boleto(1, 2, 3725667);
select sc_cbr.gerar_boleto(1, 2, 3711849);
select sc_cbr.gerar_boleto(1, 2, 3711848);
select sc_cbr.gerar_boleto(1, 2, 3718939);
select sc_cbr.gerar_boleto(1, 2, 3712461);
select sc_cbr.gerar_boleto(1, 2, 3719666);
select sc_cbr.gerar_boleto(1, 2, 3718145);
select sc_cbr.gerar_boleto(1, 2, 3725151);
select sc_cbr.gerar_boleto(1, 2, 3711752);
select sc_cbr.gerar_boleto(1, 2, 3721382);
select sc_cbr.gerar_boleto(1, 2, 3718872);
select sc_cbr.gerar_boleto(1, 2, 3718869);
select sc_cbr.gerar_boleto(1, 2, 3725639);
select sc_cbr.gerar_boleto(1, 2, 3711698);
select sc_cbr.gerar_boleto(1, 2, 3724881);
select sc_cbr.gerar_boleto(1, 2, 3726553);
select sc_cbr.gerar_boleto(1, 2, 3719018);
select sc_cbr.gerar_boleto(1, 2, 3599346);
select sc_cbr.gerar_boleto(1, 2, 3718236);
select sc_cbr.gerar_boleto(1, 2, 3715402);
select sc_cbr.gerar_boleto(1, 2, 3715100);
select sc_cbr.gerar_boleto(1, 2, 3720381);
select sc_cbr.gerar_boleto(1, 2, 3718267);
select sc_cbr.gerar_boleto(1, 2, 3724380);
select sc_cbr.gerar_boleto(1, 2, 3713870);
select sc_cbr.gerar_boleto(1, 2, 3720012);
select sc_cbr.gerar_boleto(1, 2, 3722377);
select sc_cbr.gerar_boleto(1, 2, 3718385);
select sc_cbr.gerar_boleto(1, 2, 3716512);
select sc_cbr.gerar_boleto(1, 2, 3717501);
select sc_cbr.gerar_boleto(1, 2, 3712313);
select sc_cbr.gerar_boleto(1, 2, 3718709);
select sc_cbr.gerar_boleto(1, 2, 3719142);
select sc_cbr.gerar_boleto(1, 2, 3720081);
select sc_cbr.gerar_boleto(1, 2, 3724381);
select sc_cbr.gerar_boleto(1, 2, 3724374);
select sc_cbr.gerar_boleto(1, 2, 3718271);
select sc_cbr.gerar_boleto(1, 2, 3717611);
select sc_cbr.gerar_boleto(1, 2, 3719093);
select sc_cbr.gerar_boleto(1, 2, 3715026);
select sc_cbr.gerar_boleto(1, 2, 3725095);
select sc_cbr.gerar_boleto(1, 2, 3720824);
select sc_cbr.gerar_boleto(1, 2, 3725817);
select sc_cbr.gerar_boleto(1, 2, 3717888);
select sc_cbr.gerar_boleto(1, 2, 3715342);
select sc_cbr.gerar_boleto(1, 2, 3605723);
select sc_cbr.gerar_boleto(1, 2, 3720815);
select sc_cbr.gerar_boleto(1, 2, 3717862);
select sc_cbr.gerar_boleto(1, 2, 3719498);
select sc_cbr.gerar_boleto(1, 2, 3714722);
select sc_cbr.gerar_boleto(1, 2, 3725376);
select sc_cbr.gerar_boleto(1, 2, 3717718);
select sc_cbr.gerar_boleto(1, 2, 3718438);
select sc_cbr.gerar_boleto(1, 2, 3717865);
select sc_cbr.gerar_boleto(1, 2, 3721900);
select sc_cbr.gerar_boleto(1, 2, 3718833);
select sc_cbr.gerar_boleto(1, 2, 3719494);
select sc_cbr.gerar_boleto(1, 2, 3715890);
select sc_cbr.gerar_boleto(1, 2, 3719846);
select sc_cbr.gerar_boleto(1, 2, 3711506);
select sc_cbr.gerar_boleto(1, 2, 3720102);
select sc_cbr.gerar_boleto(1, 2, 3720850);
select sc_cbr.gerar_boleto(1, 2, 3716909);
select sc_cbr.gerar_boleto(1, 2, 3717885);
select sc_cbr.gerar_boleto(1, 2, 3717884);
select sc_cbr.gerar_boleto(1, 2, 3718373);
select sc_cbr.gerar_boleto(1, 2, 3608294);
select sc_cbr.gerar_boleto(1, 2, 3719465);
select sc_cbr.gerar_boleto(1, 2, 3717883);
select sc_cbr.gerar_boleto(1, 2, 3719497);
select sc_cbr.gerar_boleto(1, 2, 3719499);
select sc_cbr.gerar_boleto(1, 2, 3715698);
select sc_cbr.gerar_boleto(1, 2, 3715348);
select sc_cbr.gerar_boleto(1, 2, 3725089);
select sc_cbr.gerar_boleto(1, 2, 3719730);
select sc_cbr.gerar_boleto(1, 2, 3724210);
select sc_cbr.gerar_boleto(1, 2, 3724201);
select sc_cbr.gerar_boleto(1, 2, 3720817);

select sc_cbr.gerar_boleto(1, 2, 3715825);
select sc_cbr.gerar_boleto(1, 2, 3724668);
select sc_cbr.gerar_boleto(1, 2, 3724670);
select sc_cbr.gerar_boleto(1, 2, 3719063);
select sc_cbr.gerar_boleto(1, 2, 3720010);
select sc_cbr.gerar_boleto(1, 2, 3715439);
select sc_cbr.gerar_boleto(1, 2, 3717480);
select sc_cbr.gerar_boleto(1, 2, 3724006);
select sc_cbr.gerar_boleto(1, 2, 3716770);
select sc_cbr.gerar_boleto(1, 2, 3716700);
select sc_cbr.gerar_boleto(1, 2, 3717787);
select sc_cbr.gerar_boleto(1, 2, 3719305);
select sc_cbr.gerar_boleto(1, 2, 3716906);
select sc_cbr.gerar_boleto(1, 2, 3724196);
select sc_cbr.gerar_boleto(1, 2, 3724195);
select sc_cbr.gerar_boleto(1, 2, 3724207);


--comando para a impressão dos boletos
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3712433
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3714817
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3712449
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3714994
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3711922
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3725370
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3720430
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3718871
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3719054
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3721626
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3718786
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3715427
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3599330
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3714409
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3718940
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3715430
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3717014
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3720913
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3718931
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3725576
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3717264
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3715437
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3725337
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3719026
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3721093
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3720967
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3719061
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3725667
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3711849
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3711848
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3718939
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3712461
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3719666
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3718145
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3725151
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3711752
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3721382
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3718872
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3718869
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3725639
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3711698
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3724881
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3726553
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3719018
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3599346
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3718236
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3715402
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3715100
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3720381
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3718267
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3724380
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3713870
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3720012
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3722377
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3718385
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3716512
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3717501
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3712313
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3718709
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3719142
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3720081
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3724381
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3724374
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3718271
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3717611
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3719093
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3715026
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3725095
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3720824
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3725817
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3717888
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3715342
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3605723
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3720815
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3717862
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3719498
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3714722
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3725376
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3717718
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3718438
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3717865
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3721900
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3718833
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3719494
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3715890
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3719846
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3711506
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3720102
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3720850
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3716909
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3717885
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3717884
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3718373
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3608294
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3719465
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3717883
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3719497
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3719499
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3715698
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3715348
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3725089
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3719730
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3724210
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3724201
http://192.168.1.6:8080/scan/pages/fatura_relatorio?objetoAtualiza.codigo=3720817


select * from sc_sgr.tbl_rol where nm_rol like '%fatura_relatorio%'