---
title: Choose
slug: choose
---

# CHOOSE

CHOOSE function evaluates the expression and returns the value parameter whose ordinal position in the list of parameters corresponds to the result of the expression. If no match is found it will return the else-value. All values as well as the else-value for this function must have the same type. 

**Example**

<pre >
<EclCode
id="ChooseExp_1"
tryMe="ChooseExp_1"
code="/*CHOOSE Example:*/

Eval := 4;

CHOOSE(Eval, 2, 3, 5, 6, 20);      // Returns 6

CHOOSE(Eval, 6, 6, 7, 10, 9, 11);  // Returns 10

CHOOSE(Eval, 3, 4, 8);             // Returns 8 (the else value)">
</EclCode>
</pre>

## Syntax

<pre>
<EclCode code="CHOOSE(Expression, Value1, ..., ValueN, Else);">
</EclCode>
</pre>

| _Value_ | _Definition_ |
| :- | :- |
| Expression | Evaluation field. |
| Value1 … ValueN | If expression matches it will return the result. |
| Else | If nothing matches else-value is returned. |

**Example**

<pre>
<EclCode
id="ChooseExp_2"
tryMe="ChooseExp_2"
code="/*
CHOOSE Example:
*/

// Evaluates the Expression field (value 2) and uses it to return value 5 (value in position 2 of values)
CHOOSE(2, 3, 5, 6, 20);          

// Evaluates the Expression field (value 3) and uses it to return 'baz' (value in position 3 of values)
CHOOSE(3, 'foo', 'bar', 'baz');  

// Evaluates the Expression field (value 5) and uses it to return the Else value 'baz' (No value in position 5 of values, thus returns Else value'baz') 
getVal := CHOOSE(5, 'foo', 'bar', 'baz');  

OUTPUT(getVal, NAMED('getVal'));">
</EclCode>
</pre>
