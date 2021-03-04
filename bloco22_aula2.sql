Aula 2 Bloco 22 - Normalização e Modelagem de Banco de Dados

A normalização evita desperdícios de espaço e garante bancos mais simples de se entender e manter! Seu conhecimento diferencia os profissionais iniciantes dos profissionais mais experientes, além de agregar mais valor a nossos futuros projetos.

Entender o que é a normalização
Saber discernir se uma tabela está ou não normalizada
Aplicar a 1ª Forma Normal
Aplicar a 2ª Forma Normal
Aplicar a 3ª Forma Norma
Aprender a criar e restaurar backups usando o MySQL Workbench e também o comando dump ;

Por que isso é importante?

Os conceitos de normalização permitem que você aprofunde seus conhecimentos nas estruturas relacionais fundamentais, o que colabora para a tomada de decisões mais assertivas e seguras. Essa confiança será importantíssima no momento de fazer modificações em estruturas de bancos de dados existentes ou criar novas estruturas do zero.

O que é a Normalização?
Para que você possa ter uma ideia do que é e de como funciona a normalização, assista ao vídeo abaixo:
Obs.: É recomendado assistir a todos os vídeos em sequência.

QUAIS OS PROBLEMAS DA REDUNDÂNCIA DE DADOS?

* tabelas ocupando espaços desnecessários;
* anomalia de inserção;
* anomalia de atualização;
* anomalia de exclusão;

COMO NORMALIZAR?
resolver estes problemas...

separar os dados relacionados em tabelas diferentes.
integridade de dados
redução de espação gasto no banco de dados.

**************
1ª Forma Normal

Para iniciar a organização de um banco de dados, devemos nos atentar para a primeira forma normal - base de todas as outras. Seus preceitos são:

regras:
as tabelas devem ser escaláveis(preparadas para grande quantidades de dados)

as tabelas devem ser extensíveis(mudanças não devem quebrar a integridade dos dados)
**************************************
Colunas devem possuir apenas um valor
Valores em uma coluna devem ser do mesmo tipo de dados
Cada coluna deve possuir um nome único
A ordem dos dados registrados em uma tabela não deve afetar a integridade dos dados
**************************************


**************
2ª Forma Normal
Para a Segunda Forma Normal , devemos atentar para o seguinte:

***********************************
A tabela deve estar na 1ª Forma Normal
A tabela não deve possuir dependências parciais.
**************************************

Uma dependência parcial pode ser considerada como qualquer coluna que não depende exclusivamente da chave primária da tabela para existir.

Por exemplo, considere uma tabela Pessoa Estudantes que possui as seguintes colunas

id	nome	data_matricula	curso
1	Samuel	2020-09-01	Física
2	Joana	2020-08-15	Biologia
3	Taís	2020-07-14	Contabilidade
4	André	2020-06-12	Biologia

A coluna curso pode ser considerada uma dependência parcial pois poderiámos mover os valores dessa coluna para uma outra tabela e os dados dessa tabela podem existir independente de existir uma pessoa estudante vinculada a esse curso ou não. Dessa forma depois de normalizar teríamos duas tabelas:

Cursos
id	nome
1	Física
2	Biologia
3	Contabilidade

Pessoas Estudantes
id	nome	data_matricula	curso_id
1	Samuel	2020-09-01	1
2	Joana	2020-08-15	2
3	Taís	2020-07-14	3
4	André	2020-06-12	2

Dessa forma, aplicamos a segunda forma normal na tabela Pessoas Estudantes .

Lembre-se que a função da normalização não é necessariamente reduzir o número de colunas mas remover redundâncias e possíveis anomalias de inclusão/alteração ou remoção.

**************
3ª Forma Normal

Por fim, a Terceira Forma Normal estabelece que:

A tabela deve estar na 1ª e 2ª Formas Normais;
A tabela não deve conter atributos (colunas) que não sejam totalmente dependentes na PK (chave primária).

***********************************

Exercícios de fixação - normalização de dados

Vamos consolidar toda a explicação passada até o momento através de alguns desafios.

Exercício 1: Normalize a tabela a seguir para a 1ª Forma Normal.
Não se preocupe em montar a estrutura em código SQL neste primeiro momento. Crie apenas uma planilha (Excel, Google Sheets, Open Office Calc ou semelhantes) da estrutura esperada.

