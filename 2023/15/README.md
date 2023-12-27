# Day 15: Lens Library

[Full info here](https://adventofcode.com/2023/day/15)

## Part One

>The HASH algorithm is a way to turn any string of characters into a single
number in the range 0 to 255. To run the HASH algorithm on a string, start with
a current value of 0. Then, for each character in the string starting from the
beginning:

>- Determine the ASCII code for the current character of the string.
>- Increase the current value by the ASCII code you just determined.
>- Set the current value to itself multiplied by 17.
>- Set the current value to the remainder of dividing itself by 256.

>After following these steps for each character in the string in order, the
current value is the output of the HASH algorithm.

>The initialization sequence (your puzzle input) is a comma-separated list of
steps to start the Lava Production Facility. Ignore newline characters when
parsing the initialization sequence. To verify that your HASH algorithm is
working, the book offers the sum of the result of running the HASH algorithm on
each step in the initialization sequence.

>For example:
```
rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7
```

## Part Two

>The book goes on to describe a series of 256 boxes numbered 0 through 255. The
boxes are arranged in a line starting from the point where light enters the
facility. The boxes have holes that allow light to pass from one box to the
next all the way down the line.
```
      +-----+  +-----+         +-----+
Light | Box |  | Box |   ...   | Box |
----------------------------------------->
      |  0  |  |  1  |   ...   | 255 |
      +-----+  +-----+         +-----+
```

>Inside each box, there are several lens slots that will keep a lens correctly
positioned to focus light passing through the box. The side of each box has a
panel that opens to allow you to insert or remove lenses as necessary.

>If the operation character is a dash (-), go to the relevant box and remove the
lens with the given label if it is present in the box. Then, move any remaining
lenses as far forward in the box as they can go without changing their order,
filling any space made by removing the indicated lens. (If no lens in that box
has the given label, nothing happens.)

>If the operation character is an equals sign (=), it will be followed by a
number indicating the focal length of the lens that needs to go into the
relevant box; be sure to use the label maker to mark the lens with the label
given in the beginning of the step so you can find it later. There are two
possible situations:

>- If there is already a lens in the box with the same label, replace the old
lens with the new lens: remove the old lens and put the new lens in its place,
not moving any other lenses in the box.
>- If there is not already a lens in the box with the same label, add the lens
to the box immediately behind any lenses already in the box. Don't move any of
the other lenses when you do this. If there aren't any lenses in the box, the
new lens goes all the way to the front of the box.

>With the help of an over-enthusiastic reindeer in a hard hat, follow the
initialization sequence. What is the focusing power of the resulting lens
configuration?

---

## Solution

This puzzle didn't have a whole lot of complication.

Building the hash function and the box behavior just required careful 
attention to the puzzle description.



