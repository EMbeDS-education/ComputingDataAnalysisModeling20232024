x = int(input())
n = 1
while 2 ** n <= x:
  n += 1
print(n - 1, 2 ** (n - 1))