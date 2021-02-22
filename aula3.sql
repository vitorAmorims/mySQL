BLOCO 20
schema sakila

AULA 3 - FILTRANDO DADOS

1 - Precisamos identificar o cliente com o e-mail LEONARD.SCHOFIELD@sakilacustomer.org .
resolução: SELECT * FROM customer WHERE email = 'LEONARD.SCHOFIELD@sakilacustomer.org';

2 - Precisamos de um relatório dos nomes,
em ordem alfabética, 
dos clientes que não estão mais ativos no nosso sistema e pertencem à loja com o id 2. 
Porém, não inclua o cliente KENNETH no resultado.
resolução: 
SELECT first_name FROM customer 
WHERE active <> 1 AND store_id = 2 AND first_name <> 'KENNETH'
ORDER BY first_name;

3 - O setor financeiro quer saber nome, descrição, ano de lançamento e quais são os 100 filmes com o maior custo de substituição, do valor mais alto ao mais baixo, entre os filmes feitos para menores de idade e que têm o custo mínimo de substituição de $18,00 dólares.
resolução: 
SELECT title, description, release_year
FROM film
WHERE (rating = 'PG' OR rating = 'PG-13' OR rating = 'R') AND replacement_cost <= 18
ORDER BY replacement_cost LIMIT 100;

4 - Quantos clientes estão ativos e na loja 1?
resolução: SELECT COUNT(*) FROM customer WHERE active = 1 AND store_id = 1;

5 - Mostre todos os detalhes dos clientes que não estão ativos na loja 1.
resolução: SELECT * FROM customer WHERE active <> 1 AND store_id = 1;
8 rows

6 - Precisamos descobrir 
quais são os 50 filmes feitos para maiores de 17 anos e adultos com a menor taxa de aluguel, para que possamos fazer uma divulgação melhor desses filmes.
resolução: SELECT * FROM film WHERE (rating = 'R' OR rating = 'NC-17') ORDER BY rental_rate LIMIT 50;

/////////////////////////////////////////////////COMANDO LIKE

Encontre todos os detalhes dos filmes que contêm a palavra " ace " no nome.
resolução: SELECT * FROM film WHERE title LIKE '%ace%';

Encontre todos os detalhes dos filmes cujas descrições finalizam com " china ".
resolução: SELECT * FROM film WHERE description LIKE '%china';

Encontre todos os detalhes dos dois filmes cujas descrições contêm a palavra " girl " e o título finaliza com a palavra " lord ".
resolução: SELECT * FROM film WHERE description LIKE '%girl%' AND title LIKE '%lord';

Encontre os dois casos em que, a partir do 4° caractere no título do filme, tem-se a palavra " gon ".
resolução: SELECT * FROM film WHERE title LIKE '___gon%';

Encontre os dois casos em que, a partir do 4° caractere no título do filme, tem-se a palavra " gon " e a descrição contém a palavra " Documentary ".
resolução: SELECT * FROM film WHERE title LIKE '___gon%' AND description LIKE '%Documentary%';

Encontre os dois filmes cujos títulos ou finalizam com " academy " ou inciam com " mosquito ".
resolução: SELECT * FROM film WHERE title LIKE '%academy' OR title LIKE 'mosquito%';re

Encontre os seis filmes que contêm as palavras " monkey " e " sumo " em suas descrições.
resolução: SELECT * FROM film WHERE description LIKE '%monkey%' AND description LIKE '%sumo%';

//////////////////////////////////////////////OPERADOR IN

Como você faria, então, para encontrar, usando o IN , todos os detalhes sobre o aluguel dos clientes com os seguintes ids: 269, 239, 126, 399, 142?
resolução: SELECT * FROM payment WHERE customer_id IN (269,239,126,399,142);

Como encontraria todas as informações sobre os endereços que estão registrados nos distritos de QLD, Nagasaki, California, Attika, Mandalay, Nantou e Texas?
resolução: SELECT * FROM address WHERE district IN ('QLD', 'Nagasaki', 'California', 'Attika', 'Mandalay', 'Nantou', 'Texas');

