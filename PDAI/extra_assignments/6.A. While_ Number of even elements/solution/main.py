a = int(input())
num_even = 0
while a != 0:
  if a % 2 == 0:
    num_even += 1
  a = int(input())
print(num_even)