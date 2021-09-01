select sc_ctb.gerar_arquivo_exportacao_periodo('2019-12-12', '2019-12-12');
select sc_ctb.gerar_arquivo_exportacao_periodo('2019-12-13', '2019-12-13');
--select sc_ctb.gerar_arquivo_exportacao_periodo('2019-12-05', '2019-12-05');
--select sc_ctb.gerar_arquivo_exportacao_periodo('2019-12-06', '2019-12-06');
--select sc_ctb.gerar_arquivo_exportacao_periodo('2019-12-07', '2019-12-07');
--select sc_ctb.gerar_arquivo_exportacao_periodo('2019-12-08', '2019-12-08');

--select sc_opr.atualiza_limite_todos_contratos()

select * from sc_cnt.tbl_cnt where cd_cnt = 105557;
select * from sc_cnt.tbl_cnt where cd_cnt = 280360;
select * from sc_cnt.tbl_lcn where cd_lcn = 21368484;
select * from sc_cnt.tbl_lcn where cd_ctp_lcn = 21368484;

--problema dia 20/11 conta para ser configurada: 105557
--problema dia 21/11 conta para ser configurada: 19601
--problema dia 22/11 conta para ser configurada: 280459
--problema dia 25/11 conta para ser configurada: 70982
--problema dia 26/11 conta para ser configurada: 3504
