# Data Types

Data types in ECL are used to define the layout or structure of your data. 

Data types supported in ECL:
- INTEGER
- REAL
- UNSIGNED
- DECIMAL
- STRING
- UFT
- UNICODE
- BOOLEAN

## INTEGER 
An n-byte integer value. Valid values for n are: 1, 2, 3, 4, 5, 6, 7,or 8. Default is 8-bytes.

### Syntax 
```java
[UNSIGNED] INTEGER attribName
```

|*Value*|*Definition*|
|:----|:---------|
UNSIGNED | Optional, if omitted the integer is signed
INTEGER  | OPtional, recommended
attribName | The name by which the variable will be invoked

<br>

### Value Range

|Size | Signed Values |	Unsigned Values |
|-----|---------------|-----------------|
1-byte | -128 to 127 | 0 to 255
2-byte | -32,768 to 32,767 | 0 to 65,535
3-byte | -8,388,608 to 8,388,607 |	0 to 16,777,215
4-byte | -2,147,483,648 to 2,147,483,647 |	0 to 4,294,967,295
5-byte | -549,755,813,888 to 549,755,813,887 | 0 to 1,099,511,627,775
6-byte | -140,737,488,355,328 to 140,737,488,355,327 |	0 to 281,474,976,710,655
7-byte | -36,028,797,018,963,968 to 36,028,797,018,963,967 |	0 to 72,057,594,037,927,935
8-byte | -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807	| 0 to 18,446,744,073,709,551,615


#### Example

<br>
<pre id="TypeInt_Exp">

``` java
INTEGER Val1 := 12;
INTEGER Val2 := 12.5;

// Notice the decimal point has been cut off
Val1 + Val2;

Val3 := 67;
Val4 := 10;

Val3 * Val4;
```
</pre>
<a class="trybutton" href="javascript:OpenECLEditor(['TypeInt_Exp'])"> Try Me </a>


## REAL
An n-byte standard IEEE floating point value. Valid values are 4 or 8. 

### Syntax

```java
REAL [n] attribName
```
|*Value*|*Definition*|
|:----|:---------|
REAL| Optional, recommended
[n] | Optional, if omitted, REAL is a double-precision floating-point value (8-bytes).
attribName |  The name by which the variable will be invoked

<br>

|TypeSignificant Digits|Largest Value|Smallest Value|
|----------------------|-------------|--------------|
REAL4 | 7 (9999999) | 3.402823e+038 } 1.175494e-038
REAL8 | 15 (999999999999999) | 1.797693e+308 | 2.225074e-308

#### Example

<br>
<pre id="TypeReal_Exp">

``` java
```
</pre>
<a class="trybutton" href="javascript:OpenECLEditor(['TypeReal_Exp'])"> Try Me </a>


## UNSIGNED

## DECIMAL
## STRING
## UFT
## UNICODE
## BOOLEAN







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
