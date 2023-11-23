n, m = [int(s) for s in input().split()]
a = [['.' if (i + j) % 2 == 0 else '*']
     for i in range(n)
     for j in range(m)]
for line in a:
  print(*line)