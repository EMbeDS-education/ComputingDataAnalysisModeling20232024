a = int(input())
b = int(input())

if a == 0:
  if b == 0:
    print('many solutions')
  else:
    print('no solution')
elif b % a == 0:
  print(b // a)
else:
  print('no solution')
