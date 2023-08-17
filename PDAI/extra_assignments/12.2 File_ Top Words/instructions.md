Write a function called "top_10words" that has a string argument (filename).  It should remove stop words (and punctuations) and return the top 10 words with highest frequency in the document "danta_1.txt".

Stop words are usually the most common in any text ( like “the”, “of”, “to” and “and”), so they don’t tell us much that is distinctive about Divina Commedia. In general, we are more interested in finding the words that will help us differentiate this text from texts that are about different subjects. So we’re going to filter out the common function words. Words that are ignored like this are known as stop words.  

Files:

- manzoni_1.txt: Promessi Sposi, Capitolo I.
- stopwords_italian.txt: the most common in any Italian language text

**Output** is dictionary of word-frequency:

 

```
[('don', 28), ('due', 27), ('poi', 24), ('abbondio', 21), ('ogni', 19), ('de', 18), ('qualche', 18), ('sempre', 18), ('quel', 17), ('cosa', 17)]
```

_Hint: convert all text to lower case_

Documentation on https://docs.python.org/3/tutorial/inputoutput.html 