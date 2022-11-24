DROP DATABASE IF EXISTS TeG_lattaruli;

/*
================= PREMESSE =============
si è deciso, per alcune colonne,di utilizzare varchar, in quanto
i valori di tali campi potrebbero avere lunghezza variabile

*/

CREATE DATABASE TeG_lattaruli;
use TeG_lattaruli;

-- tabella testate
CREATE TABLE testate(
    idTestata char(4) PRIMARY KEY,
    nome varchar(20) NOT NULL,
    /* 
        possibile chiave esterna mancanate verso "redazioni"
        se così fosse testate.redazione sarebbe una chiave esterna verso 
        redazioni.idRedazione, in sintassi:
    
        FOREIGN KEY (redazione) REFERENCES redazioni(idRedazione)
    */
    redazione char(4) NOT NULL
);

-- tabella redattori
CREATE TABLE redattori(
    idRedattori char(3) PRIMARY KEY,
    cognome varchar(10) NOT NULL,
    nome varchar(8) NOT NULL,
    via varchar(15) NOT NULL,
    citta varchar(15) NOT NULL,
    provincia char(2) NOT NULL,
    CAP char(5) NOT NULL,
    email text NOT NULL
);

-- tabella redazioni
CREATE TABLE redazioni(
    idRedazione char(4) PRIMARY KEY,
    nomeComitato varchar(10) NOT NULL,
    citta varchar(8) NOT NULL,
    indirizzoWeb text NOT NULL
);

-- tabella redazRedat
CREATE TABLE redazRedat(
    idRedazione char(4),
    idRedattori char(3),
    PRIMARY KEY (idRedazione, idRedattori),
    FOREIGN KEY (idRedazione) REFERENCES redazioni(idRedazione),
    FOREIGN KEY (idRedattori) REFERENCES redattori(idRedattori)
);

-- tabella categorie
CREATE TABLE categorie(
    nomeCategoria char(10) PRIMARY KEY,
    categoriaPadre char(10) NOT NULL,
    -- chiave ricorsiva: 
    FOREIGN KEY (categoriaPadre) REFERENCES categorie(nomeCategoria)
);

-- tabella inserzioni
CREATE TABLE inserzioni(
    codice char(6) PRIMARY KEY,
    testo text NOT NULL,
    categoria char(10) NOT NULL,
    FOREIGN KEY (categoria) REFERENCES categorie(nomeCategoria)
);

-- tabella instest
CREATE TABLE instest(
    idInserzione char(6),
    idTestata char(4),
    PRIMARY KEY (idInserzione, idTestata),
    FOREIGN KEY (idInserzione) REFERENCES inserzioni(codice),
    FOREIGN KEY (idTestata) REFERENCES testate(idTestata)
);

-- tabella aziende
CREATE TABLE aziende(
    idAzienda char(6) PRIMARY KEY,
    nomeAzienda varchar(40) NOT NULL,
    referente varchar(40) NOT NULL,
    telefono char(11) NOT NULL,
    citta varchar(15) NOT NULL,
    provincia char(2) NOT NULL,
    CAP char(5) NOT NULL
);

-- tabella insaz
CREATE TABLE insaz(
    idAzienda char(6),
    idInserzione char(6),
    PRIMARY KEY(idAzienda, idInserzione),
    FOREIGN KEY (idAzienda) REFERENCES aziende(idAzienda),
    FOREIGN KEY (idInserzione) REFERENCES inserzioni(codice)
);

-- tabella privati
CREATE TABLE privati(
    idPrivato char(3) PRIMARY KEY,
    cognome varchar(10) NOT NULL,
    nome varchar(8) NOT NULL,
    via varchar(15) NOT NULL,
    citta varchar(15) NOT NULL,
    provincia char(2) NOT NULL,
    CAP char(5) NOT NULL,
    email text NOT NULL
);

-- tabella inspriv
CREATE TABLE inspriv(
    /* violazione idPrivato: 
        privati.idPrivato è di dimensione 3, mentre è richiesto sia
        di dimensione 6.
        Soluzione: settare la lunghezza di ispriv.idPrivato a 6
     */
    idPrivato char(6),
    idInserzione char (6),
    PRIMARY KEY (idPrivato, idInserzione),
    FOREIGN KEY (idPrivato) REFERENCES privati(idPrivato),
    FOREIGN KEY (idInserzione) REFERENCES inserzioni(codice)
);

