n0=[0]
n1=[1]
n2=[0,0]

def sup1 (n,l,i,ii,liste):
    if i == 0:
        liste.reverse()
        verifiefin(n,l,liste)
    elif ii == i:
        liste.reverse()
        verifiefin(n,l,liste)
    else:
        if ii < i:
            liste.pop(ii)
            liste.insert(ii,0)
            sup1 (n,l,i,ii+1,liste)
    
def ajoute1 (n,l,i,liste):
    liste.reverse()
    if 0 == liste[i]:
        liste.pop(i)
        liste.insert(i,1)
        sup1(n,l+1,i,0,liste)
    else:
        liste.reverse()
        ajoute1(n,l,i+1,liste)

def ajoute0 (n,l,i,liste,tot):
    while i < tot+1:
        liste.append(0)
        i=i+1
    verifiefin(n,l+1,liste)
        
def verifiefin(n,l,liste):
    if l==n:
        print(n,": ",liste)
        start()
    elif 0 in liste:
        ajoute1(n,l,0,liste)
    else :
        ajoute0(n,l,0,[],len(liste))       
        
    
def nieme(n):
    if n<1:
        print("ce n n'est pas valide")
        start()
    else:
        verifiefin(n,1,n0)


def start():
    n=int(input("choisissez un n > 0 :"))
    if n<4:
        if n==1:
            print(n,": ",n0)
            start()
        elif n==2:
            print(n,": ",n1)
            start()
        elif n==3:
            print(n,": ",n2)
            start()
    else:        
        nieme(n)

start()