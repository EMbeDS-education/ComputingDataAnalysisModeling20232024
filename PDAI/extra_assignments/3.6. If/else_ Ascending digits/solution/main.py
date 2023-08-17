x = int(input())
hundreds = x // 100
tens = x // 10 % 10
units = x % 10
if hundreds < tens and tens < units:
  print('YES')
else:
  print('NO')