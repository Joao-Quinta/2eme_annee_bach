from __future__ import print_function, division #for compatibility python2.7
import time #for measuring execution time

def naive_pow(x, n):
    if n < 1:
        return 1
    elif n < 2:
        return x
    else:
        return x * naive_pow(x, n-1)


def fast_pow(x, n):
    if n < 1:
        return 1
    if n < 2:
        return x
    else:
        if n%2 == 0:
            return fast_pow(x * x, n // 2)
        else:
            return x * fast_pow(x * x, (n - 1) // 2)


def measure_time(func, x_range, n_range, it=1000):
    beg = time.clock()
    for i in range(it):
        for x in x_range:
            for n in n_range:
                func(x, n)
    end = time.clock()
    return end - beg

def measure_time_2(func, x, n, it=1000):
    beg = time.clock()
    for i in range(it):
        func(x, n)
    end = time.clock()
    return end - beg

print(measure_time_2(naive_pow, 12, 36, 100000))
print(measure_time_2(fast_pow, 12, 36, 100000))