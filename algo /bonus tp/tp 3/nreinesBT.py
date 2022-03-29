from aidereinesbt import print_state

def T(x,k,n):
    '''La fonction T donne les enfants valides à l'étape k'''
    return [i for i in range(n-1,-1,-1) if i not in x[:k]]

def B(x,k,n):
    '''La fonction B verifie s'il y a des conflics diagonaux à l'étape k'''
    for i in range(k):
      if abs(i-k) == abs(x[i] - x[k]):
        return False
    return True


def P(x,k,n):
    '''La fonction P vérifie que la condition pour une solution est atteinte.
       En utilisant un des templates, par construction les conflicts sur les
       lignes, les colonnes et les diagonales ont déjà été testés.'''
    return k == n-1

def printSol(x,k,n):
    '''Impression de la solution'''
    print_state(x)

def rBacktrack(x,k,n):
    '''Template reccursif du backtracking'''
    for y in T(x,k,n):
      x[k]=y
      if B(x,k,n):
        if P(x,k,n):  printSol(x,k,n)
        rBacktrack(x,k+1,n)


N = 4
print("Cherche des solutions pour N = "+str(N)+"...")
rBacktrack([None]*N,0,N)

