**Reading the contents of a text file in Python**

Being able to read files means that we can load data into our programs and use that data for whatever we might wish. For example, we might read in a list of users and their passwords so that we could have a program that only runs for authenticated users.
To open a file in Python you simply need to use the open() function and assign its return value to a variable that will represent the file's contents:


```
file = open('my_file.txt', 'r')
```

Once you have finished playing around with your file it is **essential** that you _close_ the file so that it is released by the operating system for other processes to use. You can do this with the close() method of the file object:


```
file.close()
```

# File opening modes

The open() function takes two arguments in this case. The first is the name of the file that you wish to open (not every file is going to be called my_file.txt!). The second argument specifies the _mode_ that you want to open the file in. Files can be opened in the following modes:


- r - read mode. Use this when you want to read a file's contents.
- w - write mode. Use this when you want to overwrite the contents of a file.
- a - append mode. Use this when you want to add (write) text data to the end of a file.

# File operations

You can now perform various operations on your file, such as reading its entire contents, reading a certain number of bytes of the file, reading an individual line, getting all of the lines of a file or iterating (looping) through the file, line by line.
Here are examples of how to do each of these operations with a file object.


```
file = **open**('my_file.txt', 'r')


# Access the whole of the file's contents
whole_file_contents = file.**read()**
print(whole_file_contents)


# Access a certain number of bytes of the file:
first_four_bytes = file.**read(4)**
print(first_four_bytes)


# Access a line of the file:
first_line = file.**readline()**  # readline() returns the next line in the file that hasn't yet been read
second_line = file.**readline()**
print(first_line)
print(second_line)


# Get a list containing each line of the file as a different element
file_lines = file.**readlines()**
third_line = file_lines[2]  #file_lines is a list, so you can use square bracket notation to access an item from the list by its index number
print(third_line)


# Loop through each line in the file:
for **line** in **file**:
    print(line)
    input("Press Enter to read the next line...")


# Close the file now that we are finished with it
file.**close()**
```

# The with method

There is another way to open a file that ensure that it will **always** be closed for you when you are done. This method uses the with keyword:


```
**with** open('my_file.txt', 'r') **as** file:
    # write your code for how you want to use file within the indented block
    print(file.readline())

```

In the with method we still make use of open() so all of the file opening modes apply. You also still get file object that you can call your methods on - this is accessed by the variable name specified after the as keyword. In the example above, the variable name is 'file', but it could have been anything sensible.
If you find the with method confusing then don't worry about it for now. There is nothing wrong with using a combination of open() and close(), as long as you remember to close your files every time!
  

**TASK** 

Write a function called "nword_file" that has a string argument.  It should return [the number of unique words ](http://agendatarragona.com/egkc88l/count-number-of-unique-words-in-a-text-file-python.html)[in the document "danta_1.txt" and print it.](https://stackoverflow.com/questions/6255641/counting-the-number-of-unique-words-in-a-document-with-python)

 Documentation on [https://docs.python.org/3/tutorial/inputoutput.html](https://docs.python.org/3/tutorial/inputoutput.html) 