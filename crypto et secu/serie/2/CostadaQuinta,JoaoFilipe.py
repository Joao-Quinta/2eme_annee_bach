def minuscule(listee,new,i,sym):#cette fonction est appelle par tout tipe de chiffrement et dechiffrement, elle recoit une liste de chars/symboles en minuscules et majuscules, elle parcourt la liste depuis le debut, si la ieme val est une majuscule (1er if), elle prend cette lettre, et la met dans une nouvelle liste mais en minuscule, si la ieme lettre est deja minuscule, alors elle l a met telle qu'elle dans la nouvelle liste, ensuite si c'est ni majuscule ni minuscule, c'est un symbole, qu'elle met dans une 2eme liste, ainsi que son index dans la liste de base, si ieme char = *, alors cette deuxieme liste apprend (i) et ('*'), ca fait une sorte de glossaire de symboles, transorme ces deux listes en variables globales, elles ont des noms uniques pour n'etre pas appeles par hasard a des mauvais moments, et vu que la fcontion est tjrs appelle pour tout chiffrement/dechiffrement, les valeurs en question sont tjrs à jour, j'ai appris plus tard que python avait une fonction lower() qui rendait les majuscules en minuscules, mais du coup j'ai quand meme garde ma fcontion
    if i<len(listee):
        if ord(listee[i]) in [x for x in range(65,91)]:
            new.append(chr(ord(listee[i])+32))
            minuscule(listee,new,i+1,sym)
        elif ord(listee[i]) in [x for x in range(97,123)]:
            new.append(listee[i])
            minuscule(listee,new,i+1,sym)
        else:
            sym.append(i+(int(len(sym)/2)))
            sym.append(listee[i])
            listee.pop(i)
            minuscule(listee,new,i,sym)            
    else:
        global messagee,symbole
        messagee,symbole = new, sym

def symboles(messageeee,sym):#comme minuscule est appelle en debut de tout chiffrement/dechffrement, cette fcontion est appelle en toute fin, elle recoit le message chiffre/dechiffre sous forme de liste, et une deuxieme liste, le glossaire, si le glossaire est vide, alors y a rien a faire, sinon, il faut inserer le ieme element ou i%2=0, à la place i-1 dans message 
    global reponse
    reponse=""
    if len(sym)>0:
        messageeee.insert(sym[0],sym[1])
        sym.pop(0)
        sym.pop(0)
        symboles(messageeee,sym)  
    else :
        i=0
        while i<len(messageeee):
            reponse=reponse+messageeee[i]
            i=i+1
        else:
            print(reponse)    

    
        
def decryptcesar (liste, n):#fais exactement la meme chose que la donction qui crypte, mais à l'envers, en enlevant la valeur de décalage souhaité n
    minuscule((list(str(liste))),[],0,[])
    message,sym=messagee,symbole
    i=0
    decrypte=[]
    while i < len(message):
        decrypte.append(chr(((valabs(((ord(message[i]))-97)-n))%26)+97))
        i=i+1
    else:
        symboles(decrypte,sym)
        
   
def encryptcesar (liste, n):
    minuscule((list(str(liste))),[],0,[])
    message,sym=messagee,symbole 
    i=0
    crypte=[]
    while i < len(message):#tant que i (commence à 0) est plus petit que len(liste), on insère dans la liste crypte (vide qu début) la valeur (une lettre qu on rend int a l aide de ord()) en ieme position du message à chiffrer, auquel on additionne le décalage n souhaité, et on retransforme en charactére à l'aide de chr(), on incrémente i, et on parcourt comme ca tout le message à crypter.
        crypte.append(chr(((((ord(message[i]))-97)+n)%26)+97))
        i=i+1
    else:#des que i = len (liste), on print la liste crypte, qui contient le message crypté, et on rappelle la fonction principal pour refaire un autre choix
        symboles(crypte,sym) 
    
def enlevedouble(cle, i):#recoit message cle qui a ete inverse, et i=0
    if i<len(cle):#si i < len(cle), alors:
        if cle.count(cle[i]) > 1:#si le nb d'apparitions de la valeur cle[i]->(rend la valeur de cle à la place i,vu que i=0 commnce par le debut), est plus grand que 1, on , utilise cle.index() de la valeur cle[i] qui est dans cle plus que 1 fois, index rend la premiere pos de cle[i] dans cle, on attribue cette valeur à p, et on utilise cle.pop(p) pour enlever la valeur en pieme position dans la liste cle, et on reappelle la donction avec le meme i, car il est possible que la meme valeur soit presente 3, 4 .. n fois, et on enleve une a la fois, jusqu a en avoir que une, vu qu on avait inverse la liste cle au debut, quand on reinversera, il nous restera que la premiere apparition de chaque valeur
            p=cle.index(cle[i])
            cle.pop(p)
            enlevedouble(cle,i)
        else:
            enlevedouble(cle, i+1)#s il n y a pas plus de 1 apparition de cle[i] dans cle, on rappelle la fonction de forme recursif en incrémentant i, de cette forme on avance dans la cle
    else:
        cle.reverse()#quand nous sommes ici, ca veut dire que i=len(cle), et donc nous avons parcouru la liste, et enlevé tous les doubles, et reverse encore une fois cle
    return cle #rend la valeur de cle sans doubles
        
