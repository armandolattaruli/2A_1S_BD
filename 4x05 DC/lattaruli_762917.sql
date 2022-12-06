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
    (1, "gazzetta", "GAZZ"),
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
     ("001", "Santostasi", "Michele", "via 2", "70043", "email@2"),
     ("002", "Prestieri", "Maurizio", "via 3", "70044", "email@3"),
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
        ("000001", "casa", "AUTO"),
        ("000002", "casa", "MODA"),
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

-- ============= 4x03 =============

ALTER TABLE testate
    ADD CONSTRAINT vincoloTestate FOREIGN KEY (redazione) REFERENCES redazioni(idRedazione) ON UPDATE CASCADE;

-- ALTER TABLE inspriv
--     DROP FOREIGN KEY `inspriv_ibfk_2` ;

-- ALTER TABLE inspriv
--     ADD CONSTRAINT vincolo_inspriv FOREIGN KEY(idInserzione) REFERENCES inserzioni(idinserzione);


-- query 1
SELECT count(idTestata) AS 'Numero testate presenti: '
FROM testate;

-- query 2
SELECT count(idRedazione) AS 'Numero comitari presenti: '
FROM redazioni;

-- query 3
SELECT count(idRedattori) AS 'Numero persone inserite in ogni comitato: '
    FROM redazRedat
    GROUP BY idredazione;

-- query 4
SELECT nomeCategoria AS 'Categorie presenti nel DB', categoriaPadre, idCategoria
    FROM categorie
    ORDER BY categoriaPadre;

-- query 5 - A
SELECT count(idPrivato) AS 'Numero inserzioni privati: ' FROM inspriv;

-- query 5 - B
SELECT count(idAzienda) AS 'Numero inserzioni aziende: ' FROM insaz;



-- ========== 4x04 ===============
-- query 6
SELECT nome FROM testate;

-- query 7
SELECT * FROM redattori;

-- query 8
SELECT cognome, nome FROM redattori;

-- query 9
SELECT cognome, nome, email FROM redattori;

-- query 10
SELECT * FROM redattori WHERE email LIKE 'A%';

-- query 11
SELECT * FROM redattori WHERE email LIKE '%@%';

-- query 12
SELECT * FROM redattori WHERE email NOT LIKE '%@%';

-- query 13
SELECT nomeComitato FROM redazioni WHERE indirizzoWeb IS NOT NULL; 

-- query 14
SELECT codice, testo FROM inserzioni WHERE categoria = "CASE";

-- query 15
SELECT codice, testo FROM inserzioni WHERE testo LIKE "%casa%";

-- query 16
SELECT codice, testo FROM inserzioni WHERE testo LIKE "%casa%" && testo LIKE "%vend%";

-- query 17
SELECT codice, testo FROM inserzioni WHERE testo LIKE "%modic%";

-- query 18
SELECT * FROM privati;

-- query 19
SELECT * FROM privati WHERE citta = "70125" OR citta = "70126";

-- query 20
SELECT * FROM aziende WHERE telefono LIKE "%556%";

-- query 21
ALTER TABLE privati
    ADD COLUMN numeroCivico int(5);

ALTER TABLE aziende
    ADD COLUMN numeroCivico int(5);

-- query 22
ALTER TABLE privati
    ADD COLUMN eta int(3);

-- query 23
ALTER TABLE aziende
    ADD COLUMN capitaleSociale int(30),
    ADD COLUMN annoFondazione int(4);

-- ==================== 4x05 =================
UPDATE privati
    SET numeroCivico=52, eta=50     
    WHERE idPrivato="000";
UPDATE privati
    SET numeroCivico=20, eta=65     
    WHERE idPrivato="001";
UPDATE privati
    SET numeroCivico=78, eta=42     
    WHERE idPrivato="002";

UPDATE aziende
    SET numeroCivico=89, annoFondazione=1950
    WHERE idAzienda="000000";
UPDATE aziende
    SET numeroCivico=23, annoFondazione=1930
    WHERE idAzienda="000001";
UPDATE aziende
    SET numeroCivico=45, annoFondazione=2000
    WHERE idAzienda="000002";

-- query 24
SELECT nomeAzienda FROM aziende;

-- query 25
SELECT nomeAzienda FROM aziende WHERE annoFondazione < 1980;

-- query 26
SELECT nomeAzienda FROM aziende WHERE annoFondazione > 1998;

-- query 27
SELECT nomeAzienda FROM aziende WHERE (annoFondazione > 1980 && annoFondazione < 1998);

-- query 28

-- query 29
SELECT cognome, nome, numeroCivico FROM privati WHERE numeroCivico > 19;

-- query 30
SELECT cognome, nome, numeroCivico FROM privati WHERE (numeroCivico = 19 || numeroCivico = 23);

-- query 31
SELECT nome, cognome, via, numeroCivico, citta AS "Codice_Avviamento_Postale" FROM privati
    WHERE (numeroCivico > 19 && numeroCivico < 24);
