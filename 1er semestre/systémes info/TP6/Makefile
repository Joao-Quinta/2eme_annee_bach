client: main.o sendMAIL.o communication.o videBuffer.o
	gcc main.c sendMAIL.c communication.c videBuffer.c -o client

main.o: main.c
	gcc -c main.c

sendMAIL.o: sendMAIL.c sendMAIL.h
	gcc -c sendMAIL.c

communication.o : communication.c communication.h
	gcc -c communication.c

videBuffer.o: videBuffer.c videBuffer.h
	gcc -c videBuffer.c

clean:
	rm *.o client
