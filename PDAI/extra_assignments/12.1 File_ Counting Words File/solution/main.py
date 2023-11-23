def nword_file(name): # to complete
  with open(name) as f:
    read_data = f.read().lower() 
    # using split() 
    # to count words in string 
    res =  len(set(read_data.split()))
    return res
    
    
print(nword_file('dante_1.txt'))