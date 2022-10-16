#include <string>

class studenti {
private:
		int matricola;
		std::string cognome, nome;

public:
	studenti(int mat, std::string cog, std::string nom) {
		matricola = mat;
		cognome = cog;
		nome = nom;
	}

	int getMatricola() {
		return matricola;
	}

	std::string getCognome() {
		return cognome;
	}

	std::string getNome() {
		return nome;
	}

	void setMatricola(int mat) {
		matricola = mat;
	}

	void setCognome(std::string c) {
		cognome = c;
	}

	void setNome(std::string n) {
		nome = n;
	}
};