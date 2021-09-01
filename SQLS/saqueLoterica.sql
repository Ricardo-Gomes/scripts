--- obter as informações do saque loterica necessarias para fazer o desfazimento ou cancelamento
select pec.cartao, pec.protocolo
from sc_opr.tbl_pec_rec pec
where pec.operacao = 5802858