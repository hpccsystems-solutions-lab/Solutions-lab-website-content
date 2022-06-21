# REAL
REAL data type is an n-byte standard IEEE floating point value. Valid values are 4 or 8. 

## Syntax

```java
REAL [n] attribName
```
|*Value*|*Definition*|
|:----|:---------|
REAL| Optional, recommended.
[n] | Optional, if omitted, REAL is a double-precision floating-point value (8-bytes).
attribName |  The name by which the variable will be invoked.

</br>

### Value Range

|TypeSignificant Digits|Largest Value|Smallest Value|
|----------------------|-------------|--------------|
REAL4 | 7 (9999999) | 3.402823e+038 } 1.175494e-038
REAL8 | 15 (999999999999999) | 1.797693e+308 | 2.225074e-308

#### Example

<br>
<pre id="TypeReal_Exp">

``` java
/*
REAL Examples.
*/

REAL Real_Num1 := 21.2545;
REAL Real_Num2 := 23.154;

OUTPUT(Real_Num1, NAMED('Real_Num1'));
OUTPUT(Real_Num2, NAMED('Real_Num2'));
OUTPUT( Real_Num1 + Real_Num2, NAMED('TotalSum'));

```
</pre>
<a class="trybutton" href="javascript:OpenECLEditor(['TypeReal_Exp'])"> Try Me </a>

</br>
</br>