def produitclemono (cle, alpha, i):#recoit la phrase cle, alphabet ordone et i=0
    cle.reverse()#on reverse la cle
    cle1=enlevedouble(cle, 0)#appel de fonction qui va enlever les doubles dans cle, cle1=cle sans doubles
    while i < len(cle1):#tant que i < len(cle1), 
        if cle1[i] in alpha :#si cle1[i] , i=0 initiallement, est dans la liste alphabet (elle sera forcement), alors on reutilise index pour trouver la pos de cle1[i] dans alphabet, et on l enlève avc alpha.pop(), ensuite on incremente i, et la boucle s arrete des que i= len(cle1), on aura donc parcouru cle1
            p = alpha.index(cle1[i])
            alpha.pop(p)
            i=i+1
        else:
            i=i+1
    return cle1+alpha #on return ensuite cle1 (cle sans doubles) + (colle les deux listes) alpha, qui est l'alphabet sans les valeurs de cle1, len(cle1+alpha) forcement = 26

def encryptermono(listee,n):#fonction de passage, elle recoit le message a crypter et la cle sous forme de phrase elle appelle minuscule, pour transformer le message en liste de minuscules, et elle transmet ca à encryptermono1
    minuscule((list(str(n))),[],0,[])#pour enelever les eventuels symboles à la phrase
    cle,sym=messagee,symbole
    minuscule((list(str(listee))),[],0,[])
    message,sym=messagee,symbole 
    encryptermono1(message,cle,[], 0,sym)
    
def encryptermono1(listee,nn,crypte, i,sym):
    listealphabet = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']#on definit l'alphabet ordone sous forme de liste
    n=produitclemono(nn, listealphabet, 0)# on appelle une fonction qui va creer la cle à partir du message de cle
    while i < len(listee):
        crypte.append(n[ord(listee[i])-97])#crypte, liste vide, recoit les valeurs : liste[i], i=0, on prend donc la ieme valeur de listee (message a chiffrer), on le transforme en int, avc ord(), ce int sera >=97 et <=97+26, car à 'a' on assossie 97, du coup on soustrait à la valeur donné par ord() la valeur 97, pour avoir un resultat entre 0 et 25, ensuite on prend ce résultat et on cherche avc n[] (n est la cle) la lettre à la meme pos que le résultat, et nous avons donc le char qui sera ajoute dans crytpe, on incrémente i, pour passer au 2eme char de listee etc            
        i=i+1
    symboles(crypte,sym)
    
def decryptermono(listee,n):#fonction de passage, elle recoit le message a decrypter et la cle sous forme de phrase elle appelle minuscule, pour transformer le message en liste de minuscules, et elle transmet ca à decryptermono1
    minuscule((list(str(n))),[],0,[])#pour enelever les eventuels symboles à la phrase
    cle,sym=messagee,symbole
    minuscule((list(str(listee))),[],0,[])
    message,sym=messagee,symbole
    decryptermono1(message,cle,[],0,sym)
    
def decryptermono1(listee,nn,decrypte, i,sym):
    listealphabet = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']#on definit l'alphabet ordone sous forme de liste
    n=produitclemono(nn, listealphabet, 0)# on appelle une fonction qui va creer la cle à partir du message de cle
    while i < len(listee):
        decrypte.append(chr(n.index(listee[i])+97))#on parcourt la listee(message chiffre), en commenceant par le debut, soit listee[i] = c (exemple), ensuite on cherche la pous de c dans la cle n, à l aide de n.index(c), on aura un chiffre entre 0 et 25 comme réponse, à ce résultat on aditionne 97 (on avait soustrait dans la fonction cryptage), avc chr() on le transforme en lettre entre 'a' et 'z', que on ajoute dans decrypte, on incremente i (le reste marche comme dans cryptage)         
        i=i+1
    symboles(decrypte,sym)
    
def vigenerecry (listee,cle,rep,i,sym):#chiffrement vigenere, on a un compteur i, qui commence a 0 et parcour vers la droite le message a chiffrer (ici listee), on prend la ieme valeur de message, et de cle, on les transforme en int avc ord(), leur enleve 97, comme ca on a 2 int entre [0,25], on les adittionne, cette operation permet un resultat > 25, on fait modulo %26, on additionne 97 et on utilise chr(), ceci donne la letter chiffre qu on met dans la liste rep, qui sera la réponse, on incremente i par récurrence.
    if i<len(listee):
        rep.append(chr(97+(((ord(listee[i])-97)+(ord(cle[i])-97))%26)))
        vigenerecry(listee,cle,rep,i+1,sym)
    else:
        symboles(rep,sym)
        
