# IF Statement

The IF function allows you to make a logical comparison between value(s) and what returning a result if that condition is True or False.



## Syntax

```java
attr_name := IF(expression, true_result [, false_result])
```

|*Value*|*Definition*|
|:------|:---------|
attribName | The name by which the variable will be invoked.
IF| Required
expression| Boolean expression to be check for True or False
true_result| Result value or action if expression is True
false_result|May be omitted only if true_result is an action


<br>
#### Example

<br>
<pre id = 'IfExp_1'>

```java
/*
IF Example:
Example includes nested IF*/

Permission := 23;
Age        := 12;

Res1 := IF(Permission >= Age, 'Application Accepted', 'Application Rejected');

Flag := FALSE;
Res2 := IF(Flag, ', Try Again', ', Move on');

Final := IF(Res1 = 'Application Accepted' AND Res2 = ', Move on',
              OUTPUT(Res1 + Res2, NAMED('Passed')),
              OUTPUT(Res1 + Res2, NAMED('Failed'))
           );

Final;

```

</pre>
<a class="trybutton" href="javascript:OpenECLEditor(['IfExp_1'])"> Try Me </a>

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
