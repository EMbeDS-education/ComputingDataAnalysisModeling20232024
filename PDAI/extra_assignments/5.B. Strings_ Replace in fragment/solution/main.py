s = input()
first_pos, last_pos = s.find('h') + 1, s.rfind('h')
left, middle, right = s[:first_pos], s[first_pos:last_pos], s[last_pos:]
print(left + middle.replace('h', 'H') + right)