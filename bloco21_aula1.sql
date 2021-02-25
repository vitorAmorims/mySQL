funções SQL, joins e subqueries

bloco 21 

Criar condicionais no SQL usando IF e CASE ;
Manipular strings no SQL;
Usar as diversas funções matemáticas do MySQL ;
Extrair informações específicas sobre datas de uma tabela;
Utilizar as funções de agregação AVG , MIN , MAX , SUM e COUNT ;
Exibir e filtrar dados de forma agrupada com GROUP BY e HAVING .

-- Converte o texto da string para CAIXA ALTA
SELECT UCASE('Oi, eu sou uma string');

-- Converte o texto da string para caixa baixa
SELECT LCASE('Oi, eu sou uma string');

-- Substitui as ocorrências de uma substring em uma string
SELECT REPLACE('Oi, eu sou uma string', 'string', 'cadeia de caracteres');

-- Retorna a parte da esquerda de uma string de acordo com o
-- número de caracteres especificado
SELECT LEFT('Oi, eu sou uma string', 3);

-- Retorna a parte da direita de uma string de acordo com o
-- número de caracteres especificado
SELECT RIGHT('Oi, eu sou um string', 6);

-- Exibe o tamanho, em caracteres, da string
SELECT LENGTH('Oi, eu sou uma string');

-- Extrai parte de uma string de acordo com o índice de um caractere inicial
-- e a quantidade de caracteres a extrair
SELECT SUBSTRING('Oi, eu sou uma string', 5, 2);

-- Se a quantidade de caracteres a extrair não for definida,
-- então a string será extraída do índice inicial definido, até o seu final
SELECT SUBSTRING('Oi, eu sou uma string', 5);

fixação
Faça uma query que exiba a palavra 'trybe' em CAIXA ALTA.
SELECT UCASE('trybe');

Faça uma query que transforme a frase 'Você já ouviu falar do DuckDuckGo?' em 'Você já ouviu falar do Google?' .
SELECT REPLACE('Você já ouviu falar do DuckDuckGo?','DuckDuckGo?','Google?');

Utilizando uma query , encontre quantos caracteres temos em 'Uma frase qualquer' .
SELECT LENGTH('Uma frase qualquer');

Extraia e retorne a palavra "JavaScript" da frase 'A linguagem JavaScript está entre as mais usadas' .
SELECT SUBSTRING('A linguagem JavaScript está entre as mais usadas',12,11);

Por fim, padronize a string 'RUA NORTE 1500, SÃO PAULO, BRASIL' para que suas informações estejam todas em caixa baixa.
SELECT LCASE('RUA NORTE 1500, SÃO PAULO, BRASIL');

IF/CASE

sintaxe:
SELECT IF (CONDICAO, VERDADEIRO, FALSE)
FOM nome;

sintaxe:
SELECT campos,
  CASE
    WHEN campo e condicao THEN novoValor 
    WHEN campo e condicao THEN novoValor 
    WHEN campo e condicao THEN novoValor 
  ELSE campo e seu valor
END AS nomedacolunaCase
FROM nomeTabela;

ex:
SELECT IF (rental_rate > 0.99, 'caro','barato')
FROM film;

ex1:
SELECT title, rental_rate, IF (rental_rate = 0.99, 'barato',
'caro') as preco_aluguel
FROM film limit 2;

ex2:
SELECT title, rental_rate,
  CASE
    WHEN rental_rate = 0.99 THEN 'barato' 
    WHEN rental_rate = 2.99 THEN 'médio' 
    WHEN rental_rate = 4.99 THEN 'caro' 
  ELSE rental_rate = 'não classificado'
END AS valor
FROM film
ORDER BY title
LIMIT 10;

funções matemáticas do SQL

SELECT 5 + 5;
SELECT 5 - 5;
SELECT 5 * 5;
SELECT 5 / 5;

