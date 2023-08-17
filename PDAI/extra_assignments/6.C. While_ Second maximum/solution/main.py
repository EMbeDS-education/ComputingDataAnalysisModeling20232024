maximum = int(input())
second_maximum = int(input())
if second_maximum > maximum:
  second_maximum, maximum = maximum, second_maximum
a = -1
while a != 0:
  a = int(input())
  if a > maximum:
    second_maximum, maximum = maximum, a
  elif a > second_maximum:
    second_maximum = a
print(second_maximum)