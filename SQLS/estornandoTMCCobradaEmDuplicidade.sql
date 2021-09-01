--listando todos os clientes que tiveram TMC cobradas em duplicidade
select tsc.cd_crt, max(tsc.cd_tsc) as max_servico, count(*) as qtde
from sc_srv.tbl_tsc tsc
where tsc.dt_vnc_tsc >= '2019-12-01'
  and tsc.cd_srv = 12
  and tsc.st_tsc = 2
group by tsc.cd_crt
having count(*) > 1;

--consultando um caso específico de TMC cobradas de um cliente
select *
from sc_srv.tbl_tsc tsc
where tsc.dt_vnc_tsc >= '2019-12-01'
  and tsc.cd_srv = 12
  --and tsc.st_tsc = 2
  and tsc.cd_crt = 60586810662614;

--estornando valor das empresas
select sc__buxo.estornar_tmc_duplicidade();