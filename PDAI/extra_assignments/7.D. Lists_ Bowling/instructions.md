# Statement

In bowling, the player starts with 10 pins in a row at the far end of a lane. The goal is to knock all the pins down. For this assignment, the number of pins and balls will vary. Given the number of pins _N_ and then the number of balls _K_ to be rolled, followed by _K_ pairs of numbers (one for each ball rolled), determine which pins remain standing after all the balls have been rolled.

The balls are numbered from 1 to _N_ for this situation. The subsequent number pairs, one for each _K_ represent the first and last (inclusive) positions of the pins that were knocked down with each roll. Print a sequence of _N_ characters, where `"I"` represents a pin left standing and `"."` represents a pin knocked down.

# Example input

```
10 3
8 10
2 5
3 6
```

# Example output

```
I.....I...
```

# Theory

If you don't know how to start solving this assignment, please, review a theory for this lesson:

https://snakify.org/lessons/lists/ 


You may also try step-by-step theory chunks:

https://snakify.org/lessons/lists/steps/1/