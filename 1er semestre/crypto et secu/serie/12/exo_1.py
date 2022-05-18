import random


# exo 1


# gets valeurs mod n pour toute puissance 1,2,4,8... jusqua puissance souhaite, used by expo_rapide
def get_res_val_res_i(nb, exp, div, res):
    res[0].append((nb ** 1) % div)
    res[1].append(1)
    i = 2
    res_val, res_i = res[0], res[1]
    while i < exp:
        res_val.append(res_val[-1] ** 2 % div)
        res_i.append(i)
        i = i * 2
    return res


# receoit vails de get_res_val_res_i, et donne les valeurs necessaires au calcul pour la exp en question, used by expo_rapide
def get_val_expo(exp, res):
    val_mod, val_expo = res[0], res[1]
    res = []
    while exp > 0:
        if exp >= val_expo[-1]:
            res.append(val_mod[-1])
            exp = exp - val_expo[-1]
        val_expo.pop(-1)
        val_mod.pop(-1)
    return res


# calcul expo rapide
def expo_rapide(nb, exp, div):
    res, res_final = [[], []], 1
    val_final = get_val_expo(exp, get_res_val_res_i(nb, exp, div, res))
    i = 0
    while i < len(val_final):
        res_final = res_final * val_final[i]
        i = i + 1
    res_final = res_final % div
    return res_final


# generateur random int premier entre min et max, demande au moins nb (a) aleatoires pour donner reponse
def generateur_premier(min=10, max=3000):
    val_premier = random.randint(min, max)
    val_a = random.randint(2, val_premier - 1)
    res = []
    while len(res) < 10:  # cb de testes pour etre sur que premier, ici 10
        res_mod = expo_rapide(val_a, val_premier - 1, val_premier)
        if res_mod == 1:
            res.append(res_mod)
        else:
            val_premier = random.randint(min, max)
            res = []
        val_a = random.randint(2, val_premier - 1)
    return val_premier


# recoit a et b avc a>b, rend pgcb(a,b), et les coeff de bezout, ie, pgcd(a,b)=a*coeff1+b*coeff2
def algo_etendu(a, b):
    r, s, t, q = [0, 0], [0, 0], [0, 0], [0, 0]
    r[0], r[1], s[0], s[1], t[0], t[1], q[0] = a, b, 1, 0, 0, 1, 0
    q[1] = r[0] // r[1]
    val = -1
    while val != 0:
        i = len(r)
        r.append(r[i - 2] - (q[i - 1] * r[i - 1]))
        s.append(s[i - 2] - (q[i - 1] * s[i - 1]))
        t.append(t[i - 2] - (q[i - 1] * t[i - 1]))
        if r[i] == 0:
            break
        q.append(r[i - 1] // r[i])
        val = r[i]
    return r[-2]


print("T le tiers genere 2 premiers p et q, qu il multiplie entre eux pour avoir n (p*q=n)")
p = generateur_premier()
q = generateur_premier()
n = p * q
print("n est publique, p et q secrets")
print("n = ", n)
print()
print("Zn* est = {a appartient a Zn* <=> pgcd(a,n)=1}")
k = 10
print("A genere k elements qui appartiennent a Zn*, faisons k = ", k)
A_z_n = []
i = 0
while i < k:
    x = random.randint(2, n)
    if algo_etendu(n, x) == 1:
        A_z_n.append(x)
        i = i + 1
print("A a genere un ensemble de ", k, " secrets")
print("A genere mtn la cle publique tq : v = s**2 mod n (ou s = elements de l ensemble de secrets)")
A_z_n_publique = []
for i in range(len(A_z_n)):
    A_z_n_publique.append(A_z_n[i] ** 2 % n)
print("cette liste est publique ", A_z_n_publique)
print()

print("a genere r aleatoire, et calcule x tq x = r**2 mod n, et envoie x a B")
r = random.randint(2, n ** 2)
x = r ** 2 % n
print("x est = ", x)
print()

print("B recoit x, et genere ", k, " defis e tq e appartien {0,1}")
e = []
for i in range(k):
    e.append(random.randint(0, 1))
print("B envoie les ", k, " defis a A ")
print()
print("A calcule y = (r * (produit) i a k(si**ei))mod n")
produit = 1
for i in range(len(A_z_n)):
    produit = produit * (A_z_n[i] ** e[i])
y = (produit * r) % n
print("A a calcule y = ", y, " et l envoie a B")
print()
print("B accept y <=> y!=0 et y**2 = (x * (produit) i a k(vi**ei))mod n")
produit_b = 1
for i in range(len(A_z_n)):
    produit_b = produit_b * (A_z_n_publique[i] ** e[i])
y_2 = (produit_b * x) % n

if y ** 2 == y_2:
    print("B a accepte")
else:
    print("B a pas accepte")
