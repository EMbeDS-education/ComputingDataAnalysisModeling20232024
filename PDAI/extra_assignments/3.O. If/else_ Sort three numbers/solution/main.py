a = int(input())
b = int(input())
c = int(input())

if a <= b <= c:
  print(a, b, c, end='\n')
elif a <= c <= b:
  print(a, c, b, end='\n')
elif b <= a <= c:
  print(b, a, c, end='\n')
elif b <= c <= a:
  print(b, c, a, end='\n')
elif c <= a <= b:
  print(c, a, b, end='\n')
else:
  print(c, b, a, end='\n')