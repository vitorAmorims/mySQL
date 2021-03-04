Bloco 22 - Normalização e Modelagem de Banco de Dados

aula 3 

Clonar tabelas existentes;
Lidar com VIEWs ;
Alterar tabelas existentes;
Deletar uma tabela;
Usar um INDEX .

*************************
Clonar tabelas existentes
************************
Antes de trabalhar com a alteração ou manipulação de tabelas existentes, existe uma operação que é extremamente útil e simples: clonar tabelas.

Para clonar uma tabela, é preciso fazer apenas um comando:

-- Sintaxe:
CREATE TABLE nome_para_nova_tabela LIKE tabela_a_ser_clonada;

-- Exemplo:
CREATE TABLE actor_clone LIKE sakila.actor;

Ao fazer isso, você terá criado uma tabela com a estrutura exatamente igual (chave primária, chave estrangeira, tipos, restrições etc.) usando apenas uma linha de código!


****************Pontos de Atenção*********************
Esse comando não copia os dados, apenas a estrutura;

Caso não especifique qual banco de dados utilizar, a nova tabela será inserida no banco que estiver ativo no momento da execução. Sendo assim, sempre especifique o banco de dados antes.

USE nome_do_banco_de_dados;
CREATE TABLE nome_para_nova_tabela LIKE tabela_a_ser_clonada;

Caso não especifique qual banco de dados utilizar, a nova tabela será inserida no banco que estiver ativo no momento da execução. Sendo assim, sempre especifique o banco de dados antes.

Dê um pause aqui na lição e clone alguma tabela do banco de dados sakila para ver na prática o resultado do comando acima.

CREATE TABLE actor_clone LIKE actor;

*************IMPORTANTE************
NESTE CASO, PODEMOS USAR A COPIA DOS DADOS DA TABELA ORIGEM PARA UM ARQUIVO, E POSTERIOR INSERIR OS DADOS DA TABELA ORIGEM NA TABELA CLONE.
COMANDO:

MYSQLDUMP -u root -p --no-create-info livros tabela1 tabela2 tabela3 > backup.sql

copiei os dados da tabela origem, renomeei para novatabela e rodei o insert no workbench

*********************************
O que é e como lidar com uma VIEW

Uma VIEW é nada mais nada menos que uma tabela temporária no seu banco de dados, que pode ser consultada como qualquer outra. Porém, por ser uma tabela temporária, ela é criada a partir de uma query que você definir.

Uma VIEW te permite:
*Ter uma tabela que pode ser usada em relatórios;
*Ter uma tabela para usar como base para montar novas queries;
*Reduzir a necessidade de recriar queries utilizadas com frequência.

Anatomia de uma VIEW

USE nome_do_banco_de_dados; -- Defina em qual banco a view será criada
CREATE VIEW nome_da_view AS query;
***********************************
Um exemplo de uso

Suponha que a gerência quer ter uma maneira simples para sempre saber quem são os top 10 clientes que mais compram com a empresa. Pode-se criar uma view para resolver isso!

CREATE VIEW top_10_customers AS
    SELECT c.customer_id, c.first_name, SUM(p.amount) AS total_amount_spent
    FROM sakila.payment p
    INNER JOIN sakila.customer c ON p.customer_id = c.customer_id
    GROUP BY customer_id
    ORDER BY total_amount_spent DESC
    LIMIT 10;
    

Para excluir uma VIEW , use o seguinte comando:
DROP VIEW nome_da_view;

********************************************
Tudo que você deve saber sobre o ALTER TABLE
********************************************
Algo extremamente comum durante o ciclo de desenvolvimento de software é a necessidade constante de fazer melhorias na estrutura do banco de dados. As tabelas são uma dessas estruturas que são alteradas com frequência.
Ao executar o bloco de código abaixo, a tabela noticia será criada. Essa tabela será utilizada como exemplo para testar modificações em sua estrutura.

USE sakila;
CREATE TABLE noticia(
    noticia_id INT PRIMARY KEY,
    titulo VARCHAR(100),
    historia VARCHAR(300)
) engine = InnoDB;

-- Adicionar uma nova coluna
ALTER TABLE noticia ADD COLUMN data_postagem date NOT NULL;