Funcionario_id	Nome	   Sobrenome	Contato	         Contato	     DataCadastro	  Setor
12	       Joseph	   Rodrigues	jo@gmail.com	         (35)998552-1445    2020-05-05 08:50:25 Administração, Vendas
13	       André	   Freeman	andre1990@gmail.com     (47)99522-4996     5 de Fevereiro de 2020	Operacional
14	       Cíntia	   Duval	cindy@outlook.com       (33)99855-4669     2020-05-05 10:55:35  Estratégico, Vendas
15	       Fernanda   Mendes	fernandamendes@yahoo.com(33)99200-1556     2020-05-05 11:45:40  Marketing

******************
primera fase normal
*******************
Colunas devem possuir apenas um valor
Valores em uma coluna devem ser do mesmo tipo de dados
Cada coluna deve possuir um nome único
A ordem dos dados registrados em uma tabela não deve afetar a integridade dos dados

Funcionario_id	 Nome	   Sobrenome	Email	        Contato	    DataCadastro	 NomeSetor
2	       Joseph	   Rodrigues	jo@gmail.com	(35)998552-1445    2020-05-05 08:50:25 Administração
2	       Joseph	   Rodrigues	jo@gmail.com	(35)998552-1445    2020-05-05 08:50:25 Vendas


Exercício 2: Usando a estrutura (já normalizada para 1ª Forma Normal) da tabela anterior, transforme-a agora na 2ª Forma Normal.
******************
segunda fase normal
*******************
A tabela deve estar na 1ª Forma Normal
A tabela não deve possuir dependências parciais.
Uma dependência parcial pode ser considerada como qualquer coluna que não depende exclusivamente da chave primária da tabela para existir.

tabela setor
id        Nome
1               Administração 
2               Vendas
3               Operacional
4               Marketing
5               Estratégico

tabela funcionário
id	       Nome	   Sobrenome	Email	        Contato	    DataCadastro	 
2	       Joseph	   Rodrigues	jo@gmail.com	(35)998552-1445    2020-05-05 08:50:25 
2	       Joseph	   Rodrigues	jo@gmail.com	(35)998552-1445    2020-05-05 08:50:25 

Exerício 3: Monte uma query que:

Crie um banco de dados chamado normalization ;
CREATE DATABASE normalization;

Crie todas as tabelas resultantes do exercício 2 (na 2ª Forma Normal);
CREATE TABLE setor(
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(100) NOT NULL
);


CREATE TABLE funcionario(
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  Nome VARCHAR(60) NOT NULL,
  Sobrenome VARCHAR(100) NOT NULL,
  Email VARCHAR(100) NOT NULL,
  Contato VARCHAR(50) NOT NULL,
  DataCadastro DATETIME NOT NULL
);

Popule todas as tabelas com os dados fornecidos nos exercícios.

DUMP

Como criar um dump de um banco de dados com o MySQL Workbench

Abra o MySQL Workbench e conecte-se ao seu servidor local.
Clique na aba Administration e selecione Data Export .

Para exportar schema e/ou dados, siga as instruções abaixo:
Escolha quais bancos de dados devem ser incluídos no backup;
Escolha quais tabelas deve ser incluídas no backup;
Escolha se Stored Procedures e Stored Functions devem ou não ser incluídas;
Escolha se gostaria de exportar apenas estrutura ( Structure Only ), apenas os dados ( Data Only ) ou ambos ( Structure and Data );
Escolha se gostaria de incluir os triggers no arquivo de backup;
Escolha se gostaria de incluir o esquema (código para criar banco de dados. Ex.: CREATE DATABASE );
Selecione o local para onde exportar o arquivo.

VIA CONSOLE

https://www.devmedia.com.br/backup-no-mysql-com-mysqldump-parte-1/7483

como utilizar o MySQLDUMP em linha de comando

Funcionamento

Com este utilitário, você pode copiar, uma ou mais tabelas, um banco de dados inteiro ou todos os bancos de dados do servidor. Lembrando que este funciona em linha de comando e é o que utilizaremos nos exemplos.

Um detalhe interessante para casos que ocorram acidentes com o hardware ou qualquer outro problema e também para minimizar a perda de informações, é interessante que o comando FLUSH LOGS seja emitido ao efetuarmos o backup. Isso garante que um novo log seja criado e no caso de um backup on-line, as informações concorrentes ao backup sejam colocadas em logs separados, ou seja, além do backup você ainda terá os logs e poderá sincronizá-los no momento do restore. A leitura de logs para sincronia será apresentada em um outro artigo, onde falaremos do utilitário MySQLBINLOG.

