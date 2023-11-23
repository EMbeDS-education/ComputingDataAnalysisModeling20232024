x1 = int(input())
y1 = int(input())
x2 = int(input())
y2 = int(input())
x3 = int(input())
y3 = int(input())

if x1 == x2:
  x4 = x3
elif x1 == x3:
  x4 = x2
else:
  x4 = x1
  
if y1 == y2:
  y4 = y3
elif y1 == y3:
  y4 = y2
else:
  y4 = y1
  
print(x4)
print(y4)