def compute_factorial(n) :
    if n<0:
        raise ValueError('Please, provide a natural number')
    fact = 1
    for i in range(1,n+1):
        fact*=i
    return fact