//////////////////////////////////////////////////OPERADOR BETWEEN

consolidando o conhecimento

1 - Encontre o nome, sobrenome e e-mail dos clientes com os seguintes sobrenomes: hicks, crawford, henry, boyd, mason, morales e kennedy, ordenados por nome em ordem alfabética.

resposta:
SELECT first_name, last_name, email FROM customer
WHERE last_name IN ('hicks', 'crawford', 'henry', 'boyd', 'mason', 'morales', 'kennedy')
ORDER BY first_name;


first_name | last_name | email                              |
+------------+-----------+------------------------------------+
| ANITA      | MORALES   | ANITA.MORALES@sakilacustomer.org   |
| EMMA       | BOYD      | EMMA.BOYD@sakilacustomer.org       |
| ESTHER     | CRAWFORD  | ESTHER.CRAWFORD@sakilacustomer.org |
| JUANITA    | MASON     | JUANITA.MASON@sakilacustomer.org   |
| MONICA     | HICKS     | MONICA.HICKS@sakilacustomer.org    |
| PAULINE    | HENRY     | PAULINE.HENRY@sakilacustomer.org   |
| RHONDA     | KENNEDY   | RHONDA.KENNEDY@sakilacustomer.org  

2 - Encontre o e-mail dos clientes com os address_id 172, 173, 174, 175 e 176, ordenados em ordem alfabética.
resposta: 
SELECT * FROM customer
WHERE address_id IN (172,173,174,175,176)
ORDER BY email;

 customer_id | store_id | first_name | last_name | email                              | address_id | active | create_date         | last_update         |
+-------------+----------+------------+-----------+------------------------------------+------------+--------+---------------------+---------------------+
|         170 |        1 | BEATRICE   | ARNOLD    | BEATRICE.ARNOLD@sakilacustomer.org |        174 |      1 | 2006-02-14 22:04:36 | 2006-02-15 04:57:20 |
|         172 |        1 | BERNICE    | WILLIS    | BERNICE.WILLIS@sakilacustomer.org  |        176 |      1 | 2006-02-14 22:04:36 | 2006-02-15 04:57:20 |
|         171 |        2 | DOLORES    | WAGNER    | DOLORES.WAGNER@sakilacustomer.org  |        175 |      1 | 2006-02-14 22:04:36 | 2006-02-15 04:57:20 |
|         169 |        2 | ERICA      | MATTHEWS  | ERICA.MATTHEWS@sakilacustomer.org  |        173 |      0 | 2006-02-14 22:04:36 | 2006-02-15 04:57:20 |
|         168 |        1 | REGINA     | BERRY     | REGINA.BERRY@sakilacustomer.org    |        172 |      1 | 2006-02-14 22:04:36 | 2006-02-15 04:57:20 |

3 - Descubra quantos pagamentos foram feitos entre 01/05/2005 e 01/08/2005. Lembre-se de que, no banco de dados, as datas estão armazenadas no formato ano/mês/dia, diferente do formato brasileiro, que é dia/mês/ano.
resposta:
SELECT COUNT(*) FROM payment
WHERE payment_date BETWEEN '2005-05-01' AND '2005-08-01';
+----------+
| COUNT(*) |
+----------+
|    10180 |
+----------+
///////////////////////////////////////////////////////////JOIN//////////////////////////////////////////////////////////////////

4 - Encontre o título, ano de lançamento e duração do empréstimo de todos os filmes com a duração de empréstimo de 3 a 6. Os resultados devem ser classificados em filmes com maior duração de empréstimo primeiro.

sintaxe:
SELECT * FROM alunos
JOIN assistem
ON alunos.id = assistem.id_aluno
JOIN cursos
ON assistem.idcurso = curso.idcurso;

