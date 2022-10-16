//esame {cod_corso, data, voto, matr_studente}
#include <string>

class esami {
private:
	int cod_corso;
	std::string data;
	int voto;
	int matr_studente;

public:
	esami(int cod, std::string d, int v, int mat) {
		cod_corso = cod;
		data = d;
		voto = v;
		matr_studente = mat;
	}

	int getCod_corso() {
		return cod_corso;
	}

	std::string getData() {
		return data;
	}

	int getVoto() {
		return voto;
	}

	int getMatrStud() {
		return matr_studente;
	}

	void setCorso(int cod) {
		cod_corso = cod;
	}

	void setData(std::string dt) {
		data = dt;
	}

	void setVoto(int v) {
		voto = v;
	}

	void setMatr_studente(int mat) {
		matr_studente = mat;
	}
};