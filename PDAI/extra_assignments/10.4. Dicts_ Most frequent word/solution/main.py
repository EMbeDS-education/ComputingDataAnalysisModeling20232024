words_count = {}
for i in range(int(input())):
  words = input().split()
  for word in words:
    if word not in words_count:
      words_count[word] = 0
    words_count[word] += 1
max_frequency = max(words_count.values())
for word in sorted(words_count):
  if words_count[word] == max_frequency:
    print(word)
    break