******************resolução:
select film.title, film.release_year, datediff(rental.return_date, rental.rental_date) as duracao
from film
join inventory
on inventory.film_id = film.film_id
join rental
on rental.inventory_id = inventory.inventory_id
where datediff(rental.return_date, rental.rental_date) between 3 and 6
order by datediff(rental.return_date, rental.rental_date) desc;

5 - Monte um relatório que exiba o título e classificação dos 500 primeiros filmes direcionados para menores de idade.
Os resultados devem estar ordenados por classificação mais abrangente primeiro.

A tabela a seguir é um guia de como a classificação indicativa é usada no banco de dados sakila . Consulte-a ao fazer os desafios propostos.
G = permitido para todos
PG = permitido para crianças menores de 13 anos
PG-13 = permitido para pessoas com mais de 13 anos
R = permitido para pessoas com mais de 17 anos
NC-17 = permitido apenas para adultos
Entre no banco de dados sakila e siga as instruções (e guarde as queries para conferir posteriormente):

resposta: select title, rating from film where rating in('PG','PG-13','R') order by rating limit 500;

//////////////////////////////////////////////Encontrando e separando resultados que incluem datas//////////////////////

-- Encontra todos os pagamentos deste dia, ignorando horas, minutos e segundos
SELECT * FROM sakila.payment
WHERE DATE(payment_date) = '2005-07-31';


-- Encontra todos pagamentos deste dia, ignorando horas, minutos e segundos
SELECT * FROM sakila.payment
WHERE payment_date LIKE '2005-07-31%';

-- Encontra um pagamento com dia e hora exatos
SELECT * FROM sakila.payment
WHERE payment_date LIKE '2005-08-20 00:30:52';

-- Encontra pagamentos especificando um valor mínimo e um valor máximo para a data
SELECT *
FROM sakila.payment
WHERE payment_date BETWEEN '2005-05-26 00:00:00' AND '2005-05-27 23:59:59';

-- Teste cada um dos comandos a seguir:
SELECT DATE(payment_date) FROM sakila.payment; -- YYYY-MM-DD
SELECT YEAR(payment_date) FROM sakila.payment; -- Ano
SELECT MONTH(payment_date) FROM sakila.payment; -- Mês
SELECT DAY(payment_date) FROM sakila.payment; -- Dia
SELECT HOUR(payment_date) FROM sakila.payment; -- Hora
SELECT MINUTE(payment_date) FROM sakila.payment; -- Minuto
SELECT SECOND(payment_date) FROM sakila.payment; -- Segundo

schema sakila
1 - Quantos aluguéis temos com a data de retorno 2005-08-29 ? Há múltiplas maneiras possíveis de encontrar a resposta.
reposta: select count(*) from rental where date(return_date) = '2005-08-29';
+----------+
| count(*) |
+----------+
|      298 |
+----------+

2- Quantos filmes foram alugados entre 01/07/2005 e 22/08/2005 ?
reposta: select count(*) from rental where rental_date between '2005-07-01' and '2005-08-22';
+----------+
| count(*) |
+----------+
|    11171 |
+----------+

3 - Usando a tabela rental , extraia data, ano, mês, dia, hora, minuto e segundo dos registros com rental_id = 10330.
reposta: 
select 
date(rental_date),
year(rental_date),
month(rental_date),
day(rental_date),
hour(rental_date),
minute(rental_date),
second(rental_date)
from rental where rental_id = 10330;

4 - Monte uma query que encontre o id e a data de aluguel do filme que foi alugado no dia 18/08/2005 às 00:14:03.
reposta: select rental_id, rental_date from rental where rental_date in('2005-08-18 00:14:03');
+-----------+---------------------+
| rental_id | rental_date         |
+-----------+---------------------+
|     12151 | 2005-08-18 00:14:03 |
+-----------+---------------------+
1 row in set (0.01 sec)


//////////////////////////////////////exercício do dia Aula 3
DROP SCHEMA IF EXISTS PecasFornecedores;
CREATE SCHEMA PecasFornecedores;
USE PecasFornecedores;

