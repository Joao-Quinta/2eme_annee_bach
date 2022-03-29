# -*- coding: utf-8 -*-
from __future__ import division, print_function #for compatibilty with python2.7
import random

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

def is_major(A, el):
    m = len(A) // 2
    return A.count(el) > m

def reduce_list(A):
    n = len(A)
    if n % 2 == 0:
        A2 = []
        for i in range(0, n, 2):
            if A[i] == A[i + 1]:
                A2.append(A[i])
        return A2
    else:
        if is_major(A, A[0]):
            return [A[0]]
        else:
            return reduce_list(A[1:])

def get_major(A):
    A2 = list(A)
    while True:
        A2 = reduce_list(A2)
        current_n = len(A2)
        if current_n == 1:
            if is_major(A, A2[0]):
                return A2[0]
            else:
                return None
        elif not current_n:
            return None

try: #necessite matplotlib
    import matplotlib.pyplot as plt
    import time
    print("Attention : this may take a long time!")
    chrono_n = [i*1.e4 for i in range(1, 6)]
    chronos = []
    mean_number = 5
    for A_length in chrono_n:
        print("*** Measurements with len(A) = ", A_length)
        tot_time = 0.
        for i in range(mean_number):
            A = generate_maj_list(length=int(A_length))
            begin = time.clock()
            if get_major(A) != 3:
                print("We have a problem ...")
            end = time.clock()
            tot_time += end - begin
        tot_time /= mean_number
        chronos.append(tot_time)
    #plot graph
    fig = plt.figure()
    plt.xlabel('n', fontsize=20)
    plt.ylabel('time [s]', fontsize=20)
    plt.title('t(n)', fontsize=20)
    plt.grid(True)
    plt.plot(chrono_n, chronos, "o-")
    plt.show()

except ImportError:
    print("Un bout du code nécessitait le module matplotlib ;\
            il n'a pas été exécuté.")
