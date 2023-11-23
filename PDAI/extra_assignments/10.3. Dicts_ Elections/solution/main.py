n = int(input())
votes_total = {}
for i in range(n):
  candidate, num_votes = input().split()
  if candidate not in votes_total:
    votes_total[candidate] = 0
  votes_total[candidate] += int(num_votes)
for candidate in sorted(votes_total):
  print(candidate, votes_total[candidate])