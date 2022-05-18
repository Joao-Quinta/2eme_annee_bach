"""NOTE IMPORTANTE:

Dans tout ce module, nous proposons de coder les etats de la facon suivante:
Un etat 'state' est une liste contenant, a l'indice i, le numero de colonne
de la reine etant sur la ligne i. Ainsi, state[4]=7 veut dire que la reine sur
la cinquieme ligne est situee sur la huitieme colonne.
"""

def print_state(state):
    for column in state:
        for j in range(len(state)):
            symbol="x" if j==column else "o"
            print(symbol, end=" ")
        print()
    print()

if __name__ == "__main__":
	my_state = [1,3,4,0,2]
	print_state(my_state)