mysql> SELECT rental_duration, rental_rate FROM film LIMIT 2;
+-----------------+-------------+
| rental_duration | rental_rate |
+-----------------+-------------+
|               6 |        0.99 |
|               3 |        4.99 |
+-----------------+-------------+
2 rows in set (0.00 sec)

mysql> SELECT rental_duration + rental_rate FROM film LIMIT 2;
+-------------------------------+
| rental_duration + rental_rate |
+-------------------------------+
|                          6.99 |
|                          7.99 |
+-------------------------------+
2 rows in set (0.00 sec)


SELECT rental_duration + rental_rate FROM sakila.film LIMIT 10;
SELECT rental_duration - rental_rate FROM sakila.film LIMIT 10;
SELECT rental_duration / rental_rate FROM sakila.film LIMIT 10;
SELECT rental_duration * rental_rate FROM sakila.film LIMIT 10;

Divisão de inteiros com DIV e como encontrar seus restos com o MOD
O DIV retorna o resultado inteiro de uma divisão, ignorando as casas decimais de um número. Veja os exemplos abaixo:
SELECT 10 DIV 3; -- 3
SELECT 10 DIV 2; -- 5
SELECT 14 DIV 3; -- 4
SELECT 13 DIV 2; -- 6

Já o operador MOD retorna o resto de uma divisão como resultado. Por exemplo:
SELECT 10 MOD 3; -- 1
SELECT 10 MOD 2; -- 0
SELECT 14 MOD 3; -- 2
SELECT 13 MOD 2; -- 1
SELECT 10.5 MOD 2; -- 0.5, ou seja, 2 + 2 + 2 + 2 + 2 = 10, restando 0.5

Desafios com DIV e MOD

Dica: Números pares são aqueles que podem ser divididos em duas partes iguais. Ou seja, são aqueles cuja divisão por 2 retorna resto 0.

1 - Monte uma query usando o MOD juntamente com o IF para descobrir se o valor 15 é par ou ímpar. Chame essa coluna de 'Par ou Ímpar' , onde ela pode dizer 'Par' ou 'Ímpar'.
SELECT IF (CONDICAO, VERDADEIRO, FALSO) AS 'Par ou Impar'
FROM table;

SELECT IF (20 MOD 2 = 1,'Impar','Par') AS 'Par ou Impar';


2 - Temos uma sala de cinema que comporta 220 pessoas. Quantos grupos completos de 12 pessoas podemos levar ao cinema sem que ninguém fique de fora?
SELECT 220 DIV 12; --18 GRUPOS


3 - Utilizando o resultado anterior, responda à seguinte pergunta: temos lugares sobrando? Se sim, quantos?
SELECT 220 MOD 12; -- 4 lugares

Arredondando Valores
-- Podemos omitir ou especificar quantas casas decimais queremos
SELECT ROUND(10.4925); -- 10
SELECT ROUND(10.5136); -- 11
SELECT ROUND(-10.5136); -- -11
SELECT ROUND(10.4925, 2); -- 10.49
SELECT ROUND(10.4925, 3); -- 10.493

nota:
round 0...0,49 arredonda para baixo
round 0...0.51 arredonda para cima

O arredondamento sempre para cima pode ser feito com o CEIL :
SELECT CEIL(10.51); -- 11
SELECT CEIL(10.49); -- 11
SELECT CEIL(10.2); -- 11

O arredondamento sempre para baixo pode ser feito com o FLOOR :
SELECT FLOOR(10.51); -- 10
SELECT FLOOR(10.49); -- 10
SELECT FLOOR(10.2); -- 10

Exponenciação e Raiz Quadrada
SELECT POW(2, 2); -- 4
SELECT POW(2, 4); -- 16

Encontrando a raiz quadrada de um valor usando SQRT :
SELECT SQRT(9); -- 3
SELECT SQRT(16); -- 4

Para situações em que se faz necessário gerar valores aleatórios, podemos usar a função RAND , em conjunto com as funções anteriores.

Consolidando seu conhecimento

