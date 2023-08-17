city_country = {}
for _ in range(int(input())):
  country, *cities = input().split()
  for city in cities:
    city_country[city] = country
for _ in range(int(input())):
  print(city_country[input()])