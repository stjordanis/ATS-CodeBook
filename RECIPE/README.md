# ATS-CodeBook/RECIPE

For varieties of coding examples in ATS

## [Hello](./Hello)

This example shows how to construct a simple program in ATS, compile
it and then execute it.

## [HX-intinf](./HX-intinf)

This example presents a simple method for using GMP in ATS.
It also makes use of some timing functions for measuring performance.

## [BinarySearch](./BinarySearch)

The program in this example demonstrates a stream-based approach to
locating a zero of a given continuous function in a given interval via
the so-called binary search.

## [ReadFromSTDIN](./ReadFromSTDIN)

This example demonstrates a stream-based approach to constructing an
interactive program that handles input from the user.

## [ReadFromSTDIN2](./ReadFromSTDIN2)

This example is meant to be directly compared with
[ReadFromSTDIN](./ReadFromSTDIN). While the code in this one does
essentially the same as that of [ReadFromSTDIN](./ReadFromSTDIN), it
is written in a different style, which greatly stresses the use of
combinators in functional programming.

## [ReadFromSTDIN3](./ReadFromSTDIN3)

This example does essentially the same as the code in
[ReadFromSTDIN2](./ReadFromSTDIN2) except for using the alarm signal
(SIGALRM) to prevent the possible scenario of waiting indefinitely for
the user's input.

## [GuessNumber](./GuessNumber)

This example implements a very simple game of guessing a number chosen
from the range btween 0 and 100. During each round, the computer
prints out its guess and the player gives a response whether the guess
is less than, greater than or equal to the chosen number.

## [Hangman](./Hangman)

This example gives a straightforward implementation of Hangman, a
famous word-guessing game. A linear stream is employed to handle inputs
from the player. Also, the game-state is passed as a call-by-reference
argument to the game-loop (so as for it to be updated).
  
## [Hangman2](./Hangman2)

This example implements a distributed version of the Hangman game for
two players, where only the one who does the guessing part of the game
can send messages to the other one through a web-based uni-directional
channel.
  
## [Hangman3](./Hangman3)

This example implements another distributed version of the Hangman
game for two communicating players, where the communication is done
through two web-based uni-directional channels (that are untyped).
  
## [Tokenizer](./Tokenizer)

This example gives an implementation of a tokenizer that turns a
linear stream of characters into a linear stream of tokens (for
identifier names and (unsigned) integers.
  
## [CSV-parsing](./CSV-parsing)

This example presents a way to parse a table in the
CSV format such that each line in the table is converted into
a hashtable (of gvalues declared in *libats/ML/SATS/gvalue.sats*).
  
## [WordFrqncyCount](./WordFrqncyCount)

This example gives a stream-based implementation that counts words in
a given on-line source and then sorts these words according to their
frequencies. It also explains a bit about using an npm-based package
in ATS.

