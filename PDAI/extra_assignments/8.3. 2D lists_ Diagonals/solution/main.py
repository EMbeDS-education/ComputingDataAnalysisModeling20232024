n = int(input())
a = [[0] * n for i in range(n)]
for i in range(n):
  for j in range(n):
    a[i][j] = abs(i - j)
for line in a:
  print(*line)