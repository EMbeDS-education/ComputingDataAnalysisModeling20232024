first = set([int(s) for s in input().split()])
second = set([int(s) for s in input().split()])
print(*sorted(first & second))