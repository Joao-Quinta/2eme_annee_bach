def get_steps_greedy(d, X):
    steps = []
    i = 0
    n = len(X)
    next_well = None
    while X[i] < X[-1]:
        for i_well in range(i+1, n):
            if X[i_well] - X[i] > d:
                next_well = i_well - 1
                break
            next_well = i_well
        if i != next_well:
            i = next_well
            steps.append(X[i])
        else:
            steps.append("Fail!")
            break
    return steps


d = 10
X = [0, 5, 10, 17, 21, 37, 45]
##X = [0, 5, 10, 17, 21, 30, 38]
steps = get_steps_greedy(d, X)
print(steps)
