# -*- coding: utf-8 -*-
import random
import time

def generate_random_list(length, rng=(1, 100), typ=int):
    """Return a list that does not necessarily contain any major element."""
    return [typ(random.randint(rng[0], rng[1])) for i in range(length)]

def generate_maj_list(length, major_value=3, rng=(1, 100), typ=int, m="auto"):
    """length: length of the list
    major_value: value of the major element
    rng: range of the values into the list
    typ: type of the values into the list
    m: number of times the major element appears. (if a float is given, then
        number(n) = int(m*n))
    """
    A = []
    major_value = typ(major_value)
    if m is "auto":
        m = length / 2 + 1
    elif isinstance(m, float):
        m = m * length
    m = int(m)
    for i in range(m):
        A.append(major_value)
    for i in range(length-m):
        A.append(typ(random.randint(rng[0], rng[1])))
    random.shuffle(A)
    return A

def naive_major(A):
    m = len(A) // 2 # '//' veut dire 'division entiere'.
    for el in A:
        if A.count(el) > m:
            return el
    return None

#vérifie si l'element 'el' est majoritaire de A
def is_major(A, el):
    i=0
    res=0
    while i<len(A):
        if A[i]==el:
            res=res+1#correspond à combien de fois 'el' est dans A
            i=i+1
        else:
            i=i+1
    if len(A)%2==1:#impair
        if res>=len(A)/2:
            return True
        else:
            return False
    else:#pair
        if res>=(len(A)/2)+1:
            return True
        else:
            return False

#reduce A
def reduce_list(A):
    i=0
    a=[]
    while i<len(A):
        if A[i]==A[i+1]:#compare la ieme valeur avec i+1 ème valeur, si elles sont égales, alors la ième valeur est ajouté à ap
            a.append(A[i])
            i=i+2#incrémentaiton par 2, vu qu'on compare a0 avc a1, a2 avec a3 etc
        else:
            i=i+2
    A=a
    return A

def get_major(A):
    if len(A)%2==1:#si impair, on prend la derniere valeur et on regarde si c'est le major de A
        if is_major(A,A[len(A)-1])==True:
            return A[len(A)-1]
        else:#si ca ne l'est pas on supprime la valeur, et on r'appelle get_major avec
            A.pop(len(A)-1)
            get_major(A)
    else:
        ap=A
        while len(ap)>1:#tant que ap est plus grand que 1 on appele reduce_liste itérativement, sauf si ap est impair, alors on revérifie si le dernier element est lae major, sinon on l'enleve, et on appele reduce_liste() avc une liste qui est mtn de taille paire
            if len(ap)%2==1:
                dern=ap[len(ap)-1]
                if is_major(A,dern)==True:
                    return dern
                else:
                    ap.pop(len(ap)-1)
                    ap=reduce_list(ap)
            else:
                ap=reduce_list(ap)#si pair on appele tout simplement reduce_liste()
        if len(ap)==0:#si vide, alors A n'a pas de valeur majoritaire
            return None
        else:
            if is_major(A,ap[0])==True:#on vérfie qu'on a la bonne réponse
                return ap[0]
	    else:
		return None