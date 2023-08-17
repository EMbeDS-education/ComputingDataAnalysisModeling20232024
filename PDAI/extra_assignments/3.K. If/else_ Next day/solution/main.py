month = int(input())
day = int(input())

if ((day == 30) and (month == 4 or month == 6 or month == 9 or month == 11)
    or (day == 28) and (month == 2)
    or (day == 31)):
  month += 1
  day = 1
else:
  day += 1
if month == 13:
  month = 1

print(month)
print(day)