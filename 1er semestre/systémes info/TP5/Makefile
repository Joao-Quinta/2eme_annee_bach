

lockFILES: main.o LOCK.o getPID.o
	gcc main.o LOCK.o getPID.o -o lockFILES

main.o: main.c
	gcc -c main.c

LOCK.o: LOCK.c LOCK.h
	gcc -c LOCK.c

getPID.o: getPID.c getPID.h
	gcc -c getPID.c

clean:
	rm *.o lockFILES
