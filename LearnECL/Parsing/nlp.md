# NLP

NLP (Natural Language Parsing) is the process of determining the syntactic structure of a text by analyzing its constituent words based on an underlying grammar.

# String Parsing

String parsing, or syntactic analysis is the process of analyzing a string of symbols, either in natural language, computer languages or data structures, conforming to the rules of a formal grammar.

# How it's done

To parse (pattern match) content/text, start by defining your PATTERNS, and defining your end result record structure, then use the PARSE function to go over your content.

## PATTERN

Defines the specific text to be searched/detected in the content. Start parse patterns by creating "atomic" bits and then growing them into more complex patterns as you go. So the first thing we need to do is define the atomic level of patterns. Patterns use Perl standard regular expressions to define a matching character sequences.\
When defining a pattern, you basically assigning type of pattern to an attribute. \

`PATTERN attribute name := PATTERN ();`

Any number of alpha characters together:

    PATTERN Alpha := PATTERN('[A-Z]')+;

Single numeric digit:

    PATTERN Nbr := PATTERN('[0-9]');

Separators -- including "space" character:

    PATTERN Sep := PATTERN('[-, /.]');

Space, tab, new line, and return characters are all white space:

    PATTERN ws := PATTERN('[ \t\r\n]');

## OPT

Everything within the parenthesis is optional. Opt and regular expression can be used to build more complex patterns.

"white space" = 1 or 2 separators:

    PATTERN Ws := Sep OPT(Sep);

1 or 2-digit number:

    PATTERN Num12 := OPT(Nbr) Nbr;

2 or 4-digit number:

    PATTERN Year := Nbr Nbr OPT(Nbr Nbr);

2 or 4-digit number using regular expression:

    PATTERN Year := Nbr*2 OPT(Nbr*2);

### Complex Pattern

Patterns are used to show different ways of representing search patterns. They can be combined using logical OR (|) to build final Pattern.

In the following example, two different types of time patterns, AMPM and Zulu are used to build a final pattern(time).

```java
//AMPM: A numeric pattern ending with a non-optional Alpha pattern.
//Zulu: Purely numeric pattern, three instances of Num12 delimited by colons,
//giving us hours, minutes and seconds.

PATTERN Alpha := PATTERN('[A-Z]')+;
PATTERN AMPM  := Num12 ':' Num12 OPT(':' Num12) ' ' Alpha;
PATTERN Zulu  := Num12 ':' Num12 ':' Num12;
PATTERN Time  := (AMPM | Zulu); // | logical OR
```

## TRANSFORM Functions

Followings are used with in conjunctions with Transform for parsing purposes.

### MATCHED(_pattern_)

Returns true or false as to whether the named pattern found a match.

### MATCHTEXT([*pattern*])

Returns the matching ASCII text the Pattern found. If a named is omitted, MATCHTEXT returns all matching text.

### MATCHUNICODE([*pattern*])

Returns the matching Unicode text the named pattern found. If a named is omitted, MATCHUNICODE returns all matching Unicode text.

## Validate Function

`VALIDATE(pattern, isValidExpression)`\
Check the validity of the pattern. `isValidExpression` is an expression or function that returns a Boolean and should use MATCHTEXT or MATCHUNICODE to refer to the text that matched the pattern.

```java
PATTERN Alpha := PATTERN('[A-Z]')+;
SetMonths := ['JAN','FEB','MAR','APR','MAY','JUN','JUL','AUG','SEP','OCT','NOV','DEC'];

//inline function: evaluate the first 3 charcters of the text.
isValidMonth(STRING txt) := txt[1..3] IN SetMonths;
PATTERN Month := VALIDATE(Alpha,isValidMonth(MATCHTEXT)) ;
```

## RULE

Defines our final pattern possibilities, combined with logical OR (|). The patterns are treated as Tokens.

    RULE DateRule := (NumDate | AlphaDate1 | AlphaDate2);

## TOKEN

The TOKEN value type defines a parsing expression very similar to a PATTERN, but once matched, the parser doesn't backtrack to find alternative matches as it would with PATTERN.

## PARSE

Processes an input dataset much like NORMALIZE does, parsing a given field's data to see if it satisfies a given rule, producing a result set of those matches via a TRANSFORM. If multiple results are found they all will be returned.

\
Put it into practice [dataParsing.ecl](https://ide.hpccsystems.com/workspaces/share/291d17d9-e5cb-4fac-83c2-ac5997c28a31)

Put it into practice [simpleParsing.ecl](https://ide.hpccsystems.com/workspaces/share/291d17d9-e5cb-4fac-83c2-ac5997c28a31)

**References**\
[Parsing tips and tricks by Richard Taylor](https://hpccsystems.com/blog/Tips_and_Tricks_for_ECL_Part2_PARSE)
