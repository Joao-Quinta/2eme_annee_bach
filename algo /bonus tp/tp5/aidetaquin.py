from __future__ import division, print_function
from math import sqrt, log
from random import choice as rand_choice
from state import State

"""
Written by Y.Thorimbert

In this file we choose to represent a state of the problem as a list
of numbers in which number 16 denotes the empty cell.

Note that using State objects as implemented in state module, this
list for state x is stored as 'x.value'.

All the functions below are specific to "taquin" (or 15-Puzzle) game.
"""

DIRECTIONS = ["up", "right", "down", "left"]  # possible directions


def is_solution(x):
    """Check if the value of the state x is the list of numbers from 1 to 16.
    """
    return x.value == list(range(1, len(x.value) + 1))


def count_bad_cells(x):
    """Heuristic g(x) function: counts the number of misplaced cells."""
    count = 0
    for i, n in enumerate(x.value):
        if n != i + 1:
            count += 1
    return count


##def count_bad_cells(x): #equivalent
##    """Heuristic g(x) function: counts the number of misplaced cells."""
##    count = 0
##    for i in range(len(x.value)):
##        if x.value[i] != i + 1:
##            count += 1
##    return count

def gen_board_in_direction(board, direction):
    """This is a helper function for get_children.
    Returns the state of <board> after moving the empty cell in a given
    direction.
    """
    newboard = list(board)  # copy original board
    l = len(board)
    n = int(sqrt(l))
    i = newboard.index(l)  # index of empty cell
    j = i
    # moves the empty cell index according to the direction
    if direction == "up":
        j -= n
    elif direction == "down":
        j += n
    elif direction == "left":
        j -= 1
    elif direction == "right":
        j += 1
    newboard[i], newboard[j] = newboard[j], newboard[i]  # swap elements
    return newboard


def get_children(x):
    """
    Returns a list of States instance containing all the possible children
    of x.
    """
    l = len(x.value)
    i = x.value.index(l)  # index of element whose value is 'l' (=15)
    n = int(sqrt(l))
    possible_directions = list(DIRECTIONS)
    # remove impossible directions:
    if i % n == n - 1:
        possible_directions.remove("right")
    elif i % n == 0:
        possible_directions.remove("left")
    if i < n:
        possible_directions.remove("up")
    elif i > l - n - 1:
        possible_directions.remove("down")
    children = []
    # for each possible direction, append the corresponding children state:
    for direction in possible_directions:
        next_board = gen_board_in_direction(x.value, direction)
        sol = State(value=next_board, parent=x, step=direction)
        children.append(sol)
    return children


def gen_disorder(board, n):
    """
    Use this function to verify your algorithm. It produces a disordered board
    and the corresponding solution path as output.
    """
    x = State(board, None, 0, "start")
    solutions = [x]
    for i in range(n):
        children = get_children(x)
        choice = rand_choice(children)  # pick a random child
        while choice.value in [sol.value for sol in solutions]:
            children.remove(choice)
            choice = rand_choice(children)
        solutions.append(choice)
        x = choice
    return solutions


def show_board(board, empty_symbol="O"):
    """This function simply displays a board. <board> is a list."""
    l = len(board)
    nformat = int(round(log(l, 10)) + 1) + 1  # + 1 pour l'espace
    n = int(sqrt(l))
    line = 0
    column = 0
    i = 0
    while i < l:
        s = "{:>" + str(nformat) + "}"
        if board[i] == 16:
            number = empty_symbol
        else:
            number = str(board[i])
        print(s.format(number), end="")
        if i % n == n - 1:
            print("")
        i += 1
    print("")

initial_board = [1, 2, 3, 4,
                 5, 6, 16, 8,
                 9, 10, 7, 11,
                 13, 14, 15, 12]
initial_state = State(value=initial_board, parent=None, depth=0, step="start")

"""
print("Initial state:")
show_board(initial_state.value)
print("Children:")
for child in get_children(initial_state):
    print("child", child.step)
    show_board(child.value)

"""
"""
initial_board = list(range(1, 17))  # solution ...
disorder_nodes = gen_disorder(initial_board, 10)  # ... on met du desordre
# disorder_nodes contient maintenant une liste d'etats dont le dernier est le
# point de depart de la recherche (c'est l'etat le plus desordonne).
disordered_state = disorder_nodes[-1]
initial_node = State(value=disordered_state.value, parent=None, depth=0, step="start")
# solve(initial_node)  #...

"""