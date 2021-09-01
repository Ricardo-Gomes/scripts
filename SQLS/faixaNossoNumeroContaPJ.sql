--listando todas as faixas de nosso números cadastradas
select cce.cd_cce, 
       gem.cd_gem || ' - ' || gem.nm_gem as grupo_empresarial,
       emp.cd_emp || ' - ' || emp.nm_emp as empresa, 
       cnt.cd_cnt || ' - ' || cnt.nm_cnt as conta, 
       cun.nr_cpf_cnpj_cun as cnpj, cun.nm_cun as razao_social, 
       cce.ns_nmr_ini_cce || ' - ' || cce.ns_nmr_fin_cce as faixa_nosso_numero
from sc_cce.tbl_cce cce
     inner join sc_cad.tbl_cun cun on cce.cd_cun = cun.cd_cun
     inner join sc_cad.tbl_fem fem on cun.cd_cun = fem.cd_cun and fem.cd_fem = 1
     inner join sc_cad.tbl_emp emp on fem.cd_emp = emp.cd_emp
     inner join sc_cad.tbl_gem gem on emp.cd_gem = gem.cd_gem
     inner join sc_cnt.tbl_cnt cnt on cce.cd_cnt = cnt.cd_cnt
order by faixa_nosso_numero asc;