-- Modificar o tipo e propriedades de uma coluna
ALTER TABLE noticia MODIFY noticia_id BIGINT;

-- Adicionar incremento automático a uma coluna
-- (especifique o tipo da coluna + auto_increment)
ALTER TABLE noticia MODIFY noticia_id BIGINT auto_increment;

-- Alterar o tipo e nome de uma coluna
ALTER TABLE noticia CHANGE historia conteudo_postagem VARCHAR(1000) NOT NULL;

-- Dropar/Excluir uma coluna
ALTER TABLE noticia DROP COLUMN data_postagem;

-- Adicionar uma nova coluna após outra
ALTER TABLE noticia ADD COLUMN data_postagem DATETIME NOT NULL AFTER titulo;

**************************
DROPando uma tabela
**************************
DROP TABLE nome_da_tabela;

Ponto Importante

Você não conseguirá dropar (excluir) uma tabela que é referenciada por uma restrição de chave estrangeira. A chave estrangeira ou a tabela que a contém deve ser excluída antes.

Por exemplo, tente dropar a tabela sakila.language com o comando abaixo:

DROP TABLE sakila.language;

Ao executar o comando, você verá que ele não funciona, retornando a seguinte mensagem de erro:

Error Code: 3730. Cannot drop table 'language' referenced by a foreign key constraint 'fk_film_language' on table 'film'

Isso acontece em função de as informações da tabela language serem utilizadas na tabela film . Caso tente dropar a tabela film , você perceberá que ela também possui restrições. Essas restrições estão relacionadas ao conceito de integridade referencial , que deve ser considerado quando se cria um banco de dados. Elas têm o intuito de evitar que tabelas sejam excluídas acidentalmente.
Integridade referencial : Propriedade que afirma que todas as referências de chaves estrangeiras devem ser válidas.

Em primeiro lugar, descubra o nome da FOREIGN KEY  e qual tabela possui o relacionamento:

SELECT
  TABLE_NAME,
  COLUMN_NAME,
  CONSTRAINT_NAME,
  REFERENCED_TABLE_NAME,
  REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE
  REFERENCED_TABLE_NAME = 'My_Table'; --substitua My_Table pela nome de sua tabela.

E então você pode remover a restrição nomeada da seguinte maneira:

ALTER TABLE My_Table DROP FOREIGN KEY My_Table_Constraint;
Referências: 1 e 2 .

exemplo:

mysql> describe gerente;
+-------+-------------+------+-----+---------+----------------+
| Field | Type        | Null | Key | Default | Extra          |
+-------+-------------+------+-----+---------+----------------+
| id    | int         | NO   | PRI | NULL    | auto_increment |
| Nome  | varchar(50) | NO   |     | NULL    |                |
+-------+-------------+------+-----+---------+----------------+
2 rows in set (0.01 sec)

mysql> describe cuidador;
+------------+-------------+------+-----+---------+----------------+
| Field      | Type        | Null | Key | Default | Extra          |
+------------+-------------+------+-----+---------+----------------+
| id         | int         | NO   | PRI | NULL    | auto_increment |
| Nome       | varchar(50) | NO   |     | NULL    |                |
| id_gerente | int         | NO   | MUL | NULL    |                |
+------------+-------------+------+-----+---------+----------------+
3 rows in set (0.01 sec)

mysql> SELECT
    ->   TABLE_NAME,
    ->   COLUMN_NAME,
    ->   CONSTRAINT_NAME,
    ->   REFERENCED_TABLE_NAME,
    ->   REFERENCED_COLUMN_NAME
    -> FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
    -> WHERE
    ->   REFERENCED_TABLE_NAME = 'cuidador';
+------------+-------------+-----------------+-----------------------+------------------------+
| TABLE_NAME | COLUMN_NAME | CONSTRAINT_NAME | REFERENCED_TABLE_NAME | REFERENCED_COLUMN_NAME |
+------------+-------------+-----------------+-----------------------+------------------------+
| Animal     | cuidador_id | Animal_ibfk_2   | cuidador              | id                     |
+------------+-------------+-----------------+-----------------------+------------------------+
1 row in set (0.06 sec)

