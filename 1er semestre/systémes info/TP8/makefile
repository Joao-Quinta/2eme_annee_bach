all: cuisinier serveur
cuisinier: cook.c shm.h
	gcc cook.c -o cuisinier -lrt -pthread
serveur: serveur.c shm.h
	gcc serveur.c -o serveur -lrt -pthread
