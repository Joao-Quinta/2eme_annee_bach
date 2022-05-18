from __future__ import print_function
from random import random, randint
from copy import deepcopy

def print_matrix(m):
    n = len(m[0]) #detect length
    for i in range(n):
        for j in range(n):
            if m[i][j] is None:
                s = "x"
            else:
                s = m[i][j]
            print("{:>2}".format(s), end=" ")
        print("")

def gen_matrix(n, fairness=0.5, deltaprice=3):
    matrix = [[None for i in range(n)] for i in range(n)] #0 matrix
    for i in range(n):
        matrix[i][i] = 0
    #build "atomic" trips:
    for i in range(n-1):
        matrix[i+1][i] = randint(1, 5)
    #generates other
    for depth in range(1, n-1):
        for i in range(depth, n-1):
            s = sum([matrix[k+1][k] for k in range(i-depth, i+1)])
            matrix[i+1][i-depth] =  s
            if random() > fairness:
                matrix[i+1][i-depth] += randint(-deltaprice, deltaprice)
    return matrix

def get_copy(matrix):
    return deepcopy(matrix)

def get_transposed_matrix(matrix):
    M = get_copy(matrix)
    n = len(matrix[0])
    for x in range(n):
        for y in range(n):
            M[x][y] = matrix[y][x]
    return M
