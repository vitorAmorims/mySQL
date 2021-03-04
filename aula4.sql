Bloco 20 - aula 4

/////////////////////////////////////////drop databases nomeDB;

restaurar Schema

//////////////////////////////////////////insert

sintaxe:

INSERT INTO nome_da_tabela (coluna1, coluna2)
VALUES ('valor_coluna1', 'valor_coluna2');

ou 

INSERT INTO nome_da_tabela (coluna1, coluna2) VALUES
('valor_1','valor_2'),
('valor_3','valor_4'),
('valor_5','valor_6');

//////////////////////////////////////////insert ignore
INSERT IGNORE INTO pessoas (id, name) VALUES
(4,'Gloria'), -- Sem o IGNORE, essa linha geraria um erro e o INSERT não continuaria.
(5,'Amanda');

-- Pesquisando agora, você verá que a informação duplicada não foi inserida.
-- Porém os dados corretos foram inseridos com sucesso.
SELECT * FROM pessoas;

////////////////////////////////////////insert select 
INSERT INTO tabelaA (coluna1, coluna2)
    SELECT tabelaB.coluna1, tabelaB.coluna2
    FROM tabelaB
    WHERE tabelaB.nome_da_coluna <> 'algumValor'
    ORDER BY tabelaB.coluna_de_ordenacao;
    
INSERT INTO sakila.actor (first_name, last_name)
    SELECT first_name, last_name FROM sakila.staff;
    
 
exercícios com insert

Insira um novo funcionário na tabela sakila.staff .

insert into staff (first_name, last_name, address_id, email, store_id, active, username, password)
values ('Vitor','Amorim', 100, 'vtamorims@gmail.com', 1, 1, 'vtamorims', 2030);

Para saber quais campos são obrigatórios, clique com o botão direito na tabela sakila.staff e selecione "Table Inspector". Clique na aba "columns" e verifique quais campos aceitam nulos para te guiar. Lembre-se de que valores que são gerados automaticamente não precisam ser inseridos manualmente. Boa explorada!

describe staff;

Feito o exercício anterior, vamos agora para o nível 2. Insira dois funcionários novos em apenas uma query.

insert into staff (first_name, last_name, address_id, email, store_id, active, username, password)
values
('Silvia','Smarra', 2, 'silviasmarra@gmail.com', 1, 1, 'silviaS', 000),
('Neusa','Maria', 1, 'neusamaria@gmail.com', 2, 1, 'MamaeNeusa', 'cantogregoriano');

Selecione os cinco primeiros nomes e sobrenomes da tabela sakila.customer e cadastre essas pessoas como atores na tabela sakila.actor .

insert into actor(first_name, last_name) 
  select first_name, last_name from customer limit 5;

Cadastre três categorias de uma vez só na tabela sakila.category .

insert into category (name) values ('teste'), ('teste1'), ('teste2');
+-------------+-------------+---------------------+
| category_id | name        | last_update         |
+-------------+-------------+---------------------+
|           1 | Action      | 2006-02-15 04:46:27 |
|           2 | Animation   | 2006-02-15 04:46:27 |
|           3 | Children    | 2006-02-15 04:46:27 |
|           4 | Classics    | 2006-02-15 04:46:27 |
|           5 | Comedy      | 2006-02-15 04:46:27 |
|           6 | Documentary | 2006-02-15 04:46:27 |
|           7 | Drama       | 2006-02-15 04:46:27 |
|           8 | Family      | 2006-02-15 04:46:27 |
|           9 | Foreign     | 2006-02-15 04:46:27 |
|          10 | Games       | 2006-02-15 04:46:27 |
|          11 | Horror      | 2006-02-15 04:46:27 |
|          12 | Music       | 2006-02-15 04:46:27 |
|          13 | New         | 2006-02-15 04:46:27 |
|          14 | Sci-Fi      | 2006-02-15 04:46:27 |
|          15 | Sports      | 2006-02-15 04:46:27 |
|          16 | Travel      | 2006-02-15 04:46:27 |
|          17 | teste       | 2021-02-15 10:03:30 |
|          18 | teste1      | 2021-02-15 10:03:30 |
|          19 | teste2      | 2021-02-15 10:03:30 |
+-------------+-------------+---------------------+


