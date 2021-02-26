bloco 21
aula 2
Descomplicando JOINs, UNIONs e Subqueries
schema sakila db

Utilizar INNER JOIN para combinar dados de duas ou mais tabelas
Utilizar LEFT JOIN e RIGHT JOIN para combinar dados de duas ou mais tabelas
Utilizar SELF JOIN para fazer join de uma tabela com ela própria
Unir resultados com UNION e UNION ALL
Utilizar SUBQUERIES
Criar queries mais eficientes através do EXISTS

*************
A ideia do JOIN é permitir combinar registros de duas ou mais tabelas, através do relacionamento que uma tabela tem com a outra.
*************
Já o UNION permite acrescentar os resultados de uma query à outra.

JUNÇÕES

INNER JOIN

desafios
Vamos ver agora alguns desafios para consolidar esse conhecimento sobre o INNER JOIN , utilizando o banco de dados sakila . Antes de começar a escrever suas queries , identifique quais tabelas contêm as informações de que você precisa e como elas estão relacionadas.
1-Monte uma query que exiba o id do ator , nome do ator e id do filme em que ele já atuou usando as tabelas actor e film_actor .
SELECT film_actor.actor_id, actor.first_name, film_actor.film_id
FROM film_actor
JOIN actor
ON film_actor.actor_id = actor.actor_id;

Adicional, faça uma query que traga o id do ator, nome do ator e o id de todos os filmes que o ator participou.
SELECT COUNT(film_actor.actor_id) AS id, actor.first_name, GROUP_CONCAT(film_actor.film_id) AS Total
FROM film_actor
JOIN actor
ON film_actor.actor_id = actor.actor_id
GROUP BY film_actor.actor_id;


2-Use o JOIN para exibir o nome , sobrenome e endereço de cada um dos funcionários do banco. Use as tabelas staff e address .
SELECT staff.first_name AS nome, staff.last_name AS sobrenome, address.address AS endereco
FROM staff
JOIN address
ON staff.address_id = address.address_id;
+------+-----------+----------------------+
| nome | sobrenome | endereco             |
+------+-----------+----------------------+
| Mike | Hillyer   | 23 Workhaven Lane    |
| Jon  | Stephens  | 1411 Lillydale Drive |
+------+-----------+----------------------+
2 rows in set (0.01 sec)



3-Exiba o id do cliente , nome e email dos primeiros 100 clientes, ordenados pelo nome em ordem decrescente, juntamente com o id do endereço e o nome da rua onde o cliente mora. Essas informações podem ser encontradas nas tabelas customer e address .
SELECT customer.customer_id, customer.first_name, customer.email,
address.address_id, address.address
FROM customer
JOIN address
ON customer.address_id = address.address_id
ORDER BY customer.first_name DESC
LIMIT 100;

4-Exiba o nome , email , id do endereço , endereço e distrito dos clientes que moram no distrito da California e que contêm "rene" em seus nomes. As informações podem ser encontradas nas tabelas address e customer .
SELECT customer.first_name, customer.email, customer.address_id, address.address, address.district
FROM customer
JOIN address
ON customer.address_id = address.address_id
WHERE address.district = 'California' AND customer.first_name LIKE '%rene%;


SELECT customer.first_name, customer.email, customer.address_id, address.address, address.district
FROM customer
JOIN address
ON customer.address_id = address.address_id
WHERE customer.first_name LIKE 'RENE%';

5-Exiba o nome e a quantidade de endereços dos clientes cadastrados. Ordene seus resultados por nomes de forma decrescente. Exiba somente os clientes ativos. As informações podem ser encontradas na tabela address e customer .
SELECT customer.first_name, COUNT(customer.address_id)
FROM customer
WHERE customer.active = 1
GROUP BY customer_id
ORDER BY customer.first_name DESC;

ADICIONAL 
Selecione id, nome, os ids de endereços dos clientes ativos.
Ordene o resultado [ids de endereços dos clientes ativos] decrescente.

