select * from sc_pbl.tbl_ftp where cd_ftp = 2;
select * from sc_ssp.tbl_haep where cd_haep = 12646;

select * from sc_pbl.tbl_ftp where cd_ftp = 2;

--marcar como não enviado
update sc_ssp.tbl_haep 
   set st_haep = 1, 
       dt_env_haep = null
where cd_haep in (12686);

--marcar como enviado
update sc_ssp.tbl_haep 
   set st_haep = 2, 
       dt_env_haep = now()
where cd_haep in (12736, 12737, 12738, 12739, 12740, 12741, 12742);

update sc_pbl.tbl_ftp set flag_passivo = 'N' where cd_ftp = 2;
update sc_pbl.tbl_ftp set nm_snh_ftp = 'SOM2019A' where cd_ftp = 2;
select * from sc_pbl.tbl_ftp where cd_ftp = 2;