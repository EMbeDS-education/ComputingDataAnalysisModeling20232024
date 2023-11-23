n = int(input())
possible = set(range(n))
while True:
  line = input()
  if line == 'HELP':
    break
  guess = set([int(s) for s in line.split()])
  if input() == 'YES':
    possible &= guess
  else:
    possible -= guess
print(*sorted(possible))