Cadastre uma nova loja na tabela sakila.store .
insert into store (manager_staff_id, address_id) values (3,4);
mysql> select * from store;
+----------+------------------+------------+---------------------+
| store_id | manager_staff_id | address_id | last_update         |
+----------+------------------+------------+---------------------+
|        1 |                1 |          1 | 2006-02-15 04:57:12 |
|        2 |                2 |          2 | 2006-02-15 04:57:12 |
|        3 |                3 |          4 | 2021-02-15 10:05:39 |
+----------+------------------+------------+---------------------+


///////////////////////////////////////UPDATE
UPDATE sakila.staff
SET first_name = 'Rannveig'
WHERE first_name = 'Ravein';


/////////////////////////////////////////////////feature de segurança
O MySQL possui uma feature de segurança chamada "Safe Update", onde ele admoesta instruções SQL executadas sem a cláusula "WHERE". Por exemplo, ao executar este comando:

Exemplo: UPDATE Nome_Table SET Campo_X = 0;

O MySQL irá dizer:

“You are using safe update mode and you tried to update a table without a WHERE clause that uses a KEY column.”

para habilitar esta feature, use:
SET SQL_SAFE_UPDATES = 1;

Ou configurar para um modo mais conveniente para você, alterando os valores das variáveis:
SET sql_safe_updates=1, sql_select_limit=500, max_join_size=10000;


para desbilitar está feature, use:
SET SQL_SAFE_UPDATES=0;


///////////////////////////////////////////////update em massa


-- Opção 1 - Incluindo a lista de condições fixas
UPDATE sakila.actor
SET first_name = 'JOE'
WHERE actor_id IN (1,2,3);

-- Opção 2 - Especificando como cada entrada será alterada individualmente
UPDATE sakila.actor
SET first_name = (
CASE actor_id WHEN 1 THEN 'JOE' -- se actor_id = 1, alterar first_name para 'JOE'
              WHEN 2 THEN 'DAVIS' -- se actor_id = 2, alterar first_name para 'DAVIS'
              WHEN 3 THEN 'CAROLINE' -- se actor_id = 3, alterar first_name para 'CAROLINE'se
END);

mysql> select * from actor order by actor_id desc limit 3;
+----------+------------+-----------+---------------------+
| actor_id | first_name | last_name | last_update         |
+----------+------------+-----------+---------------------+
|      200 | THORA      | TEMPLE    | 2006-02-15 04:34:33 |
|      199 | JULIA      | FAWCETT   | 2006-02-15 04:34:33 |
|      198 | MARY       | KEITEL    | 2006-02-15 04:34:33 |
+----------+------------+-----------+---------------------+
3 rows in set (0.00 sec)


UPDATE sakila.actor
SET first_name = (
CASE 
WHEN actor_id = 200 THEN 'VITOR'
WHEN actor_id = 199 THEN 'LUCAS'
WHEN actor_id = 198 THEN 'SILVIA'
ELSE first_name
END
);

mysql> select * from actor order by actor_id desc limit 3;
+----------+------------+-----------+---------------------+
| actor_id | first_name | last_name | last_update         |
+----------+------------+-----------+---------------------+
|      200 | VITOR      | TEMPLE    | 2021-02-22 13:49:49 |
|      199 | LUCAS      | FAWCETT   | 2021-02-22 13:49:49 |
|      198 | SILVIA     | KEITEL    | 2021-02-22 13:49:49 |
+----------+------------+-----------+---------------------+
3 rows in set (0.00 sec)



////////////////////////////////////////////////////update de forma sequencial
UPDATE nome_da_tabela
SET coluna1 = valor1, coluna2 = valor2
[WHERE condições]
[ORDER BY expressao [ ASC | DESC ]]
[LIMIT quantidade_resultados];

