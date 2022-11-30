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
    categoriaPadre char(10),
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

-- =============== 28/11/2022 ==============
INSERT INTO testate (idTestata, nome, redazione)
VALUES
    (0, "corriere", "CORR"),
    (1, "gazzetta", "MEZZ"),
    (2, "IL POST", "POST");

-- modificare la dimensione del nome e del cognome etc.
ALTER TABLE privati 
MODIFY cognome VARCHAR(30) NOT NULL,
MODIFY nome VARCHAR(30) NOT NULL;

-- creare la tabella città avente come attributi: etc.
CREATE TABLE citta(
    citta varchar(30) NOT NULL,
    provincia char(2) NOT NULL,
    CAP char(5) PRIMARY KEY
);

-- modificare le tabelle in cui è presente l'attributo città etc
ALTER TABLE redattori 
MODIFY citta char(5) NOT NULL;
ALTER TABLE redattori
ADD FOREIGN KEY (citta) REFERENCES citta(CAP);


ALTER TABLE redazioni 
MODIFY citta char(5) NOT NULL;
ALTER TABLE redazioni
ADD FOREIGN KEY (citta) REFERENCES citta(CAP);


ALTER TABLE aziende 
    MODIFY citta char(5) NOT NULL,
    ADD FOREIGN KEY (citta) REFERENCES citta(CAP),
    DROP COLUMN provincia,
    DROP COLUMN CAP;


ALTER TABLE privati 
    MODIFY citta char(5) NOT NULL,
    ADD FOREIGN KEY (citta) REFERENCES citta(CAP),
    DROP COLUMN provincia,
    DROP COLUMN CAP;

-- inserire nel database tanti comitati di redazioni quante sono le testate...
INSERT INTO citta (citta, provincia, CAP)
VALUES ("Bari", "BA", "70042"),
    ("Taranto", "TA", "70043"),
    ("Torino", "TO", "70044");

INSERT INTO redazioni (idRedazione, nomeComitato, citta, indirizzoWeb)
VALUES ("CORR", "com_corr", "70042", "indirizzo"),
    ("GAZZ", "com_gazz", "70043", "indirizzo2"),
    ("POST", "com_post", "70044", "indirizzo3");

-- inserire nel database un numero di persone etc
ALTER TABLE redattori
DROP COLUMN provincia;
ALTER TABLE redattori
DROP COLUMN CAP;

INSERT INTO redattori (idRedattori, cognome, nome, via, citta, email)
VALUES ("000", "Lattaruli", "Armando", "via 1", "70042", "email1"),
     ("001", "Santostasi", "Michele", "via 2", "70043", "email2"),
     ("002", "Prestieri", "Maurizio", "via 3", "70044", "email3"),
     ("003", "Raffaele", "Cutolo", "via 4", "70042", "email4");

INSERT INTO redazRedat (idRedattori, idRedazione)
VALUES ("000", "CORR"),
    ("000", "POST"),
    ("001", "GAZZ"),
    ("002", "CORR"),
    ("003", "CORR"),
    ("003", "POST");

-- modificare la tabella categorie etc.
-- rimuoviamo prima i vincoli presenti nelle altre tabelle

ALTER TABLE inserzioni
DROP FOREIGN KEY inserzioni_ibfk_1;

ALTER TABLE categorie 
DROP FOREIGN KEY categorie_ibfk_1;

ALTER TABLE categorie
DROP PRIMARY KEY;

ALTER TABLE categorie
ADD COLUMN (
    idCategoria
    char(4) NOT NULL PRIMARY KEY
);

-- inserire le categorie etc

INSERT INTO categorie (nomeCategoria, categoriaPadre, idCategoria)
VALUES ("moda", NULL, "MODA"),
        ("street", "MODA", "STRT"),
        ("classica", "MODA", "CLAS"),

        ("case", NULL, "CASE"),
        ("affitti", "CASE", "AFFI"),
        ("vendite", "CASE", "VEND"),

        ("automobili", NULL, "AUTO"),
        ("sportive", "AUTO", "SPRT"),
        ("utilitarie", "AUTO", "UTIL");


-- inserire nelle tabelle almeno 10 inserzioni di privati etc
INSERT INTO privati(idPrivato, cognome, nome, via, citta, email)
VALUES ("000", "Rossi", "Federico", "via 1", "70042", "email1"),
    ("001", "Verdi", "Umberto", "via 1", "70043", "email2"),
    ("002", "Bianchi", "Antonio", "via 1", "70044", "email3");

INSERT INTO aziende (idAzienda, nomeAzienda, referente, telefono, citta)
VALUES ("000000", "Ferrari", "Marco Rossi", "telefono 1", "70042"),
        ("000001", "Zara", "Andrea Luce", "telefono 2", "70043"),
        ("000002", "Pirelli", "Elettra Foscolo", "telefono 3", "70044");

INSERT INTO inserzioni (codice, testo, categoria)
VALUES ("000000", "testo", "VEND"),
        ("000001", "testo", "AUTO"),
        ("000002", "testo", "MODA"),
        ("000003", "testo", "UTIL"),
        ("000004", "testo", "VEND"),
        ("000005", "testo", "CASE"),
        ("000006", "testo", "AFFI"),
        ("000007", "testo", "CLAS"),
        ("000008", "testo", "STRT"),
        ("000009", "testo", "SPRT"),

        ("000011", "testo", "VEND"),
        ("000012", "testo", "MODA"),
        ("000013", "testo", "CLAS"),
        ("000014", "testo", "SPRT"),
        ("000015", "testo", "SPRT"),
        ("000016", "testo", "STRT"),
        ("000017", "testo", "UTIL"),
        ("000018", "testo", "VEND"),
        ("000019", "testo", "AFFI"),
        ("000020", "testo", "VEND");


INSERT INTO inspriv (idPrivato, idInserzione)
VALUES ("000", "000000"),
        ("000", "000001"),
        ("001", "000002"),
        ("002", "000003"),
        ("000", "000004"),
        ("001", "000005"),
        ("002", "000006"),
        ("002", "000007"),
        ("000", "000008"),
        ("001", "000009");

INSERT INTO insaz (idAzienda, idInserzione)
    VALUES ("000000", "000011"),
        ("000000", "000012"),
        ("000001", "000013"),
        ("000002", "000014"),
        ("000000", "000015"),
        ("000001", "000016"),
        ("000002", "000017"),
        ("000002", "000018"),
        ("000000", "000019"),
        ("000001", "000020");
