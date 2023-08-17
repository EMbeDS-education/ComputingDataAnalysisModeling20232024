prev, next = 1, 1
n = int(input())
for i in range(n - 2):
  prev, next = next, prev + next
print(next)