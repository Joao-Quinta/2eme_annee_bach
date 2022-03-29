coin_set = [30, 24, 12, 6, 3, 1]

def compute_change(money,coin_set):
    i=0
    change = []
    while i < len (coin_set):
        v=coin_set[i]
        if money >= v:
            change.append(v)
            money = money - v
        else: 
            i=i+1
    else :
        return change
        


print(compute_change(100, coin_set))