# Function

A Function is a set of statements that take inputs, does some specific computation and produces an output or return a result. Result could be a value or a dataset.

</br>

**Notes**

- For function to be called/used from outside, `EXPORT` is required
- Function name should match the file name. if not "Error: Definition must contain EXPORT or SHARED " is generated

</br>

## Syntax

```java
EXPORT [return_data_type] function_name (data_type arg [, data_type arg]+) := FUNCTION

    ecl_code
    RETURN return_value;

END;
```
|*Value*|*Definition*|
|:----|:---------|
EXPORT | Optional
return_data_type|Optional (compiler can infer it from return_value). If returning a dataset, the data type is DATASET(record_definition)
function_name| The name by which the function will be invoked
data_type| The argument’s data type. If passing a dataset, the data type is DATASET(record_definition)
ecl_code| Whatever code is needed to build return_value. Conversely, if the code does not contribute to return_value then it is ignored. Attributes defined here are scoped to the function
RETURN|Required
return_value|The result of the function
END|Required

#### Example

<br>
<pre id = 'FuncExp_1'>

```java
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


```
</pre>
<a class="trybutton" href="javascript:OpenECLEditor(['FuncExp_1'])"> Try Me </a>


## Outputs in Function - Using WHEN

`OUTPUT` can be used to return multiple results from a function. `PARALLEL` and `WHEN` are the keywords used to generate multiple results.

`PARALLEL` let's you run actions in parallel and `WHEN` behaves as a trigger. WHEN is used in scheduling.

#### Example

<br>
<pre id = 'FuncExp_2'>

```java
/*
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
```
</pre>
<a class="trybutton" href="javascript:OpenECLEditor(['FuncExp_2'])"> Try Me </a>


## One Line Function

If you don’t have any ecl_code for the function, it is a one-liner. \
`FUNCTION`, `RETURN` and `END` keywords are omitted.

#### Example

<br>
<pre id = 'FuncExp_3'>

```java
/*
FUNCTION Example:
One line function
*/

UNSIGNED2 Squared(UNSIGNED1 n) := n * n;

isEven(INTEGER num) := num % 2 = 0;
```
</pre>
<a class="trybutton" href="javascript:OpenECLEditor(['FuncExp_3'])"> Try Me </a>


