a = [int(s) for s in input().split()]
for i in a:
  if a.count(i) == 1:
    print(i, end=' ')
