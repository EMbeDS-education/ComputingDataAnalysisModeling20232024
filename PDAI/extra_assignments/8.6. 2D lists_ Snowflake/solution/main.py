n = int(input())
a = [['.'] * n for i in range(n)]
for i in range(n):
  for j in range(n):
    if i == j or i + j + 1 == n or i == n // 2 or j == n // 2:
      a[i][j] = '*'
for line in a:
  print(*line)