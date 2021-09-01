alter table sc_fcr.tbl_fcr add data_inicio_cobranca date;

update sc_fcr.tbl_fcr set data_inicio_cobranca = current_date + 2 where cd_fcr in (3962677, 3962406);
update sc_fcr.tbl_fcr set data_inicio_cobranca = null where cd_fcr = 3962677;

select fcr.vl_sld_dvd_fcr,
           COALESCE(fcr.vl_rst_enc_fcr,0),
           fcr.cd_fcr,
           fcr.vl_mnm_fcr,
           crt.fg_ind_crt,
           fcr.vl_fcr
    from sc_fcr.tbl_fcr fcr
       inner join sc_opr.tbl_crt crt on crt.cd_fcr = fcr.cd_fcr
    where crt.cd_crt = 60586876660144
      --and fcr.st_fcr in (1, 6)
      and coalesce(fcr.data_inicio_cobranca, fcr.dt_ems_fcr) < now();

      select * from sc_fin.tbl_bnc where cd_bnc = 336;
      insert into sc_fin.tbl_bnc(cd_bnc, nm_bnc, nm_rdz_bnc, fg_atv_bnc)
      values(336, 'C6 BANK', 'C6 BANK', 'S');