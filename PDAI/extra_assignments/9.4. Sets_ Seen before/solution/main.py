a = [int(s) for s in input().split()]
seen = set()
for i in a:
  if i in seen:
    print('YES')
  else:
    print('NO')
  seen.add(i)