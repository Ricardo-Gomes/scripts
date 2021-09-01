select 'select ' || cmd_job || ';' as comando
from sc_job.tbl_job 
where tp_job = 1 
  and dt_vig_ini_job < current_date 
  and coalesce(dt_vig_fim_job, current_date) >= current_date 
  and fg_atv_job = 'S'
order by nr_ord_job;


--select sc_fcr.gerar_parcelas_e_cobrar_servicos(null, null);
--select sc_rdc.contabilizar_compra_credito();
--select sc_ccb.corrige_valor_parcela_saqueextra_new();
--select sc_fcr.gerar_fatura_data_apuracao(CURRENT_DATE);
--select sc_srv.cobrar_servico_tsm();
--select sc_fcr.contabilizar_fatura_cartao(NULL,NULL);
select sc_cnt.fecha_saldo_contas(CURRENT_DATE-2);
select sc_cnt.fecha_saldo_contas(CURRENT_DATE-1);
--select sc_opr.atualiza_limite_job();
--select sc_fcr.marcar_cartao_inadimplente();
--select sc_fep.fatura_campanha_eleicao(current_date);
--select sc_fep.fatura_empresas(CURRENT_DATE);
--select sc_cci.macar_desmarcar_cobranca_individual();
--select sc_ssp.gerar_arquivo_plastico();
--select sc_ssp.gerar_arquivo_senha();
--select sc_ssp.enviar_arquivos_plastico();
--select sc_srv.identificar_servico_contas_inativas(now()::date);
--select sc_srv.cobrar_servico_conta_inativa(now()::date);
--select sc_srv.cobrar_tarifa_servico(now()::date, null, null);
--select sc_opr.inativar_cartao(now()::date);
--select sc_rnc.processar_renegociacao_externa();
--select sc_rds.fechanento_valores_atm();
--select sc_ind.atualiza_inadimplencia();
--select sc_srv.identificar_servico_1_via_cartao();
--select sc_svg.gerar_arquivo_remessa(null);
--select sc_opr.atualiza_numero_saques_cartao();
--select sc_spc.processar_negativacao_spc();
--select sc_fep.contabilizar_fatura_empresa();
--select sc_mgr.atualizar_divida();
--select sc_mgr.efetuar_baixa_saqcard();
--select sc_aeo.gerar_arquivo_bracce_job();
--select sc_aeo.repassar_investidor();
--select sc_fin.cancelar_boleto_avulso();
--select sc_atb.zerar_tarifa_abonadas();
--select sc_rds.contabilizar_saque_facil();
--select sc_ccb.processar_pagamentos_ccb(current_date);
--select sc_ccb.repassar_cessionarios(current_date);
--select sc_ccb.contabiliza_baixa();
--select sc_ccb.atualizar_ccb();
--select sc_pgc.contabilizar_pagamentos();
--select sc_fcr.contabilizar_juros_multa();
--select sc_cnt.reprocessar_contas();
--select sc_mnt.gerar_minutrade_job();
--select sc_mnt.enviar_arquivo_minutrade();
--select sc_scan_cbe.quebrar_acordo();
select sc_scan_cbe.enviar_email_baixa_debito_em_conta();
--select sc_dgt.enviar_imagens(null,null);
--select sc_dgt.informar_digitalizacao();
--select sc_ctb.gerar_arquivo_exportacao_periodo(current_date-3,current_date-2);
--select sc_ctb.regerar_arquivos_cancelados();
--select sc_rdc.confirma_transacao_cielo();
--select sc_rdc.gerar_parcelas_estabelecimento();
--select sc_rdc.gerar_repasse(current_date);
--select sc_rdc.contabilizar_repasse();
--select sc_rdc.transfererir_repasse();
--select sc_ccb.gerar_arquivo_remessa_adicional_sem_endereco(current_date);
--select sc_ccb.gerar_arquivo_baixa_adicional(current_date);
--select sc_rdc.gerar_arquivo_habilita_produto_job();
--select sc_rdc.gerar_arquivo_extrato(current_date);
--select sc_analise.gerar_dados_inadimplencia_sintetica();
--select sc_rdc.gerar_arquivo_extrato_sobral_e_palacio(current_date);
--select sc_rcg.contabilizar_recargas();
select sc_adp.informar_cartoes_sem_deposito();



