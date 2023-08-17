x = int(input())
thousands = x // 1000
hundreds = x // 100 % 10
tens = x // 10 % 10
units = x % 10
if thousands == units and hundreds == tens:
  print('YES')
else:
  print('NO')