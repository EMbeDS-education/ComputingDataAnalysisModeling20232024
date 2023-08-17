a = [int(s) for s in input().split()]
counter = 0
for i in range(len(a)):
  for j in range(i + 1, len(a)):
    if a[i] == a[j]:
      counter += 1
print(counter)