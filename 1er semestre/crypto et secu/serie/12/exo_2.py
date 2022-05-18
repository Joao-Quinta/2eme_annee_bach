import random


# generer G1

def permutation(liste, change,
                res):  # input type liste � permuter, liste de permutation, liste vide qui sera le resultat
    i = 0
    while i < len(change):
        res.append(liste[change[i] - 1])
        i = i + 1
    return res


def genere_g1(nb_noeuds, nb_max_aretes, nb_shuffles):
    g1 = []
    g1_noeuds = []
    g1_aretes = []

    # on genere une liste noeuds, et on les shuffle x=nb_shuffle fois
    for i in range(nb_noeuds):
        g1_noeuds.append(i)
    for i in range(nb_shuffles):
        random.shuffle(g1_noeuds)

    # en fait, c est tout simplement une liste qui va de 0 a nb_noeuds-1, et on la melange
    g1.append(g1_noeuds)

    for i in g1_noeuds:
        g1_aretes.append([])
        noeuds_possibles = g1_noeuds.copy()
        noeuds_possibles.pop(noeuds_possibles.index(i))
        nb_aretes = random.randint(1, nb_max_aretes)
        x = len(noeuds_possibles) - nb_aretes
        while len(noeuds_possibles) > x:
            j = random.randint(0, len(noeuds_possibles) - 1)
            g1_aretes[-1].append(noeuds_possibles[j])
            noeuds_possibles.pop(j)

    # on a cree les aretes pour chaque noeud, chaque noeud a x=nb_max_aretes de aretes
    g1.append(g1_aretes)

    # g1 est une liste de 2 listes, la premiere (g1[0]) liste sont les noeuds, la deuxieme (g1[1]) les aretes
    # en fait g1[0][i] est le noeud i, et g1[1][i] sont les aretes du noeud i

    # exemple simple, avec nb_noeuds = 4, nb_max_aretes = 2
    # g1 = [[2, 0, 3, 1], [[1, 0], [2], [2], [3]]]
    # g1[0] = [2, 0, 3, 1] /////// g1[1] = [[1, 0], [2], [2], [3]]
    # soit i = 0, alors le noeud 2, a 2 aretes, une qui va vers le noeud 1, et une deuxieme qui va ver le noeud 0
    # soit i = 1, alors le noeud 0, a 1 arete, une qui va vers le noeud 2
    # soit i = 2, alors le noeud 3, a 1 arete, une qui va vers le noeud 2
    # soit i = 3, alors le noeud 1, a 1 arete, une qui va vers le noeud 3

    # ici ce n'est pas le cas, mais si jamais on a par exemple une arete qui va du noeud 1 au noeud 2, et une arete du noeud 2 qui va vers le noeud 1
    # i.e. : 1->2 ,  2->1    -------> on traitera ces cas plus tard

    return g1


def genere_g2(g1, permutation_liste):
    g2 = []
    # la permutation des noeuds est facile, j utilise la fonction du TP DES
    noeuds_g2 = permutation(g1[0], permutation_liste, [])
    g2.append(noeuds_g2)

    liste_aretes_g2 = []
    for i in range(len(g1[1])):
        liste_aretes_g2.append([])
        for j in g1[1][i]:
            liste_aretes_g2[i].append(noeuds_g2[g1[0].index(j)])

    g2.append(liste_aretes_g2)
    return g2


def aretes_duplicate(g):
    liste_aretes = []
    for i in range(len(g[0])):
        liste_indice = []
        j = 0
        val_max = len(g[1][i])
        while j < val_max:
            sens1 = [g[0][i], g[1][i][j]]
            sens2 = [g[1][i][j], g[0][i]]
            if sens1 not in liste_aretes:
                liste_aretes.append(sens1)
                liste_aretes.append(sens2)
                j = j + 1
            else:
                g[1][i].pop(j)
                val_max = val_max - 1
    return g


nb_noeuds = 500
nb_shuffles = 1000
nb_max_aretes = 150
nb_defis = 30


print()
if nb_max_aretes > nb_noeuds:
    print("pas possible, nb_max_aretes > nb_noeuds")
else:
    print("On genere le graph G1 de ", nb_noeuds, " noeuds")
    # on genere g1
    g1 = genere_g1(nb_noeuds, nb_max_aretes, nb_shuffles)
    # g1 = [[2, 0, 4, 1, 3], [[0], [3], [2, 3, 1], [3, 4], [1]]]

    print("On genere la cle de permutation pi, qui est secrete")
    # on genere la liste permutation
    permutation_pi = []
    for i in range(nb_noeuds):
        permutation_pi.append(i)
    for i in range(nb_shuffles):
        random.shuffle(permutation_pi)
    # permutation_liste = [4, 1, 0, 2, 3]

    # on "clean" g1 ( on enleve les doubles aretes)
    g1 = aretes_duplicate(g1)

    print("On genere le graph G2 depui G1 et la cle de permutation pi secrete")
    # on cree g2 depuis g1 et la cle de permutaiton
    g2 = genere_g2(g1, permutation_pi)

    print("les graphs g1 et g2 sont publiques, mais pas pa premutation pi")
    print()
    print()

    print("A cree la permutation sigma aleatoire")
    # on cree la permutation avc laquelle on cree H
    permutation_sigma = []
    for i in range(nb_noeuds):
        permutation_sigma.append(i)
    for i in range(nb_shuffles):
        random.shuffle(permutation_sigma)

    print("A cree le graph H depuis G2 avc permutation aleatoire sigma")
    h = genere_g2(g2, permutation_sigma)
    print("A envoie H a B")
    print()
    print()
    print("B recoit H, et cree le defi")
    liste_defis = []
    for i in range(nb_defis):
        liste_defis.append(random.randint(1, 2))
    print("B envoie la liste de defis a A")
    print()
    print("Maintenant A calcule a chaque fois H depuis g1 ou g2 selon la liste de defis, pour prouver a B qu'il a la permutation secrete pi")
    print()
    for i in range(len(liste_defis)):
        if liste_defis[i] == 1:
            h_test = genere_g2(g2, permutation_sigma)
        else:
            h_test = genere_g2(genere_g2(g1, permutation_pi), permutation_sigma)
        if h_test != h:
            print("probleme")
    print("A a la permutation pi")