CREATE TABLE Pecas (
  code INTEGER PRIMARY KEY NOT NULL,
  name TEXT NOT NULL
);

CREATE TABLE Fornecedores (
  code VARCHAR(40) PRIMARY KEY NOT NULL,  
  name TEXT NOT NULL
);

CREATE TABLE Fornecimentos (
  code INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  peca INTEGER,
  FOREIGN KEY (peca) REFERENCES Pecas (code),
  Fornecedor VARCHAR(40),
  FOREIGN KEY (fornecedor) REFERENCES Fornecedores (code),
  Preco INTEGER NOT NULL
);

CREATE TABLE Vendas (
  code INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
  fornecimento INTEGER,
  quantity INTEGER,
  order_date DATETIME,
  FOREIGN KEY (fornecimento) REFERENCES Fornecimentos (code)
);
 
INSERT INTO Fornecedores(code, name)
  VALUES ('ROB', 'Robauto SA'),
    ('CNF', 'Confiauto LTDA'),
    ('MAP', 'Malok Auto Peças'),
    ('INF', 'Infinity Peças LTDA');

INSERT INTO Pecas(code, name)
  VALUES (1, 'Rebimboca'),
    (2, 'Parafuseta'),
    (3, 'Grampola'),
    (4, 'Grapeta');

INSERT INTO Fornecimentos(peca, fornecedor, preco)
  VALUES (1, 'CNF', 10),
    (1, 'ROB', 15),
    (2, 'CNF', 20),
    (2, 'ROB', 25),
    (2, 'MAP', 14),
    (3, 'INF', 50),
    (3, 'MAP', 45),
    (4, 'CNF', 5),
    (4, 'ROB', 7);

INSERT INTO Vendas(fornecimento, quantity, order_date)
  VALUES (1, 3, '2017-05-22 11:28:36'),
    (2, 2, '2018-03-22 11:35:24'),
    (3, 8, '2018-11-16 15:51:36'),
    (3, 10, '2019-02-13 13:23:22'),
    (8, 5, '2019-06-11 12:22:48'),
    (6, 1, '2019-09-07 09:53:58'),
    (7, 3, '2020-01-05 08:39:33'),
    (9, 5, '2020-05-13 14:05:19');
    
1 - Escreva uma query para exibir todas as peças que começam com GR .
select * from Pecas where name like 'gr%';
+------+----------+
| code | name     |
+------+----------+
|    3 | Grampola |
|    4 | Grapeta  |
+------+----------+
2 rows in set (0.00 sec)

Escreva uma query para exibir todos os fornecimentos que contenham a peça com code 2.
Organize o resultado por alfabética de fornecedor.

select * from Fornecimentos where peca = 2 order by fornecedor;
+------+------+------------+-------+
| code | peca | Fornecedor | Preco |
+------+------+------------+-------+
|    3 |    2 | CNF        |    20 |
|    5 |    2 | MAP        |    14 |
|    4 |    2 | ROB        |    25 |
+------+------+------------+-------+
3 rows in set (0.01 sec)

Escreva uma query para exibir as peças e o preço de todos os fornecimentos em que o código do fornecedor tenha a letra N .
select peca, Preco from Fornecimentos where Fornecedor like '%N%';
+------+-------+
| peca | Preco |
+------+-------+
|    1 |    10 |
|    2 |    20 |
|    3 |    50 |
|    4 |     5 |
+------+-------+
4 rows in set (0.00 sec)

Escreva uma query para exibir todas as informações dos fornecedores que são empresas limitadas (LTDA). Ordene os resultados em ordem alfabética decrescente.
select * from Fornecedores where name like '%LTDA%' order by name desc;

+------+----------------------+
| code | name                 |
+------+----------------------+
| INF  | Infinity Peças LTDA  |
| CNF  | Confiauto LTDA       |
+------+----------------------+
2 rows in set (0.01 sec)

