--Cartoes inativos por mÊs 90 dias
select to_char(dt_ult_dps_crt, 'mm/yyyy') mes_ultimo_deposito, 
       to_char((dt_ult_dps_crt + interval '90 days')::date, 'mm/yyyy') as mes_inativacao, 
       count(*) as qtde_cartoes,
       count(distinct fnc.cd_cun) as qtde_cpfs
from sc_opr.tbl_crt crt
     inner join sc_cad.tbl_fnc fnc on crt.cd_fnc = fnc.cd_fnc
where dt_ult_dps_crt >= to_date('01/01/2019', 'dd/mm/yyyy') - interval '90 days'
  and dt_ult_dps_crt < to_date('17/09/2019', 'dd/mm/yyyy') - interval '90 days'
group by to_char(dt_ult_dps_crt, 'mm/yyyy'), to_char((dt_ult_dps_crt + interval '90 days')::date, 'mm/yyyy')
order by mes_inativacao, mes_ultimo_deposito, qtde_cartoes desc;

--Cartoes inativos por mÊs 35 dias
select to_char(dt_ult_dps_crt, 'mm/yyyy') mes_ultimo_deposito, 
       to_char((dt_ult_dps_crt + interval '35 days')::date, 'mm/yyyy') as mes_inativacao, 
       count(*) as qtde_cartoes,
       count(distinct fnc.cd_cun) as qtde_cpfs
from sc_opr.tbl_crt crt
     inner join sc_cad.tbl_fnc fnc on crt.cd_fnc = fnc.cd_fnc
where dt_ult_dps_crt >= to_date('01/01/2019', 'dd/mm/yyyy') - interval '35 days'
  and dt_ult_dps_crt < to_date('17/09/2019', 'dd/mm/yyyy') - interval '35 days'
group by to_char(dt_ult_dps_crt, 'mm/yyyy'), to_char((dt_ult_dps_crt + interval '35 days')::date, 'mm/yyyy')
order by mes_inativacao, mes_ultimo_deposito, qtde_cartoes desc;