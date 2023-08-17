partial_sum = 0
current_factorial = 1
for i in range(1, int(input()) + 1):
  current_factorial *= i
  partial_sum += current_factorial
print(partial_sum)