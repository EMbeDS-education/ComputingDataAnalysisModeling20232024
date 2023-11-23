x = []
y = []
for i in range(8):
  a = [int(s) for s in input().split()]
  x.append(a[0])
  y.append(a[1])
answer = 'NO'
for i in range(8):
  for j in range(i + 1, 8):
    if ((x[i] == x[j]) or
        (y[i] == y[j]) or
        (abs(x[i] - x[j]) == abs(y[i] - y[j]))):
      answer = 'YES'
print(answer)
