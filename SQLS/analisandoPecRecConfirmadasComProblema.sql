select dmn.nm_vlr_dmn, pec.* 
from sc_opr.tbl_pec_rec pec
     inner join sc_cad.tbl_dmn dmn on pec.situacao = dmn.vl_cmp_dmn and dmn.nm_cmp_dmn = 'SITUACAO_PEC_REC'
where data_inclusao >= current_date - interval '3 day'
  and pec.situacao = 2;


insert into sc_cad.tbl_dmn(cd_dmn, nm_cmp_dmn, vl_cmp_dmn, nm_vlr_dmn)
values(nextval('sc_cad.sq_dmn'), 'SITUACAO_PEC_REC', 6, 'CANCELADA');
alter table sc_opr.tbl_pec_rec add data_cancelamento timestamp without time zone;

60586896504863, 125059004
60586871528588, 125085714

select * from sc_cnt.tbl_tlc where cd_tlc = 186