---
title: ECL Syntax
slug: ecl-syntax
---

# ECL SYNTAX

ECL syntax is characterized by its English-like readability and declarative nature. Developers use ECL to define data transformation workflows by specifying operations on datasets. ECL scripts consist of modules and functions that manipulate data through a sequence of transformations, including filters, joins, sorts, and aggregations. ECL's unique feature is its ability to optimize and parallelize these transformations across distributed computing resources, making it well-suited for big data processing tasks. 

- ECL is not case-sensitive but usually reserved keywords and built-in functions are written in ALL CAPS
- White space is ignored, allowing formatting for readability as needed

## Definitions

ECL definitions are the basic building blocks of ECL. A definition specifies what needs to be done rather than how it is to be done.

- The Definition operator (`:=` read as "is defined as") defines an expression
- Definitions must be explicitly terminated with a semi-colon (`;`)

**Syntax**
<pre>
    <EclCode 
    code="
    [attrib_type] attrib_name := value
    ">
    </EclCode>
</pre>

| Value | Definition |
| :- | :- |
| attrib_type | Optional. Compiler can infer it from definition. |
| attrib_name | The name by which the definition will be invoked. |
| value | Assigned value to the definition. |


<pre>
    <EclCode
    code="
    // attrib_name Val1 is defined and value 12 is assigned to it
    Val1 := 12;

    // attrib_name Val2 is defined and value 65 is assigned to it
    Val2 := 65;

    // attrib_name Result is defined and the summation of Val1 and Val2 is assigned to it
    Result := Val1 + Val2;
    ">
    </EclCode>
</pre>


## Comments

Comments in ECL are supported using the following syntax.

| Comment Type | Symbol | Example |
| :- | :- | :- |
| Single Line | `//` | `// This is a single-line comment.` |
| Multi Line | `/* */` | `/* This is a multi-line comment. */` |

<pre>
    <EclCode 
    code="
    // This is a single-line comment.

    /*  This
        is
        a
        multi-line
        comment.
    */
    ">
    </EclCode>
</pre>

## Field Access

You can use object.property to access dataset fields and definitions.

- `dataset.fieldName` Referencing a field from a dataset
- `moduleName.definition`  Referencing an attribute from a module

<pre>
    <EclCode
    code="
    MyDataset.FieldName;
    MyModule.ExportedValue;
    "> 
    </EclCode>
</pre>

## Statement Types

In ECL, coding revolves around two main approaches: Definitions and Actions. These provide the structure to define data intricacies using Definitions and execute tasks effectively through Actions, forming the foundation for robust ECL solutions.

**Example**
<pre>
    <EclCode
    id = "IntroExp_1"
    tryMe="IntroExp_1"
    code="
    /* Actions vs Definitions */

    // Definitions
    STRING Def1 := 'Concatenating two Definitions ';
    STRING Def2 := 'and performing an OUTPUT Action.';

    // Action: String Concatenation
    Def1 + Def2;

    // Definitions
    Val1 := 12;
    Val2 := 50;
    SomeResult := Val1 + Val2;

    // Action: Print Result
    SomeResult;
    ">
    </EclCode>
</pre>

## Action

Action simply means "do something". Actions trigger execution of a workunit that produce output in the workunit. Actions do NOT have a return value.

<pre>
    <EclCode 
    code="
    // Action
    OUTPUT('This is an Action.');

    // Action
    SUM(1,2);
    ">
    </EclCode>
</pre>

**Example**
<pre>
    <EclCode
    id="IntroExp_2"
    tryMe="IntroExp_2"
    code="
    /* Actions vs Definitions */

    // Defining an attribute
    str := 'Hello Word';

    // Performing an OUTPUT Action
    OUTPUT(str, NAMED('My_First_Program'));

    // Defining an Action
    NumOne := MAX(1,2,5,6);

    // Performing an OUTPUT Action
    OUTPUT(NumOne, NAMED('ActionThis'));

    // Simple Actions
    'My first ECL code';
    1 + 4 + 5;
    2 * 3;
    ">
    </EclCode>
</pre>