SELECT customer.customer_id, customer.first_name, GROUP_CONCAT(address_id, ' ') AS ID_address
FROM customer
WHERE customer.active = 1
GROUP BY customer_id
ORDER BY customer.address_id DESC;


6-Monte uma query que exiba o nome , sobrenome e a média de valor ( amount ) paga aos funcionários no ano de 2006. Use as tabelas payment e staff . Os resultados devem estar agrupados pelo nome e sobrenome do funcionário.

SELECT staff.first_name, staff.last_name, AVG(payment.amount)
FROM payment
JOIN staff
ON staff.staff_id = payment.staff_id
WHERE YEAR(payment_date) = 2006
GROUP BY staff.first_name, staff.last_name;

opcional
selecione o nome, sobrenome, e todos os pagamentos efetuados no ano de 2006. Use as tabelas payment e staff . Os resultados devem estar agrupados pelo id funcionário.
SELECT staff.first_name, staff.last_name, GROUP_CONCAT(payment.amount, ' ')
FROM payment
JOIN staff
ON staff.staff_id = payment.staff_id
WHERE YEAR(payment_date) = 2006
GROUP BY staff.staff_id;


7-Monte uma query que exiba o id do ator , nome , id do filme e título do filme , usando as tabelas actor , film_actor e film . Dica: você precisará fazer mais de um JOIN na mesma query .

SELECT film_actor.actor_id, actor.first_name, film_actor.film_id, film.title
FROM film_actor
JOIN actor
ON film_actor.actor_id = actor.actor_id
JOIN film
ON film_actor.film_id = film.film_id;

opcional
monte uma query que exiba id do ator , nome , id do filme e título do filme , usando as tabelas actor , film_actor e film .
Somente para os filmes exibidos no ano 2006 e duração sejá maior que 100 minutos.
Ordene o resultado pelo maior tempo de duração do Filme decrescente.
Obs: Resposta apenas os reistros 3 e 4.

+----------+------------+---------+---------------+--------+
| actor_id | first_name | film_id | title         | length |
+----------+------------+---------+---------------+--------+
|      121 | LIZA       |     141 | CHICAGO NORTH |    185 |
|      127 | KEVIN      |     141 | CHICAGO NORTH |    185 |
+----------+------------+---------+---------------+--------+
2 rows in set (0.01 sec)



SELECT film_actor.actor_id, actor.first_name, film_actor.film_id, film.title, film.length
FROM film_actor
JOIN actor
ON film_actor.actor_id = actor.actor_id
JOIN film
ON film_actor.film_id = film.film_id
WHERE film.release_year = 2006 and film.length > 100
ORDER BY film.length DESC
LIMIT 2 OFFSET 2;

////////////////LEFT JOIN e RIGHT JOIN
Três queries e uma pergunta
Vamos visualizar a diferença entre os três joins já vistos até o momento. Rode e analise cada uma das três queries a seguir. Busque notar a diferença entre as colunas da direita e da esquerda e a quantidade de dados retornados em cada query , como foi mostrado no vídeo. Gaste de 2 a 5 minutos aqui e depois continue.
LEFT JOIN

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    a.actor_id,
    a.first_name,
    a.last_name
FROM customer c
LEFT JOIN actor a
ON c.last_name = a.last_name
ORDER BY c.last_name;

-- retornou 620 rows

Resposta:
Será exibido id do cliente, primeiro nome do cliente, sobrenome do cliente(customer)
id do ator, primeiro nome do ator, sobrenome do ator depende da
junção left join entre as tabelas customer e actor 
aonde serão exibidos todos os registros de id do cliente, primeiro nome do cliente, sobrenome do cliente e caso tenha 
alguem cliente com sobrenome igual ao sobrenome de ator os campos de ator id do ator, primeiro nome do ator, sobrenome do ator serão exibidos;

