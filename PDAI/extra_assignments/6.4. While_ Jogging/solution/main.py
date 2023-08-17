x = int(input())
y = int(input())
num_days = 1
while x < y:
  x *= 1.1
  num_days += 1
print(num_days)