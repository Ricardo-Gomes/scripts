select  *
from sc_cad.tbl_fnc 
where 
	cd_emp = 699 
	and cd_fem = 1 
	and st_fnc = 1 
order by nr_idt_fnc;



select * from sc_cad.tbl_fnc where cd_emp = 699 and cd_fem = 1 and nr_idt_fnc like '0%' and st_fnc = 1 order by nr_idt_fnc;
select * from sc_cad.tbl_fnc where cd_emp = 699 and cd_fem = 1 and st_fnc = 1 order by nr_idt_fnc;

select
cd_fnc, nr_idt_fnc 
from 
sc_cad.tbl_fnc  
where
cd_emp = 699 and cd_fem = 1 and st_fnc = 1 order by nr_idt_fnc;

-------
--update sc_cad.tbl_fnc set nr_idt_fnc = lpad(nr_idt_fnc, 6, '0' ) where cd_emp =  699 --colocar zero à esquerda

--update sc_cad.tbl_fnc set nr_idt_fnc = lpad(nr_idt_fnc, 6, '0' ) where cd_fnc = 100212 --teste 

--update sc_cad.tbl_fnc set nr_idt_fnc = cast(cast(nr_idt_fnc as int) as character varying) where cd_emp = 699 and cd_fem = 1 and nr_idt_fnc like '0%' and st_fnc = 1 -- tirar zeros a esqueda

--update sc_cad.tbl_fnc set nr_idt_fnc = cast(cast(nr_idt_fnc as int) as character varying) where cd_fnc = 100212 -- teste

select 
	cd_fnc, nr_idt_fnc 
from 
	sc_cad.tbl_fnc  
where 
	cd_emp = 699 
	and cd_fem = 1 
	and st_fnc = 1
