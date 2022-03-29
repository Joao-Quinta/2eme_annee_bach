#je definis un dictionnaire, des que j ai besoin de qqchose je prends depuis le dictionaire
dictionaire = {}
#permut init message
dictionaire["IP"] = [58,50,42,34,26,18,10,2,
      60,52,44,36,28,20,12,4,
      62,54,46,38,30,22,14,6,
      64,56,48,40,32,24,16,8,
      57,49,41,33,25,17,9,1,
      59,51,43,35,27,19,11,3,
      61,53,45,37,29,21,13,5,
      63,55,47,39,31,23,15,7]
#derneire permut
dictionaire["IP_1"] = [40,8,48,16,56,24,64,32,
              39,7,47,15,55,23,63,31,
              38,6,46,14,54,22,62,30,
              37,5,45,13,53,21,61,29,
              36,4,44,12,52,20,60,28,
              35,3,43,11,51,19,59,27,
              34,2,42,10,50,18,58,26,
              33,1,41,9,49,17,57,25]
#etent partie droite de message sur 48 bits
dictionaire["E"]= [32,1,2,3,4,5,
     4,5,6,7,8,9,
     8,9,10,11,12,13,
     12,13,14,15,16,17,
     16,17,18,19,20,21,
     20,21,22,23,24,25,
     24,25,26,27,28,29,
     28,29,30,31,32,1]
#permut init cle
dictionaire["PC_1"] = [57,49,41,33,25,17,9,
        1,58,50,42,34,26,18,
        10,2,59,51,43,35,27,
        19,11,3,60,52,44,36,
        63,55,47,39,31,23,15,
        7,62,54,46,38,30,22,
        14,6,61,53,45,37,29,
        21,13,5,28,20,12,4]
#pour permutation cle chaque etape
dictionaire["PC_2"] = [14,17,11,24,1,5,
        3,28,15,6,21,10,
        23,19,12,4,26,8,
        16,7,27,20,13,2,
        41,52,31,37,47,55,
        30,40,51,45,33,48,
        44,49,39,56,34,53,
        46,42,50,36,29,32]
#s_box pour rendre les listes de taille 6 bits en 4 bits
dictionaire["S_1"]= [[14,4,13,1,2,15,11,8,3,10,6,12,5,9,0,7],
       [0,15,7,4,14,2,13,1,10,6,12,11,9,5,3,8],
       [4,1,14,8,13,6,2,11,15,12,9,7,3,10,5,0],
       [15,12,8,2,4,9,1,7,5,11,3,14,10,0,6,13]]

dictionaire["S_2"]= [[15,1,8,14,6,11,3,4,9,7,2,13,12,0,5,10],
       [3,13,4,7,15,2,8,14,12,0,1,10,6,9,11,5],
       [0,14,7,11,10,4,13,1,5,8,12,6,9,3,2,15],
       [13,8,10,1,3,15,4,2,11,6,7,12,0,5,14,9]]

dictionaire["S_3"]= [[10,0,9,14,6,3,15,5,1,13,12,7,11,4,2,8],
       [13,7,0,9,3,4,6,10,2,8,5,14,12,11,15,1],
       [13,6,4,9,8,15,3,0,11,1,2,12,5,10,14,7],
       [1,10,13,0,6,9,8,7,4,15,14,3,11,5,2,12]]

dictionaire["S_4"] = [[7,13,14,3,0,6,9,10,1,2,8,5,11,12,4,15],
       [13,8,11,5,6,15,0,3,4,7,2,12,1,10,14,9],
       [10,6,9,0,12,11,7,13,15,1,3,14,5,2,8,4],
       [3,15,0,6,10,1,13,8,9,4,5,11,12,7,2,14]]

dictionaire["S_5"] = [[2,12,4,1,7,10,11,6,8,5,3,15,13,0,14,9],
       [14,11,2,12,4,7,13,1,5,0,15,10,3,9,8,6],
       [4,2,1,11,10,13,7,8,15,9,12,5,6,3,0,14],
       [11,8,12,7,1,14,2,13,6,15,0,9,10,4,5,3]]

dictionaire["S_6"] = [[12,1,10,15,9,2,6,8,0,13,3,4,14,7,5,11],
       [10,15,4,2,7,12,9,5,6,1,13,14,0,11,3,8],
       [9,14,15,5,2,8,12,3,7,0,4,10,1,13,11,6],
       [4,3,2,12,9,5,15,10,11,14,1,7,6,0,8,13]]

dictionaire["S_7"] = [[4,11,2,14,15,0,8,13,3,12,9,7,5,10,6,1],
       [13,0,11,7,4,9,1,10,14,3,5,12,2,15,8,6],
       [1,4,11,13,12,3,7,14,10,15,6,8,0,5,9,2],
       [6,11,13,8,1,4,10,7,9,5,0,15,14,2,3,12]]