1 - Monte uma query que gere um valor entre 15 e 20 .
SELECT ROUND(15 + (RAND() * 5));

2 - Monte uma query que exiba o valor arredondado de 15.75 com uma precisão de 5 casas decimais.
SELECT ROUND(15.75, 5);

3 -Estamos com uma média de 39.494 de vendas de camisas por mês. Qual é o valor aproximado para baixo dessa média?
SELECT FLOOR(39.494);

4 -Temos uma taxa de inscrição de 85.234% no curso de fotografia para iniciantes. Qual é o valor aproximado para cima dessa média?
SELECT CEIL(85.234);

Trabalhando com datas

SELECT CURRENT_DATE(); -- YYYY-MM-DD
SELECT NOW(); -- YYYY-MM-DD HH:MM:SS

-- 30, ou seja, a primeira data é 30 dias depois da segunda
SELECT DATEDIFF('2020-01-31', '2020-01-01');

-- -30, ou seja, a primeira data é 30 dias antes da segunda
SELECT DATEDIFF('2020-01-01', '2020-01-31');

-- -01:00:00, ou seja, há 1 hora de diferença entre os horários
SELECT TIMEDIFF('08:30:10', '09:30:10');

SELECT DATE(data_cadastro); -- YYYY-MM-DD
SELECT YEAR(data_cadastro); -- Ano
SELECT MONTH(data_cadastro); -- Mês
SELECT DAY(data_cadastro); -- Dia
SELECT HOUR(data_cadastro); -- Hora
SELECT MINUTE(data_cadastro); -- Minuto
SELECT SECOND(data_cadastro); -- Segundo

Também podemos usar CURRENT_DATE() e NOW() em conjunto com os comandos acima para encontrar resultados dinâmicos da seguinte maneira:

SELECT YEAR(CURRENT_DATE()); -- retorna o ano atual
SELECT HOUR(NOW()); -- retorna a hora atual

Para fixar, responda como seria possível encontrar as seguintes informações:

1 - Monte uma query que exiba a diferença de dias entre '2030-01-20' e hoje.
SELECT DATEDIFF('2030-01-20', CURRENT_DATE());


2 - Monte uma query exiba a diferença de horas entre '10:25:45' e '11:00:00' .
SELECT TIMEDIFF('10:25:45', '11:00:00');

Utilizando as funções de agregação AVG , MIN , MAX , SUM e COUNT

-- Usando a coluna replacement_cost (valor de substituição) vamos encontrar:
SELECT AVG(replacement_cost) FROM sakila.film; -- 19.984000 (Média entre todos registros)
SELECT MIN(replacement_cost) FROM sakila.film; -- 9.99 (Menor valor encontrado)
SELECT MAX(replacement_cost) FROM sakila.film; -- 29.99 (Maior valor encontrado)
SELECT SUM(replacement_cost) FROM sakila.film; -- 19984.00 (Soma de todos registros)
SELECT COUNT(replacement_cost) FROM sakila.film; -- 1000 registros encontrados (Quantidade)


Para praticar, vamos encontrar algumas informações sobre os filmes cadastrados em nossa base de dados.

1 - Monte um query que exiba:

A média de duração dos filmes e dê o nome da coluna de 'Média de Duração';
SELECT AVG(length) AS 'Média de Duração' FROM film;

A duração mínima dos filmes como 'Duração Mínima';
SELECT MIN(length)  AS 'Duração Mínima' FROM film;

A duração máxima dos filmes como 'Duração Máxima';
SELECT MAX(length) AS 'Duração Máxima' FROM film ;

A soma de todas as durações como 'Tempo de Exibição Total';
SELECT SUM(length)  AS 'Tempo de Exibição Total' FROM film;

E finalmente, a quantidade total de filmes cadastrados na tabela sakila.film como 'Filmes Registrados'.
SELECT COUNT(*) AS 'Filmes Registrados' FROM film;



Exibindo e filtrando dados de forma agrupada com GROUP BY e HAVING

