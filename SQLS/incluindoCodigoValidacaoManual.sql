select * 
from sc_msg.tbl_cvm 
where dt_exp_vld_cvm >= current_date
  and nsu_org_cvm in (392, 418, 672) 
order by cd_cvm;

select * from sc_msg.tbl_cvm where cd_vld_cvm = '9962' and dt_exp_vld_cvm >= current_date

--consultando o código do contrato
select ctr.cd_ctr, emp.cd_emp, emp.nm_emp, ctr.fg_atv_ctr
from sc_cad.tbl_ctr ctr
     inner join sc_cad.tbl_emp emp on ctr.cd_emp = emp.cd_emp
where emp.cd_emp in (601, 367);
   --ctr.cd_ctr = 394

select * from sc_Cad.tbl_fem where cd_emp = 367;
select * from sc_cad.tbl_ctt where cd_cun = 70414;
select * from sc_cad.tbl_tlf where nsu_org_tlf = 3525;

98104-2333

601 - "VIGON"
367 - "PRESTACAO SERVICO"

select * from sc_msg.tbl_msg limit 10;
select * from sc_msg.tbl_msg where nr_msg = 996243476 and dt_env_msg >= current_Date - 1;

insert into sc_msg.tbl_cvm (cd_cvm, tp_org_cvm, nsu_org_cvm, cd_vld_cvm, dt_exp_vld_cvm, st_cvm, dt_st_cvm, nr_env_cvm)
values(nextval('sc_msg.sq_cvm'), 4, 672, '9028', now() + interval '3 hour', 1, now(), 1);

insert into sc_msg.tbl_cvm (cd_cvm, tp_org_cvm, nsu_org_cvm, cd_vld_cvm, dt_exp_vld_cvm, st_cvm, dt_st_cvm, nr_env_cvm)
values(nextval('sc_msg.sq_cvm'), 4, 672, '8342', now() + interval '3 hour', 1, now(), 1);

insert into sc_msg.tbl_cvm (cd_cvm, tp_org_cvm, nsu_org_cvm, cd_vld_cvm, dt_exp_vld_cvm, st_cvm, dt_st_cvm, nr_env_cvm)
values(nextval('sc_msg.sq_cvm'), 4, 392, '5764', now() + interval '3 hour', 1, now(), 1);

insert into sc_msg.tbl_cvm (cd_cvm, tp_org_cvm, nsu_org_cvm, cd_vld_cvm, dt_exp_vld_cvm, st_cvm, dt_st_cvm, nr_env_cvm)
values(nextval('sc_msg.sq_cvm'), 4, 418, '6231', now() + interval '3 hour', 1, now(), 1);

insert into sc_msg.tbl_msg(cd_msg, cd_tms, ddd_msg, nr_msg, prm_msg, fg_atv_msg, fg_env_msg, dt_env_msg, cd_inc_usr, dt_inc_usr, tp_env_msg)
values(nextval('sc_msg.sq_msg'), 7, 85, 981042333, '9028@do seu pagamento de contas', 'S', 'N', null, 1, now(), 1);

insert into sc_msg.tbl_msg(cd_msg, cd_tms, ddd_msg, nr_msg, prm_msg, fg_atv_msg, fg_env_msg, dt_env_msg, cd_inc_usr, dt_inc_usr, tp_env_msg)
values(nextval('sc_msg.sq_msg'), 7, 85, 981042333, '6231@do seu pagamento de contas', 'S', 'N', null, 1, now(), 1);

insert into sc_msg.tbl_msg(cd_msg, cd_tms, ddd_msg, nr_msg, prm_msg, fg_atv_msg, fg_env_msg, dt_env_msg, cd_inc_usr, dt_inc_usr, tp_env_msg)
values(nextval('sc_msg.sq_msg'), 7, 85, 981042333, '4723@do seu pagamento de contas', 'S', 'N', null, 1, now(), 1);