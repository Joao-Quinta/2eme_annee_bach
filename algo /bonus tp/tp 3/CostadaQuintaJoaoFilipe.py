def print_stat(state):
    for column in state:
        for j in range(len(state)):
            symbol = "x" if j == column else "o"
            print(symbol, end=" ")
        print()
    print()

#donne les valeurs pour chaque niveau k, selon le x donne
def T(state, niveau, n):
    listeLeft = []
    if niveau != n:
        for i in range(0, n):
            if i not in state:
                listeLeft.append(i)
    listeLeft.reverse()
    return listeLeft

#verigie les conditions implicites, la diagoanle
def B(state, niveau, n):
    i = 0
    while i < niveau:
        if abs(state[niveau] - state[i]) != abs((niveau) - (state.index(state[i]))):
            i = i + 1
        else:
            return False
    return True

#verifie tout simplement si on a fini
def P(state, niveau, n):
    if niveau == n - 1:
        return True
    return False

#fonction generaliste pour backtracking
def solve(n):
    values, state, niveau, solution = [[] for i in range(n)], [-1 for i in range(n)], 0, []
    values[niveau] = T(state, niveau, n)
    while niveau > -1:
        if len(values[niveau]) == 0:                            #si on a parcouru toutes les solutions
            state[niveau] = -1                                  #remettre la valeur à -1 (val de base)
            niveau = niveau - 1
        else:
            state[niveau] = values[niveau].pop()                #a chaque boucle on trouve les values
            if B(state, niveau, n) == 1:                        #et on verifie que les reines sont en conflit
                if P(state, niveau, n) == 1:
                    solution.append(state.copy())               #solution
                    niveau = niveau - 1                         #on reduit niveau, car on increment apres
                niveau = niveau + 1
                values[niveau] = T(state, niveau, n)
    return solution


solution=solve(4)#appel
for i in range(0,len(solution)): #print boucle
    print_stat(solution[i])
print(solution)
print("NB de soltuions : ", len(solution))
