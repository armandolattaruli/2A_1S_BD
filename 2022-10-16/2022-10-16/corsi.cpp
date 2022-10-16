#include <string>

class corsi {
	//corso {codice, nome, anno, semestre}
private:
	int codice;
	std::string nome;
	int anno;
	int semestre;

public:
	corsi(int cod, std::string name, int an, int sem) {
		codice = cod;
		nome = name;
		anno = an;
		semestre = sem;
	}

	int getCodice() {
		return codice;
	}

	std::string getNome() {
		return nome;
	}

	int getAnno() {
		return anno;
	}

	int getSemestre() {
		return semestre;
	}

	void setCodice(int c) {
		codice = c;
	}

	void setNome(std::string n) {
		nome = n;
	}

	void setAnno(int a) {
		anno = a;
	}

	void setSemestre(int s) {
		semestre = s;
	}

};