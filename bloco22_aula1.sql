Bloco 22 - Normalização e Modelagem de Banco de Dados

Você será capaz de:

Modelar um banco de dados;
Identificar entidades , atributos e relacionamentos ;
Construir um diagrama entidade-relacionamento (diagrama ER);
Criar um banco de dados;
Criar e modelar tabelas com base em um diagrama ER.


O problema - Catálogo de Álbuns

Suponha que seja necessário criar um banco de dados para armazenar informações sobre um catálogo de álbuns musicais. As informações a serem armazenadas sobre cada álbum são:

Título;
Preço;
Estilo Musical;
Canções.
Cada álbum também terá um artista, e cada artista pode produzir vários álbuns. As canções devem ter título e duração (em segundos).


Database Design - Como modelar um banco de dados

Existem alguns passos a serem seguidos durante a modelagem e criação de um banco de dados. Um fluxo bastante comum nesse processo consiste em:

--Identificar as entidades , atributos e relacionamentos com base na descrição do problema;
--Construir um diagrama entidade-relacionamento para representar as entidades encontradas no passo 1;
--Criar um banco de dados para conter suas tabelas;
--Criar e modelar tabelas tendo o diagrama do passo 2 como base.


A seguir você verá como realizar cada um desses passos.

1) Identificando entidades, atributos e relacionamentos

Primeiramente você deve identificar as entidades , atributos e relacionamentos com base na descrição do problema. Porém, antes disso é necessário entender o significado de cada um deles.
Entidades:
São uma representação de algo do mundo real dentro do banco de dados. Elas normalmente englobam toda uma ideia e são armazenadas em formato de tabelas em um banco de dados.
Antes de expandir o código a seguir: Volte à descrição do problema acima e busque identificar quais objetos devem se tornar entidades. Depois expanda o código abaixo para verificar.

Se sua interpretação foi diferente, não se preocupe. A maneira como você modelará o banco de dados varia de acordo com a sua escala.
Entidade 1: `Álbum`;
Entidade 2: `Artista`;
Entidade 3: `Estilo Musical`;
Entidade 4: `Canção`.

Se sua interpretação foi diferente, não se preocupe, você praticará mais hoje para que melhore essa percepção.

Álbum: `album_id`, `titulo`, `preco`, `estilo_id` e `artista_id`;
Artista: `artista_id` e `nome`;
Estilo Musical: `estilo_id` e `nome`;
Canção: `cancao_id`, `nome` e `album_id`.

Algo a ser notado aqui é que algumas informações precisam ser deduzidas, como, por exemplo, a coluna que armazena o identificador único dos registros (aqui chamado de id), que todas tabelas precisam ter.

Relacionamentos:

Os relacionamentos servem para representar como uma entidade deve estar ligada com outra(s) no banco de dados. Há três tipos de relacionamentos possíveis em um banco de dados, que são:

1:1
1:n ou n:1
n:n

exemplo 1:1

empregado           x                pagamento
id
nome
sobrenome
pagamentoid--------------------------pagamentoid
                                     salariomensal
                                     
Apesar de ser possível inserir essas informações em apenas uma tabela, esse tipo de relacionamento é usado normalmente quando se quer dividir as informações de uma tabela maior em tabelas menores, evitando que as tabelas tenham dezenas de colunas.

Relacionamento Um para Muitos ou Muitos para Um (1..N):

Esse é um dos tipos mais comuns de relacionamento. Em cenários assim, uma linha na Tabela A pode ter várias linhas correspondentes na Tabela B , mas uma linha da Tabela B só pode possuir uma linha correspondente na Tabela A . Veja o exemplo abaixo:

n:1
livro          x                  categoria
id
nome
categoriaid------------------------categoriaid
                                   nome
                                   

Nesse exemplo, uma categoria pode estar ligada a vários livros, embora um livro deva possuir apenas uma categoria.

Relacionamento Muitos para Muitos (N..N):

O relacionamento muitos para muitos acontece quando uma linha na Tabela A pode possuir muitas linhas correspondentes na Tabela B e vice-versa. Veja o exemplo abaixo:

            1:n             1:1                 n: 1

actor          x          film_actor           x            filme
id------------------------atorid
nome
                          filmid------------------------------id
                                                             nome
                                                             
Esse tipo de relacionamento pode ser visto também como dois relacionamentos um para muitos ligados por uma tabela intermediária, como é o caso da tabela filme_ator . Pode-se chamar essa tabela intermediária de tabela de junção . Ela é usada para guardar informações de como as tabelas se relacionam entre si. Desta maneira, quando se quer demonstrar que um filme pode contar com vários atores e também que os atores podem atuar em vários filmes, surge a necessidade de um relacionamento muitos para muitos.

Antes de expandir o código a seguir: Volte à estrutura de tabelas do Catálogo de Álbuns e tente identificar quais tipos de relacionamentos existem entre as tabelas. Escreva-os em algum lugar e depois expanda abaixo para ver os relacionamentos. Praticar essa habilidade é crucial.

              1:n             n:1                     n:1    
