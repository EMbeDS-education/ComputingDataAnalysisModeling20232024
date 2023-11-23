a = int(input())
length = 0
sum_of_sequence = 0
while a != 0:
  sum_of_sequence += a
  length += 1
  a = int(input())
print(sum_of_sequence / length)