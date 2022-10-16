#include <iostream>
#include <fstream>
#include <string>

#include "studenti.cpp"
#include "corsi.cpp"
#include "esami.cpp"

using namespace std;

void caricaDB();
void stampaVoti();

int main() {

	caricaDB();
	stampaVoti();


	return 0;
}

void caricaDB() {
	int nStudenti = 3;

	studenti arrayStudenti[3] = {studenti(500001, "Rossi", "Mario"), studenti(500101, "Verdi", "Luca"), studenti(500201, "Neri", "Franco")};
	corsi arrayCorsi[3] = {corsi(109, "Programmazione", 1, 1), corsi(101, "Basi di dati", 2, 1), corsi(105, "Algoritmi", 2, 1)};
	esami arrayEsami[2] = {esami(101, "2022/07/30", 24, 500001), esami(101, "2022/05/05", 22, 500201)};

	ofstream myfile;

	//scrittura studenti
	myfile.open("studenti.dat");	

	for (int i = 0; i < 3; i++) {
		myfile << arrayStudenti[i].getMatricola() << endl;
		myfile << arrayStudenti[i].getCognome() << endl;
		myfile << arrayStudenti[i].getNome() << endl << endl;
	}
	myfile.close();

	//scrittura corsi
	myfile.open("corsi.dat");

	for (int i = 0; i < 3; i++) {
		myfile << arrayCorsi[i].getCodice() << endl;
		myfile << arrayCorsi[i].getNome() << endl;
		myfile << arrayCorsi[i].getAnno() << endl;
		myfile << arrayCorsi[i].getSemestre() << endl << endl;
	}

	myfile.close();

	//scrittura esami
	myfile.open("esami.dat");

	for (int i = 0; i < 2; i++) {
		myfile << arrayEsami[i].getMatrStud() << endl;		
		myfile << arrayEsami[i].getData() << endl;
		myfile << arrayEsami[i].getVoto() << endl;
		myfile << arrayEsami[i].getCod_corso() << endl << endl;
	}

	myfile.close();
}

void stampaVoti() {
	ifstream fileStud, fileEsam;
	fileStud.open("studenti.dat");
	fileEsam.open("esami.dat");

	int contatoreRighe = 0;
	int contatoreRigheSecFile = 0;

	std::string tmp, tmp2;


	while (std::getline(fileStud, tmp))
	{
		if (contatoreRighe == 0) {
			//cout << tmp << endl;			
		}

		contatoreRighe++;

		if (contatoreRighe == 4) {
			contatoreRighe = 0;
		}

		while (std::getline(fileEsam, tmp2)) {

			if (contatoreRigheSecFile == 0) {
				if (tmp2 == tmp) {

				}
			}

			contatoreRigheSecFile++;

			if (contatoreRigheSecFile == 5) {
				contatoreRigheSecFile = 0;
			}
		}
	}

}