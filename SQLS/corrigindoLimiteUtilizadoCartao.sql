--utilizando a rotina para calcular o valor do limite, sem realizar a alteração, só exibindo mensagens
--com os valores calculados
select sc_opr.corrigir_limite_utilizado(60586888161586, false);

select --tlt.cd_tlt as tipo_limite, tlt.nm_tlt as nome_tipo_limite, sum(vl_rst_fcr_tlt) as valor_utilizado
       fcr_tlt.*
from sc_opr.tbl_crt crt
    inner join sc_fcr.tbl_fcr fcr on crt.cd_fcr = fcr.cd_fcr
    inner join sc_fcr.tbl_fcr_tlt fcr_tlt on fcr.cd_fcr = fcr_tlt.cd_fcr
    inner join sc_opr.tbl_tlt tlt on fcr_tlt.cd_tlt = tlt.cd_tlt
where crt.cd_crt = 60586888161586
  and vl_rst_fcr_tlt > 0
--group by tlt.cd_tlt, tlt.nm_tlt

update sc_fcr.tbl_fcr_tlt set vl_rst_fcr_tlt = 131.90 where cd_fcr = 4121749 and cd_tlt = 1;

--utilizando a rotina para calcular o valor do limite, realizando a alteração no banco de dados,
--sugiro fortemente simular antes de realizar a alteração
select sc_opr.corrigir_limite_utilizado(60586885646659, true);