-- Exemplo:
UPDATE sakila.staff
SET password = 'FavorResetarSuaSenha123'
WHERE active = 1
ORDER BY last_update
LIMIT 2;

///////////////////////////////////////////////////////MAIS EXERCÍCIOS
SET SQL_SAFE_UPDATES = 0;

1 - Atualize o primeiro nome de todas as pessoas da tabela sakila.actor que possuem o primeiro nome "JULIA" para "JULES".
primeira etapa - ver quantas linhas tem o primeiro nome JULIA
select count(*) from actor where first_name = 'JULIA'; 
4 linhas

segunda etapa - atualizar as linhas
update actor set first_name = 'JULES' where first_name = 'JULIA';

terceira etapa - confirmar alterações
select count(*) from actor where first_name = 'JULIA';
0 linhas

2 - Foi exigido que a categoria "Sci-Fi" seja alterada para "Science Fiction".

primeira etapa: ver se existem linhas que possuem a categoria  'Sci-Fi'.
select * from category where name 'Sci-Fi';

segunda etapa: se existirem, realizar atualizações.
update category set name = 'Science Fiction' where name = 'Sci-Fi';

2 - Atualize o valor do aluguel para $25 de todos os filmes com duração maior que 100 minutos e que possuem a classificações "G" , "PG" ou "PG-13" e um custo de substituição maior que $20.

schema sakila

primeira etapa: ver quantos titulos, o preço será atualizado.
select film_id from film  where length > 100 and rating ='G' OR rating = 'PG' or rating ='PG-13' and replacement_cost > 20;
exemplo id 996

segunda etapa: atualizando o campo
update payment
join rental
on payment.rental_id = rental.rental_id
join inventory
on rental.inventory_id = inventory.inventory_id
join film
on inventory.film_id = film.film_id
set payment.amount = 25
where film.length > 100 and film.rating ='G' OR film.rating = 'PG' or film.rating ='PG-13' and film.replacement_cost > 20;

3 - Foi determinado pelo setor financeiro que haverá um reajuste em todos os preços dos filmes, com base em sua duração. Para todos os filmes com duração entre 0 e 100, o valor do aluguel passará a ser $10,00, e o aluguel dos filmes com duração acima de 100 passará a ser de $20,00.

primeira etapa:
com este comando é possivel, ver todos os valores para coluna amount
select distinct amount from payment;
+--------+
| amount |
+--------+
|   2.99 |
|  25.00 |
|   0.99 |
|   4.99 |
|   3.99 |
|   5.99 |
|   6.99 |
|  10.99 |
|   1.99 |
|   8.99 |
|   7.99 |
|   9.99 |
|  11.99 |
|   3.98 |
|   0.00 |
|   9.98 |
|   8.97 |
|   1.98 |
|   7.98 |
|   5.98 |
+--------+


segunda etapa: para ver todos os minutos dos filmes.
select distinct length from film;
140 rows

terceira etapa: montar a query para atualização.
film.length < 100 preço 10
film.length >=100 preco 20

	update payment
	join rental
	on payment.rental_id = rental.rental_id
	join inventory
	on rental.inventory_id = inventory.inventory_id
	join film
	on inventory.film_id = film.film_id
	set payment.amount = 10
	where film.length < 100;
	
	
	update payment
	join rental
	on payment.rental_id = rental.rental_id
	join inventory
	on rental.inventory_id = inventory.inventory_id
	join film
	on inventory.film_id = film.film_id
	set payment.amount = 20
	where film.length >= 100;

///////////////////////////////////////////////////DELETE
sintaxe:
DELETE FROM banco_de_dados.tabela
WHERE coluna = 'valor';
-- O WHERE é opcional. Porém, sem ele, todas as linhas da tabela seriam excluídas.


