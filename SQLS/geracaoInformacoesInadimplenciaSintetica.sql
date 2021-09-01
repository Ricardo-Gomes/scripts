select case when crt.fg_ind_crt = 'S' then current_date - crt.dt_ini_atr_crt 
            else case when fcr.dt_vnc_fcr < current_date and fcr.vl_sld_dvd_fcr > 0 then current_date - fcr.dt_vnc_fcr end
       end as dias_atraso, 
       fcr.vl_sld_dvd_fcr as saldo_devedor, 
       coalesce(sc_fcr.get_valor_principal_compra(fcr.cd_fcr), 0) as valor_compra,
       coalesce(sc_fcr.get_valor_principal_ccb(fcr.cd_fcr), 0) as valor_ccb,
       crt.cd_crt as cartao
from sc_opr.tbl_crt crt
     inner join sc_fcr.tbl_fcr fcr on crt.cd_fcr = fcr.cd_fcr
where (crt.fg_ind_crt = 'S' or (fcr.dt_vnc_fcr < current_date and fcr.vl_sld_dvd_fcr > 0))
  and fcr.st_fcr = 1 
limit 10


select emp.nm_emp as empresa,
       dmn.nm_vlr_dmn as faixa_atraso,
       ins.qtde_devedores,
       ins.valor_ccb,
       ins.valor_compra,
       ins.valor_encargos,
       ins.valor_total
from sc_analise.tbl_inadimplencia_sintetica ins
     inner join sc_cad.tbl_emp emp on ins.empresa = emp.cd_emp
     left join sc_cad.tbl_dmn dmn on ins.faixa_atraso = dmn.vl_cmp_dmn and dmn.nm_cmp_dmn = 'FAIXA_ATRASO'
where ins.data_referencia = current_date
order by empresa, faixa_atraso

select * from sc_Cad.tbl_dmn limit 10

insert into sc_cad.tbl_dmn(cd_dmn, nm_cmp_dmn, vl_cmp_dmn, nm_vlr_dmn)
values(nextval('sc_cad.sq_dmn'), 'FAIXA_ATRASO', 1, '1 A 15 DIAS');
insert into sc_cad.tbl_dmn(cd_dmn, nm_cmp_dmn, vl_cmp_dmn, nm_vlr_dmn)
values(nextval('sc_cad.sq_dmn'), 'FAIXA_ATRASO', 2, '16 A 30 DIAS');
insert into sc_cad.tbl_dmn(cd_dmn, nm_cmp_dmn, vl_cmp_dmn, nm_vlr_dmn)
values(nextval('sc_cad.sq_dmn'), 'FAIXA_ATRASO', 3, '31 A 45 DIAS');
insert into sc_cad.tbl_dmn(cd_dmn, nm_cmp_dmn, vl_cmp_dmn, nm_vlr_dmn)
values(nextval('sc_cad.sq_dmn'), 'FAIXA_ATRASO', 4, '46 A 90 DIAS');
insert into sc_cad.tbl_dmn(cd_dmn, nm_cmp_dmn, vl_cmp_dmn, nm_vlr_dmn)
values(nextval('sc_cad.sq_dmn'), 'FAIXA_ATRASO', 5, '91 A 180 DIAS');
insert into sc_cad.tbl_dmn(cd_dmn, nm_cmp_dmn, vl_cmp_dmn, nm_vlr_dmn)
values(nextval('sc_cad.sq_dmn'), 'FAIXA_ATRASO', 6, '181 DIAS EM DIANTE');

select sc_analise.gerar_dados_inadimplencia_sintetica()