CREATE DATABASE libri_lattaruli;
USE libri_lattaruli;

CREATE TABLE `autori` (
    `codice` char(20) PRIMARY KEY,
    `nome` text(20) NOT NULL,
    `cognome` text(20) NOT NULL
);

CREATE TABLE `libri`(
   `codice` char(20) PRIMARY KEY,
   `titolo` text(15) NOT NULL,
   `sottotitolo` text(20) NOT NULL,
   `autore` char(20),
   FOREIGN KEY (autore) REFERENCES autori(codice)
);