Estilo Musical  x  Cancao    x         Album:       x          Artista: 
                  `album_id`,---------`album_id`
                                       `titulo`,
                                       `preco`,
`estilo_id`----------------------------`estilo_id`
                                       `artista_id`------------`artista_id` 
                                                               `nome`
`nome`
                  `nome`                     
                  `cancao_id`                                        



Os relacionamentos identificados foram:

Um artista pode possuir um ou mais álbuns; ok
Um estilo musical pode estar contido em um ou mais álbuns; ok
Um álbum pode possuir uma ou mais canções. ok

2) Construindo um diagrama entidade-relacionamento

No segundo passo, será construído um diagrama entidade-relacionamento para representar as entidades encontradas no passo 1.

Existem diversas ferramentas para modelar os relacionamentos em um banco de dados. Hoje será usada a draw.io para criar os modelos. Você pode aprender como utilizar essa ferramenta assistindo a este vídeo.

www.draw.io

/coluna Entity Relation

Agora é preciso montar um diagrama de relacionamento básico que demonstra como uma entidade é relacionada com a outra, usando o modelo EntidadeA + verbo + EntidadeB .


Considerando as entidades Álbum , Artista , Estilo Musical e Canção , foi construído o seguinte diagrama:

O que você deve fazer quando estiver construindo seu próprio banco de dados é entender quantas vezes uma entidade pode se relacionar com uma outra, para, a partir disso, você poder criar esse primeiro diagrama, como o do exemplo acima, que mostra como as entidades estão relacionadas entre si.

CREATE DATABASES IF NOT EXISTS albuns;

CREATE TABLE Estilo_Musical(
  id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  nome VARCHAR(100) NOT NULL
);

CREATE TABLE Artista(
  id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  nome VARCHAR(100)
);

CREATE TABLE Album(
  id INTEGER PRIMARY KEY NOT NULL,
  titulo VARCHAR(100) NOT NULL,
  preco DOUBLE(6,2) NOT NULL,
  artista_id INTEGER NOT NULL,
  estilo_musical_id INTEGER NOT NULL,
  FOREIGN KEY (artista_id) REFERENCES Artista (id),
  FOREIGN KEY (estilo_musical_id) REFERENCES Estilo_Musical(id)  
);

CREATE TABLE Cancao(
  id INTEGER PRIMARY KEY NOT NULL,
  nome VARCHAR(100) NOT NULL,
  album_id INTEGER,
  FOREIGN KEY (album_id) REFERENCES Album(id)
);

Um zoológico precisa de um banco de dados para armazenar informações sobre os seus animais. As informações a serem armazenadas sobre cada animal são:
Nome;
Espécie;
Sexo;
Idade;
Localização. Cada animal também possui um cuidador, e cada cuidador pode ser responsável por mais de um animal. Além disso, cada cuidador possui um gerente, sendo que cada gerente pode ser responsável por mais de um cuidador. Siga os passos aprendidos no dia de hoje para modelar essa base de dados.

Espécie            Animal                              localizacao             cuidador            gerente
id(PK) INTEGER     id(PK) INTEGER NOT NULL              id(PK) NOT NULL        id(PK) NOT NULL     id(PK) AUTO_INCREMENT
nome NOT NULL      Nome VARCHAR(50)                     Nome VARCHAR(50)       Nome VARCHAR(50)    Nome VARCHAR(50) NOT NULL
                   Espécie_id(FK) INTEGER NULL                                 id_gerente(FK)
                   Sexo BOOLEAN(1) DEFAULT PARAMETER
                   Idade INTEGER NOT NULL
                   localizacao_id(FK) INTEGER NOT NULL
                   cuidador_id(FK)

TABLES
gerente
Espécie
localizacao
cuidador



CREATE DATABASE IF NOT EXISTS zoologico;

USE zoologico;

CREATE TABLE gerente(
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  Nome VARCHAR(50) NOT NULL
);

CREATE TABLE Especie(
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  Nome VARCHAR(50) NOT NULL
);

CREATE TABLE localizacao(
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  Nome VARCHAR(50) NOT NULL
);

CREATE TABLE cuidador(
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  Nome VARCHAR(50) NOT NULL,
  id_gerente INTEGER NOT NULL,
  FOREIGN KEY(id_gerente) REFERENCES gerente(id)
);

CREATE TABLE Animal(
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  Nome VARCHAR(50) NOT NULL,
  Sexo TINYINT(1) DEFAULT(1),
  Idade INTEGER NOT NULL,
  Especie_id INTEGER NOT NULL,
  cuidador_id INTEGER NOT NULL,
  localizacao_id INTEGER NOT NULL,
  FOREIGN KEY(Especie_id) REFERENCES Especie(id),
  FOREIGN KEY(cuidador_id) REFERENCES cuidador(id),
  FOREIGN KEY(localizacao_id) REFERENCES localizacao(id)
);
