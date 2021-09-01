select * from sc_msg.tbl_msg where fg_atv_msg = 'S' and fg_env_msg = 'N' and dt_inc_usr >= current_date and cd_tms in (2, 4) limit 10;
select count(*) from sc_msg.tbl_msg where fg_atv_msg = 'S' and fg_env_msg = 'N' and dt_inc_usr >= current_date and cd_tms in (2, 4);
update sc_msg.tbl_msg set fg_atv_msg = 'N' where fg_atv_msg = 'S' and fg_env_msg = 'N' and dt_inc_usr >= current_date and cd_tms in (2, 4);

select * from sc_msg.tbl_tms