# Definition Types

Data types in ECL are used to define the layout or structure of your data. 

## BOOLEAN

A Boolean Definition is a TRUE/FALSE expression.

```java
isFlag := TRUE;
BOOLEAN hasValidName := FALSE;

```

## Value

An alphanumeric expression, describing implied value.

```java
INTEGER num := 561;

countTotal := COUNT(someDataset(age = 20));
```

## Set Definition

Defines a set of values within [ ]. All values must be of the same value type.

`set_name := []; // all elements within [] should be the same type.`

Let's look at some example

```java
nameSet := ['alex', 'Joe', 'Sam']; //A set of strings
valSet  := [56, -96, 89, -100]; //A set of integers

//A string definition can be in a set
streetType := 'street';
streetSet  := ['st', 'ct', 'dr', 'cir', streetType, 'blvd'];


countRes := COUNT(1,2,3,3,3);
intSet   := [9, 12, countRes]

//Set can contain datasets.
```
