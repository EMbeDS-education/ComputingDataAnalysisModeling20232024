import re
# defines removePunctuations function
def removePunctuations(txt):
  return re.sub(r'[^\w\s]','',txt)
  
def top_10words(fname):
  # to complete ...
  return top_words
  

top_words = top_10words('manzoni_1.txt')
print(top_words)