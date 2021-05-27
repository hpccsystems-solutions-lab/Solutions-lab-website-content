# Getting Started

Getting started is very easy, just go to [ECL Cloud IDE](https://ide.hpccsystems.com/auth/login) and start coding.

## ECL

ECL is designed to read data (aka logical files) stored on a HPCC cluster, manipulate it and write back clean or analyzed data. Alternatively, ECL can also be used as query language like how SQL is used as a query language to query a relational database. 

Here are some similarities of ECL to SQL:

| SQL | ECL |
| --------- | ---------- |
| Declarative Language  | Declarative Language |
| Database Server | Thor Cluster or Roxie Cluster |
| A SQL Table  | An ECL Logical File  |
| A SQL Editor | VS Code Editor or ECL Cloud IDE |
| A SQL File   | A ECL File |
| Executing SQL means submitting the written SQL to the Database Server which in turn compiles it and executes it| Executing ECL means submitting the written ECL to a Thor or Roxie cluster which in turn compiles and executes it |
| SQL Execution History/Logs | ECL Workunits Database & ECL Watch Workunits View|

### Language Highlights 

- Not case sensitive
- White spaces are ignored
- Declarative Programming Language
  - In declarative programming you specifies what is to be done rather than how to do it.
- Can perform on any Cluster Size
- Source-to-source compiler
- ECL code translated to C++ that is compiled to shared libraries and executed within a custom frame-work
- One line comment
  - `//one line only`
- Block comment
  - `/* this is a block comment*/`
- Use of object.property to access dataset fields and definitions.
  - `dataset.fieldName`
  - `moduleName.definition`
  - Definition operator is `:=`
  - Terminator for statement is `;`

### Two Statement Types

**Definition\Expression**

Assign an expression to an attribute. Definitions are evaluated.\
Definitions always contain `:=`

```java
[attrib_type] attrib_name := value
```

- attrib_type
  - Optional, compiler can infer it from Definition.
- attrib_name
  - The name by which the Definition will be invoked
- value
  - Assigned value to the definition

`STRING def := 'this is a definition';`\
`INTEGER Num := 900;`

**Action**
Action simply means "do something." Actions trigger execution of a workunit that produces
results.

`OUTPUT('this is an action');`\
`SUM(1,2)`

```java
// A simple program

//defining an attribute
str := 'Hello Word';

//putting it into action
OUTPUT(str, NAMED('My_First_Program'));

//Defining an action
NumOne := MAX(1,2,5,6);

//Actionizing it
OUTPUT(NumOne, NAMED('ActionThis'));

//Pretty simple actions, followings produce result
'my first ECL code';
1 + 4 + 5;
2 * 3;

```

[To see definition types](./definitionTypes.md)
