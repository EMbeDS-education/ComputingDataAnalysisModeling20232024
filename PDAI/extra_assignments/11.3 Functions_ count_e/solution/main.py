def count_e(input_string):
  count = 0
  for c in input_string.lower(): 
      if c == 'e' or c == 's': 
          count = count + 1
  return count
  
def count_e2(input_string):
  return sum([ 1 for c in input_string.lower() if c == 'e' or c == 's'])


    
string = "HeEelloo sSam"
print(count_e(string))