dictionaire["S_8"] = [[13,2,8,4,6,15,11,1,10,9,3,14,5,0,12,7],
       [1,15,13,8,10,3,7,4,12,5,6,11,0,14,9,2],
       [7,11,4,1,9,12,14,2,0,6,10,13,15,3,5,8],
       [2,1,14,7,4,10,8,13,15,12,9,0,3,5,6,11]]
dictionaire["S_Boxes"] = ["S_1","S_2","S_3","S_4","S_5","S_6","S_7","S_8"]
#premut apres chipher
dictionaire["P"] = [16,7,20,21,
     29,12,28,17,
     1,15,23,26,
     5,18,31,10,
     2,8,24,14,
     32,27,3,9,
     19,13,30,6,
     22,11,4,25]
#rotations binaires
dictionaire["Rotations"] = [1,1,2,2,2,2,2,2,1,2,2,2,2,2,2,1]
#calcul xor
def xor(liste1,liste2,res): #input 2 listes auxquelles on va calculer le xor, et liste vide
    i=0
    while i < len(liste1):
        if liste1[i]==liste2[i]:
            res.append(0)
            i=i+1
        else:
            res.append(1)
            i=i+1
    return res #output type liste->resultat Xor

#prend le premier bit de liste, et le met en derniere place
def rotationbinaire (liste,nb_rotation): #input type liste
    i=0
    while i < nb_rotation:
        val0=liste[0]
        liste.pop(0)
        liste.append(val0)
        i=i+1
    return liste #output liste

#fait les permutations, la ieme valeur de change -1, est l indice de val liste, qu on doit rentrer ensuite dans res 
def permutation(liste, change, res): #input type liste à permuter, liste de permutation, liste vide qui sera le resultat
    i=0
    while i < len (change):
        res.append(liste[change[i]-1])
        i=i+1
    return res #retourne la reponse type liste

#divise la liste en 2 (gauche et droite)
def split ( liste, gauche, droite): #type liste, qui est partage en liste gauche et liste droite
    i=0
    while i < len(liste):
        if i < (len(liste)/2):
            gauche.append(liste[i])
        else:
            droite.append(liste[i])
        i=i+1
    return gauche, droite #retourne les deux moitiés 

#partage le resultat de cipher function en 8 sous listes de res, appele par cipher function
def separateur(liste,res): #recoit une liste de 48 bits, et les sépare en 8 sous listes de taille 6 chaque
    i=0
    while i<len(liste):
        sousliste,j=[],0 #liste de passage
        while j < 6:
            sousliste.append(liste[i+j])
            j=j+1
        res.append(sousliste)
        i=i+6
    return res #retourne la liste avc les sous listes

#calcul la ligne pour la box
def calculx1x6(x1,x6,res): #recoit les bits x1 x6, 
    liste,i,j=[],0,2
    liste.append(x1+x6)
    while i<len(liste):
        if liste[i]==1:
            res=res+1*j
        i,j=i+1,j/2
    return int(res) #retourne un entier entre [0:3]

#calcule colonne
def calculx2x3x4x5(x2,x3,x4,x5,res):                 #recoit les 4 bits x2x3x4x5, les mets dans une liste
    i,j,liste=0,8,[]
    liste.append(x2+x3+x4+x5)
    while i<len(liste):
        if liste[i]==1:
            res=res+1*j
        i,j=i+1,j/2
    return int(res)                                  #retourne la val "hexa" entre [0:15], pas [0:F]
    
#calcul ligne et colonne pour chaque sousliste
def calculLC(sousliste,resC,resL):                   #recoit une liste de 8 listes, chaque une avec 6 bits
    i=0
    while i<len(sousliste):
        listei=sousliste[i]
        resL.append(calculx1x6(listei[0],listei[5],0)) 
                                                     #pour chaque sous liste, on prend la valeur le plus a gauche et le plus a droite pour calculer la ligne
        resC.append(calculx2x3x4x5(listei[1],listei[2],listei[3],listei[4],0)) 
                                                     #pour chaque sous liste, on prend toutes les valeurs au milieu, et calcule la colonne
        i=i+1
    return resL,resC                                 #retourne deux listes, l'une avec les 8 valeurs de lignes, et l autres les 8 valeurs de colonnes

#rend une liste avec la valeur apres cipher function en hexa
def getval(ligne,colonne,res):                       #recoit liste de valeurs ligne, et colonne, et liste vide
    S_Boxes,i=dictionaire.get("S_Boxes"), 0          #prend la val S_Boxes depuis le dictionnaire
    while i<len(ligne):
        x=S_Boxes[i]
        S_=dictionaire.get(x)
        ligneval,colonneval=ligne[i],colonne[i]
        bonneligne=S_[ligneval]
        bonneval=bonneligne[colonneval]
        res.append(bonneval)
        i=i+1
    return res                                       #liste de 8 valeurs en "hexa"

#transforme hexa en binaire
def hexato2(hexa,res):                               #recoit liste de 8 valeurs en "hexa", et une liste vide
    i=0
    while i<len(hexa):
        val,j,c=hexa[i],8,0
        while c<4:
            if val >= j:
                res.append(1)
                val=val-j
            else:
                res.append(0)
            j,c=int(j/2),c+1
        i=i+1
    return res                                       #rend les valeurs de hexa en binaire
    