mysql> SELECT   TABLE_NAME,   COLUMN_NAME,   CONSTRAINT_NAME,   REFERENCED_TABLE_NAME,   REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE WHERE   REFERENCED_TABLE_NAME = 'gerente';
+------------+-------------+-----------------+-----------------------+------------------------+
| TABLE_NAME | COLUMN_NAME | CONSTRAINT_NAME | REFERENCED_TABLE_NAME | REFERENCED_COLUMN_NAME |
+------------+-------------+-----------------+-----------------------+------------------------+
| cuidador   | id_gerente  | cuidador_ibfk_1 | gerente               | id                     |
+------------+-------------+-----------------+-----------------------+------------------------+
1 row in set (0.04 sec)

***************************************************
Como usar um INDEX
***************************************************
Quando se fala em otimização de queries, o termo índice (ou INDEX ) pode vir a ser mencionado como solução para problemas de performance. Mas o que são índices, e quando se deve usá-los?
***************************************************
Como usar um INDEX
***************************************************
Quando se fala em otimização de queries, o termo índice (ou INDEX ) pode vir a ser mencionado como solução para problemas de performance.
Mas o que são índices, e quando se deve usá-los?

Uma maneira de estruturar os dados de uma maneira mais eficiente para que sejam encontrados mais rapidamente.

*******
tipos

primary key
Unique - podemos colocar em várias colunas
index - recebe valor numerico.
fulltext index - para fazer busca dentro de um texto grande
******

*********Criar INDEX depois da tabela criada:

CREATE INDEX nome_index ON tabela(coluna);
CREATE FULLTEXT INDEX nome_index ON tabela(coluna);


*********Criar INDEX ao criar tabela:
ex:
CREATE DATABASE pizzaria;
USE pizzaria;

CREATE TABLE pizzas(
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  sabor VARCHAR(100),
  preco DECIMAL(5,2),
  INDEX sabor_index(sabor)
);

*********Criar INDEX alterando uma tabela:
ALTER TABLE nome_tabela ADD INDEX nome_index(nome_coluna);

******************
******************
pontos positivos:
******************
*acelera queries select
*permite tornar uma coluna com valores únicos(unique)
*permite buscar em grandes pedaços de texto(fulltext index)
*aceleram as operacões de update quando usam where

******************
******************
pontos negativos:
******************
*ocupam espaço em disco
*tornam lentas as operacoes de insert, update, delete, porque cada indice precisa ser atualizado junto com os dados.

**************************
quais os campos que estão como indice
SHOW INDEX FROM nomedatabela;

exemplo:
CREATE FULLTEXT INDEX description_index ON film(description);

SELECT * FROM sakila.film
WHERE description LIKE "%a fanciful documentary%"; --9 ROWS 0.01S

******************************************************************
USANDO
MATH(coluna que possui o indice) AGAINST('"texto que quero procurar"') -- busca precisa
MATH(coluna que possui o indice) AGAINST("texto que quero procurar") -- busca precisa
SELECT * FROM sakila.film
WHERE MATCH (description) AGAINST('"a fanciful documentary"'); --9ROWS 0.01S

Agora, a prática:

Desafios sobre VIEW

Crie uma view chamada film_with_categories utilizando as tabelas category , film_category e film do banco de dados sakila . Essa view deve exibir o título do filme, o id da categoria e o nome da categoria, conforme a imagem abaixo. Os resultados devem ser ordenados pelo título do filme.

CREATE VIEW film_with_categories AS
SELECT film.title, film_category.category_id, category.name
FROM film
JOIN film_category
ON film_category.film_id = film.film_id
JOIN category
ON film_category.category_id = category.category_id
ORDER BY film.title;

Crie uma view chamada film_info utilizando as tabelas actor , film_actor e film do banco de dados sakila . Sua view deve exibir o actor_id , o nome completo do ator ou da atriz em uma coluna com o ALIAS actor e o título dos filmes. Os resultados devem ser ordenados pelos nomes de atores e atrizes. Use a imagem a seguir como referência.