sintaxe:
SELECT coluna(s) FROM tabela
GROUP BY coluna(s);

EX:
SELECT actor_id, count(film_id) FROM film_actor
GROUP BY actor_id;

confirmação:
SELECT COUNT(actor_id) FROM film_actor
WHERE actor_id = 1;

ex2:
SELECT first_name, COUNT(first_name) FROM actor WHERE first_name = 'PENELOPE' GROUP BY (first_name);

confirmação
SELECT * FROM actor WHERE first_name = 'PENELOPE';
+----------+------------+-----------+---------------------+
| actor_id | first_name | last_name | last_update         |
+----------+------------+-----------+---------------------+
|        1 | PENELOPE   | GUINESS   | 2006-02-15 04:34:33 |
|       54 | PENELOPE   | PINKETT   | 2006-02-15 04:34:33 |
|      104 | PENELOPE   | CRONYN    | 2006-02-15 04:34:33 |
|      120 | PENELOPE   | MONROE    | 2006-02-15 04:34:33 |
+----------+------------+-----------+---------------------+
4 rows in set (0.00 sec)

-- Média de duração de filmes agrupados por classificação indicativa
SELECT rating, AVG(length)
FROM sakila.film
GROUP BY rating;

+--------+-------------+
| rating | AVG(length) |
+--------+-------------+
| PG     |    112.0052 |
| G      |    111.0506 |
| NC-17  |    113.2286 |
| PG-13  |    120.4439 |
| R      |    118.6615 |
+--------+-------------+
5 rows in set (0.01 sec)

-- Valor mínimo de substituição dos filmes agrupados por classificação indicativa
SELECT rating, MIN(replacement_cost)
FROM sakila.film
GROUP BY rating;

+--------+-----------------------+
| rating | MIN(replacement_cost) |
+--------+-----------------------+
| PG     |                  9.99 |
| G      |                  9.99 |
| NC-17  |                  9.99 |
| PG-13  |                  9.99 |
| R      |                  9.99 |
+--------+-----------------------+
5 rows in set (0.01 sec)


-- Valor máximo de substituição dos filmes agrupados por classificação indicativa
SELECT rating, MAX(replacement_cost)
FROM sakila.film
GROUP BY rating;

+--------+-----------------------+
| rating | MAX(replacement_cost) |
+--------+-----------------------+
| PG     |                 29.99 |
| G      |                 29.99 |
| NC-17  |                 29.99 |
| PG-13  |                 29.99 |
| R      |                 29.99 |
+--------+-----------------------+
5 rows in set (0.01 sec)


-- Custo total de substituição de filmes agrupados por classificação indicativa
SELECT rating, SUM(replacement_cost)
FROM sakila.film
GROUP by rating;
+--------+-----------------------+
| rating | SUM(replacement_cost) |
+--------+-----------------------+
| PG     |               3678.06 |
| G      |               3582.22 |
| NC-17  |               4228.90 |
| PG-13  |               4549.77 |
| R      |               3945.05 |
+--------+-----------------------+
5 rows in set (0.01 sec)

Vamos praticar

1 -Monte uma query que exiba a quantidade de clientes cadastrados na tabela sakila.customer que estão ativos e a quantidade que estão inativos.
SELECT active, COUNT(active) FROM customer
GROUP BY active;


2- Monte uma query para a tabela sakila.customer que exiba a quantidade de clientes ativos e inativos por loja. Os resultados devem conter o ID da loja , o status dos clientes (ativos ou inativos) e a quantidade de clientes por status .
SELECT store_id, active, COUNT(active)
FROM customer
GROUP BY store_id, active
ORDER BY store_id;

3 - Monte uma query que exiba a média de duração por classificação indicativa ( rating ) dos filmes cadastrados na tabela sakila.film . Os resultados devem ser agrupados pela classificação indicativa e ordenados da maior média para a menor.
SELECT AVG(length) AS media, rating
FROM film
GROUP BY rating
ORDER BY media;

