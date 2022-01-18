# BOOLEAN

A Boolean data type is a TRUE/FALSE expression.

## Syntax

```java
BOOLEAN attribName
```
|*Value*|*Definition*|
|:------|:---------|
BOOLEAN | Optional.
attribName | The name by which the variable will be invoked.

<br>
#### Example

<br>
<pre id = 'BoolExp_1'>

```java
/*
BOOLEAN Example:
Showing different ways of how a boolean value works.
*/


isFlag := TRUE;
OUTPUT(isFlag, NAMED('isFlag'));

// When defined BOOLEAN 1 = TRUE, 0 = FALSE
BOOLEAN hasValidName := 0;
OUTPUT(HasValidName, NAMED('HasValidName'));

// Boolean evaluation
OUTPUT(10 >= 2, NAMED('Evaluation'));
```
</pre>
<a class="trybutton" href="javascript:OpenECLEditor(['BoolExp_1'])"> Try Me </a>
