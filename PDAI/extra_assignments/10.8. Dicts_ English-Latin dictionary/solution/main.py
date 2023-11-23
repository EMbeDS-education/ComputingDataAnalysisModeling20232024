la_en = {}
for _ in range(int(input())):
  en_word, la_words = input().split(' - ')
  for la_word in la_words.split(', '):
    if la_word not in la_en:
      la_en[la_word] = []
    la_en[la_word].append(en_word)
print(len(la_en))
for la_word in sorted(la_en):
  print(la_word, '-', ', '.join(sorted(la_en[la_word])))
