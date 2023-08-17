text = input().split()
times_seen = {}
for word in text:
  if word not in times_seen:
    times_seen[word] = 0
  print(times_seen[word], end=' ')
  times_seen[word] += 1