opcional, considerando a resposta cima, quantos atores possuem o nome igual o nome de consumidores consumidores?

SELECT COUNT(*)
FROM customer c
JOIN actor a
ON c.last_name = a.last_name;
43 registros


RIGHT JOIN

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    a.actor_id,
    a.first_name,
    a.last_name
FROM customer c
RIGHT JOIN actor a
ON c.last_name = a.last_name
ORDER BY c.last_name;

reposta:

exibira 
todos os registros actor_id, first_name, last_name de ator, 
deviido a junção rigth com customer
caso tenha relação de sobrenome da tabela(customer) com sobrenome da tabela(actor) exibira os registros da tabela customer(customer_id,first_name,last_name)

OPCIONAL: retire os vazios da exibição
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    a.actor_id,
    a.first_name,
    a.last_name
FROM customer c
RIGHT JOIN actor a
ON c.last_name = a.last_name
WHERE actor_id IS NOT NULL
ORDER BY c.last_name;

INNER JOIN

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    a.actor_id,
    a.first_name,
    a.last_name
FROM customer c
INNER JOIN actor a
ON c.last_name = a.last_name
ORDER BY c.last_name;

reposta: JOIN OR INNER JOIN
Esta querie exibirá,
todos os campos
c.customer_id,
    c.first_name,
    c.last_name,
    a.actor_id,
    a.first_name,
    a.last_name
das tabelas customer e actor
devido a junção INNER JOIN ou JOIN
onde houver relação de:
sobrenome de customer =  sobrenome de actor

retornou 43 registros.

//////////////////////SELF JOIN

customer

CustomerID	CustomerName	ContactName	Address	City	PostalCode	Country
1	Alfreds Futterkiste	Maria Anders	Obere Str. 57	Berlin	12209	Germany
2	Ana Trujillo Emparedados y helados	Ana Trujillo	Avda. de la Constitución 2222	México D.F.	05021	Mexico

SELECT 
  A.CustomerName AS CustomerName1,
  B.CustomerName AS CustomerName2,
  A.City
FROM Customers A, Customers B
WHERE A.CustomerID <> B.CustomerID
AND A.City = B.City
ORDER BY A.City;

Note que um SELF JOIN não é um tipo diferente de JOIN . É apenas um caso em que uma tabela faz join consigo mesma. Você pode utilzar qualquer dos tipos de JOIN vistos ao realizar um SELF JOIN .
Para fixar esses conceitos, tente encontrar as seguintes informações:

1 - Queremos saber os ids e custos de substituição dos filmes que possuem o mesmo custo de substituição.
SELECT 
  f1.film_id,
  f1.replacement_cost AS cost1,
  f2.film_id,
  f2.replacement_cost AS cost2 
FROM film as f1, film as f2
WHERE f1.replacement_cost = f2.replacement_cost;

2 - Exiba o título e a duração de empréstimo dos filmes que possuem a mesma duração. Exiba apenas os filmes com a duração de empréstimo entre 2 e 4 dias.
SELECT
  f1.title,
  f1.rental_duration,
  f2.title,
  f2.rental_duration
FROM film AS f1, film AS f2
WHERE f1.film_id = f2.film_id AND f1.rental_duration >=2 AND f2.rental_duration <=4;


///////////////////////union
O UNION remove os dados duplicados,
enquanto o UNION ALL os mantém.

Observe que, para usar o comando corretamente, a mesma quantidade de colunas deve ser utilizada.
Vamos trabalhar agora com alguns desafios sobre o UNION :

1-Todos os funcionários foram promovidos a atores. Monte uma query que exiba a união da tabela staff com a tabela actor , exibindo apenas o nome e o sobrenome . Seu resultado não deve excluir nenhum funcionário ao unir as tabelas.

SELECT first_name, last_name
FROM actor
UNION ALL
SELECT first_name, last_name
FROM staff;


