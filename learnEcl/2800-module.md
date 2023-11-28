---
title: Module
slug: module
---

# MODULE

MODULE is a fundamental organizational unit that contains one or more functions, actions, or definitions. Modules are used to group together code that serves a common purpose, making it easier to manage and reuse code components. 

## Notes
* OUTPUTs can not be used within a module.
* For modules to be called/used from outside the current module, EXPORT is required.
* A .ecl file (that is not a BWR) MUST contain exactly one EXPORTed attribute. That attribute MUST be named the same as the filename.
* Any non-EXPORT attributes prior to the EXPORTed attribute in the file are allowed.
* How to call a module: `ModuleName.attributeName;`


## Variable Scope

* LOCAL Definitions are limited only to the next SHARED or EXPORT definition. This is the default scope if no scope is given for an attribute

* SHARED Definitions are available to other modules within the same folder that IMPORTs them.

* EXPORT Definitions are available throughout the module in which they are defined and throughout any other module that IMPORTs them.

* Modules can contain multiple, SHARED and EXPORT values.

**Syntax**
<pre>
    <EclCode 
    code="EXPORT module_name [ ( parameters ) ] := MODULE
        ...
        SHARED
        ...
        ...
        EXPORT
    END">
    </EclCode>
</pre>

| _Value_ | _Definition_ |
| :- | :- |
| EXPORT | 	Optional, indicates that this module is available outside of this file |
| module_name | The name of the function. |
| param_data_type | Data type of each parameter (string, integer, Boolean, …). |
| MODULE | Required. |
| SHARED | The attribute or function can be accessed within the module. |
| EXPORT | The attribute or function can be accessed from outside of the module. |
| END | Indicates the end of module. |

**Example**
<pre>
    <EclCode
    id="ModuleExp_1"
    tryMe="ModuleExp_1"
    code="/*MODULE Example:*/

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
    OUTPUT(myMod.DoMath, NAMED('Mod_Call2'));">
    </EclCode>
</pre>

**Example**
<pre>
    <EclCode
    id="ModuleExp_2"
    tryMe="ModuleExp_2"
    code="/*MODULE Example:*/

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
    OUTPUT(myMod.SimpleMath(Num), NAMED('SimpleMath'));">
    </EclCode>
</pre>