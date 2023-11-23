s = input()
if 'p' in s:
  if s.find('p') == s.rfind('p'):
    print(-1)
  else:
    print(s.find('p') + s[s.find('p') + 1:].find('p') + 1)
else:
  print(-2)