m, n = [int(s) for s in input().split()]
a = [[int(j) for j in input().split()] for i in range(m)]
col1, col2 = [int(s) for s in input().split()]
for i in range(m):
  a[i][col1], a[i][col2] = a[i][col2], a[i][col1]
for line in a:
  print(*line)
