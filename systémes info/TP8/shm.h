//La mémoire partagée contiendra deux valeur:
//- un indicateur stipulant si un autre processus est près pour l'opération
//- un nombre qui sera incémenté par les deux processus conjointement
typedef struct {
    int isReady;
    int pizzaMade;
    int pizzaOnShelf;
    int totalPizzaMade;
    int totalPizzaServed;
	//partie variables pour récuperer les infos sur le nombre de pizza sur l'étagère
	FILE *affichePizzaOnShelfSERVEUR;
	FILE *affichePizzaOnShelfCOOK;
	pid_t pidSERVEUR;
	FILE *Enter;
	pid_t pidCOOK;
	FILE *pressENTER;
} memoirePartager;

#define READY 0
sem_t pizzaMade;
sem_t pizzaOnShelf;
#define FILE "/shm"
#define SLEEP_TIME 2000
#define NOMBRE_DE_PIZZA_A_PREPARER 10
#define TIME_TO_COOK_A_PIZZA 700000

