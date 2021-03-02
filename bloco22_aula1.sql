-- Caso não tenha feito ainda, refaça o banco de dados albuns por conta própria, como está descrito na seção " Hora de mexer os dedos ".

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
id(PK) INTEGER     id(PK) INTEGER NOT NULL              id(PK) NOT NULL        id(PK) NOT NULL     id(PK) NOT NULL
nome NOT NULL      Nome VARCHAR(50)                     Nome VARCHAR(50)       Nome VARCHAR(50)    Nome VARCHAR(50)
                   Espécie_id(FK) INTEGER NULL                                 id_gerente(FK)
                   Sexo BOOLEAN(1) DEFAULT PARAMETER
                   Idade INTEGER NOT NULL
                   localizacao_id(FK) INTEGER NOT NULL
                   cuidador_id(FK)


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

