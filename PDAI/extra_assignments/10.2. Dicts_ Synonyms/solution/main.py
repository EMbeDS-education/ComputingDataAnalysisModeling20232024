synonyms = {}
for i in range(int(input())):
  w1, w2 = input().split()
  synonyms[w1] = w2
  synonyms[w2] = w1
print(synonyms[input()])