select * from film_text where title = 'ACADEMY DINOSAUR';
+---------+------------------+--------------------------------------------------------------------------------------------------+
| film_id | title            | description                                                                                      |
+---------+------------------+--------------------------------------------------------------------------------------------------+
|       1 | ACADEMY DINOSAUR | A Epic Drama of a Feminist And a Mad Scientist who must Battle a Teacher in The Canadian Rockies |
+---------+------------------+--------------------------------------------------------------------------------------------------+
1 row in set (0.00 sec)

DELETE FROM sakila.film_text
WHERE title = 'ACADEMY DINOSAUR';

SET SQL_SAFE_UPDATES = 1 só funciona se o ID for incluido na ação de delete.


Meu DELETE não foi permitido...
Caso haja relações entre as tabelas ( primary key e foreign keys ) e existam restrições aplicadas a elas, ao executar o DELETE ocorrerá uma ação de acordo com a restrição que tiver sido imposta na criação da foreign key . Essas restrições podem ser as seguintes:

-- Rejeita o comando DELETE.
ON DELETE NO ACTION;

-- Rejeita o comando DELETE.
ON DELETE RESTRICT;

-- Permite a exclusão dos registros da tabela pai, e seta para NULL os registros da tabela filho.
ON DELETE SET NULL;

-- Exclui a informação da tabela pai e registros relacionados.
ON DELETE CASCADE;


O banco de dados não vai permitir que você delete o ator chamado "GRACE". Isso acontece porque a coluna actor_id da tabela film_actor é uma chave estrangeira ( foreign key ) que aponta para a coluna actor_id na tabela actor , e essa chave estrangeira possui a restrição ON DELETE RESTRICT . Se essa restrição não existisse, o ator seria deletado, deixando nosso banco de dados em um estado inconsistente, pois haveria linhas na tabela film_actor com um actor_id que não mais existiria!

select * from actor where first_name = 'GRACE';
+----------+------------+-----------+---------------------+
| actor_id | first_name | last_name | last_update         |
+----------+------------+-----------+---------------------+
|        7 | GRACE      | MOSTEL    | 2006-02-15 04:34:33 |
+----------+------------+-----------+---------------------+
1 row in set (0.00 sec)

Para conseguir excluir este ator em actors , precisamos primeiro excluir todas as referências a ele na tabela sakila.film_actor :

DELETE FROM sakila.film_actor
WHERE actor_id = 7; -- actor_id = 7 é o Id de GRACE

Após excluir as referências, podemos excluir o ator com o nome "GRACE":

DELETE FROM sakila.actor
WHERE first_name = 'GRACE';

///////////////////////////////////////////////////////////TRUNCATE
TRUNCATE banco_de_dados.tabela;

1- Exclua do banco de dados o ator com o nome de "KARL".

select * from actor where first_name = 'KARL';
+----------+------------+-----------+---------------------+
| actor_id | first_name | last_name | last_update         |
+----------+------------+-----------+---------------------+
|       12 | KARL       | BERRY     | 2006-02-15 04:34:33 |
+----------+------------+-----------+---------------------+
1 row in set (0.01 sec)

select * from film_actor where actor_id = 12;

delete from fim-actor where actor_id = 12; -- deletando referências FK

delete from actor where actor_id = 12; -- deletando PK

2 - Exclua do banco de dados os atores com o nome de "MATTHEW".

select * from actor where first_name = 'Matthew';
+----------+------------+-----------+---------------------+
| actor_id | first_name | last_name | last_update         |
+----------+------------+-----------+---------------------+
|        8 | MATTHEW    | JOHANSSON | 2006-02-15 04:34:33 |
|      103 | MATTHEW    | LEIGH     | 2006-02-15 04:34:33 |
|      181 | MATTHEW    | CARREY    | 2006-02-15 04:34:33 |
+----------+------------+-----------+---------------------+
3 rows in set (0.00 sec)

delete from film_actor where actor_id in (8,103,181);
delete from actor where actor_id in (8,103,181);

3 - Exclua da tabela film_text todos os registros que possuem a palavra "saga" em suas descrições.
select * from film_text where description like '%saga%';

SET SQL_SAFE_UPDATES = 0
delete from film_text where description like '%saga%';

