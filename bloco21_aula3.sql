Stored Routines & Stored Functions

As STORED PROCEDURES e STORED FUNCTIONS podem te ajudar a seguir um conceito de programação chamado DRY , que preza pela redução de código repetido, quando possível.

Dica sobre como nomear suas procedures e functions
Para tornar a leitura do seu código mais fácil e sua manutenção mais simples, siga o seguinte padrão ao nomear suas procedures e functions:

-- Verbo + Resultado

ObterTotalDeVendas
ExibirRankMaximo
ObterClienteMaisAtivo
CalcularNivelEngajamento
MontarNomeCompleto

antes de tudo, e importante aprender os tipos de dados:
https://www.mysqltutorial.org/mysql-data-types.aspx

***********************************************Stored Procedures
Estrutura padrão de uma stored procedure

USE banco_de_dados; -- obrigatório para criar a procedure no banco correto
DELIMITER $$ -- definindo delimitador

CREATE PROCEDURE nome_da_procedure(@parametro1, @parametro2, ..., @parametroN) -- parâmetros
BEGIN -- delimitando o início do código SQL

END $$ -- delimitando o final do código SQL

DELIMITER ; -- muda o delimitador de volta para ; - o espaço entre DELIMITER e o ';' é necessário


********************************************CRIANDO Stored Procedures

Vamos criar nossas primeiras stored procedures . Temos os seguintes tipos:
Procedure sem parâmetros;

*************
exemplo Stored Procedures sem passagem de parâmetros
*************
USE sakila;
DELIMITER $$

CREATE PROCEDURE ShowAllActors()
BEGIN
    SELECT * FROM sakila.actor;
END $$

DELIMITER ;

-- Como usar:

CALL ShowAllActors();

Procedure com parâmetros de entrada (IN) ;
*************
exemplo Stored Procedures com passagem de parâmetros
*************

NOTA: Procedure com parâmetros de entrada (IN):
Para criar procedures com funcionalidades mais elaboradas, podemos passar parâmetros de entrada. Ao definir um parâmetro do tipo IN , podemos usá-lo e modificá-lo dentro da nossa procedure.

USE sakila;

DELIMITER $$
CREATE PROCEDURE RecebeSibalaEVerificarNomesDosAtores (IN silaba CHAR(10))
BEGIN
    SELECT * FROM actor WHERE first_name  LIKE CONCAT('%', silaba, '%');
END $$
DELIMITER;

-- Como usar:

CALL RecebeSibalaEVerificarNomesDosAtores('ITOR');




Procedure com parâmetros de saída (OUT) ;
*************
exemplo Stored Procedures parâmetros de saída
*************
nota: O parâmetro OUT é útil quando você precisa que algo seja avaliado ou encontrado dentro de uma query e te retorne esse valor para que algo adicional possa ser feito com ele.

Exemplo: Estamos recebendo aqui o título de um filme como valor de entrada e depois buscando dentro da procedure a duração média de um empréstimo daquele filme. Feito isso, ele é inserido em uma variável que pode ser usada posteriormente.

USE sakila;
DELIMITER $$

CREATE PROCEDURE ShowAverageRentalDurationOfMovie(
    IN film_name VARCHAR(300),
    OUT media_aluguel_em_dias DOUBLE
)
BEGIN
    SELECT AVG(rental_duration) INTO media_aluguel_em_dias
    FROM sakila.film
    WHERE title = film_name;
END $$

DELIMITER ;

-- Como usar:

CALL ShowAverageRentalDurationOfMovie('ACADEMY DINOSAUR', @media_de_dias);
SELECT @media_de_dias;


Procedure com parâmetros de entrada e saída (IN-OUT) .

*************
exemplo Stored Procedures com parâmetros de entrada e saída (IN-OUT)
*************

nota: O IN-OUT deve ser usado quando é necessário que um parâmetro possa ser modificado tanto antes como durante a execução de uma procedure.

Exemplo: Estamos gerando um novo nome para um filme, usando como base a variável film_name , que deve ser criada e passada como parâmetro para a procedure. O parâmetro sofrerá alterações dentro da procedure, podendo ser usado posteriormente com o novo nome.

USE sakila;
DELIMITER $$

CREATE PROCEDURE NameGenerator(INOUT film_name VARCHAR(300))
BEGIN
    SELECT CONCAT('ULTRA ', film_name, ' THE BEST MOVIE OF THE CENTURY')
    INTO film_name;
