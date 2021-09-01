select sc_msg.enviar_mensagem(null);

select --count(*)
       msg.*
  from sc_msg.tbl_msg msg
    inner join sc_msg.tbl_tms tms on tms.cd_tms = msg.cd_tms
  where msg.fg_env_msg = 'N'
    and msg.fg_atv_msg = 'S' 
    --and tms.cd_tms = 1
    and msg.ddd_msg > 0
    and msg.nr_msg > 0
    --and msg.dt_inc_usr < current_date;

update sc_msg.tbl_msg set fg_atv_msg = 'N' 
where cd_msg in (
select msg.cd_msg
  from sc_msg.tbl_msg msg
    inner join sc_msg.tbl_tms tms on tms.cd_tms = msg.cd_tms
  where msg.fg_env_msg = 'N'
    and msg.fg_atv_msg = 'S' 
    and tms.cd_tms = 1
    and msg.ddd_msg > 0
    and msg.nr_msg > 0
    and msg.dt_inc_usr < current_date
  limit 10000);