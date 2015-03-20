DELIMITER $$
 
CREATE PROCEDURE produto(
        in  p_id_Produto int(11), 
        out p_Descricao  varchar(50))
BEGIN
    DECLARE into_var varchar(45);
 
    SELECT Descricao_Produto INTO into_var
    FROM produto
    WHERE id_Produto = p_id_Produto;
 
    CASE into_var
        WHEN  'Pneu novo' THEN
           SET p_Descricao = 'Produto 1';
        WHEN 'Filtro de Oleo' THEN
           SET p_Descricao = 'Produto 2';
		WHEN 'Pastilhas freio' THEN
           SET p_Descricao = 'Produto 3';
		WHEN 'Filtro de ar' THEN
           SET p_Descricao = 'Produto 4';
        ELSE
           SET p_Descricao = 'Não está na base de dados';
    END CASE;
 
END$$

DELIMITER ;