4 - Apague da maneira mais performática possível todos os registros das tabelas film_actor e film_category.
truncate film_actor;
truncate film_category;

5 - Inspecione todas as tabelas do banco de dados sakila e analise quais restrições ON DELETE foram impostas em cada uma. Use o Table Inspector para fazer isso (aba DDL).

mostra tabelas em schema sakila

show full tables from sakila;
+----------------------------+------------+
| Tables_in_sakila           | Table_type |
+----------------------------+------------+
| actor                      | BASE TABLE |
| actor_info                 | VIEW       |
| address                    | BASE TABLE |city('city_id') ON DELETE RESTRICT
| category                   | BASE TABLE | 
| city                       | BASE TABLE |country('contry_id') ON DELETE RESTRICT
| country                    | BASE TABLE |
| customer                   | BASE TABLE |address('address_id') ON DELETE RESTRICT, store('store_id') ON DELETE RESTRICT
| customer_list              | VIEW       |
| film                       | BASE TABLE |language('language_id') ON DELETE RESTRICT
| film_actor                 | BASE TABLE |actor('actor_id') ON DELETE RESTRICT
| film_category              | BASE TABLE |category('category_id') ON DELETE RESTRICT, film('film_id') ON DELETE RESTRICT
| film_list                  | VIEW       |
| film_text                  | BASE TABLE |
| inventory                  | BASE TABLE |film('film_id') ON DELETE RESTRICT, store('store_id') ON DELETE RESTRICT
| language                   | BASE TABLE |
| nicer_but_slower_film_list | VIEW       |
| payment                    | BASE TABLE |customer('customer_id') ON DELETE RESTRICT, rental('rental_id') ON DELETE RESTRICT, staff('staff_id') ON DELETE RESTRICT
| rental                     | BASE TABLE |customer('customer_id') ON DELETE RESTRICT, invenntory('inventory_id') ON DELETE RESTRICT, staff('staff_id') ON DELETE RESTRICT
| sales_by_film_category     | VIEW       |
| sales_by_store             | VIEW       |
| staff                      | BASE TABLE |address('address_id') ON DELETE RESTRICT, store('store_id') ON DELETE RESTRICT
| staff_list                 | VIEW       |
| store                      | BASE TABLE |address('address_id') ON DELETE RESTRICT, staff('staff_id') ON DELETE RESTRICT
+----------------------------+------------+

mostra informações sobre a tabela
show columns from actor_info

Em primeiro lugar, descubra o FOREIGN KEY nome da sua restrição desta maneira:

SELECT
  TABLE_NAME,
  COLUMN_NAME,
  CONSTRAINT_NAME,   -- <<-- the one you want! 
  REFERENCED_TABLE_NAME,
  REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE
  REFERENCED_TABLE_NAME = 'My_Table';
E então você pode remover a restrição nomeada da seguinte maneira:show 

ALTER TABLE My_Table DROP FOREIGN KEY My_Table_Constraint;
Referências: 1 e 2 .

Conforme sugerido por @SteffenWinkler nos comentários, se houver mais de uma tabela com esse nome em esquemas / bancos de dados diferentes, você poderá adicionar um predicado adicional à sua cláusula where:

AND TABLE_SCHEMA = 'My_Database';

Exclua o banco de dados e o recrie (use as instruções no início desta aula).
drop database sakila;

MySQL Workbench/File/Open Sql script/sakila.sql executar CTRL + R



////////////////////////////////////exercicios
DROP SCHEMA IF EXISTS Pixar;
CREATE SCHEMA Pixar;
USE Pixar;

CREATE TABLE Movies (
  id INTEGER auto_increment PRIMARY KEY NOT NULL,
  title VARCHAR(30) NOT NULL,
  director VARCHAR(30) NULL,
  year INT NOT NULL,
  length_minutes INT NOT NULL
);

CREATE TABLE BoxOffice (
  movie_id INTEGER,
  FOREIGN KEY (movie_id) REFERENCES Movies (id),
  rating DECIMAL(2,1) NOT NULL,
  domestic_sales INT NOT NULL,
  international_sales INT NOT NULL
);

