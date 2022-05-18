#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include "choix_f_t.h"
#include <openssl/evp.h>
#include <string.h>
//fonction hashage principale
void hashage(int argc, char* argv[]) {

	EVP_MD_CTX *mdctx;
	//on declare les valeurs F et T qui correspondent aux choix input
	int varF = 0;
	int varT = 0;
	const EVP_MD* md;
	unsigned int md_len, i, argument;
	unsigned char md_value[EVP_MAX_MD_SIZE];
	mdctx = EVP_MD_CTX_new();
	//appel fonction qui verifie les input
	choixFT(argc, argv, &varF, &varT);
//cas ou l'utilisateur veut hacher une chaine de caracteres et n'a pas specifier sa methode de hachage alors on utilise sha1 par defaut


	if (varF == 0){

	//cas ou F n'est pas donne comme input
		if (varT == 0){
			//cette boucle for concatène les différents arguments de argv dans le cas ou la chaine de caractere n'est pas entre guillemets, par exemple : ceci est un exemple , on concatene les argv[argument] un a un avec un espace entre, qu'on va utiliser pour hasher.
			argument = 1; 
			char str[1000];
			strcpy(str, argv[argument]);
			for (int argument = 2; argument<argc;++argument){
				strcat(str, " ");
				strcat(str, argv[argument]);
			}

		//cas ou T n'est pas non plus donne comme input
		//c'est donc un "simple" hashsage de chaine avec sha1 comme exo 2.2
                        md = EVP_get_digestbyname("sha1");
			EVP_DigestInit_ex(mdctx, md, NULL);
			EVP_DigestUpdate(mdctx, str, strlen(str));
			EVP_DigestFinal_ex(mdctx, md_value, &md_len);
			printf("Digest is:\n ");
			//ceci print le hashage
			for (i = 0; i < md_len; i++)
				printf("%02x", md_value[i]);
			printf("\n\n");
			printf("ici on a hasher une chaine de caracteres avec sha1 (methode par defaut) \n");
		}
//cas ou l'utilisateur a specifier sa methode de hachage pour sa chaine de caracteres, donc on hash avec la methode souhaiter
		else if (varT == 1){
//comme avant, argument ici commence à 3, car il existe un parametre -t et md5 en plus
			//ca décale le premier mot à hasher de 2 arguments
			argument = 3; 
			char str[1000];
			strcpy(str, argv[argument]);
			for (int argument = 4; argument<argc;++argument){
				strcat(str, " ");
				strcat(str, argv[argument]);
			}

		//cas ou T est donne comme argument, on encode donc sans sha1
			//on assigne la valeur md au type codage souhaite
			md = EVP_get_digestbyname(argv[2]); 
			printf("le parametre t a ete donne comme argument\n");
			//vu qu il n'exsite pas de valeur -f, il a donc les argumets suivants (0:hash, 1:-t, 2:md5 (par exemple), 3: ceci est une chaine)
			//ce qui veut dire que la chaine a encoder est presente a la position argv[3]
			EVP_DigestInit_ex(mdctx, md, NULL);
			EVP_DigestUpdate(mdctx, str, strlen(str));
			EVP_DigestFinal_ex(mdctx, md_value, &md_len);
			printf("Digest is:\n ");
			for (i = 0; i < md_len; i++)
				printf("%02x", md_value[i]);
			printf("\n\n");
			printf("ici on a hasher une chaine de caracteres avec la methode souhaitee : %s \n", argv[2]);
		}
		else{
			exit(EXIT_FAILURE);
		}

	}
//cas ou l'utilisateur veut hasher un fichier mais n'a pas indiquer la méthode de hachage, alors par defaut on utilise sha1
	else if (varF == 1){
	//il existe un paramentre f dans les arguments
		if (varT == 0){
		//ici il existe pas de parametre t
		//c'est donc un hashage de fichier(s) par sha1
                        md = EVP_get_digestbyname("sha1");
			//vu qu'il y a pas de t, les arguments sont (0:hash, 1: -f, 2: fichier1 etc)
			//on commence donc par hasher le premier fichier qui se trouve en position argv[2], d ou argument=2
			argument = 2;
			while (argument < argc){
				char memoAloue[400];
				//on declare une var de type fichier, on ouvre le fichier qui se trouve dans la position argument (2 pour commencer) et on l'assigne a la var fichier, "r" nous donne les autorisations de lecture du fichier
				FILE* fichier = fopen(argv[argument], "r");
				//tant qu on trouve pas de valeur nulle ou on depasse la valeur de memoire aloue, on fait le digest du fichier
				while (fgets(memoAloue, 400, fichier) != NULL){
					//md par defaut car pas de -t, donc sha1
					EVP_DigestInit_ex(mdctx, md, NULL);
					EVP_DigestUpdate(mdctx, memoAloue, strlen(memoAloue));
					EVP_DigestFinal_ex(mdctx, md_value, &md_len);
					printf("Digest of %s is:  \n", argv[argument]);
					for (i = 0; i < md_len; i++)
						printf("%02x", md_value[i]);
					printf("\n\n");
				}
				//on ferme le fichier
				fclose(fichier);
                                //on remet la var fichier a NULL pour ne pas melanger le contenu avec le fichier suivant, s'il y en a un
				fichier = NULL;
                                //on incremente l'argument pour hasher le fichier suivant, s'il y en a un
				argument++;
			}
			printf("ici on a hasher le(s) fichier(s) avec sha1 (methode par defaut) \n");
		}
//cas ou l'utilisateur veut hacher des fichiers avec une methode de hachage qu'il a specifier dans l'appel en position argv[3] 
		else if (varT == 1){
		//ici il y a le parametre f ainsi que le parametre t
		//hashage de fichier(s) par digest md5 (par exemple)
		//la seule chose qui change par rapport au cas ou t n'est pas donne comme parametre :
		//est la premiere position du fichier a encoder, ainsi que la valeur de md
			//ici le input ressemble a ca (0:hash, 1: -f, 2: -t, 3: md5 (p-exemple), 4: premier fichier a encoder)
			//la position du premier fichier est donc argument=4
			//et le message digest(md) sera donner par la position 3 (ici md5 par exemple)
			argument = 4;
			md = EVP_get_digestbyname(argv[3]);
			while (argument < argc){
			//exactement comme pour le cas sans parametre t (voir cas: varT == 0)
				char memoAloue[400];
				FILE* fichier = fopen(argv[argument], "r");
				while (fgets(memoAloue, 400, fichier) != NULL){
					EVP_DigestInit_ex(mdctx, md, NULL);
					EVP_DigestUpdate(mdctx, memoAloue, strlen(memoAloue));
					EVP_DigestFinal_ex(mdctx, md_value, &md_len);
					printf("Digest of %s is:  \n", argv[argument]);
					for (i = 0; i < md_len; i++)
						printf("%02x", md_value[i]);
					printf("\n\n");
				}
				//aussi comme pour le cas sans parametre t (voir cas: varT == 0)
				fclose(fichier);
				fichier = NULL;
				argument++;
			}
			printf("ici on a hasher le(s) fichier(s) avec la methode souhaitee : %s \n",argv[3]);
		}
		
	}

}