Escreva uma query para exibir o número de empresas (fornecedores) que contém a letra F no código.
select * from Fornecedores where code like '%F%';
+------+----------------------+
| code | name                 |
+------+----------------------+
| CNF  | Confiauto LTDA       |
| INF  | Infinity Peças LTDA  |
+------+----------------------+
2 rows in set (0.01 sec)



Escreva uma query para exibir os fornecimentos onde as peças custam mais de R$15,00 e menos de $40,00 . Ordene os resultados por ordem crescente.
select * from Fornecimentos where Preco between 15 and 40 order by Preco;
+------+------+------------+-------+
| code | peca | Fornecedor | Preco |
+------+------+------------+-------+
|    2 |    1 | ROB        |    15 |
|    3 |    2 | CNF        |    20 |
|    4 |    2 | ROB        |    25 |
+------+------+------------+-------+
3 rows in set (0.00 sec)

Escreva uma query para exibir o número de vendas feitas entre o dia 15/04/2018 e o dia 30/07/2019.
select count(*) from Vendas where date(order_date) between '2018-04-15' and '2019-07-30';

+----------+
| count(*) |
+----------+
|        3 |
+----------+


/////////////////////////////////////BÔNUS/////////////////////////////////////////////////

DROP SCHEMA IF EXISTS Scientists;
CREATE SCHEMA Scientists;
USE Scientists;

CREATE TABLE Scientists (
  SSN INT,
  Name CHAR(30) NOT NULL,
  PRIMARY KEY (SSN)
);

CREATE TABLE Projects (
  Code CHAR(4),
  Name CHAR(50) NOT NULL,
  Hours INT,
  PRIMARY KEY (Code)
);

CREATE TABLE AssignedTo (
  Scientist INT NOT NULL,
  Project CHAR(4) NOT NULL,
  PRIMARY KEY (Scientist, Project),
  FOREIGN KEY (Scientist) REFERENCES Scientists (SSN),
  FOREIGN KEY (Project) REFERENCES Projects (Code)
);

INSERT INTO Scientists(SSN,Name) 
  VALUES(123234877, 'Michael Rogers'),
    (152934485, 'Anand Manikutty'),
    (222364883, 'Carol Smith'),
    (326587417, 'Joe Stevens'),
    (332154719, 'Mary-Anne Foster'),    
    (332569843, 'George ODonnell'),
    (546523478, 'John Doe'),
    (631231482, 'David Smith'),
    (654873219, 'Zacary Efron'),
    (745685214, 'Eric Goldsmith'),
    (845657245, 'Elizabeth Doe'),
    (845657246, 'Kumar Swamy');

 INSERT INTO Projects (Code, Name, Hours)
  VALUES ('AeH1' ,'Winds: Studying Bernoullis Principle', 156),
    ('AeH2', 'Aerodynamics and Bridge Design', 189),
    ('AeH3', 'Aerodynamics and Gas Mileage', 256),
    ('AeH4', 'Aerodynamics and Ice Hockey', 789),
    ('AeH5', 'Aerodynamics of a Football', 98),
    ('AeH6', 'Aerodynamics of Air Hockey', 89),
    ('Ast1', 'A Matter of Time', 112),
    ('Ast2', 'A Puzzling Parallax', 299),
    ('Ast3', 'Build Your Own Telescope', 6546),
    ('Bte1', 'Juicy: Extracting Apple Juice with Pectinase', 321),
    ('Bte2', 'A Magnetic Primer Designer', 9684),
    ('Bte3', 'Bacterial Transformation Efficiency', 321),
    ('Che1', 'A Silver-Cleaning Battery', 545),
    ('Che2', 'A Soluble Separation Solution', 778);

 INSERT INTO AssignedTo (Scientist, Project)
  VALUES (123234877, 'AeH1'),
    (152934485, 'AeH3'),
    (222364883, 'Ast3'),       
    (326587417, 'Ast3'),
    (332154719, 'Bte1'),
    (546523478, 'Che1'),
    (631231482, 'Ast3'),
    (654873219, 'Che1'),
    (745685214, 'AeH3'),
    (845657245, 'Ast1'),
    (845657246, 'Ast2'),
    (332569843, 'AeH4');
    