mysql> flush logs;
Você deve utilizar o comando FLUSH se desejar limpar algum dos caches internos que o MySQL usa. Para executar FLUSH , você deve ter o privilégio RELOAD. Esvazia as tabelas de cache de nomes de máquinas.


shell> mysqldump -u <usuario> -p<senha> mysql > mysql.sql


O comando acima, copia o banco de dados mysql para o diretório raiz do usuário atual do sistema operacional. Para verificarmos a existência do arquivo e o seu conteúdo, no Windows, digite "dir" para listar os arquivos e em seguida "edit mysql.sql" , no Linux, “ls mysql.sql” e em seguida "cat mysql.sql".

Mas aí, a pergunta que não quer calar: "E seu eu quiser copier para o backup mais de uma tabela?"  E só você digitar os nomes das tabelas em sequência como no exemplo abaixo:

shell> mysqldump -u <usuario> -p<senha> mysql user db func > mysqltables.sql


Bom, vamos restaurar nosso backup. Basta que redirecionemos a entrada padrão para o mysql, como segue:




VIA TERMINAL 

mysql -u root -psuasenhapassword

***********************
mostra os bancos de dados
***********************
show databases;

***********************
entrar no banco de dados
***********************
use nomedobancodedados;

******************
mostra as tabelas
*****************
show tables;

************************
mostra os campos da tabela e o tipo de cada colunas
*************************
describe nomedatabelas;

DUMP
************
fazer backup - DDL e DML
*************
mkdir backup
cd backup
mysqldump -u root -psuasenhapassword nomedobancodedados > nomedobancodedados.sql;

exemplo:
mysqldump -u root -p sakila > /home/vitor/sakila.sql;
NOTA: aqui faz da estrutura, dados e gatilhos


SOMENTE A ESTRUTURA
**************************************************
mysqldump -u root -psuasenhapassword --no-data sakila > estruturasakila.sql;

SOMENTE OS DADOS
**************************************************
mysqldump -u root -p --no-create-info sakila > dadossakila.sql

SOMENTE procedimentos / funções / gatilhos
*******************************************
ex:
mysqldump -u root -p --routines --no-create-info --no-data --no-create-db --skip-opt sakila > /home/vitor/outputfile.sql

e isso salvará apenas os procedimentos / funções / gatilhos do . Se precisar importá-los para outro banco de dados / servidor, você terá que executar algo como:

mysql -u root -p <database> < outputfile.sql



***************************
recuperar o banco de dados
***************************

1 etapa(deletar database)
acessar o sql
drop databases nomedobancodedados;

*****************************
2 - etapa(criar database)
no arquivo .sql
create database nomedobancodedados;
use nomedobancodedados;

bash#
mysqldump -u root -psuasenhapassword nomedobancodedados < nomedobancodedados.sql;

ex:
mysqldump -u root -p sakila < sakila.sql;

https://www.ducea.com/2007/07/25/dumping-mysql-stored-procedures-functions-and-triggers/


Exercícios de fixação - dump

Selecione um dos bancos de dados já existentes no seu servidor local ( w3schools , northwind , sakila , hr etc.) e faça os passos a seguir:

Exporte a estrutura e os dados (tabelas, triggers, procedures, functions e o schema ) para um dump em formato de arquivo SQL, como foi exibido nas instruções anteriores. Faça o dump através da linha de comando e usando o MySQL Workbench .

Agora, a prática:
Os exercícios abaixo estão disponibilizados em arquivos no formato Excel (.xlsx). Eles podem ser abertos em softwares livres como Google Sheets, Open Office e Libre Office. Não é necessário montar queries para resolver os exercícios. Crie novas planilhas com suas respostas.