END $$

DELIMITER ;

-- Como usar:

SELECT 'ACE GOLDFINGER' INTO @movie_title;
CALL NameGenerator(@movie_title);
SELECT @movie_title;


Desafios stored procedure

Para todos os desafios abaixo, certifique-se de que a função possa ser chamada e o resultado dela seja usado corretamente. Utilize o banco de dados sakila.

1-Monte uma procedure que exiba os 10 atores mais populares, baseado em sua quantidade de filmes. Essa procedure não deve receber parâmetros de entrada ou saída e, quando chamada, deve exibir o id do ator ou atriz e a quantidade de filmes em que atuaram.
USE sakila;
DELIMITER $$

CREATE PROCEDURE AtoresMaisPopulares()
BEGIN
    SELECT actor_id, count(film_id) AS quantity
    FROM film_actor
    GROUP BY actor_id
    ORDER BY quantity DESC
    LIMIT 10;
END $$

DELIMITER ;


exercício Adicional
1-Monte uma procedure que exiba os 10 atores menos populares, baseado em sua quantidade de filmes. Essa procedure não deve receber parâmetros de entrada ou saída e, quando chamada, deve exibir o id do ator, nome do ator ou atriz, quantidade de filmes e os ids dos filmes em que atuaram.

USE sakila;
DELIMITER $$

CREATE PROCEDURE AtoresMenosPopularesEIdsDosFilmes()
BEGIN
    SELECT 
      f.actor_id,
      a.first_name,
      COUNT(f.film_id) AS  quantity,
      GROUP_CONCAT(f.film_id, ' ') AS film_ids
    FROM film_actor as f
    JOIN actor as a
    ON a.actor_id = f.actor_id
    GROUP BY a.actor_id
    ORDER BY quantity ASC
    LIMIT 10;
END $$

DELIMITER ;

-- Como usar:
CALL AtoresMenosPopularesEIdsDosFilmes();


2-Monte uma procedure que receba como parâmetro de entrada o nome da categoria desejada em uma string e que exiba o id do filme , seu titulo , o id de sua categoria e o nome da categoria selecionada. Use as tabelas film , film_category e category para montar essa procedure.
USE sakila;
DELIMITER $$

CREATE PROCEDURE EntreComCategoriaExibaDetalhes(
    IN name VARCHAR(50))
BEGIN
    SELECT f.film_id, fc.category_id, c.name
    FROM film AS f
    JOIN film_category AS fc
    ON fc.film_id = f.film_id
    JOIN category AS c
    ON fc.category_id = c.category_id
    WHERE c.name = name;
END $$

DELIMITER ;

-- Como usar:
CALL EntreComCategoriaExibaDetalhes('Travel');

3-Monte uma procedure que receba o email de um cliente como parâmetro de entrada e diga se o cliente está ou não ativo, através de um parâmetro de saída.

USE sakila;
DELIMITER $$

CREATE PROCEDURE validateCustomer (
    IN inputemail VARCHAR(30),
    OUT waiting BOOLEAN)
BEGIN
    SELECT active
    FROM customer
    where email = inputemail
    INTO waiting;
END $$
DELIMITER ;

-- Como usar:

CALL validateCustomer('ACADEMY DINOSAUR',@STATUS);
SELECT @STATUS;


*************
Stored Procedures com passagem de parâmetros IN, INOUT e OUT
exemplo: Crie uma procedure, que receba numero, representando o mês e retorne informação se estamos no mês de carnaval.
*************
DELIMITER $$
CREATE PROCEDURE proc_estamosNoCarnaval (
    IN ano INTEGER,
    INOUT mes INTEGER,
    OUT estamosNoCarnaval VARCHAR(100))
BEGIN
    DECLARE mensagem VARCHAR(100);
    IF mes IS NULL THEN 
      SET mes = MONTH(NOW());
    END IF;
    IF mes = 2 THEN 
      SET mensagem = 'Estamos no carnaval';
    ELSE
      SET mensagem = 'Não estamos no carnaval';
    END IF;
    SELECT mensagem INTO estamosNoCarnaval;
END $$
DELIMITER ;

CALL proc_estamosNoCarnaval(2021,@mes,@status);
SELECT @mes, @status


//////////////////////////////////////////////////////////////////Stored Functions