Escreva uma query para exibir todas as informações de todos os cientistas que possuam a letra e em seu nome.

select Scientists.SSN, Scientists.Name, Projects.Name, Projects.Hours
from Scientists
join AssignedTo
on AssignedTo.Scientist = Scientists.SSN
join Projects
on AssignedTo.Project = Projects.code
where Scientists.Name like '%e%';

+-----------+------------------+----------------------------------------------+-------+
| SSN       | Name             | Name                                         | Hours |
+-----------+------------------+----------------------------------------------+-------+
| 123234877 | Michael Rogers   | Winds: Studying Bernoullis Principle         |   156 |
| 326587417 | Joe Stevens      | Build Your Own Telescope                     |  6546 |
| 332154719 | Mary-Anne Foster | Juicy: Extracting Apple Juice with Pectinase |   321 |
| 332569843 | George ODonnell  | Aerodynamics and Ice Hockey                  |   789 |
| 546523478 | John Doe         | A Silver-Cleaning Battery                    |   545 |
| 654873219 | Zacary Efron     | A Silver-Cleaning Battery                    |   545 |
| 745685214 | Eric Goldsmith   | Aerodynamics and Gas Mileage                 |   256 |
| 845657245 | Elizabeth Doe    | A Matter of Time                             |   112 |
+-----------+------------------+----------------------------------------------+-------+


Escreva uma query para exibir o nome de todos os projetos cujo o código inicie com a letra A . Ordene o resultado em ordem alfabética.
select * from Projects where Name like 'A%' order by Name;
+------+--------------------------------+-------+
| Code | Name                           | Hours |
+------+--------------------------------+-------+
| Bte2 | A Magnetic Primer Designer     |  9684 |
| Ast1 | A Matter of Time               |   112 |
| Ast2 | A Puzzling Parallax            |   299 |
| Che1 | A Silver-Cleaning Battery      |   545 |
| Che2 | A Soluble Separation Solution  |   778 |
| AeH2 | Aerodynamics and Bridge Design |   189 |
| AeH3 | Aerodynamics and Gas Mileage   |   256 |
| AeH4 | Aerodynamics and Ice Hockey    |   789 |
| AeH5 | Aerodynamics of a Football     |    98 |
| AeH6 | Aerodynamics of Air Hockey     |    89 |
+------+--------------------------------+-------+

Escreva uma query para exibir o código e nome de todos os projetos que possuam em seu código o número 3 . Ordene o resultado em ordem alfabética.
select * from Projects where Code like '%3%' order by Name;
+------+-------------------------------------+-------+
| Code | Name                                | Hours |
+------+-------------------------------------+-------+
| AeH3 | Aerodynamics and Gas Mileage        |   256 |
| Bte3 | Bacterial Transformation Efficiency |   321 |
| Ast3 | Build Your Own Telescope            |  6546 |
+------+-------------------------------------+-------+


Escreva uma query para exibir todos os cientistas cujos projetos sejam AeH3 , Ast3 ou Che1 .
select Scientists.Name
from Scientists
join AssignedTo
on AssignedTo.Scientist = Scientists.SSN
join Projects
on AssignedTo.Project = Projects.Code
where Projects.code in ('AeH3','Ast3','Che1');

+-----------------+
| Name            |
+-----------------+
| Anand Manikutty |
| Eric Goldsmith  |
| Carol Smith     |
| Joe Stevens     |
| David Smith     |
| John Doe        |
| Zacary Efron    |
+-----------------+