2-Monte uma query que una os resultados das tabelas customer e actor , exibindo os nomes que contêm a palavra "tracy" na tabela customer e os que contêm "je" na tabela actor . Exiba apenas os resultados únicos.

SELECT first_name, last_name
FROM customer
WHERE first_name LIKE '%TRACY%' OR last_name LIKE '%TRACY%'
UNION
SELECT first_name, last_name
FROM actor
WHERE first_name LIKE '%je%' OR last_name LIKE '%je%';


3-Monte uma query que exiba a união dos cinco últimos nomes da tabela actor , o primeiro nome da tabela staff e cinco nomes a partir da 15ª posição da tabela customer . Não permita que dados repetidos sejam exibidos. Ordene os resultados em ordem alfabética.

(SELECT first_name as a
FROM actor
ORDER BY actor.first_name DESC
LIMIT 5)
UNION 
(SELECT first_name as s
FROM staff
LIMIT 1)
UNION 
(SELECT first_name as c
FROM customer
LIMIT 5 OFFSET 15);

VALIDATOR
https://www.eversql.com/sql-syntax-check-validator/ 


4-Você quer exibir uma lista paginada com os nomes e sobrenomes de todos os clientes e atores do banco de dados, em ordem alfabética. Considere que a paginação está sendo feita de 15 em 15 resultados e que você está na 4ª página. Monte uma query que simule esse cenário.

(SELECT first_name, last_name FROM customer
ORDER BY customer.first_name
LIMIT 15 OFFSET 15)
UNION
(SELECT first_name, last_name FROM actor
ORDER BY actor.first_name
LIMIT 15 OFFSET 15)


//////////////////SUBQUERY

SELECT f.title, f.rating
FROM (
    SELECT *
    FROM sakila.film
    WHERE rating = 'R'
) AS f;


Preenchendo uma coluna de um SELECT por meio de uma SUBQUERY .

SELECT
    address,
    district,
    (
        SELECT city
        FROM sakila.city
        WHERE city.city_id = sakila.address.city_id
    ) AS city
FROM sakila.address;

Filtrando resultados com WHERE usando como base os dados retornados de uma SUBQUERY .

SELECT address, district
FROM sakila.address
WHERE city_id in (
    SELECT city_id
    FROM sakila.city
    WHERE city in ('Sasebo', 'San Bernardino', 'Athenai', 'Myingyan')
);

Usando uma tabela externa, de fora da SUBQUERY , dentro dela.

SELECT
    first_name,
    (
        SELECT address
        FROM sakila.address
        WHERE address.address_id = tabela_externa.address_id
    ) AS address
FROM sakila.customer AS tabela_externa;

//////////////////////////SUBQUERY ou JOIN

Talvez você esteja se perguntando se seria possível resolver as queries anteriores através de um JOIN . De fato, podemos, como é exemplificado a seguir.
Usando SUBQUERY

SELECT
    first_name,
    (
        SELECT address
        FROM sakila.address
        WHERE address.address_id = tabela_externa.address_id
    ) AS address
FROM sakila.customer AS tabela_externa;

Usando INNER JOIN

SELECT c.first_name, ad.address
FROM sakila.customer c
INNER JOIN sakila.address ad ON c.address_id = ad.address_id;

/////////////////////EXISTS
SELECT
  EmployeeID,
  FirstName
FROM Employess AS e
WHERE EXISTS(
  SELECT EmployeeID
  FROM Orders AS o
  GROUP BY EmployeeID
  HAVING COUNT(*) > 30)
ORDER BY EmployeeID;

Mais Exercícios de fixação

BD Hotel
1-Usando o EXISTS na tabela books_lent e books , exiba o id e título dos livros que ainda não foram emprestados.
SELECT Id, Title
FROM Books AS b
WHERE NOT EXISTS(
  SELECT book_id
  FROM Books_Lent AS bl
  WHERE bl.book_id = b.Id
);

