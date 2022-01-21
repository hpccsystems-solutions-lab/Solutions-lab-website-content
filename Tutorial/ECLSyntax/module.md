# MODULE

MODULE is s a container that allows you to group related definitions and functionalities. The parameters passed to the module are shared by all the related members definitions.

</br>

**Notes** 
- `OUTPUT` <u>can not</u>  be used within a module
- For modules to be called/used from outside, `EXPORT` is required
- Module name should match the file name. if not "Error: Definition must contain EXPORT or SHARED " is generated
- To call a module: `ModuleName.attributeName;`

### Variable Scope

**LOCAL**   Definitions are visible only up to an EXPORT or SHARED.

**SHARED**  Definitions are visible through module.

**EXPORT**  Definitions are visible within and outside of a module.

Modules can contain multiple, SHARED and EXPORT values.

## Syntax

```java
EXPORT module_name [ ( parameters ) ] := MODULE
    ...
    SHARED
    ...
    ...
    EXPORT
END
```

|*Value*|*Definition*|
|:----|:---------|
EXPORT| Optional, indicates that this module is available outside of this file
module_name |The name of the function
param_data_type |Data type of each parameter (string, integer, Boolean, …)
MODULE | required
SHARED |The attribute or function can be accessed within the module
EXPORT |The attribute or function can be accessed from outside of the module
END |Indicates the end of module

#### Example

<br>
<pre id = 'ModExp_1'>

```java
/*
MODULE Example:
Simple MODULE using SHARED AND EXPORT
*/

MyMod := MODULE

   SHARED ValOne := 12;
   STRING StrOne := 'abc';

   EXPORT DoMath  :=  ValOne * 12;
   EXPORT PrintIt := 'Mod is used';

END;

// Calling the module
OUTPUT(myMod.PrintIt, NAMED('Mod_Call1'));
OUTPUT(myMod.DoMath, NAMED('Mod_Call2'));
```
</pre>
<a class="trybutton" href="javascript:OpenECLEditor(['ModExp_1'])"> Try Me </a>

</br>

<br>
<pre id = 'ModExp_2'>


```java
/*
MODULE Example:
Simple MODULE using FUNCTION
*/

MyMod := MODULE


   STRING LocalVal := 'This is not visible after EXPORT or SHARED';

   EXPORT SimpleFun(STRING Day, INTEGER Num) := FUNCTION

       Concat := 'Today is ' + Day + ' and your lucky number is: ' + Num;
       RETURN Concat;

    END;
    
    EXPORT SimpleMath(INTEGER Num) := FUNCTION

        Even := (STRING) Num + ' is an Even number';
        Odd  := (STRING) Num + ' is an Odd number';

        RETURN IF(Num % 2 = 0, Even, Odd);
    END;          
       
END;

// Calling the module
OUTPUT(MyMod.SimpleFun('Sunday', 45), NAMED('SimpleFun'));

Num := 12;
OUTPUT(myMod.SimpleMath(Num), NAMED('SimpleMath'));
```

</pre>
<a class="trybutton" href="javascript:OpenECLEditor(['ModExp_2'])"> Try Me </a>

</br>

