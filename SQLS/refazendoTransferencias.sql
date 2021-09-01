select * from sc_atb.tbl_tba where cd_tba = 335034;
select * from sc_atb.tbl_dtb where cd_dtb = 292641;

select sum(vl_dtb) from sc_atb.tbl_dtb where cd_atb = 2741;


SELECT nr_cpf_cnpj_tba as cpf, nm_tba as nome, vl_tba as valor, tba.ds_mtv_rjc_tba as motivo
	  FROM sc_atb.tbl_tba tba
	       inner join sc_atb.tbl_dtb dtb on tba.cd_dtb = dtb.cd_dtb
     WHERE tba.dt_env_tba >= '2019-11-20'
	  AND tba.dt_env_tba < '2019-11-21'
	  AND tba.st_tba = 6
	  and tba.dt_inc_usr < '2019-11-21'
	  and dtb.cd_atb = 2741
	  AND tba.ds_mtv_rjc_tba not LIKE '%Data da efetivação anterior a do processamento%'
	  AND tba.tp_pss_tba = 'F'
	  AND tba.cd_inc_usr <> 716;

--transferencia não realizadas
SELECT nr_cpf_cnpj_tba as cpf, nm_tba as nome, vl_tba as valor, cd_dbt_cnt as conta
	  FROM sc_atb.tbl_tba tba
	       inner join sc_atb.tbl_dtb dtb on tba.cd_dtb = dtb.cd_dtb
     WHERE tba.dt_env_tba >= '2019-11-20'
	  AND tba.dt_env_tba < '2019-11-21'
	  AND tba.st_tba = 6
	  and tba.dt_inc_usr < '2019-11-21'
	  --and dtb.cd_atb = 2741
	  AND tba.ds_mtv_rjc_tba LIKE '%Data da efetivação anterior a do processamento%'
	  AND tba.tp_pss_tba = 'F'
	  AND tba.cd_inc_usr <> 716
	  and not exists (select 1 
	                  from sc_atb.tbl_tba tba2 
	                  where tba2.st_tba = 1 
	                    and tba2.dt_inc_usr >= current_Date 
	                    and tba2.nr_cpf_cnpj_tba = tba.nr_cpf_cnpj_tba);

--transferencia realizadas
SELECT nr_cpf_cnpj_tba as cpf, nm_tba as nome, vl_tba as valor, cd_dbt_cnt as conta
	  FROM sc_atb.tbl_tba tba
	       inner join sc_atb.tbl_dtb dtb on tba.cd_dtb = dtb.cd_dtb
     WHERE tba.dt_env_tba >= '2019-11-20'
	  AND tba.dt_env_tba < '2019-11-21'
	  AND tba.st_tba = 6
	  and tba.dt_inc_usr < '2019-11-21'
	  --and dtb.cd_atb = 2741
	  AND tba.ds_mtv_rjc_tba LIKE '%Data da efetivação anterior a do processamento%'
	  AND tba.tp_pss_tba = 'F'
	  AND tba.cd_inc_usr <> 716
	  and exists (select 1 
	                  from sc_atb.tbl_tba tba2 
	                  where tba2.st_tba = 1 
	                    and tba2.dt_inc_usr >= current_Date 
	                    and tba2.nr_cpf_cnpj_tba = tba.nr_cpf_cnpj_tba)	                    
	  

	  select sc_atb.realizar_transferencias_rejeitadas_por_horario()
group by substring(trim(tba.ds_mtv_rjc_tba), 1, 30)