Exercício 1: Converta esta tabela para a 1ª Forma Normal. Após tentar resolver, consulte aqui a resposta.
cliente_id	nome_cliente	Item	Endereco	Assinaturas	Fornecedor	ContatoFornecedor	Preco
1	          Doren Fatima	Xbox	Rua Norte Sul, 35, Belo Horizonte	LancamentosXbox	Microsoft	47-99855-6995	1850
2	          Ramon Jonathan	PlayStation	Av Rodrigues Ramos, 950 Bahia	LancamentosPlayStation	Sony	33-5259-79855	2100
3	          Vanderson Judis	Xbox	Rua Brusque 352, Ipatinga	LancamentosXbox	Microsoft	47-99855-6995	1850
3	          Vanderson Judis	PlayStation	Rua Brusque 352, Ipatinga	LancamentosPlayStation	Sony	33-5259-79855	2100
4	          Carolina Rude	PlayStation	Av Atlantica, 254, Camboriú	LancamentosPlayStation	Sony	33-5259-79855	2100



Exercício 2: Converta a tabela construída no exercício anterior (que já deve estar na 1ª Forma Normal) para a 2ª Forma Normal. Após tentar resolver, consulte aqui aqui a resposta.

cliente_id	nome_cliente	       Endereco	                           Assinaturas
1	          Doren Fatima	       Rua Norte Sul, 35, Belo Horizonte	 LancamentosXbox
2	          Ramon Jonathan	     Av Rodrigues Ramos, 950 Bahia	     LancamentosPlayStation
3	          Vanderson Judis	     Rua Brusque 352, Ipatinga	         LancamentosXbox
3	          Vanderson Judis	     Rua Brusque 352, Ipatinga	         LancamentosPlayStation
4	          Carolina Rude	       Av Atlantica, 254, Camboriú	       LancamentosPlayStation

cliente_id	item
1	          Xbox
2	          PlayStation
3         	Xbox
3	          PlayStation
4	          PlayStation

Item	       Fornecedor	  ContatoFornecedor	Preco
Xbox	       Microsoft	   47-99855-6995	  1850
PlayStation	 Sony	         33-5259-79855	  2100


Exercício 3: Agora, converta essa nova tabela (que já deve estar na 2ª Forma Normal) para a 3ª Forma Normal. Após tentar resolver, consulte aqui a resposta.
table
cliente_id	nome_cliente	       Endereco	               Municipio             
1	          Doren Fatima	       Rua Norte Sul, 35       Belo Horizonte	       
2	          Ramon Jonathan	     Av Rodrigues Ramos, 950 Bahia	               
3	          Vanderson Judis	     Rua Brusque 352,        Ipatinga	             
4	          Carolina Rude	       Av Atlantica, 254,      Camboriú	             

table
id_cliente_assinatura      cliente_id    assinaturas_id
1                              1             1
2                              2             2
3                              3             1
4                              3             2
5                              4             2

table
assinaturas_id   Assinaturas               console_id            
1                LancamentosXbox           1 
2                LancamentosPlayStation2   2

table
console_id	item
1	          Xbox
2	          PlayStation

table
Item	       Fornecedor	  ContatoFornecedor	Preco
Xbox	       Microsoft	   47-99855-6995	  1850
PlayStation	 Sony	         33-5259-79855	  2100

Exercício 4: Converta para a 3ª Forma Normal a tabela deste exercício do site Gitta .

http://www.gitta.info/LogicModelin/en/html/DataConsiten_selfAssessment5.html

A tabela a seguir já está na primeira forma normal (1NF). Existe apenas uma entrada por campo. Converta esta tabela para a terceira forma normal (3NF) usando as técnicas que você aprendeu nesta unidade. Escreva um breve relatório sobre sua solução e publique-o no quadro de discussão. Verifique as outras soluções e comente-as, se necessário. Se você tiver dúvidas, também pode publicá-las no fórum de discussão. Um tutor examinará as perguntas regularmente e dará feedback e respostas.

Uma mesa com os alunos e suas notas nos diversos temas.

UnitID	StudentID	Date	    TutorID	Topic	Room	Grade	Book	     TutEmail
U1	    St1	      23.02.03	Tut1	  GMT	  629	  4.7	  Deumlich	 tut1@fhbb.ch
U2	    St1	      18.11.02	Tut3	  GIn	  631	  5.1	  Zehnder	   tut3@fhbb.ch
U1	    St4	      23.02.03	Tut1	  GMT	  629	  4.3	  Deumlich	 tut1@fhbb.ch
U5	    St2	      05.05.03	Tut3	  PhF	  632	  4.9	  Dümmlers	 tut3@fhbb.ch
U4	    St2	      04.07.03	Tut5	  AVQ	  621	  5.0	  SwissTopo	 tut5@fhbb.ch

