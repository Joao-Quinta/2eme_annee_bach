import aidetaquin as at
from state import State


####################################################################################################################### <AIDETAQUIN> #######################################################################################################################

# DIRECTIONS = ["up", "right", "down", "left"]              4 directions
# def is_solution(x)                                        Check if the value of the state x is the list of numbers from 1 to 16.
# def count_bad_cells(x)                                    Heuristic g(x) function: counts the number of misplaced cells. (sans case vide)
# def gen_board_in_direction(board, direction)              This is a helper function for get_children. Returns the state of <board> after moving the empty cell in a given direction.
# def get_children(x)                                       Returns a list of States instance containing all the possible children of x
# def gen_disorder(board, n)                                Use this function to verify your algorithm. It produces a disordered board and the corresponding solution path as output.
# def show_board(board, empty_symbol="O")                   This function simply displays a board. <board> is a list.

####################################################################################################################### <AIDETAQUIN> #######################################################################################################################


# fonction de cout, ou x est un E-node  ///// c^(x)=h(x)+g(x) \\\\\
def c_hat(x):
    bad_count = at.count_bad_cells(x)
    if bad_count == 0:
        return x.depth
    return x.depth + bad_count - 1


def solve(board):
    liveNodeList = []
    E_node = board
    while not at.is_solution(E_node):
        list_children = at.get_children(E_node)
        for child in list_children:  # cette boucle for evite les cas up->down (evite de tourner en rond)
            if child.depth > 1 and child.parent.parent.value == child.value:
                pass
            else:
                cout_child = c_hat(child)
                if len(liveNodeList) == 0:
                    liveNodeList.append([child, cout_child])
                else:
                    j = 0
                    while j < len(liveNodeList):
                        if cout_child <= liveNodeList[j][1]:
                            liveNodeList.insert(j, [child, cout_child])
                            j = len(liveNodeList)
                        else:
                            if j == len(liveNodeList) - 1:
                                liveNodeList.append([child, cout_child])
                                j = len(liveNodeList)
                            j = j + 1
        E_node = liveNodeList[0][0]
        liveNodeList.pop(0)
    solution = State.get_path(E_node)
    solution.pop(0)
    return solution


board_resolu = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
x = at.gen_disorder(board_resolu, 3)
initial_board = x[-1].value
initial_state = State(value=initial_board, parent=None, depth=0, step="start")
path = solve(initial_state)
print(path)
# exemple