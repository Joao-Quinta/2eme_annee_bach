hash: main.o choix_f_t.o hashing.o
	g++ main.o choix_f_t.o hashing.o -lssl -lcrypto -o hash
main.o: main.c
	g++ -c main.c
choix_f_t.o: choix_f_t.c choix_f_t.h
	g++ -c choix_f_t.c
hashing.o: hashing.c hashing.h
	g++ -c hashing.c
clean:
	rm *.o hash