+----+---------------------------------------------------+
| Id | Title                                             |
+----+---------------------------------------------------+
|  6 | Refactorign                                       |
|  7 | The Complete Software Developer’s Career Guide    |
+----+---------------------------------------------------+
2 rows in set (0.01 sec)



2-Usando o EXISTS na tabela books_lent e books , exiba o id e título dos livros estão atualmente emprestados e que contêm a palavra "lost" no título.
SELECT Id, Title
FROM Books AS b
WHERE EXISTS(
  SELECT book_id
  FROM Books_Lent AS bl
  WHERE bl.book_id = b.Id AND b.Title LIKE '%lost%'
);

+----+---------------+
| Id | Title         |
+----+---------------+
|  3 | Paradise Lost |
+----+---------------+
1 row in set (0.00 sec)


3-Usando a tabela carsales e customers , exiba apenas o nome dos clientes que ainda não compraram um carro.
CarSales
CarID
CUstomerID

Customers
CustomerId
Name

SELECT Name
FROM Customers AS customer
WHERE NOT EXISTS(
  SELECT CustomerID
  FROM CarSales AS sale
  WHERE sale.CustomerId = customer.CUstomerID
);

+------------+
| Name       |
+------------+
| Jack Fonda |
+------------+
1 row in set (0.00 sec)



4-Usando o comando EXISTS em conjunto com JOIN e as tabelas cars , customers e carsales , exiba o nome do cliente e o modelo do carro de todos os clientes que fizeram compras de carros.

CarSales
CarID
CustomerID

Customers
CustomerId
Name

Cars
Id
Name
Cost

SELECT Customers.Name, Cars.Name
FROM Customers
JOIN CarSales
ON CarSales.CustomerId = Customers.CustomerId
JOIN Cars
ON Cars.Id = CarSales.CarID
WHERE EXISTS(
  SELECT CustomerID
  FROM CarSales
  WHERE CarSales.CustomerID = Customers.CustomerId
);


/////////////////////primeira subquerie com exists

SUBQUERIES FROM

exemplo

SELECT f.*
FROM (SELECT * FROM film
WHERE title like '%air%') as f;


CTE common table expressions
WITH cteFilms (film_id, title)
AS
(
 SELECT film_id, title FROM film
 WHERE title like '%air%'
)
SELECT * FROM cteFilms; 


SUBQUERIES COLUMN

SELECT
  customer_id,
  first_name,
  (SELECT address FROM address AS a WHERE a.address_id = ct.address_id) AS 'Endereco'
FROM customer ct;


CTE common table expressions

primeiro exemplo
WITH cteCustomer AS
( SELECT 
    customer_id,
    first_name,
    address.address as Address
  FROM customer
  JOIN address
  ON customer.address_id = address.address_id
)
SELECT * FROM cteCustomer;

segundo exemplo
With CTE_Orders_quantity AS
(
Select shop_id,
product_id,
brand_id,
shop_name,
quantity
from order_detail where quantity> 30
)
Select * from CTE_Orders_quantity s
JOIN details_people p
ON s.product_id=p.product_id
where shop_idin( 2, 1);



SUBQUERIES WHERE

SELECT 
  first_name.
  last_name
FROM actor
WHERE actor_id IN (
  SELECT actor_id
  FROM film_actor
  GROUP BY actor_id
  HAVING COUNT(*) > 20
);

exibe nome e sobrenome de atores onde exista
id do ator = id do film_ator

SELECT first_name, last_name
FROM actor as a
WHERE EXISTS(
SELECT actor_id
FROM film_actor as f
WHERE f.actor_id = a.actor_id
GROUP BY actor_id
HAVING actor_id > 100);

exiba nome e sobrenome de cliente onde não exista
cliente com nome igual de nome de ator


SELECT first_name, last_name
FROM customer AS c
WHERE NOT EXISTS(
SELECT actor_id
FROM actor AS a
WHERE c.first_name = a.first_name);



