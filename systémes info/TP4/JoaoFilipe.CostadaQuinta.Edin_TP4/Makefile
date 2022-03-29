

ultra-cp: main.o listingFichier.o copieFichier.o listedossier.o checkifFileOrDossier.o testifFileExist.o  rechercheFichier.o
	gcc main.o listingFichier.o copieFichier.o listedossier.o checkifFileOrDossier.o testifFileExist.o  rechercheFichier.o -o ultra-cp

main.o: main.c
	gcc -c main.c

listingFichier.o: listingFichier.c listingFichier.h
	gcc -c listingFichier.c

copieFichier.o: copieFichier.c copieFichier.h
	gcc -c copieFichier.c

listedossier.o: listedossier.c listedossier.h
	gcc -c listedossier.c

checkifFileOrDossier: checkifFileOrDossier.c checkifFileOrDossier.h
	gcc -c checkifFileOrDossier.c

testifFileExist: testifFileExist.c testifFileExist.h
	gcc -c testifFileExist.c

rechercheFichier.o: rechercheFichier.c rechercheFichier.h
	gcc -c rechercheFichier.c

clean:
	rm *.o ultra-cp
