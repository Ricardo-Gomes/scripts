select max(mes) from sc_analise.tbl_cartoes_mes where ano = 2019;

select emp.nm_empresa as empresa,
       mes.descricao as mes,
       sum(case when cm.ativo = 'S' then 

select sc_analise.processa_mes('10/2019');

select emp.cd_emp as codigo_empresa,
       emp.nm_emp as empresa, coalesce(ina.data_contrato, ati.data_contrato) as data_contrato,
       --ina.*, ati.*
       sum(case when ina.mes = '01/2019' then ina.qtde_cartoes else 0 end) as cartoes_inativos_01_2019,
       sum(case when ati.mes = '01/2019' then ati.qtde_cartoes else 0 end) as cartoes_ativos_01_2019,
       sum(case when ina.mes = '02/2019' then ina.qtde_cartoes else 0 end) as cartoes_inativos_02_2019,
       sum(case when ati.mes = '02/2019' then ati.qtde_cartoes else 0 end) as cartoes_ativos_02_2019,
       sum(case when ina.mes = '03/2019' then ina.qtde_cartoes else 0 end) as cartoes_inativos_03_2019,
       sum(case when ati.mes = '03/2019' then ati.qtde_cartoes else 0 end) as cartoes_ativos_03_2019,
       sum(case when ina.mes = '04/2019' then ina.qtde_cartoes else 0 end) as cartoes_inativos_04_2019,
       sum(case when ati.mes = '04/2019' then ati.qtde_cartoes else 0 end) as cartoes_ativos_04_2019,
       sum(case when ina.mes = '05/2019' then ina.qtde_cartoes else 0 end) as cartoes_inativos_05_2019,
       sum(case when ati.mes = '05/2019' then ati.qtde_cartoes else 0 end) as cartoes_ativos_05_2019,
       sum(case when ina.mes = '06/2019' then ina.qtde_cartoes else 0 end) as cartoes_inativos_06_2019,
       sum(case when ati.mes = '06/2019' then ati.qtde_cartoes else 0 end) as cartoes_ativos_06_2019,
       sum(case when ina.mes = '07/2019' then ina.qtde_cartoes else 0 end) as cartoes_inativos_07_2019,
       sum(case when ati.mes = '07/2019' then ati.qtde_cartoes else 0 end) as cartoes_ativos_07_2019,
       sum(case when ina.mes = '08/2019' then ina.qtde_cartoes else 0 end) as cartoes_inativos_08_2019,
       sum(case when ati.mes = '08/2019' then ati.qtde_cartoes else 0 end) as cartoes_ativos_08_2019,
       sum(case when ina.mes = '09/2019' then ina.qtde_cartoes else 0 end) as cartoes_inativos_09_2019,
       sum(case when ati.mes = '09/2019' then ati.qtde_cartoes else 0 end) as cartoes_ativos_09_2019,
       sum(case when ina.mes = '10/2019' then ina.qtde_cartoes else 0 end) as cartoes_inativos_10_2019,
       sum(case when ati.mes = '10/2019' then ati.qtde_cartoes else 0 end) as cartoes_ativos_10_2019,
       sum(case when ina.mes = '11/2019' then ina.qtde_cartoes else 0 end) as cartoes_inativos_11_2019,
       sum(case when ati.mes = '11/2019' then ati.qtde_cartoes else 0 end) as cartoes_ativos_11_2019,
       sum(case when ina.mes = '12/2019' then ina.qtde_cartoes else 0 end) as cartoes_inativos_12_2019,
       sum(case when ati.mes = '12/2019' then ati.qtde_cartoes else 0 end) as cartoes_ativos_12_2019
from sc_cad.tbl_emp emp
     inner join sc_analise.tbl_mes mes on 1 = 1
     left join (select to_char((crt.dt_ult_dps_crt + interval '90 days')::date, 'mm/yyyy') as mes, 
                       to_char(ctr.dt_ctr, 'dd/mm/yyyy') as data_contrato,
                       fnc.cd_emp, count(*) as qtde_cartoes, 
                       count(distinct fnc.cd_cun) as qtde_cpfs
                from sc_opr.tbl_crt crt
                     inner join sc_cad.tbl_fnc fnc on crt.cd_fnc = fnc.cd_fnc
                     inner join sc_cad.tbl_ctr ctr on crt.cd_ctr = ctr.cd_ctr
                where crt.dt_ult_dps_crt >= to_date('01/01/2019', 'dd/mm/yyyy') - interval '90 days'
                  and crt.dt_ult_dps_crt < current_date - interval '90 days'
                  --and fnc.cd_emp = 948
                group by to_char((crt.dt_ult_dps_crt + interval '90 days')::date, 'mm/yyyy'), fnc.cd_emp, to_char(ctr.dt_ctr, 'dd/mm/yyyy')) ina on emp.cd_emp = ina.cd_emp and mes.descricao = ina.mes
     left join (select to_char((crt.dt_pri_dps_crt)::date, 'mm/yyyy') as mes, 
                       to_char(ctr.dt_ctr, 'dd/mm/yyyy') as data_contrato,
                       fnc.cd_emp, count(*) as qtde_cartoes, 
                       count(distinct fnc.cd_cun) as qtde_cpfs
                from sc_opr.tbl_crt crt
                     inner join sc_cad.tbl_fnc fnc on crt.cd_fnc = fnc.cd_fnc
                     inner join sc_cad.tbl_ctr ctr on crt.cd_ctr = ctr.cd_ctr
                where crt.dt_pri_dps_crt >= to_date('01/01/2019', 'dd/mm/yyyy')
                  and crt.dt_pri_dps_crt < current_date
                  --and fnc.cd_emp = 948
                group by to_char((crt.dt_pri_dps_crt)::date, 'mm/yyyy'), fnc.cd_emp, to_char(ctr.dt_ctr, 'dd/mm/yyyy')) ati on emp.cd_emp = ati.cd_emp and mes.descricao = ati.mes
where coalesce(ina.data_contrato, ati.data_contrato) is not null
group by emp.nm_emp, coalesce(ina.data_contrato, ati.data_contrato), emp.cd_emp
order by empresa, data_contrato desc;

select * from sc_cad.tbl_ctr limit 10;

insert into sc_analise.tbl_mes(descricao, mes, ano) values('01/2019', 1, 2019);
insert into sc_analise.tbl_mes(descricao, mes, ano) values('02/2019', 2, 2019);
insert into sc_analise.tbl_mes(descricao, mes, ano) values('03/2019', 3, 2019);
insert into sc_analise.tbl_mes(descricao, mes, ano) values('04/2019', 4, 2019);
insert into sc_analise.tbl_mes(descricao, mes, ano) values('05/2019', 5, 2019);
insert into sc_analise.tbl_mes(descricao, mes, ano) values('06/2019', 6, 2019);
insert into sc_analise.tbl_mes(descricao, mes, ano) values('07/2019', 7, 2019);
insert into sc_analise.tbl_mes(descricao, mes, ano) values('08/2019', 8, 2019);
insert into sc_analise.tbl_mes(descricao, mes, ano) values('09/2019', 9, 2019);
insert into sc_analise.tbl_mes(descricao, mes, ano) values('10/2019', 10, 2019);
insert into sc_analise.tbl_mes(descricao, mes, ano) values('11/2019', 11, 2019);
insert into sc_analise.tbl_mes(descricao, mes, ano) values('12/2019', 12, 2019);