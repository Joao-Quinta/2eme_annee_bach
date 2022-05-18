import random


# generateur random int premier entre min et max, demande au moins nb (a) aleatoires pour donner reponse
def generateur_premier(min, max):
    val_premier = random.randint(min, max)
    val_a = random.randint(2, val_premier - 1)
    res = []
    while len(res) < 10:#cb de testes pour etre sur que premier, ici 10
        res_mod = expo_rapide(val_a, val_premier - 1, val_premier)
        if res_mod == 1:
            res.append(res_mod)
        else:
            val_premier = random.randint(min, max)
            res = []
        val_a = random.randint(2, val_premier - 1)
    return val_premier


# genere min max pseudo aleatoires avc n chiffres (min)
def genere_min_max(n):
    res_min = 1
    i = 0
    while i < n:
        res_min = res_min * 10
        i = i + 1
    f = random.randint(300, 990)
    res_min = res_min * f
    f = random.randint(584984974, 59584784749858)
    res_max = res_min + (res_min * f)
    return res_min, res_max


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
    return r[-2], s[-2], t[-2]


# calcul de e tq e et phi_n sont coprimes
def calcul_e(phi_n):
    e = 3
    res = 0
    while res != 1:
        res, s, t = algo_etendu(phi_n, e)
        e = e + 1
    return e - 1


# genere cles publique et prive RSA
def genere_keys(n):
    a, b = genere_min_max(n)
    p = generateur_premier(a, b)
    q = generateur_premier(a, b)
    print("voici p : ",p)
    print("voici q : ",q)
    print("copier les val sur wolfram alpha pour verifier que c'est bien des nb premiers")
    print()
    n_phi_n = [p * q, (p - 1) * (q - 1)]
    liste_p_q = [p, q]
    e = calcul_e(n_phi_n[1])
    res, s, t = algo_etendu(n_phi_n[1], e)
    d = n_phi_n[1] + t
    liste_dp_dq_p1_q1 = (
        expo_rapide(d, 1, (p - 1)), expo_rapide(d, 1, (q - 1)), expo_rapide((q ** -1), 1, p),
        expo_rapide((p ** -1), 1, q))
    public_key = [e, n_phi_n[0]]
    private_key = [d, n_phi_n[0]]
    return private_key, public_key, liste_p_q, liste_dp_dq_p1_q1


# etape encryption
def encrypt_function(m, key):
    c = expo_rapide(m, key[0], key[1])
    print("public key : ( e , n ) ", key)
    return c


# etape decryption key[0]=d,key[1]=n
def decrypt_function(c, key, pq, dpdqp1q1):
    p, q = pq[0], pq[1]
    dp, dq, p1, q1 = dpdqp1q1[0], dpdqp1q1[1], dpdqp1q1[2], dpdqp1q1[3]
    m_de = expo_rapide(((expo_rapide(c, dp, p) * q * q1) + (expo_rapide(c, dq, q) * p * p1)), 1, key[1])#marche pas
    m_de = expo_rapide(c, key[0], key[1])
    print("private key : ( d , n ) ", key)
    return m_de


#fonction qui met tout ensemble
def main_function(m):
    private_key, public_key, liste_p_q, liste_dp_dq_p1_q1 = genere_keys(1)#augmenter 1 pour taille cle plus grande
    c = encrypt_function(m, public_key)
    print("le message :", m, " est associe au cipher text : ", c)
    m_de = decrypt_function(c, private_key, liste_p_q, liste_dp_dq_p1_q1)
    print("le ciphertext decrypte donne : ", m_de)
    if m == m_de:
        print("ce qui est bien le message de base")

#j'ai un probleme avec le theoreme du reste chinois, j'ai essaye de l mplementer (ligne 129)
#mais malheureusement ca ne marche pas, j'ai donc fait la decryption avec la formule de base
#c**d%n
main_function(5)
