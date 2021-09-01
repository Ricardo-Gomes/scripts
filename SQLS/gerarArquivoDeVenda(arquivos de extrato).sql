-- Gerar Arquivo de Vendas (arquivos de extrato)
select sc_rdc.gerar_arquivo_extrato(
     50,
    '2020-01-01',
    '2020-01-31');