Escreva uma query para exibir todas as informações de todos os projetos com mais de 500 horas.
select * from Projects
join AssignedTo
on AssignedTo.Project = Projects.Code
join Scientists
on AssignedTo.Scientist = Scientists.SSN
where Hours > 500;

+------+-----------------------------+-------+-----------+---------+-----------+-----------------+
| Code | Name                        | Hours | Scientist | Project | SSN       | Name            |
+------+-----------------------------+-------+-----------+---------+-----------+-----------------+
| AeH4 | Aerodynamics and Ice Hockey |   789 | 332569843 | AeH4    | 332569843 | George ODonnell |
| Ast3 | Build Your Own Telescope    |  6546 | 222364883 | Ast3    | 222364883 | Carol Smith     |
| Ast3 | Build Your Own Telescope    |  6546 | 326587417 | Ast3    | 326587417 | Joe Stevens     |
| Ast3 | Build Your Own Telescope    |  6546 | 631231482 | Ast3    | 631231482 | David Smith     |
| Che1 | A Silver-Cleaning Battery   |   545 | 546523478 | Che1    | 546523478 | John Doe        |
| Che1 | A Silver-Cleaning Battery   |   545 | 654873219 | Che1    | 654873219 | Zacary Efron    |
+------+-----------------------------+-------+-----------+---------+-----------+-----------------+
6 rows in set (0.00 sec)

Escreva uma query para exibir todas as informações de todos os projetos cujas horas sejam maiores que 250 e menores 800.
select * from Projects
join AssignedTo
on AssignedTo.Project = Projects.Code
join Scientists
on AssignedTo.Scientist = Scientists.SSN
where Hours between 250 and 800;
+------+----------------------------------------------+-------+-----------+---------+-----------+------------------+
| Code | Name                                         | Hours | Scientist | Project | SSN       | Name             |
+------+----------------------------------------------+-------+-----------+---------+-----------+------------------+
| AeH3 | Aerodynamics and Gas Mileage                 |   256 | 152934485 | AeH3    | 152934485 | Anand Manikutty  |
| AeH3 | Aerodynamics and Gas Mileage                 |   256 | 745685214 | AeH3    | 745685214 | Eric Goldsmith   |
| AeH4 | Aerodynamics and Ice Hockey                  |   789 | 332569843 | AeH4    | 332569843 | George ODonnell  |
| Ast2 | A Puzzling Parallax                          |   299 | 845657246 | Ast2    | 845657246 | Kumar Swamy      |
| Bte1 | Juicy: Extracting Apple Juice with Pectinase |   321 | 332154719 | Bte1    | 332154719 | Mary-Anne Foster |
| Che1 | A Silver-Cleaning Battery                    |   545 | 546523478 | Che1    | 546523478 | John Doe         |
| Che1 | A Silver-Cleaning Battery                    |   545 | 654873219 | Che1    | 654873219 | Zacary Efron     |
+------+----------------------------------------------+-------+-----------+---------+-----------+------------------+

Escreva uma query para exibir o nome e o código de todos os projetos cujo nome NÃO inicie com a A .

select Projects.Name, Projects.Code from Projects where Name not like 'A%';
+----------------------------------------------+------+
| Name                                         | Code |
+----------------------------------------------+------+
| Winds: Studying Bernoullis Principle         | AeH1 |
| Build Your Own Telescope                     | Ast3 |
| Juicy: Extracting Apple Juice with Pectinase | Bte1 |
| Bacterial Transformation Efficiency          | Bte3 |
+----------------------------------------------+------+
4 rows in set (0.00 sec)


Escreva uma query para exibir o nome de todos os projetos cujo código contenha a letra H .
select Name from Projects where Name like '%H%';
+----------------------------------------------+
| Name                                         |
+----------------------------------------------+
| Aerodynamics and Ice Hockey                  |
| Aerodynamics of Air Hockey                   |
| Juicy: Extracting Apple Juice with Pectinase |
+----------------------------------------------+
3 rows in set (0.00 sec)

///////////////////////////////////////Recursos adicionais
