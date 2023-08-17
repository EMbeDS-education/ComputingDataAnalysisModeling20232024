item_dollars = int(input())
item_cents = int(input())
n = int(input())
total_cents = (item_dollars * 100 + item_cents) * n
print(total_cents // 100, total_cents % 100)