#cipher function etape
def cipher (subkey,right32,res):                     #recoit la subkey pour l etape, et le right message qu on va Expandre
    E,P=dictionaire.get("E"),dictionaire.get("P")
    right48=permutation(right32,E,[])                #les deux listes ont mtn la meme taille
    ress=xor(subkey,right48,[])                      #on fait xor des deux listes
    souslistes=separateur(ress,[])                   #on sépare le resultat du xor en 8 sous listes
    ligne,colonne=calculLC(souslistes,[],[])         #on calcule la ligne et colonne pour chaque sous liste
    res1=getval(ligne,colonne,[])                    #on va chercher les valeurs pour les 8 valeurs à chaque S_Box
    res2=hexato2(res1,[])                            #on transforme les valeurs "hexa" en binaire
    res=permutation(res2,P,[])                       #permutation finale
    return res                                       #on returne le resultat de la permutaiton 
    
#etape cle (rotation binaire, permutation)
def etapekey(gauche,droite,nb_rotation,res):                #etapekey recoit les deux valeurs gauche - droite cle, nb_rotations binaires
    PC_2=dictionaire.get("PC_2")
    i=0
    while i < 16:                                           #boucle qui calcule directement toutes les subkeys (qu on utilisera dans cipher fuction)
        gauche=rotationbinaire(gauche,nb_rotation[i])       #rotation bianire
        droite=rotationbinaire(droite,nb_rotation[i])       #rotation binaire
        res.append(permutation(gauche+droite,PC_2,[]))      #la permutaiton qui nous donne la subkey
        i=i+1
    return res                                              #return la liste res avc les subkeys

#etape message (cipher, xor, et change)    
def etapemessage(left,right,subkey):                        #recoit les deux cotes du message
    E=dictionaire.get("E")  
    rescipher=cipher(subkey,right,[])                       #cipher function
    left=xor(left,rescipher,[])                             #xor du resultat avec gauche
    return right,left                                       #on inverse les resultats 
    
#etape init, fait permutation initial de cle et mesage, ainsi que les separer en 2    
def init(message,key):                                          #2 listes
    IP,PC_1=dictionaire.get("IP"),dictionaire.get("PC_1")   
    resG=permutation(message,IP,[])                             #permutation message
    resD=permutation(key,PC_1,[])                               #permutaiton cle
    resG1,resG2=split(resG,[],[])                               #on les separe en 2
    resD1,resD2=split(resD,[],[])
    return resG1,resG2,resD1,resD2                              #rends les valeurs resG = message, resD = cle

def corpsEN(message,key,res):                                               #fonction qui met tout ensemble
    IP_1,Rotations=dictionaire.get("IP_1"),dictionaire.get("Rotations")     
    resG1,resG2,resD1,resD2=init(message,key)                               #initialisation
    subkey=etapekey(resD1,resD2,Rotations,[])                               #on a toutes les subkeys
    i=0 
    while i<16:                                                             #boucle qui à chaque fois une etapemessage, avc la subkey necessaire
        resG1,resG2=etapemessage(resG1,resG2,subkey[i])
        i=i+1
    res=permutation(resG2+resG1,IP_1,[])                                    #vu qu on a inverse G et D dans la derniere etape, on les reinverse avant la derniere permutation
    return res

def corpsDE(message,key,res):                                               #exactement comme encryption, mais on inverser l ordre de subkey
    IP_1,Rotations=dictionaire.get("IP_1"),dictionaire.get("Rotations")
    resG1,resG2,resD1,resD2=init(message,key)
    subkey=etapekey(resD1,resD2,Rotations,[])
    subkey.reverse()                                                        #la seule étape qui change, on inverse subkey, la subkey de l etape 16, est mtn la premiere
    i=0
    while i<16:
        resG1,resG2=etapemessage(resG1,resG2,subkey[i])
        i=i+1
    res=permutation(resG2+resG1,IP_1,[])
    return res

message_test = list(map(int,list(format(0x0011223344556677, '0>64b'))))
cle_test = list(map(int,list(format(0x0123456789ABCDEF, '0>64b'))))

trys1=corpsEN(message_test,cle_test,[])
print(trys1)
trys2=corpsDE(trys1,cle_test,[])
print(trys2)
if trys2==message_test:
    print("ca marche mal mais bien")
else:
    print("ca marche pas de tout")
#j'ai essaye la fonction avec le message et cle teste, et il y a une erreur quelque part, mais en faisant le decryptage du mauvais resultat j ai le message_test de base
#j'ai donc une erreur qqpart, mais mon code a un sens

#toutes les petites fontions marchent comme sense, les grandes aussi, la preuve j ai un résultat, 
#je fais p-e une rotation de trop qqpart ? ou j'inverse des cotes que je devrais pas, jsp, j'ai cherche mais malheureusment pas trouve