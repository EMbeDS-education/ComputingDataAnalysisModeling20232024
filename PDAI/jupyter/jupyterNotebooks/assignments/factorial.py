def compute_factorial(n) :
    if n<0:
      print('Please, provide a natural number')
      return -1
    fact = 1
    for i in range(1,n+1):
        fact*=i
    return fact