ACTION_TO_RIGHT = {
  'read': 'R',
  'write': 'W',
  'execute': 'X',
}

file_rights = {}
for _ in range(int(input())):
  filename, *rights = input().split()
  file_rights[filename] = set(rights)
for _ in range(int(input())):
  action, filename = input().split()
  if ACTION_TO_RIGHT[action] in file_rights[filename]:
    print('OK')
  else:
    print('Access denied')
