# MAP Function

MAP function evaluates the list of Boolean expressions and returns the value associated with the first true expression. 

MAP Characteristics

- If no match is found than the else-value is returned
- All return values and else_value values must be of the same type 
- All expressions must reference the same level of dataset scoping. Therefore, all expressions must either reference fields in the same dataset or the existence of a set of related child records 
- The expressions are evaluated in the order in which they appear.

## Syntax

```java
attr_name := MAP(expression1 => value1,
                 expression2 => value2,
                 ...
                 ...
                 expressionN => valueN
                 [,else_value]
                 )
```

</br>

|*Value*|*Definition*|
|:------|:---------|
attr_name | The name by which the function will be invoked
MAP| ECL Keyword, required
Expression1…N  | Boolean expression
=>| “Result in” operator
Else_value| Optional if all other possible return values are actions, otherwise required. The value to return if all expressions are false.


<br>
#### Example

<br>
<pre id = 'MapExp_1'>

```java
/*
MAP Example:
*/

Value := 120;

Assessment := MAP(Value BETWEEN  0   AND 50   => 'Under Estimated',
                  Value BETWEEN  51  AND 100  => 'About Right',
                  Value BETWEEN  101 AND 150  => 'Still Acceptable',
                  Value BETWEEN  151 AND 200  => 'Too High',
                 'Rejected');

OUTPUT(Assessment, NAMED('Assessment'));
```

</pre>
<a class="trybutton" href="javascript:OpenECLEditor(['MapExp_1'])"> Try Me </a>

## Logical Operators 
Logical values that can be used for comparison of two values.

</br>

**Demo Dataset**

|PersonID|FirstName|LastName|isEmployed|avgHouseIncome|
|:----|:---|:---|:----|:---|
102 | Fred | Smith | FALSE | 0
012 | Joe | Blow | TRUE | 11250
085 | Blue | Moon | TRUE | 185000
055 | Silver | Jo | FALSE | 5000
265 | Darling | Jo | TRUE | 5000
333 | Jane | Smith | FALSE | 50000

</br>

<br>
<pre id = 'MapExp_2'>

```java
/*
MAP Example:
Using logical operations
*/


Value  := 100;
Flag   := False;
Letter := 'A';

Assessment := MAP(Value BETWEEN  0   AND 50    OR  Flag  => 'Under Estimated',
                  Value BETWEEN  51  AND 100  AND ~Flag => 'About Right',
                  Value BETWEEN  101 AND 150 AND ~Flag AND Letter = 'A' => 'Still Acceptable',
                  Value BETWEEN  151 AND 200 => 'Too High',
                  'Rejected');

OUTPUT(Assessment, NAMED('Assessment'));
```

</pre>
<a class="trybutton" href="javascript:OpenECLEditor(['MapExp_2'])"> Try Me </a>

</br>

## Logical Operators 
Logical values that can be used for comparison of two values.

</br>

|Operator|Description|
|:----|:---|
=	  | Equal
\>  | Greater than
<	  | Less than
\>= | Greater than or equal	
<=  | Less than or equal	
<>  | Not equal
!=  | Not equal
~   | Not
AND | Logical AND
OR  | Logical OR
IN  | To specify multiple possible values for a field/column
NOT IN  | To specify multiple possible values that are not in a field/column
BETWEEN | Between a certain range