4 - Monte uma query para a tabela sakila.address que exiba o nome do distrito e a quantidade de endereços registrados nele. Os resultados devem ser ordenados da maior quantidade para a menor.
SELECT district, count(district) AS quantidade
FROM address
GROUP BY district
ORDER BY quantidade DESC;

Exibindo e filtrando dados de forma agrupada com GROUP BY e HAVING

Filtrando Resultados do GROUP BY com HAVING

Podemos usar o HAVING para filtrar resultados agrupados, assim como usamos o SELECT...WHERE para filtrar resultados individuais.

A query a seguir busca o nome e a quantidade de nomes cadastrados na tabela sakila.actor e os agrupa por quantidade. Por fim, filtramos os resultados agrupados usando o HAVING , para que somente os nomes que estão cadastrados duas ou mais vezes sejam exibidos.

SELECT first_name, COUNT(*)
FROM sakila.actor
GROUP BY first_name
HAVING COUNT(*) > 2;

-- Ou, melhor ainda, usando o AS para dar nomes às colunas de agregação,
-- melhorando a leitura do resultado
SELECT first_name, COUNT(*) AS nomes_cadastrados
FROM sakila.actor
GROUP BY first_name
HAVING nomes_cadastrados > 2;

-- Observação: o alias não funciona com strings para o HAVING,
-- então use o underline ("_") para separar palavras
-- Ou seja, o exemplo abaixo não vai funcionar
SELECT first_name, COUNT(*) AS 'nomes cadastrados'
FROM sakila.actor
GROUP BY first_name
HAVING `nomes cadastrados` > 2;

Brincando um pouco com o HAVING

1 - Usando a query a seguir, exiba apenas as durações médias que estão entre 115.0 a 121.50. Além disso, dê um alias (apelido) à coluna gerada por AVG(length) , de forma que deixe a query mais legível. Finalize ordenando os resultados de forma decrescente.

SELECT rating, AVG(length) AS 'media'
FROM sakila.film
GROUP BY rating
HAVING media >= 115.0 AND media <= 121.50
ORDER BY MEDIA DESC;

2 - Usando a query a seguir, exiba apenas os valores de total de substituição de custo que estão acima de $3950.50. Dê um alias que faça sentido para SUM(replacement_cost) , de forma que deixe a query mais legível. Finalize ordenando os resultados de forma crescente.

SELECT rating, SUM(replacement_cost) AS 't_subs_custo'
FROM sakila.film
GROUP by rating
HAVING t_subs_custo > 3950.50
ORDER BY t_subs_custo ASC;



Exercícios

Tempo sugerido para realização: 40 minutos

Exercício 1: Exercícios sobre funções de agregação neste link .
https://sqlbolt.com/lesson/select_queries_with_aggregates

1 - Find the longest time that an employee has been at the studio
SELECT MAX(Years_employed) FROM employees;

2 - For each role, find the average number of years employed by employees in that role
SELECT Role, AVG(Years_employed) FROM employees GROUP BY Role;


3 - Find the total number of employee years worked in each building
SELECT Building, SUM(Years_employed
) FROM employees GROUP BY Building;


With the Pixar database that you've been using, aggregate functions can be used to answer questions like, "How many movies has Pixar produced?", or "What is the highest grossing Pixar film each year?".

USE Pixar;

SELECT Movies.title, Movies.year, SUM(BoxOffice.domestic_sales + international_sales) AS Total FROM Movies
JOIN BoxOffice
ON BoxOffice.movie_id = Movies.id
GROUP BY Movies.id;



Exercício 2: Exercícios sobre funções de agregação parte 2 neste link .


https://sqlbolt.com/lesson/select_queries_with_aggregates_pt_2
1 - Find the number of Artists in the studio (without a HAVING clause)
SELECT COUNT(Building) FROM employees WHERE Building = '2W';

