---
title: ECL Syntax
slug: ecl-syntax
---

# ECL SYNTAX

ECL syntax is characterized by its English-like readability and declarative nature. Developers use ECL to define data transformation workflows by specifying operations on datasets. ECL scripts consist of modules and functions that manipulate data through a sequence of transformations, including filters, joins, sorts, and aggregations. ECL's unique feature is its ability to optimize and parallelize these transformations across distributed computing resources, making it well-suited for big data processing tasks.

## Definition

- Definition operator is :=
- Terminator for statement is ;

<EclCode

code= "Val1 := 12;
Val2 := 65;

Result := Val1 + Val2;"

> </EclCode>

## Comments

| Comment Type | Symbol  | Example                               |
| ------------ | ------- | ------------------------------------- |
| Single Line  | `//`    | `// This is a single-line comment.`   |
| Multi Line   | `/* */` | `/* This is a multi-line comment. */` |

## Field Access

You can use of object.property to access dataset fields and definitions.

- `dataset.fieldName` Referencing an attribute from a module
- `moduleName.definition` Referencing a field from dataset

<pre>
<EclCode

code="MyDataset.FieldName;
MyModule.ExportedValue;"

> 
</EclCode>
</pre>

## Statement Types

In ECL, coding revolves around two main approaches: Definitions and Actions. These provide the structure to define data intricacies using Definitions and execute tasks effectively through Actions, forming the foundation for robust ECL solutions.

**Example**

<pre>
<EclCode
id = "IntroExp_1"
tryMe="IntroExp_1"

code="// Action vs Definition Examples.
STRING Def1 := 'OUTPUT turns definition ';
STRING Def2 := 'to action.';

// Action: String concatenation
Def1 + Def2;

Val1 := 12;
Val2 := 50;

// Definition
SomeResult := Val1 + Val2;

// Action: print result
SomeResult;"

> </EclCode>
</pre>

## Definition

Assigning an expression to an attribute. Definitions can't not be executing unless it is wrapped in an action and are defined by `:=`. Let's take a look at an example:

`Val := 23;` is a Definition. Attribute Val is defined and value 23 is assigned to it. To turn `Val` to an action we can wrap it in an OUTPUT.`OUTPUT(Val);` is an Action and result would be 23.

<EclCode code="[attrib_type] attrib_name := value"></EclCode>

| Value       | Definition                                       |
| :---------- | :----------------------------------------------- |
| attrib_type | Optional, compiler can infer it from Definition. |
| attrib_name | The name by which the Definition will be invoked |
| value       | Assigned value to the Definition.                |

## Action

Action simply means "do something." Actions trigger execution of a workunit that produces results.

<pre>
<EclCode code="OUTPUT('this is an action');
SUM(1,2);">
</EclCode>
</pre>

**Example**

<pre>
<EclCode
id="IntroExp_2"
tryMe="IntroExp_2"
code="//Action vs Definition Examples.

// Defining an attribute
str := 'Hello Word';

// Turning it into Action
OUTPUT(str, NAMED('My_First_Program'));

// Defining an Action
NumOne := MAX(1,2,5,6);

// Turning to Action
OUTPUT(NumOne, NAMED('ActionThis'));

// Simple Actions, followings produce result
'my first ECL code';
1 + 4 + 5;
2 * 3;"></EclCode>
</pre>
