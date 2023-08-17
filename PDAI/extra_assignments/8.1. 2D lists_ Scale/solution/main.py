m, n = [int(s) for s in input().split()]
a = [[int(j) for j in input().split()] for i in range(m)]
c = int(input())
for i in range(m):
  for j in range(n):
    a[i][j] *= c
for line in a:
  print(*line)