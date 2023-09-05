---
title: Boolean
slug: boolean
---

# BOOLEAN

A boolean data type is used to represent a logical value that can have one of two possible states: true or false. It is commonly used to express conditions, comparisons, and decisions. In a boolean context, true indicates that a condition is met or that something is valid, while false indicates the opposite.

## Syntax

<pre>
<EclCode
code="BOOLEAN attribName">
</EclCode>
</pre>

| Value      | Definition                                      |
| :--------- | :---------------------------------------------- |
| BOOLEAN    | Optional.                                       |
| attribName | The name by which the variable will be invoked. |

**Example**

<pre >
<EclCode 
id = 'BoolExp_1'
tryMe="BoolExp_1"
code="/* BOOLEAN Examples.*/

isFlag := TRUE;
OUTPUT(isFlag, NAMED('isFlag'));

// When defined BOOLEAN 1 = TRUE and 0 = FALSE
BOOLEAN hasValidName := 0;
OUTPUT(HasValidName, NAMED('HasValidName'));

// Boolean evaluation
OUTPUT(10 >= 2, NAMED('Evaluation'));">
</EclCode>
</pre>