Na área de programação, temos uma boa prática chamada DRY (Don't Repeat Yourself) que, em resumo, sugere que você não se repita ou reescreva o mesmo código várias vezes.
Nesse ponto, temos uma das principais ferramentas para combater esse problema no SQL: as stored functions .

Através delas, podemos encapsular nossas queries usadas mais frequentemente dentro de um bloco de código nomeado e parametrizável.

Sua primeira stored function

Stored functions podem ser executadas com o comando SELECT . Ao criá-las, temos que definir o tipo de retorno que sua função possui.
Tipos de retorno comuns:

DETERMINISTIC - Sempre retorna o mesmo valor ao receber os mesmos dados de entrada;
NOT DETERMINISTIC - Não retorna o mesmo valor ao receber os mesmos dados de entrada;
READS SQL DATA - Indica para o MySQL que sua função somente lerá dados.

Em muitas situações, sua function estará apenas lendo e retornando dados. Nesses casos, a opção READS SQL DATA deve ser usada. No entanto, sempre avalie o tipo mais adequado à sua função.

****************************************
Estrutura padrão de uma stored function
****************************************

USE banco_de_dados; -- obrigatório para criar a função no banco correto
DELIMITER $$

CREATE FUNCTION nome_da_function(parametro1, parametro2, ..., parametroN)
RETURNS tipo_de_dado tipo_de_retorno
BEGIN
    DECLARE name type
    query_sql
    RETURN name
END $$

DELIMITER ;


***********************
EX: FUNCTION
Exemplo: Uma stored function que exibe a quantidade de filmes em que um determinado ator ou atriz atuou:
***********************
USE sakila;
DELIMITER $$

CREATE FUNCTION MoviesWithActor(actor_id int)
RETURNS INT READS SQL DATA
BEGIN
    DECLARE movie_total INT;
    SELECT COUNT(*)
    FROM sakila.film_actor
    WHERE sakila.film_actor.actor_id = actor_id INTO movie_total;
    RETURN movie_total;
END $$

DELIMITER ;

-- Como usar:

SELECT MoviesWithActor(1);

***********************
EX2: FUNCTION
Exemplo: ma stored function que exibe o nome completo de um ator ou de uma atriz, dado seu id como parâmetro:
**********************

USE sakila;
DELIMITER $$

CREATE FUNCTION GetFullName(id INT)
RETURNS VARCHAR(200) READS SQL DATA
BEGIN
    DECLARE full_name VARCHAR(200);
    SELECT concat(first_name, ' ', last_name)
    FROM sakila.actor
    WHERE actor_id = id
    LIMIT 1
    INTO full_name ;
    RETURN full_name;
END $$

DELIMITER ;

SELECT GetFullName(51);

***********************
EX3: FUNCTION
Exemplo: Exibir a quantidade de films atuados por um ator/atriz. 
**********************

USE sakila;

DELIMITER $$

CREATE FUNCTION ObterQuantidadeDeFilmesPorAtor(idAtor INT)
RETURNS INT READS SQL DATA
BEGIN
    DECLARE totalDeVendas INT;
    SELECT COUNT(*)
    FROM film_actor
    WHERE actor_id = idAtor
    LIMIT 1
    INTO totalDeVendas;
    RETURN totalDeVendas;
END $$
DELIMITER ;

SELECT ObterQuantidadeDeFilmesPorAtor(10);


**********************
EX4: FUNCTION
Exemplo:  Calcular a soma total de alugueis por filme.
**********************

USE sakila;

DELIMITER $$
CREATE FUNCTION SomarTotalAluguelPorFilmeAndStore(
    id_film INTEGER,
    IdStore INTEGER)
RETURNS INT READS SQL DATA
BEGIN
  DECLARE total INT;
  SELECT SUM(p.amount)
  FROM payment as p
  jOIN customer as c
  ON p.customer_id = c.customer_id
  JOIN store as s
  ON c.store_id = s.store_id
  JOIN inventory as i
  ON s.store_id = i.store_id
  JOIN film as f
  ON i.film_id = f.film_id
  WHERE f.film_id = id_film AND s.store_id = IdStore
  INTO total;
  RETURN total;
END $$
DELIMITER ;

SELECT SomarTotalAluguelPorFilmeAndStore(10,1);

payment        x customer  x    store       x    inventory        X      film
                                                   film_id              film_id                                           
                                                 
customer_id      customer_id                 

                 store_id       store_id          store_id
staff_id                                    

rental_id                                   

amount

payment_date



Agora você vai desenvolver algumas functions

1 - Utilizando a tabela sakila.payment , monte uma function que retorna a quantidade total de pagamentos feitos até o momento por um determinado customer_id .

USE sakila;

DELIMITER $$
CREATE FUNCTION totaldePagamentosporCustomerID(customerID INT)
RETURNS INT READS SQL DATA
BEGIN
    DECLARE numerodepagamentos INT;
    SELECT COUNT(*) AS pagamentos
    FROM payment as p
    JOIN customer as c
    ON p.customer_id = c.customer_id
    WHERE c.customer_id = customerID
    INTO numerodepagamentos;
    RETURN numerodepagamentos;
END $$
DELIMITER ;

SELECT totaldePagamentosporCustomerID(100);

2 - Crie uma function que, dado o parâmetro de entrada inventory_id , retorna o nome do filme vinculado ao registro de inventário com esse id.
USE sakila;

DELIMITER $$
CREATE FUNCTION RetorneNomeFilmeVinculadoInventario(inventory_id INT)
RETURNS INT READS SQL DATA
BEGIN
    DECLARE nomeDoFilme VARCHAR(200);
    SELECT f.title
    FROM film as f
    JOIN inventory as i
    ON i.film_id = f.film_id
    WHERE i.inventory_id = inventory_id
    INTO nomeDoFilme;
    RETURN nomeDoFilme;
END $$
DELIMITER ;

SELECT RetorneNomeFilmeVinculadoInventario(100);

3 - Crie uma function que receba uma determinada categoria de filme em formato de texto (ex: 'Action' , 'Horror' ) e retorna a quantidade total de filmes registrados nessa categoria.

USE sakila;

DELIMITER $$
CREATE FUNCTION TotalFimesCategoria(category VARCHAR(150))
RETURNS INTEGER READS SQL DATA
BEGIN
    DECLARE movie_total INT;
    SELECT COUNT(fc.film_id) AS quantity
    FROM film_category as fc
    JOIN category as c
    ON c.category_id = fc.category_id
    WHERE c.name = category
    INTO movie_total;
    RETURN movie_total;
END $$
DELIMITER ;

SELECT TotalFimesCategoria('Games');

film_category    x    category
                        name
film_id              
category_id           category_id


https://app.betrybe.com/course/back-end/sql/procedures_and_subqueries/conteudos/stored-functions-vs-store-procedures?use_case=next_button

**************************TRIGGERS************************
O que são triggers?

Triggers são blocos de código SQL que são disparados em reação a alguma atividade que ocorre no banco de dados. Eles podem ser disparados em dois momentos distintos, e é possível definir condições para esse disparo.

Momentos em que um trigger pode ser disparado

BEFORE : antes que alguma ação seja executada;
AFTER : após alguma ação já ter sido executada.
O que pode ativar um Trigger?
  INSERT ;
  UPDATE ;
  DELETE .

O que pode ser acessado dentro de um trigger?
O valor OLD de uma coluna: valor presente em uma coluna antes de uma operação;
O valor NEW de uma coluna: valor presente em uma coluna após uma operação.

Em quais operações os valores OLD e NEW estão disponíveis?
Operação	OLD	NEW
    INSERT	Não	Sim
    UPDATE	Sim	Sim
    DELETE	Sim	Não

Sintaxe

DELIMITER $$

CREATE TRIGGER nome_do_trigger
[BEFORE | AFTER] [INSERT | UPDATE | DELETE] ON tabela
FOR EACH ROW
BEGIN
    -- o código SQL entra aqui
END;

DELIMITER $$ ;

Exemplos das três operações
Para os próximos exemplos, considere as seguintes tabelas e banco de dados:

CREATE DATABASE IF NOT EXISTS rede_social;

USE rede_social;

CREATE TABLE perfil(
    perfil_id INT PRIMARY KEY auto_increment,
    saldo DECIMAL(10, 2) NOT NULL DEFAULT 0,
    ultima_atualizacao DATETIME,
    acao VARCHAR(50),
    ativo BOOLEAN DEFAULT 1
) engine = InnoDB;

CREATE TABLE log_perfil(
    acao_id INT PRIMARY KEY AUTO_INCREMENT,
    acao VARCHAR(300),
    data_acao DATE
) engine = InnoDB;

*******************************trigger para o INSERT
Exemplo de trigger para o INSERT :

Considerando a tabela perfil , hora de montar um Trigger que define a data de inserção e o tipo de operação, quando um novo registro é inserido.

******************
Ex: triiger insert
******************

USE rede_social;

DELIMITER $$
CREATE TRIGGER trigger_perfil_insert
    BEFORE INSERT ON perfil
    FOR EACH ROW
BEGIN
    SET NEW.ultima_atualizacao = NOW(),
        NEW.acao = 'INSERT';
END; $$
DELIMITER ;

No `trigger` acima, o valor da coluna `ultima_atualizacao` está sendo definido para a data atual com o comando `NOW()` e, na sequência, definindo o valor da coluna `acao` para "INSERT". A palavra-chave `NEW` é utilizada para acessar e modificar as propriedades da tabela.

Para ver o resultado do uso do `Trigger` na prática, execute o exemplo abaixo:

INSERT INTO perfil(saldo) VALUES (2500);

SELECT * FROM perfil;
   
Colunas `ultima_atualizacao` e `acao` preenchidas dinamicamente pelo `Trigger`

*******************************trigger para o UPDATE

******************
Exemplo de trigger para o UPDATE :
******************

Considerando a tabela perfil , hora de montar um Trigger que define a data de atualização e o tipo de operação, quando algum registro for modificado.

USE rede_social;

DELIMITER $$
CREATE TRIGGER trigger_perfil_update
    BEFORE UPDATE ON perfil
    FOR EACH ROW
BEGIN
    SET NEW.ultima_atualizacao = NOW(),
        NEW.acao = 'UPDATE';
END; $$
DELIMITER ;

No `Trigger` acima, o valor da coluna `ultima_atualizacao` está sendo atualizado para a data atual com o comando `NOW()` e, na sequência, definindo o valor da coluna `acao` para "UPDATE". Novamente, a palavra-chave `NEW` é utilizada para acessar e modificar as propriedades da tabela.

Para ver o resultado do uso do `Trigger` na prática, execute o exemplo abaixo:

UPDATE perfil
SET saldo = 3000
WHERE perfil_id = 1;

SELECT * FROM perfil;


*******************************trigger para o DELETE
******************
Exemplo de trigger para o DELETE :
******************

Considerando a tabela log_perfil , hora de criar um trigger que envia informações para essa tabela quando um registro da tabela perfil é excluído.

USE rede_social;

DELIMITER $$
CREATE TRIGGER trigger_perfil_delete
    AFTER DELETE ON perfil
    FOR EACH ROW
BEGIN
    INSERT INTO log_perfil(acao, data_acao)
    VALUES ('exclusão', NOW());
END; $$
DELIMITER ;

O trigger acima envia informações para a tabela `log_perfil`, dizendo qual foi o tipo da operação e o horário do ocorrido.

Pode-se confirmar o seu funcionamento excluindo um registro do banco de dados e depois fazendo uma pesquisa na tabela `log_perfil`. Veja o exemplo abaixo:

DELETE FROM perfil WHERE perfil_id = 1;

SELECT * FROM log_perfil;

*************************************
Exercícios de fixação com TRIGGERS
*************************************

t's Trigger Time
Alright, people! Hora de montar uns triggers.
Considerando as tabelas e os banco de dados abaixo:


CREATE DATABASE IF NOT EXISTS betrybe_automoveis;

USE betrybe_automoveis;

CREATE TABLE carros(
    id_carro INT PRIMARY KEY auto_increment,
    preco DECIMAL(12, 2) NOT NULL DEFAULT 0,
    data_atualizacao DATETIME,
    acao VARCHAR(15),
    disponivel_em_estoque BOOLEAN DEFAULT 0
) engine = InnoDB;

CREATE TABLE log_operacoes(
    operacao_id INT AUTO_INCREMENT PRIMARY KEY,
    tipo_operacao VARCHAR(15) NOT NULL,
    data_ocorrido DATE NOT NULL
) engine = InnoDB;


1 - Crie um TRIGGER que, a cada nova inserção feita na tabela carros , defina o valor da coluna data_atualizacao para o momento do ocorrido, a acao para 'INSERÇÃO' e a coluna disponivel_em_estoque para 1 .

USE betrybe_automoveis;

DELIMITER $$
CREATE TRIGGER tr_carros_insert
  BEFORE INSERT ON carros
  FOR EACH ROW
BEGIN
  SET NEW.data_atualizacao = NOW();
  SET NEW.acao = 'INSERÇÃO';
END $$
DELIMITER ;

INSERT INTO carros(preco, disponivel_em_estoque)
VALUES (100.000, 1);

SELECT * FROM carros;


2 - Crie um TRIGGER que, a cada atualização feita na tabela carros , defina o valor da coluna data_atualizacao para o momento do ocorrido e a acao para 'ATUALIZAÇÃO' .

USE betrybe_automoveis;

DELIMITER $$
CREATE TRIGGER tr_carros_update
  AFTER UPDATE ON carros
  FOR EACH ROW
BEGIN
  SET NEW.data_atualizacao = NOW();
  SET NEW.acao = 'ATUALIZAÇÃO';
END $$
DELIMITER ;

SELECT * FROM carros;
-- id_carro = 2

UPDATE carros
SET preco = 200.000
WHERE id_carro = 2;

SELECT * FROM carros; --atualizou o campo data_atualizacao

3 - Crie um TRIGGER que, a cada exclusão feita na tabela carros , envie para a tabela log_operacoes as informações do tipo_operacao como 'EXCLUSÃO' e a data_ocorrido como o momento da operação.
USE betrybe_automoveis;

DELIMITER $$
CREATE TRIGGER tr_carros_delete
 AFTER DELETE ON carros
 FOR EACH ROW
BEGIN
  INSERT INTO log_operacoes(tipo_operacao, data_ocorrido)
  VALUES (OLD.acao, OLD.data_atualizacao);
END $$
DELIMITER ;

SELECT * FROM carros;
--id_carro = 3

SELECT * FROM log_operacoes;
--tabela vazia

DELETE FROM carros WHERE id_carro  = 3;

SELECT * FROM log_operacoes;
--ocorreu insert com os registros do id_carro = 3 (tabela carros)

////////////////DESAFIO TRIGGERS

CREATE DATABASE IF NOT EXISTS BeeMovies;

USE BeeMovies;

CREATE TABLE movies(
    movie_id INT PRIMARY KEY auto_increment,
    ticket_price DECIMAL(12, 2) NOT NULL DEFAULT 0,
    ticket_price_estimation VARCHAR(15),
    release_year YEAR
) engine = InnoDB;

CREATE TABLE movies_logs(
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    movie_id INT NOT NULL,
    action VARCHAR(15) NOT NULL,
    log_date DATE NOT NULL
) engine = InnoDB;


1-Crie um Trigger para INSERT que deve definir o valor do campo release_year da tabela movies como o ano atual de forma dinâmica, sem haver a necessidade de digitar manualmente o valor do ano. Além disso, crie um outro Trigger para INSERT que adiciona um novo registro na tabela movies_logs , informando o movie_id do filme que acaba de ser inserido na tabela movies , a action como 'INSERT' e a log_date como a data atual.

USE BeeMovies;

DELIMITER $$
CREATE TRIGGER tr_movies_release_year_insert
  BEFORE INSERT ON movies
  FOR EACH ROW
BEGIN
  SET NEW.release_year = DATE(NOW());
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER tr_informeOFilmeinseridoEmMovies_insert
  AFTER INSERT ON movies
  FOR EACH ROW
BEGIN
  INSERT INTO movies_logs(movie_id, action, log_date)
  VALUES (NEW.movie_id, 'INSERT', DATE(NOW()));
END $$
DELIMITER ;

INSERT INTO movies(ticket_price, ticket_price_estimation) VALUES (59.99, 'AMAZING');
Query OK, 1 row affected (0.01 sec)


INSERT INTO movies(ticket_price, ticket_price_estimation) VALUES (59.99, 'CRAZY');
Query OK, 1 row affected (0.01 sec)

mysql> SELECT * FROM movies;
+----------+--------------+-------------------------+--------------+
| movie_id | ticket_price | ticket_price_estimation | release_year |
+----------+--------------+-------------------------+--------------+
|        1 |        59.99 | AMAZING                 |         2021 |
|        2 |        59.99 | CRAZY                   |         2021 |
+----------+--------------+-------------------------+--------------+
2 rows in set (0.00 sec)

mysql> SELECT * FROM movies_logs;
+--------+----------+--------+------------+
| log_id | movie_id | action | log_date   |
+--------+----------+--------+------------+
|      1 |        1 | INSERT | 2021-02-27 |
|      2 |        2 | INSERT | 2021-02-27 |
+--------+----------+--------+------------+
2 rows in set (0.00 sec)


2-Crie um Trigger para UPDATE que, ao receber uma alteração na tabela movies , deve comparar o valor anterior de ticket_price com o valor sendo inserido nesta atualização. Caso o valor seja maior que o anterior, insira na coluna ticket_price_estimation o valor de 'Increasing' . Caso contrário, insira o valor 'Decreasing' . Adicionalmente, insira um novo registro na tabela movies_logs , contendo informações sobre o registro alterado ( movie_id , action e log_date ).

USE BeeMovies;

DELIMITER $$
CREATE TRIGGER trigger_movie_update
    BEFORE UPDATE ON movies
    FOR EACH ROW
BEGIN
    SET NEW.ticket_price_estimation = IF(NEW.ticket_price > OLD.ticket_price, 'Increasing', 'Decreasing');
    INSERT INTO movies_logs(movie_id, action, log_date)
    VALUES(NEW.movie_id, 'UPDATE', NOW());
END; $$
DELIMITER ;

SELECT * FROM movies;
+----------+--------------+-------------------------+--------------+
| movie_id | ticket_price | ticket_price_estimation | release_year |
+----------+--------------+-------------------------+--------------+
|        1 |        59.99 | AMAZING                 |         2021 |
|        2 |        59.99 | CRAZY                   |         2021 |
+----------+--------------+-------------------------+--------------

SELECT * FROM movies_logs;
+--------+----------+--------+------------+
| log_id | movie_id | action | log_date   |
+--------+----------+--------+------------+
|      1 |        1 | INSERT | 2021-02-27 |
|      2 |        2 | INSERT | 2021-02-27 |
+--------+----------+--------+------------+
2 rows in set (0.00 sec)


UPDATE movies
SET ticket_price = 100.00
WHERE movie_id =  1;

SELECT * FROM movies; -- o registro foi atualizado
+----------+--------------+-------------------------+--------------+
| movie_id | ticket_price | ticket_price_estimation | release_year |
+----------+--------------+-------------------------+--------------+
|        1 |       100.00 | Increasing              |         2021 |
|        2 |        59.99 | CRAZY                   |         2021 |
+----------+--------------+-------------------------+--------------+
2 rows in set (0.00 sec)

SELECT * FROM movies_logs;

mysql> SELECT * FROM movies_logs;

-- inseriu o registro com a action UPDATE
+--------+----------+--------+------------+
| log_id | movie_id | action | log_date   |
+--------+----------+--------+------------+
|      1 |        1 | INSERT | 2021-02-27 |
|      2 |        2 | INSERT | 2021-02-27 |
|      3 |        1 | UPDATE | 2021-02-27 |
+--------+----------+--------+------------+
3 rows in set (0.00 sec)


3-Crie um Trigger na tabela movies que, ao ter algum de seus registros excluídos, deve enviar uma informação para a tabela movies_logs , onde devem ser guardados a data da exclusão, a action 'DELETE' e o id do filme excluído.

USE BeeMovies;

DELIMITER $$
CREATE TRIGGER tr_EnviarRegistrosExcluidos_delete
  AFTER DELETE ON movies
  FOR EACH ROW
BEGIN
  INSERT INTO movies_logs(movie_id, action, log_date)
  VALUES (OLD.movie_id, 'DELETE', OLD.release_year);
END $$
DELIMITER ;

SELECT * FROM movies;
+----------+--------------+-------------------------+--------------+
| movie_id | ticket_price | ticket_price_estimation | release_year |
+----------+--------------+-------------------------+--------------+
|        1 |       100.00 | Increasing              |         2021 |
|        2 |        59.99 | CRAZY                   |         2021 |
+----------+--------------+-------------------------+--------------+

SELECT * FROM movies_logs;
+--------+----------+--------+------------+
| log_id | movie_id | action | log_date   |
+--------+----------+--------+------------+
|      1 |        1 | INSERT | 2021-02-27 |
|      2 |        2 | INSERT | 2021-02-27 |
|      3 |        1 | UPDATE | 2021-02-27 |
+--------+----------+--------+------------+

DELETE FROM movies WHERE movie_id = 2;
DELETE FROM movies_logs;
alter table movies modify column release_year date;

