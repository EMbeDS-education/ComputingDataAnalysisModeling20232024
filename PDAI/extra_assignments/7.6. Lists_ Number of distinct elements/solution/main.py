num_distinct = 1
a = [int(s) for s in input().split()]
for i in range(1, len(a)):
  if a[i - 1] != a[i]:
    num_distinct += 1
print(num_distinct)