SELECT COUNT(Building) FROM employees WHERE Role = 'Artist';


2 - Find the number of Employees of each role in the studio
SELECT Role, COUNT(Role) FROM employees GROUP BY Role;

3 - Find the total number of years employed by all Engineers
SELECT Role, SUM(Years_employed) FROM employees WHERE Role = 'Engineer'; 


Restaure o banco de dados abaixo antes de continuar:
O banco de dados usado como base para os próximos exercícios pode ser restaurado usando este arquivo SQL .
Baixe o conteúdo do arquivo .sql linkado acima;
Copie todo o código SQL;
Abra o MySQL Workbench e abra uma nova janela de query;
Copie todo o código para dentro dessa janela;
Selecione todo o código usando Ctrl + a;
Execute o código teclando Ctrl + ENTER.

Exercício 3: Exercícios sobre funções de agregação parte 3 neste link .
https://www.w3resource.com/mysql-exercises/aggregate-function-exercises/

1. Write a query to list the number of jobs available in the employees table. Go to the editor
SELECT COUNT(DISTINCT job_id) 
FROM employees;

2. Write a query to get the total salaries payable to employees.
SELECT SUM(SALARY) FROM employees;

3. Write a query to get the minimum salary from employees table.
SELECT MIN(SALARY) FROM employees;

4. Write a query to get the maximum salary of an employee working as a Programmer. Go to the editor
SELECT JOB_ID, MAX(salary) FROM employees WHERE JOB_ID = 'IT_PROG';

5. Write a query to get the average salary and number of employees working the department 90.
SELECT AVG(SALARY), COUNT(*) FROM employees WHERE DEPARTMENT_ID = 90;

6. Write a query to get the highest, lowest, sum, and average salary of all employees. 
SELECT MAX(SALARY), MIN(SALARY), SUM(SALARY), AVG(SALARY) FROM employees;

7. Write a query to get the number of employees with the same job.
SELECT JOB_ID, COUNT(JOB_ID) FROM employees GROUP BY JOB_ID;

8. Write a query to get the difference between the highest and lowest salaries.
SELECT MAX(SALARY) - MIN(SALARY) AS DIFFERENCE FROM FROM employees;

9. Write a query to find the manager ID and the salary of the lowest-paid employee for that manager. 
SELECT manager_id, MIN(SALARY)
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id
ORDER BY MIN(salary) DESC;

10. Write a query to get the department ID and the total salary payable in each department.
SELECT department_id, SUM(salary) AS total
FROM employees
GROUP BY department_id;

11. Write a query to get the average salary for each job ID excluding programmer. 
SELECT job_id, AVG(salary) AS media
FROM employees
GROUP BY job_id
HAVING job_id <> 'IT_PROG';

ou 

SELECT job_id, AVG(salary) 
FROM employees 
WHERE job_id <> 'IT_PROG' 
GROUP BY job_id;

12 -Write a query to get the total salary, maximum, minimum, average salary of employees (job ID wise), for department ID 90 only.
SELECT job_id, SUM(salary), MAX(salary), MIN(salary), AVG(salary)
FROM employees 
WHERE department_id = 90;
GROUP BY job_id

13 - Write a query to get the job ID and maximum salary of the employees where maximum salary is greater than or equal to $4000
SELECT job_id, MAX(salary)
FROM employees
GROUP BY job_id
HAVING MAX(salary) >= 4000;

14. Write a query to get the average salary for all departments employing more than 10 employees.
SELECT department_id, AVG(salary), COUNT(*) AS Total_employees
FROM employees
GROUP BY department_id
HAVING Total_employees > 10;

Exercício 4: Exercícios sobre manipulação de strings neste link .
https://www.w3resource.com/mysql-exercises/string-exercises/

1. Write a query to get the job_id and related employee's id. Go to the editor
Partial output of the query :


job_id	Employees ID
AC_ACCOUNT	206
AC_MGR	        205
AD_ASST	200
AD_PRES	100
AD_VP	        101 ,102
FI_ACCOUNT	110 ,113 ,111 ,109 ,112
Sample table: employees