INSERT INTO Movies(title, director, year, length_minutes)
  VALUES ('Toy Story', 'John Lasseter', 1995, 81),
         ('Vida de inseto', 'Andrew Staton', 1998, 95),
         ('ratatui', 'Brad Bird', 2010, 115),
         ('UP', 'Pete Docter', 2009, 101),
         ('Carros', 'John Lasseter', 2006, 117),
         ('Toy Story 2', 'John Lasseter', 1999, 93),
         ('Valente', 'Brenda Chapman', 2012, 98);


INSERT INTO BoxOffice(movie_id, rating, domestic_sales, international_sales)
  VALUES (1, 8.3, 190000000, 170000000),
         (3, 7.9, 245000000, 239000000),
         (4, 6.1, 330000000, 540000000),
         (5, 7.8, 140000000, 310000000),
         (6, 5.8, 540000000, 600000000),
         (7, 7.5, 250000000, 190000000);

Exercício 1 : Insira as produções da Pixar abaixo na tabela Movies :
Monstros SA, de Pete Docter, lançado em 2001, com 92 minutos de duração.
Procurando Nemo, de John Lasseter, lançado em 2003, com 107 minutos de duração.
Os Incríveis, de Brad Bird, lançado em 2004, com 116 minutos de duração.
WALL-E, de Pete Docter, lançada em 2008, com 104 minutos de duração.

insert into Movies (title, director, year, length_minutes)
values
('Monstros SA', 'Pete Docter', 2001, 92),
('Procurando Nemo', 'John Lasseter', 2003, 107),
('Os Incríveis', 'Brad Bird', 2004, 116),
('WALL-E', 'Pete Docter', 2008, 104);

Exercício 2 : Procurando Nemo foi aclamado pela crítica! Foi classificado em 6.8, fez 450 milhões no mercado interno e 370 milhões no mercado internacional. Adicione as informações à tabela BoxOffice.

select * from Movies where title = 'Procurando Nemo';

--id = 9 - Procurando Nemo

describe BoxOffice;
insert into BoxOffice(movie_id, rating, domestic_sales, international_sales)
values
(9, 6.8, 4500000, 3700000);


Exercício 3 : O diretor do filme "Procurando Nemo" está incorreto, na verdade ele foi dirigido por Andrew Staton. Corrija esse dado utilizando o UPDATE .

update Movies
set director = 'Andrew Staton'
where id = 9;


Exercício 4 : O título do filme "Ratatouille" esta escrito de forma incorreta na tabela Movies , além disso, o filme foi lançado em 2007 e não em 2010. Corrija esses dados utilizando o UPDATE .
update Movies
set title = "Ratatouille", year = 2007
where id = 3;
 select * from Movies;
+----+-----------------+----------------+------+----------------+
| id | title           | director       | year | length_minutes |
+----+-----------------+----------------+------+----------------+
|  1 | Toy Story       | John Lasseter  | 1995 |             81 |
|  2 | Vida de inseto  | Andrew Staton  | 1998 |             95 |
|  3 | Ratatouille     | Brad Bird      | 2007 |            115 |
|  4 | UP              | Pete Docter    | 2009 |            101 |
|  5 | Carros          | John Lasseter  | 2006 |            117 |
|  6 | Toy Story 2     | John Lasseter  | 1999 |             93 |
|  7 | Valente         | Brenda Chapman | 2012 |             98 |
|  8 | Monstros SA     | Pete Docter    | 2001 |             92 |
|  9 | Procurando Nemo | Andrew Staton  | 2003 |            107 |
| 10 | Os Incríveis    | Brad Bird      | 2004 |            116 |
| 11 | WALL-E          | Pete Docter    | 2008 |            104 |
+----+-----------------+----------------+------+----------------+


