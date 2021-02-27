**********************
-- sintaxe IF
**********************
IF condição THEN lista_declarações
  ELSEIF condição THEN lista_declarações
  ...
ELSE
  lista_declarações
END IF;

**********************
-- sintaxe IF (TERNÁRIO)
**********************

SET @TERNARIO = IF (5 > 2, 'TRUE', 'FALSE');
Query OK, 0 rows affected (0.00 sec)

mysql> SELECT @TERNARIO;
+-----------+
| @TERNARIO |
+-----------+
| TRUE      |
+-----------+
1 row in set (0.00 sec)

***********************************************************************
exemplo IF
--Exemplo de bloco IF;
*************************************************************************
DELIMITER $$
CREATE FUNCTION fn_calcular_imposto(salario DEC(8,2))
RETURNS DEC(8,2) 
BEGIN
  DECLARE valor_imposto DEC(8,2);
  IF (salario < 1000.oo) THEN
    SET valor_imposto = 0.00;
  ELSEIF salario < 2000.00 THEN
    SET valor_imposto = salario * 0,15;
  ELSEIF salario < 3000.00 THEN
    SET valor_imposto = salario * 0,22;
  ELSE
    SET valor_imposto = salario * 0,27;
  END IF
  RETURN valor_imposto;
END $$
DELIMITER ;

SELECT fn_calcular_imposto(850.00);

**********************
-- sintaxe CASE
**********************

CASE valor_referência
  WHEN valor_comparado THEN lista_declarações
  WHEN valor_comparado THEN lista_declarações
  WHEN valor_comparado THEN lista_declarações
ELSE
  lista_declarações
END CASE;

***********************************************************************
exemplo IF
--Exemplo de bloco CASE
*************************************************************************
DELIMITER $$
CREATE FUNCTION case_calcular_imposto(salario DEC(8,2))
RETURNS DEC(8,2)
BEGIN
  DECLARE valor_imposto DEC(8,2);
  CASE
    WHEN salario < 1000.00 THEN SET valor_imposto = 0.00;
    WHEN salario < 2000.00 THEN SET valor_imposto = salario * 0.15;
    WHEN salario < 3000.00 THEN SET valor_imposto = salario * 0.22;
   ELSE 
     SET valor_imposto = salario * 0.27;
   END CASE;
   RETURN valor_imposto;
END $$
DELIIMITER ;