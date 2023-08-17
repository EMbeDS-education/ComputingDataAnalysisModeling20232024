prev = next = int(input())
counter = 0
while next != 0:
  if prev < next:
    counter += 1
  prev, next = next, int(input())
print(counter)