Exercício 5 : Insira as novas classificações abaixo na tabela BoxOffice , lembre-se que a coluna movie_id é uma foreign key referente a coluna id da tabela Movies :
Monsters SA, classificado em 8.5, lucrou 300 milhões no mercado interno e 250 milhões no mercado internacional.
id = 8
Os Incríveis, classificado em 7.4, lucrou 460 milhões no mercado interno e 510 milhões no mercado internacional.
id = 10
WALL-E, classificado em 9.9, lucrou 290 milhões no mercado interno e 280 milhões no mercado internacional.
id = 11
insert into BoxOffice(movie_id, rating, domestic_sales, international_sales)
values
(8, 8.5, 300000000, 250000000),
(10,7.4,460000000, 510000000),
(11,9.9,290000000, 280000000);
select * from BoxOffice;
+----------+--------+----------------+---------------------+
| movie_id | rating | domestic_sales | international_sales |
+----------+--------+----------------+---------------------+
|        1 |    8.3 |      190000000 |           170000000 |
|        2 |    7.2 |      160000000 |           200600000 |
|        3 |    7.9 |      245000000 |           239000000 |
|        4 |    6.1 |      330000000 |           540000000 |
|        5 |    7.8 |      140000000 |           310000000 |
|        6 |    5.8 |      540000000 |           600000000 |
|        7 |    7.5 |      250000000 |           190000000 |
|        9 |    6.8 |        4500000 |             3700000 |
|        8 |    8.5 |      300000000 |           250000000 |
|       10 |    7.4 |      460000000 |           510000000 |
|       11 |    9.9 |      290000000 |           280000000 |
+----------+--------+----------------+---------------------+


Exercício 6 : Exclua da tabela Movies o filme "WALL-E".
id = 11;
select * from BoxOffice where movie_id = 11;
+----------+--------+----------------+---------------------+
| movie_id | rating | domestic_sales | international_sales |
+----------+--------+----------------+---------------------+
|       11 |    9.9 |      290000000 |           280000000 |
+----------+--------+----------------+---------------------+

delete from BoxOffice where movie_id = 11;
delete from Movies where title = 'WALL-E';

 select * from Movies;
+----+-----------------+----------------+------+----------------+
| id | title           | director       | year | length_minutes |
+----+-----------------+----------------+------+----------------+
|  1 | Toy Story       | John Lasseter  | 1995 |             81 |
|  2 | Vida de inseto  | Andrew Staton  | 1998 |             95 |
|  3 | Ratatouille     | Brad Bird      | 2007 |            115 |
|  4 | UP              | Pete Docter    | 2009 |            101 |
|  5 | Carros          | John Lasseter  | 2006 |            117 |
|  6 | Toy Story 2     | John Lasseter  | 1999 |             93 |
|  7 | Valente         | Brenda Chapman | 2012 |             98 |
|  8 | Monstros SA     | Pete Docter    | 2001 |             92 |
|  9 | Procurando Nemo | Andrew Staton  | 2003 |            107 |
| 10 | Os Incríveis    | Brad Bird      | 2004 |            116 |
+----+-----------------+----------------+------+----------------+


Exercício 7 : Exclua da tabela Movies todos os filmes dirigidos por "Andrew Staton".
primeiro, vamos ver os filmes dirigidos por Andrew Staton;
select * from Movies where director = 'Andrew Staton';
+----+-----------------+---------------+------+----------------+
| id | title           | director      | year | length_minutes |
+----+-----------------+---------------+------+----------------+
|  2 | Vida de inseto  | Andrew Staton | 1998 |             95 |
|  9 | Procurando Nemo | Andrew Staton | 2003 |            107 |
+----+-----------------+---------------+------+----------------+

delete from BoxOffice where movie_id in(2,9);
delete from Movies where id in(2,9);
elect * from Movies;
+----+---------------+----------------+------+----------------+
| id | title         | director       | year | length_minutes |
+----+---------------+----------------+------+----------------+
|  1 | Toy Story     | John Lasseter  | 1995 |             81 |
|  3 | Ratatouille   | Brad Bird      | 2007 |            115 |
|  4 | UP            | Pete Docter    | 2009 |            101 |
|  5 | Carros        | John Lasseter  | 2006 |            117 |
|  6 | Toy Story 2   | John Lasseter  | 1999 |             93 |
|  7 | Valente       | Brenda Chapman | 2012 |             98 |
|  8 | Monstros SA   | Pete Docter    | 2001 |             92 |
| 10 | Os Incríveis  | Brad Bird      | 2004 |            116 |
+----+---------------+----------------+------+----------------+
8 rows in set (0.00 sec)

