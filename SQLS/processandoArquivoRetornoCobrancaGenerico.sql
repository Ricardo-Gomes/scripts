select harcg.cd_harcg
from sc_cbr.tbl_harcg harcg
where st_harcg = 1 
                   
select sc_cbr.validar_arquivo_retorno_gen(1993);
select sc_cbr.validar_arquivo_retorno_gen(1994);

select sc_cbr.efetuar_baixas_retorno_gen(1993,1);
select sc_cbr.efetuar_baixas_retorno_gen(1994,1);