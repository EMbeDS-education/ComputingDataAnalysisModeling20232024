import re

def top_10words(fname): 
  freqword = {}
  
  with open(fname) as f:
    read_data = removePunctuations(f.read().lower()).split()
    read_data = removeStopwords(read_data)
    for w in read_data:
      if w in freqword:
          freqword[w] += 1
      else:
          freqword[w] = 1

    top_words = sorted(freqword.items(), key=lambda item: item[1], reverse=True)[:10]
 
  return top_words
  
def removeStopwords(wordlist):
  with open("stopwords_italian.txt","r") as f:
    stopwords = f.read().splitlines()
    return [w for w in wordlist if w not in stopwords]

# define remove Punctuations
def removePunctuations(txt):
  return re.sub(r'[^\w\s]','',txt)
  
top_words = top_10words('manzoni_1.txt')
print(top_words)