--> conta cobrança: 161427
--> conta liquidação: 161126

select * from sc_ccb.tbl_csn

281054 - (AG 1048 C/C 4392-2)

select * from sc_fin.tbl_ccr order by cd_ccr;

SELECT * FROM sc_fin.tbl_ccr WHERE fg_sis_emp_ccr = 'N';

insert into sc_fin.tbl_ccr(cd_Ccr, cd_cnt, cd_bnc, cd_agn_ccr, cd_cnt_ccr, nr_dgt_vrf_cnt_ccr, nr_dgt_vrf_agn_ccr, fg_atv_ccr, cd_inc_usr, dt_inc_usr, tp_pss_ccr, nr_cpf_cnpj_ccr, nm_emp_ccr, nm_bnc_ccr, cd_cun, fg_sis_emp_ccr, fg_rrc_ccr)
values(13, 281054, 104, 1048, 4392, '2', '0', 'S', 1, now(), 'J', 21444981000136, 'SOMA', 'CAIXA ECONOMICA FEDERAL', 55219, 'S', 'S');