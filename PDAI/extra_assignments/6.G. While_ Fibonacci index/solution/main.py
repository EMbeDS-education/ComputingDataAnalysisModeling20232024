prev, next = 1, 1
index = 2
possible_fib = int(input())
while possible_fib > next:
  prev, next = next, prev + next
  index += 1
if possible_fib == next:
  print(index)
else:
  print(-1)