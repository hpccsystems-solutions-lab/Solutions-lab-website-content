---
title: Decimal
slug: decimal
---

# DECIMAL

A packed decimal value of n total digits. If you have a fixed precision, use decimal instead of REAL.

## Syntax

<pre>
<EclCode 
code="[UNSIGNED] DECIMALn [_y]  attribName">
</EclCode>
</pre>

| Value      | Definition                                                                       |
| :--------- | :------------------------------------------------------------------------------- |
| [UNSIGNED] | Optional, if omitted the rightmost nibble holds the sign.                        |
| DECIMAL    | Required.                                                                        |
| n          | Total digits.                                                                    |
| [_y]       | Optional, if present, the `y` defines the number of decimal places in the value. |
| attribName | The name by which the variable will be invoked.                                  |

Keep in mind that y should always be less than or equal to n, and max is 32 leading total.

**Example**

<pre>
<EclCode 
id = 'DecimalExp_1' 
tryMe="DecimalExp_1" 
code="/*
DECIMAL Examples.
*/

// Defining a four digit value with two digit decimal placeholder.
DECIMAL4_2 Num1 := 12.36;

// Defining a five digit value with two digit decimal placeholder.
DECIMAL5_3 Num2 := 13.56;

OUTPUT(Num1, NAMED('Num1'));
OUTPUT(Num2, NAMED('Num2')); ">
</EclCode>
</pre>
