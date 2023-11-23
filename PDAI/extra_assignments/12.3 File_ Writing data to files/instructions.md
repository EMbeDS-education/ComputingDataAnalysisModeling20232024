 

# Introduction

This text for this assignment contains many mini tasks for you to complete - they are not all listed out as 'Exercise 1', 'Exercise 2', etc. 
You will need to read the text carefully and follow along as instructed!
I repeat - you will **not** see tasks listed as 'Exercise 1', 'Exercise 2', etc. Read the instructions super carefully and write code when it tells you!


# Writing to files

Writing to files in Python is really easy. To do it, simply open a file in _write_ mode ("w" after the name of the file), use the write() method to write a string to it and then close the file once you are done. Task: Type the following code into a Python editor and run it.  

```
my_file = open("newfile.txt", "w")
my_file.write("Hello!\n")
my_file.close()
```

Have a look at the project tabs where your Python file is stored. You should see a new tab called newfile.txt - open it and look inside!  You can write multiple strings to a file whilst it is open. 
Task: Adjust your code by adding the following line before my_file.close()  

```
my_file.write("This is a bit more of my message.\n")
```

Task: Run your program and now look inside newfile.txt again.  _Note that you need to include_ "\n" _on the end of any string that you write to the file if you want the next string to appear on a new line._ Task: Finally, replace both my_file.write() lines with the following:  

```
my_file.write("Where did the message go?\n")
```

Task: Run your program and look inside newfile.txt once more.  

# Appending to files

Opening a file in write mode will cause its contents to be entirely overwritten with whatever strings are written to it before it is closed again.  Task: Replace your program with the following code:  

```
with open("newfile.txt", "**a**") as my_file:
    my_file.write("Your message is here!\n")
```

_Notice that we are now using the_ with _method for opening and closing the file. Read the lesson slides if this has confused you._
  

# Choosing between write and append mode

The choice between using write and append mode will depend on the purpose of the output file that you are writing to.  If you were using the file to store details of all users in a database you would want to append new users to the end of the file.   If you were using the file to store some settings for your program, it might be OK to overwrite them each time.  The key thing is that you understand the difference and use the most appropriate method for your program. Always use caution when using write mode as it can erase the entire contents of a file without giving you any warning, and without any way to get it back!  

# Exercise

Write a program that asks users to keep entering items to add to a To Do list until they enter the word 'stop'. 
Once all of the user's items have been entered, the user should be asked to enter a filename for their To Do file.
Finally, use a for loop to write all of the items in the list to the user's To Do file (each item on a new line), using the filename that they entered as the name of the file. If the user enters a filename for a todo list that already exists, the items that they have typed should be _added_ to the end of the existing file. Otherwise, a new file should be created that the items are written to.


**Extension**
Add validation to your program so that the user must enter a filename that contains at least one letter followed by '.txt'. The user should be repeatedly prompted for a filename until a valid one is entered. 


**Another extension**
Modify your program so that users can select to either:

1. Open and display the contents of an existing to do list file

2. Enter items to add to a new to do list file 