DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `WhileLoopProc`()
BEGIN
				Declare  var int;
               set var = 0;
               WHILE (var <> 3) DO
					 if (var = 0) then
					   SELECT contato,COUNT(*)  
						FROM cliente        
						GROUP BY contato; 
	 				 elseif (var = 1) then
					   SELECT Descricao_Produto,COUNT(*)  
						FROM produto        
						GROUP BY Descricao_Produto; 
					elseif (var = 2) then
					SELECT Descricao_Produto,COUNT(*)  
						FROM produto        
						GROUP BY Descricao_Produto;
					else select var;
					end if;
					set var = var + 1;
                  END WHILE;
               
       END$$

DELIMITER ;