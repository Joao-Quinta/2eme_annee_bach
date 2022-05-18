
def increx(n,i,lenn,listee,h):
    if n <= (listee[lenn]):#verifie qu on depasse pas la valeur recherche
        if n == (listee[lenn]):#si n <= on verifie si c est =, si oui, c est bon
            print("x = ",len(listee)," ; ","y = ",h)
        else:
            increy(h+1,2,0,[1],h+1,n)#sinon, on call increy, alors inci on lui donne h+1(h=1 au debut, ici on veut h=2, pour monter dans les Y, 2 c est le premiere increment dans le axe y, 0 lenn comme pour increx, [1], la premiere val 
            #on va a increy pcq increx a besoin de la premiere valeur de la liste
    else:
        listee.append(listee[lenn]+i)#prnd la derniere valeur de listee (on incremente lenn pour que ceci soit vrai), et on ajoute i
        #print(listee)
        increx(n,i+1,lenn+1,listee,h)#on recall increx avc meme n, i=i+1 pour la next increment, lenn aumente aussi, vu qu on a ajoute un truc en listee, la listee, et h
        
def increy(h,i,lenn,listee,hau,n):
    if h == len(listee):#si h== len (listee), ca veut dire qu on est a l hauteur souhaite 
        z=int(listee[lenn])#on prend 1ere valeur 
        listee.clear()
        listee.append(z)#(pour verifier)
        increx(n,h,0,listee,hau)
    else:
        listee.append(listee[lenn]+i)#on incremente 1 fois, et la liste sera [1,3], c est bon, len(listee)=h, et 3 est la valeur cherche
        increy(h,i+1,lenn+1,listee,hau,n)
                    
def start():
    n=int(input("donnez la valeur souhaite :"))
    increx(n,1,0,[1],1)
    start()
    
start()