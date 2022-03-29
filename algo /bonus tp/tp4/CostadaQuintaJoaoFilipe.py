import aidevoyage as av

def get_solution(M):
####################################################################### _PARTIE_POUR_OPTIMISER_MATRICE_ #######################################################################
    T = []
    i = 0
    while i < len(M):                                                   #on parcourt toute les lignes
        j = 0
        T.append(M[i].copy())                                           #on construit T en mm temps qu on incremente
        while j < len(M):                                               #on parcourt chaque colonne de chaque ligne
            if M[i][j] != 0 and M[i][j] is not None:                    # on prend que les valeurs non nulles, et non type None
                liste_val = [M[i][j]]                                   # liste_val est reset a chaque tour, et vaut la valeur de la matrice de base M (qu'on cherche a changer si possible
                k = 1                                                   # vu que k commence a 1, on rajoute 1 à decalage
                decalage = i - j + 1                                    # donne cb de valeurs sont a droite de la valeur dans liste_val
                while k < decalage:
                    val_ligne_pre = T[i - k][j]                         # vu que k<i, on pourra jamais avoir [i-k] negatif
                    val_ligne_cur = T[i][i - k]                         # j+(i-j)-k = i-k
                    liste_val.append(val_ligne_pre + val_ligne_cur)     #liste_val prend la valeur
                    k = k + 1
                T[i][j] = min(liste_val)                                #quand on fini la boucle, on prend la valeur min, ca sera la valeur [i][j] de T
            j = j + 1
        i = i + 1

####################################################################### _PARTIE_POUR_PATH_ #######################################################################

    M = av.get_transposed_matrix(M)                                     #transpose les 2 matrices avec la fonction de aide voyage
    T = av.get_transposed_matrix(T)                                     #ca aidera a comarer les chemins
    path = [(len(M)-1)]
    last = len(M)
    i = 0
    while last > 0:
        if M[i][0:last] != T[i][0:last]:                                #des qu on aura une ligne i tq T[i][0:val] == M[i][0:val], alors on aura la fin du trajet optimale
            i = i + 1
        else:                                                           #si cette ligne est i = 0, alors on aura le bon trajet
            if T[i][0:last] == [0]:
                break
            last = T[i].index(0) + 1                                    #si i different de 0, on change la val, pour trouverle chemin opti pour arriver au debut du prochain trajet
            path.append(T[i].index(0))
            i = 0
    path.reverse()                                                      #path est a l invers, faut le reverse()
    T = av.get_transposed_matrix(T)                                     #on retranspose les matrices
    M = av.get_transposed_matrix(M)

####################################################################### _PARTIE_POUR_COUT_ #######################################################################

    cout = T[len(M)-1][0]                                               #val a return pour cout

    return T, path, cout

n=5
M=av.gen_matrix(n)
x, y, z = get_solution(M)

# x est la matrice optimise
#y est le path optimale
# z est le cout total plus bas possible

#av.print_matrix(x)
#print(y)
#print(z)