def valabs(x):#recoit x qui est dans i=[-26,26], si x est <0, alors faut calculer 26+(-x) (x negatif) donc, 26-x, imaginons qu'on doit dechiffrer 'a'=0, par un decalage de 1, alors ceci 0-1=-1 =>26-1=25 = 'z', ce qui est la réponse souhaite 
    if x>=0:
        return x
    else:
        a=26+x
        return a
    
def vigenerede (listee,cle,rep,i,sym):#dechiffrement vigenere, on a un compteur i, qui commence a 0 et parcour vers la droite le message a dechiffrer (ici listee), on prend la ieme valeur de message, et de cle, on les transforme en int avc ord(), leur enleve 97, comme ca on a 2 int entre [0,25], on les soustrait, cette operation permet un resultat negatif, on appelle donc valabs(valeur) (comme pour dechiffrement cesar) avc cette valeur, qui nous rend la valeur souhaite, 0-1=25, et pas -1, on fait modulo %26, on additionne 97 et on utilise chr(), ceci donne la letter dechiffre qu on met dans la liste rep, qui sera la réponse, on incremente i par récurrence.
    if i<len(listee):
        rep.append(chr(97+(valabs((ord(listee[i])-97)-(ord(cle[i])-97))%26)))
        vigenerede(listee,cle,rep,i+1,sym)
    else:
        symboles(rep,sym)


def makecle1 (listee, cle, d,sym):#2eme fonction appele par makecle, elle rend la cle et le message en meme taille, et appelle nsuite les fonctions de chiffrement/dechiffrement selon la valeur de d
    if len(listee)==len(cle):
        if d==0:
            vigenerecry(listee,cle,[],0,sym)
        else:
            vigenerede(listee,cle,[],0,sym)
    elif len(listee)>len(cle):
        makecle(listee,cle,[], d,sym)
    else:
        cle.reverse()
        i=0
        while len(cle)>len(listee):
            cle.pop(i)
        else:
            cle.reverse()
            if d==0:
                vigenerecry(listee,cle,[],0,sym)
            else:
                vigenerede(listee,cle,[],0,sym)
        
def makecle (listee, cle, nouvcle, d, sym):#fonction qui fait la cle pour chiffrement /dechiffrement vigenere, par contre, si le len(message) est pas multiple, de len(cle), alors à la fin, len(cle)>len(message), donc on reappelle une 2eme fonction pour les rendre en meme taille
    p=len(cle)
    i=0      
    while len (nouvcle) < len(listee) :
        while i<p:
            nouvcle.append(cle[i])
            i=i+1
        else:
            i=0
    else:
        makecle1(listee,nouvcle,d,sym)        

def encryvigenere(listee,n):#matrice de passage, appelle par l utilisateur, transforme les chaines de characterees en liste, appelle minuscule() qui va mettre en variable global les valeurs message et symbole, message correspond au message a chiffrer/dechiffrer, et symbole, à la liste de symboles a pas changer ex: *, appelle make cle avc toutes ses infos 
    minuscule((list(str(listee))),[],0,[])
    message,sym=messagee,symbole
    makecle (message,(list(str(n))), [], 0, sym)
    
def decryvigenere(listee,n):#comme encryvigenere, mais appelle makecle avc d=1, ceci veut dire qu on va dechiffrer, alors que dans encryvigenere on appelle makecle avc d=0 donc chiffrer
    minuscule((list(str(listee))),[],0,[])
    message,sym=messagee,symbole
    makecle (message,(list(str(n))), [], 1, sym)
    

## a chaque appel de fonction on aura 3 variables globales, message, symbole, reponse, message est le message a chiffrer/dechiffrer sous forme de liste, symbole la liste type glossaire(explique avant), et finalement reponse, à qui on assossie la réponse.

##pour appeler une fonction utiliser les commandes si dessous
##la réponse sera enregistre dans la variable globale reponse, et sera pas retourne 
print("malheureuesement je n'ai pas reussi à return la reponse souhaite, par contre elle est stocke dans la variable globale -> reponse")
encryptcesar ("AbC*d", 4)
decryptcesar ("efg*h", 4)
encryptermono("salut ceci est une chaine","ceci est une phrase")
decryptermono("mcbqo itih tmo qft ipchft","ceci est une phrase")
encryvigenere("holla*mon*non*est*fonction","pikapika")
decryvigenere("wwvlp*uyn*cwx*ehb*pockdidv","pikapika")
