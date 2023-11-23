Write a function called "first_letter" that has a string argument.  It should return the first letter of the string.

**Note**

The keyword `[def](https://repl.it/teacher/assignments/reference/compound_stmts.html#def)` introduces a function _definition_. It must be followed by the function name and the parenthesized list of formal parameters. The statements that form the body of the function start at the next line, and must be indented. 

The _execution_ of a function introduces a new symbol table used for the local variables of the function. More precisely, all variable assignments in a function store the value in the local symbol table; whereas variable references first look in the local symbol table, then in the local symbol tables of enclosing functions, then in the global symbol table, and finally in the table of built-in names. 

The actual parameters (arguments) to a function call are introduced in the local symbol table of the called function when it is called; thus, arguments are passed using _call by value_ (where the _value_ is always an object _reference_, not the value of the object). [1](https://repl.it/teacher/assignments/4954335/edit#id2) When a function calls another function, a new local symbol table is created for that call. 

