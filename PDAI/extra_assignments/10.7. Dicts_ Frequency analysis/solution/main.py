frequency = {}
for _ in range(int(input())):
  for word in input().split():
    if word not in frequency:
      frequency[word] = 0
    frequency[word] += 1
for i in sorted(set(frequency.values()), reverse=True):
  for word in sorted([word for word in frequency if frequency[word] == i]):
    print(word, i)