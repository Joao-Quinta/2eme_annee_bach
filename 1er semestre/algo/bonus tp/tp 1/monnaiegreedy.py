"""
Author : Yann Thorimbert
Date : 24.09.2014

This code implements a simple greedy money change algorithm
"""

def print_change(money, coin_set):
    """Solve and print the solution."""
    print("Print change for " + str(money) + " pence:")
    while coin_set:
        if coin_set[0] <= money:
            money -= coin_set[0]
            print("Coin changed : " + str(coin_set[0]))
        else:
            coin_set.pop(0)

#Optimal example:
print("*** FIRST EXAMPLE ***")
MONEY = 100
COIN_SET = [30, 24, 12, 6, 3, 1]
print_change(MONEY, COIN_SET)

#Non-optimal example: (optimal would be: 24, 24)
print("*** SECOND EXAMPLE ***")
MONEY = 48
COIN_SET = [30, 24, 12, 6, 3, 1]
print_change(MONEY, COIN_SET)