**Working with structured data**

So far, we have learnt to read text data from files and to write text to a file. 

 
 We then learnt how to add some structure to store a list of items, with each item being stored on a new line. This was useful for creating a program that could generate and display a list of jobs.

 
 

But what if we wanted to store more complex data than simply a list of jobs? What if, for each job, we wanted to store:

· a description of the job

· a date that it must be done by

· a priority value

 
 

To do this we could still store the details about each job on a new line in the file but use a symbol such as a comma (,) to separate each value, for example:

 
 

```
Description,Due by,Priority
```

```
Wash car,12/08/18,3
```

```
Clean room,12/08/18,2
```

```
Buy groceries,10/08/18,1
```

```
Do laundry,13/08/18,2
```

A file that is structured this way is an industry-standard, highly recognised means of storing and sharing structured data and it called a **CSV** file or **Comma Separated Value** file. Can you guess why?

 


- Each line in the file represents a _record._
- A record is a collection of data that all relates to the same thing (_entity_), for example a person or a task or a book, etc.
- Each item of data within a record is called a _field_
- Fields are separated (_delineated_) by commas

 
 

The first line in a CSV is often (but not always) a _header_ row, which manes that it stored the column headings (or field names) for the file, rather than actual data values themselves.

 
 

**Using CSV files in other applications**

 
Because CSV files are made of simple text they can be easily read by different applications including spreadsheet applications such as Microsoft Excel, OpenOffice Calc and Apple Numbers. 

 
 

# Reading CSV files in Python

So, we know what CSV files are and (hopefully), we've even managed to open one in a spreadsheet and see its contents. Let's look at how we can use them in Python.

 
 

Because CSV files are simply structured text files, we could just use the same technique that we have already learnt for displaying their contents line-by-line in Python.

 
 

**Exercise**

Write a function called "read_csvfile" to  see the contents of the todo.csv file. 

Let's extend the function so that each of the individual values within each record can be accessed and used.

You can use line._strip()_, this is necessary to remove the new line character that is added to the end of each line in the text file and can mess up the display of data when it is printed.

The second technique to use is values = line._split(",")_. This simple line of code cuts up the line string every time it comes across a comma and returns a list that contains each item from the row of text as a new element.

Let's do one more thing to improve the output of our todo list items. Instead of simply saying the priority of each item is either 1, 2 or 3, we are going to read those values and replace them with "High", "Medium" and "Low" as appropriate.

```
**if** values[2] == **'1'**:
    values[2] = **"High"**
**elif** values[2] == **'2'**:
    values[2] = **"Medium"**
**elif** values[2]== **'3'**:
    values[2] = **"Low"**
```

Finally, let's look at how we could format the output to make it a little nicer. Amend your code to present your list of to do items as a table.
 
 

Here's an example of the output that you should be aiming for:

 

```
+-------------------------------------+
|Job Description|Due by    |Priority  |
+-------------------------------------+
|Wash car       |12/08/18  |Low       |
|Clean room     |12/08/18  |Medium    |
|Buy groceries  |10/08/18  |High      |
|Do laundry     |13/08/18  |Medium    |
+-------------------------------------+
```

_**HINT**_: you must use the following instructions  to print tabular data

```
border = "+" + "-" * 37 + "+\n" # to print a border table
```

```
table += border
```

```
...
```

```
table+=**f"|{**values[0]**:15}|{**values[1]**:10}|{**values[2]**:10}|\n"** _# print tabular data_
```

 
 
 Reading CSV files in Python
 So, we know what CSV files are and (hopefully), we've even managed to open one in a spreadsheet and see its contents. Let's look at how we can use them in Python.
 
 
 
 Because CSV files are simply structured text files, we could just use the same technique that we have already learnt for displaying their contents line-by-line in Python.
 
 
 
 **Exercise**
 Enter the following code into the code editor and run your program. You should see the contents of the todo.csv file is shown in the console (the black box at the bottom).
 with open('todo.csv','r') as data_file: for line in data_file:
 print(line, end="")
print() # Needed just to return the cursor to a new line after showing the file 
 
 
 Of course, if we have a file of data we probably want to do something with it more than simply printing it out like a text file.
 
 
 
 **Exercise**
 Let's extend our program so that each of the individual values within each record can be accessed and used.
 
 You can use line.strip(). This is necessary to remove the new line character that is added to the end of each line in the text file and can mess up the display of data when it is printed.
 The second technique to use is values = line.split(","). This simple line of code cuts up the line string every time it comes across a comma and returns a list that contains each item from the row of text as a new element.
 Let's do one more thing to improve the output of our todo list items. Instead of simply saying the priority of each item is either 1, 2 or 3, we are going to read those values and replace them with "High", "Medium" and "Low" as appropriate.
  
  Finally, let's look at how we could format the output to make it a little nicer. Amend your code to present your list of to do items as a table.
 
 
  Here's an example of the output that you should be aiming for:
 
 
 
 +-----------------------------------------+| Job description | Due by | Priority |
+-----------------------------------------+
| Wash car | 12/08/18 | Low |
| Clean room | 12/08/18 | Medium |
| Buy groceries | 10/08/18 | High |
| Do laundry | 13/08/18 | Medium |
+-----------------------------------------+  
  HINT: 
 line =   **"+"**+ **"-"** * 37 + **"+\n"** 
 **tabular_data =** 
 table += **"+"**+ **"-"** * 37 + **"+\n"** _# creates a line_
 