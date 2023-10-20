---
title: Function
slug: function
---

# FUNCTION

A Function is a set of statements that take input, does some specific computation and produces an output or returns a result. The result could be a value or a dataset.

Notes

* For a function to be called/used from outside of the current module, EXPORT is required.
* A non-BWR (Builder Window Runnable) file must have an EXPORTed attribute that matches the filename, if not "Error: Definition must contain EXPORT or SHARED" is generated.
* The EXPORTed attribute must be the last exported attribute in the file. It is perfectly legal to have other (local or SHARED) attributes preceding the final EXPORTed attribute.

## Syntax

<pre>
<EclCode code="EXPORT [return_data_type] function_name (data_type arg [, data_type arg]+) := FUNCTION

    ecl_code
    RETURN return_value;

END;">
</EclCode>
</pre>

| _Value_ | _Definition_ |
| :- | :- |
| EXPORT | Optional. |
| return_data_type | Optional (compiler can infer it from return_value). If returning a dataset, the data type is DATASET(record_definition). |
| function_name | The name by which the function will be invoked. |
| data_type | The argument’s data type. If passing a dataset, the data type is DATASET(record_definition). |
| ecl_code | Whatever code is needed to build return_value. Conversely, if the code does not contribute to return_value then it is ignored. Attributes defined here are scoped to the function |
| RETURN | Required |
| return_value | The result of the function. |
| END | Required. |

**Example**

<pre>
<EclCode
id="FunctionExp_1"
tryMe="FunctionExp_1"
code="/*Function Example:*/

/*
Function Example:
*/

EXPORT MyFunc (STRING Val) := FUNCTION

   Result := 'Hello ' + Val + ' , welcome to this function';
   RETURN Result;

END;

// Using MyFunc
Res := MyFunc('Jonny');
OUTPUT(Res, NAMED('res'));

OUTPUT(MyFunc('Sunny'), NAMED('Sunny'));

"></EclCode>
</pre>

## Outputs in Functions - Using WHEN

OUTPUT can be used to return multiple values from a function. 

PARALLEL is an action which allows items in an actionlist to execute simultaneously and the WHEN function behaves as a trigger. 

WHEN allows actions based on triggers such as after a value is computed.

**Example**

<pre>
<EclCode
id="FunctionExp_2"
tryMe="FunctionExp_2"
code="/*
Function Example:
Outputting multiple values using WHEN.
*/

Pop_Layout := RECORD
    STRING   City;
    STRING   State;
    STRING   County;
    INTEGER  Population;
END;
Pop_DS := DATASET([
                {'Dauphin Island','AL','Mobile',1335},
                {'Guy','AR','Faulkner',778},
                {'El Centro','CA','Imperial',111425},
                {'Indio','CA','Riverside',417059},
                {'Englewood','CO','Arapahoe',6183},
                {'Keywest','FL','Monroe',31401}], 
                Pop_Layout);


SomeFunc(DATASET(Pop_Layout) Pop_DS) := FUNCTION


    Str        := 'This is a WHEN example.';
    SomeFilter := Pop_DS(Pop_DS.Population >= 50000);
    MaxPop     := Pop_DS(Population = MAX(Pop_DS, Population));

  SideActions := PARALLEL
     (
         OUTPUT(Pop_DS, NAMED('Pop_DS'));
         OUTPUT(SomeFilter, NAMED('SomeFilter'));
         OUTPUT(MaxPop, NAMED('MaxPop'));
     );

  RETURN WHEN(Str, SideActions);
END;


// Calling the SomeFunc function
SomeFunc(Pop_DS);

"></EclCode>
</pre>

## One Line Function
If you don't have any ecl_code for the function, it is a one-liner. FUNCTION, RETURN, and END keywords are omitted.

**Example**

<pre>
<EclCode
id="FunctionExp_3"
tryMe="FunctionExp_3"
code="/*
FUNCTION Example:
One line function
*/

// Squared Function Example
UNSIGNED2 Squared(UNSIGNED1 n) := n * n;

// isEven Function Example
isEven(INTEGER num) := num % 2 = 0;

OUTPUT(Squared(3), NAMED('SquaredFunction'));
OUTPUT(isEven(10), NAMED('isEvenFunction'));

"></EclCode>
</pre>