select tdp.nm_tdp as tipo_despesa,
       count(*) as qtde_total, sum(dsp.vl_dsp) as valor_total,
       sum(case when dsp.dt_cnf_usr >= '2019-01-01' and dsp.dt_cnf_usr < '2019-02-01' then 1 else 0 end) as qtde_jan,
       sum(case when dsp.dt_cnf_usr >= '2019-01-01' and dsp.dt_cnf_usr < '2019-02-01' then dsp.vl_dsp else 0 end) as valor_jan,
       sum(case when dsp.dt_cnf_usr >= '2019-02-01' and dsp.dt_cnf_usr < '2019-03-01' then 1 else 0 end) as qtde_fev,
       sum(case when dsp.dt_cnf_usr >= '2019-02-01' and dsp.dt_cnf_usr < '2019-03-01' then dsp.vl_dsp else 0 end) as valor_fev,
       sum(case when dsp.dt_cnf_usr >= '2019-03-01' and dsp.dt_cnf_usr < '2019-04-01' then 1 else 0 end) as qtde_mar,
       sum(case when dsp.dt_cnf_usr >= '2019-03-01' and dsp.dt_cnf_usr < '2019-04-01' then dsp.vl_dsp else 0 end) as valor_mar,
       sum(case when dsp.dt_cnf_usr >= '2019-04-01' and dsp.dt_cnf_usr < '2019-05-01' then 1 else 0 end) as qtde_abr,
       sum(case when dsp.dt_cnf_usr >= '2019-04-01' and dsp.dt_cnf_usr < '2019-05-01' then dsp.vl_dsp else 0 end) as valor_abr,
       sum(case when dsp.dt_cnf_usr >= '2019-05-01' and dsp.dt_cnf_usr < '2019-06-01' then 1 else 0 end) as qtde_mai,
       sum(case when dsp.dt_cnf_usr >= '2019-05-01' and dsp.dt_cnf_usr < '2019-06-01' then dsp.vl_dsp else 0 end) as valor_mai,
       sum(case when dsp.dt_cnf_usr >= '2019-06-01' and dsp.dt_cnf_usr < '2019-07-01' then 1 else 0 end) as qtde_jun,
       sum(case when dsp.dt_cnf_usr >= '2019-06-01' and dsp.dt_cnf_usr < '2019-07-01' then dsp.vl_dsp else 0 end) as valor_jun,
       sum(case when dsp.dt_cnf_usr >= '2019-07-01' and dsp.dt_cnf_usr < '2019-08-01' then 1 else 0 end) as qtde_jul,
       sum(case when dsp.dt_cnf_usr >= '2019-07-01' and dsp.dt_cnf_usr < '2019-08-01' then dsp.vl_dsp else 0 end) as valor_jul,
       sum(case when dsp.dt_cnf_usr >= '2019-08-01' and dsp.dt_cnf_usr < '2019-09-01' then 1 else 0 end) as qtde_ago,
       sum(case when dsp.dt_cnf_usr >= '2019-08-01' and dsp.dt_cnf_usr < '2019-09-01' then dsp.vl_dsp else 0 end) as valor_ago,
       sum(case when dsp.dt_cnf_usr >= '2019-09-01' and dsp.dt_cnf_usr < '2019-10-01' then 1 else 0 end) as qtde_set,
       sum(case when dsp.dt_cnf_usr >= '2019-09-01' and dsp.dt_cnf_usr < '2019-10-01' then dsp.vl_dsp else 0 end) as valor_set,
       sum(case when dsp.dt_cnf_usr >= '2019-10-01' and dsp.dt_cnf_usr < '2019-11-01' then 1 else 0 end) as qtde_out,
       sum(case when dsp.dt_cnf_usr >= '2019-10-01' and dsp.dt_cnf_usr < '2019-11-01' then dsp.vl_dsp else 0 end) as valor_out,
       sum(case when dsp.dt_cnf_usr >= '2019-11-01' and dsp.dt_cnf_usr < '2019-12-01' then 1 else 0 end) as qtde_nov,
       sum(case when dsp.dt_cnf_usr >= '2019-11-01' and dsp.dt_cnf_usr < '2019-12-01' then dsp.vl_dsp else 0 end) as valor_nov,
       sum(case when dsp.dt_cnf_usr >= '2019-12-01' and dsp.dt_cnf_usr < '2020-01-01' then 1 else 0 end) as qtde_dez,
       sum(case when dsp.dt_cnf_usr >= '2019-12-01' and dsp.dt_cnf_usr < '2020-01-01' then dsp.vl_dsp else 0 end) as valor_dez
from sc_cap.tbl_dsp dsp
     inner join sc_cap.tbl_tdp tdp on dsp.cd_tdp = tdp.cd_tdp
where dsp.dt_cnf_usr >= '2019-01-01'
  and dsp.st_dsp = 3
group by tdp.nm_tdp
order by tipo_despesa;

  select * from sc_cad.tbl_dmn where nm_cmp_dmn = 'ST_DSP';

  select * from sc_cap.tbl_atd