//////////////////////////////////////////Bônus

Exercício 8 : Altere a classificação da tabela BoxOffice para 9.0 de todos os filmes que lucraram mais de 400 milhões no mercado interno.

primeiro vamos ver a tabela geral
select * from BoxOffice;
+----------+--------+----------------+---------------------+
| movie_id | rating | domestic_sales | international_sales |
+----------+--------+----------------+---------------------+
|        1 |    8.3 |      190000000 |           170000000 |
|        3 |    7.9 |      245000000 |           239000000 |
|        4 |    6.1 |      330000000 |           540000000 |
|        5 |    7.8 |      140000000 |           310000000 |
|        6 |    5.8 |      540000000 |           600000000 |
|        7 |    7.5 |      250000000 |           190000000 |
|        8 |    8.5 |      300000000 |           250000000 |
|       10 |    7.4 |      460000000 |           510000000 |
+----------+--------+----------------+---------------------+

SET SQL_SAFE_UPDATES = 0;

update BoxOffice
set rating = 9
where domestic_sales > 400000000;

 select * from BoxOffice;
+----------+--------+----------------+---------------------+
| movie_id | rating | domestic_sales | international_sales |
+----------+--------+----------------+---------------------+
|        1 |    8.3 |      190000000 |           170000000 |
|        3 |    7.9 |      245000000 |           239000000 |
|        4 |    6.1 |      330000000 |           540000000 |
|        5 |    7.8 |      140000000 |           310000000 |
|        6 |    9.0 |      540000000 |           600000000 |
|        7 |    7.5 |      250000000 |           190000000 |
|        8 |    8.5 |      300000000 |           250000000 |
|       10 |    9.0 |      460000000 |           510000000 |
+----------+--------+----------------+---------------------+
8 rows in set (0.00 sec)

 SET SQL_SAFE_UPDATES = ;

Exercício 9 : Altere a classificação da tabela BoxOffice para 6.0 de todos os filmes que lucraram menos de 300 milhões no mercado internacional e mais de 200 milhões no mercado interno.

SET SQL_SAFE_UPDATES = 0;

update BoxOffice
set rating = 6
where international_sales < 300000000 and domestic_sales > 200000000;


Exercício 10 : Exclua da tabela Movies todos os filmes com menos de 100 minutos de duração.
primeiro
select * from BoxOffice bo
    -> join Movies mo
    -> on bo.movie_id = mo.id
    -> where mo.length_minutes < 100;
+----------+--------+----------------+---------------------+----+-------------+----------------+------+----------------+
| movie_id | rating | domestic_sales | international_sales | id | title       | director       | year | length_minutes |
+----------+--------+----------------+---------------------+----+-------------+----------------+------+----------------+
|        1 |    8.3 |      190000000 |           170000000 |  1 | Toy Story   | John Lasseter  | 1995 |             81 |
|        6 |    5.8 |      540000000 |           600000000 |  6 | Toy Story 2 | John Lasseter  | 1999 |             93 |
|        7 |    7.5 |      250000000 |           190000000 |  7 | Valente     | Brenda Chapman | 2012 |             98 |
+----------+--------+----------------+---------------------+----+-------------+----------------+------+----------------+
3 rows in set (0.00 sec)

resposta:	
delete from BoxOffice Bo
where exists(
select * from Movies Mo
where Mo.length_minutes < 100
and Bo.movie_id = Mo.id);


////////////////////////////////////////Tutorial
https://app.betrybe.com/course/back-end/sql/table-management/recursos-adicionais-opcional?use_case=next_button