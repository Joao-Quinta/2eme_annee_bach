#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include "hashing.h"
#include "choix_f_t.h"

//main qui appelle simplement la fonction hashage avc les mêmes arguments recus)
int main(int argc, char* argv[]) {
	hashage(argc, argv);
	return 0;
}
