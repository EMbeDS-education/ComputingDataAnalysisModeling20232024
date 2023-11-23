def double_char(input_string):
  double_string = ""
  for i in input_string:
    double_string = double_string + (i*2)
  
  return double_string
  
print(double_char("Hello"))  
