maximum = int(input())
counter = 1
a = -1
while a != 0:
  a = int(input())
  if a > maximum:
    maximum, counter = a, 1
  elif a == maximum:
    counter += 1
print(counter)