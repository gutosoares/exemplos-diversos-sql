-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `checando`(
    in pNome_cliente varchar(30),
	in pNome_cliente2 varchar(30),
    out resultado int)
begin 

    if exists (select * from cliente where Nome_cliente = pNome_cliente and Nome_cliente = pNome_cliente2) then
        set resultado = 0;
        elseif exists (select * from cliente where Nome_cliente = pNome_cliente or Nome_cliente = pNome_cliente2) then
        set resultado = -1;
		else
		set resultado = -2;
    end if;
end$$

DELIMITER ;