SELECT job_id, GROUP_CONCAT(employee_id, ' ')  'Employees ID' 
FROM employees
GROUP BY job_id;

2. Write a query to update the portion of the phone_number in the employees table, within the phone number the substring '124' will be replaced by '999'.
UPDATE employees
SET phone_number = replace(phone_number, '124', '999')
WHERE phone_number LIKE '%124%';

3. Write a query to get the details of the employees where the length of the first name greater than or equal to 8.
SELECT * FROM employees WHERE LENGTH(first_name) >= 8;

4. Write a query to display leading zeros before maximum and minimum salary. 
http://clubedosgeeks.com.br/banco-de-dados/funcao-lpad-em-sql-adicionando-zeros-a-esquerda#:~:text=Estou%20falando%20da%20fun%C3%A7%C3%A3o%20LPAD,string%20retornada%20na%20consulta%20SQL.

https://www.w3schools.com/sql/func_mysql_lpad.asp

SELECT LPAD(MAX(max_salary),7,'0'), LPAD(MAX(min_salary),7,'0')
FROM jobs;

5. Write a query to append '@example.com' to email field.
UPDATE employees SET email = CONCAT(email, '@example.com');

6. Write a query to get the employee id, first name and hire month.
SELECT employee_id, first_name, MONTH(hire_date)
FROM employees;

OU 

SELECT employee_id, first_name, MID(hire_date, 6,2)
FROM employees;

7. Write a query to get the employee id, email id (discard the last three characters). Go to the editor
SELECT REVERSE(MID(REVERSE('texto bem grande'),4)) AS teste;

8. Write a query to find all employees where first names are in upper case.
SELECT * 
FROM employees
WHERE first_name = UCASE(first_name);

OU 

SELECT * FROM employees 
WHERE first_name = BINARY UPPER(first_name);

9. Write a query to extract the last 4 character of phone numbers. 
SELECT RIGHT(phone_number,4) FROM employess;

10. Write a query to get the last word of the street address. 
SELECT SUBSTRING_INDEX(street_address AS 'last word'), ' ', -1) 
FROM locations

mysql> SELECT SUBSTRING_INDEX('OLHO NO LANCE MALANDRO', ' ', 1);
+---------------------------------------------------+
| SUBSTRING_INDEX('OLHO NO LANCE MALANDRO', ' ', 1) |
+---------------------------------------------------+
| OLHO                                              |
+---------------------------------------------------+
1 row in set (0.00 sec)

11. Write a query to get the locations that have minimum street length. 

SELECT * FROM address
WHERE LENGTH(address) <= (SELECT MIN(LENGTH(address)) FROM address);

ou 

SELECT * FROM address
WHERE LENGTH(address) >= (SELECT MAX(LENGTH(address)) FROM address);

12. Write a query to display the first word from those job titles which contains more than one words.
Sample table: jobs


Code:

SELECT job_title, SUBSTR(job_title,1, INSTR(job_title, ' ')-1)
FROM jobs;
Sample Output:

job_title	    				SUBSTR(job_title,1, INSTR(job_title, ' ')-1)
President	
Administration Vice President			Administration
Administration Assistant			Administration
Finance Manager					Finance
Accountant	
Accounting Manager				Accounting
Public Accountant				Public
Sales Manager					Sales
Sales Representative				Sales
Purchasing Manager				Purchasing
Purchasing Clerk				Purchasing
Stock Manager					Stock
Stock Clerk					Stock
Shipping Clerk					Shipping
Programmer	
Marketing Manager				Marketing
Marketing Representatives			Marketing
Human Resources Representative			Human
Public Relations Representative			Public

13. Write a query to display the length of first name for employees where last name contain character 'c' after 2nd position. Go to the editor
SELECT LENGTH(first_name)
FROM employees
WHERE last_name LIKE "_c%;