CREATE VIEW film_info AS
SELECT film_actor.actor_id, CONCAT(actor.first_name, ' ', actor.last_name) AS actor, film.title
FROM film_actor
JOIN actor
ON film_actor.actor_id = actor.actor_id
JOIN film
ON film_actor.film_id = film.film_id
ORDER BY actor;

Crie uma view chamada address_info que faça uso das tabelas address e city do banco de dados sakila . Sua view deve exibir o address_id , o address , o district , o city_id e a city . Os resultados devem ser ordenados pelo nome das cidades. Use a imagem abaixo como referência.

CREATE VIEW address_info AS
SELECT address.address_id, address.address, address.district, address.city_id, city.city
FROM address
JOIN city
ON address.city_id = city.city_id
ORDER BY city.city;

Crie uma view chamada movies_languages , usando as tabelas film e language do banco de dados sakila . Sua view deve exibir o título do filme , o id do idioma e o idioma do filme , como na imagem a seguir.

CREATE VIEW movies_languages AS
SELECT film.title, language.language_id, language.name
FROM language
JOIN film
ON film.language_id = language.language_id;

Desafios sobre INDEX

Verifique o impacto de um FULLTEXT INDEX na tabela category (banco de dados sakila ), adicionando-o na coluna name . Após ter adicionado o índice, mensure o custo da query utilizando o execution plan, como já foi feito em lições anteriores. Após ter criado e mensurado o custo da query, exclua o índice e mensure novamente esse custo.


CREATE FULLTEXT INDEX category_name_index ON category(name);

-- Após ter criado o índice, mensure o custo com a seguinte query:
SELECT *
FROM sakila.category
WHERE MATCH(name) AGAINST('action');

DROP INDEX category_name_index ON category;

-- Após ter excluído o índice, mensure o custo com a seguinte query:
SELECT *
FROM sakila.category
WHERE name LIKE '%action%';

Verifique o impacto de um INDEX na tabela address (banco de dados sakila ) adicionando-o na coluna postal_code . Após ter adicionado o índice, mensure o custo da query utilizando o execution plan, como já foi feito em lições anteriores. Após ter criado e mensurado o custo da query, exclua o índice e mensure novamente esse custo.


CREATE FULLTEXT INDEX address_postal_code  ON address(postal_code);

-- Após ter criado o índice, mensure o custo com a seguinte query:
SELECT *
FROM sakila.address
WHERE MATCH(postal_code) AGAINST('10714'); --1 row 0.00s

DROP INDEX address_postal_code ON address;

-- Após ter excluído o índice, mensure o custo com a seguinte query:
SELECT *
FROM sakila.address
WHERE postal_code LIKE '%10714%'; --1 row 0.00s

Desafios sobre ALTER TABLE

Restaure o banco de dados HR abaixo antes de continuar, caso não o tenha restaurado em alguma lição anterior:
O banco de dados usado como base para os próximos exercícios pode ser restaurado através deste arquivo SQL.
ok
Baixe o conteúdo do arquivo .sql linkado acima;
ok
Copie todo o código SQL;
ok
Abra o MySQL Workbench e abra uma nova janela de query;
ok
Cole o SQL para dentro dessa janela;
ok
Selecione todo o código usando CTRL + A;
ok
Execute-o teclando CTRL + ENTER.
ok


Desafios:

Escreva uma query SQL para alterar o nome da coluna street_address para address , mantendo o mesmo tipo e tamanho de dados.
exemplo
USE hr;
ALTER TABLE employees CHANGE salary salary_new double(7,2);
ALTER TABLE employees CHANGE salary_new salary double(7,2);
ALTER TABLE employees CHANGE salary salary_new decimal(8,2);
ALTER TABLE employees CHANGE salary_new SALARY decimal(8,2);


Escreva uma query SQL para alterar o nome da coluna region_name para region , mantendo o mesmo tipo e tamanho de dados.
REGION_NAME varchar(25)
ALTER TABLE regions CHANGE REGION_NAME region VARCHAR(25);


Escreva uma query SQL para alterar o nome da coluna country_name para country , mantendo o mesmo tipo e tamanho de dados.

--countries.COUNTRY_NAME VARCHAR(40)
ALTER TABLE countries CHANGE COUNTRY_NAME country VARCHAR(40);