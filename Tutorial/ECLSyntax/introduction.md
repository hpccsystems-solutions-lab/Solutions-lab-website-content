# Introduction

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

<br> 

## Language Highlights 

- ECL is NOT case sensitive language, but it is recommended to use uppercase for reserved words
- White spaces are ignored, but it is strongly recommended to use white space for clarity and readability.
- Declarative Programming Language, which means you specifies what needs to be done rather than how to do it.
- Source-to-source compiler
- ECL code translated to C++ that is compiled to shared libraries and executed within a custom frame-work

## Definition
  - Definition operator is `:=`
  - Terminator for statement is `;`

```java
 Val1 := 12;
 Val2 := 65;

 Result := Val1 + Val2;
 ```


## Comment Out

**Single Line**

`//` is used to comment out one line.

```java
// One line is commented out
// X + Y = Z
```

**Block comment**

`/* ..... */` is used for block commenting out.

  ```java
  /* this is a block comment
      It can be used to comment out multiple lines.*/
  ```

## Field Access

Use of object.property to access dataset fields and definitions.
  - `dataset.fieldName`
  - `moduleName.definition`

```java
MyData.FisrtName

MyMod.GetValue
```


## Two Statement Types


### Definition\Expression 

Assign an expression to an attribute. Definitions are evaluated.\
Definitions always contain `:=`

```java
[attrib_type] attrib_name := value
```

|Value|Definition|
|:----|:---------|
attrib_type | Optional, compiler can infer it from Definition
attrib_name | The name by which the Definition will be invoked
value | Assigned value to the definition

```java
STRING def := 'this is a definition';
INTEGER Num := 900;

SomeResult := Val1 + Val2;
```

### Action

Action simply means "do something." Actions trigger execution of a workunit that produces results.

```java
OUTPUT('this is an action');
SUM(1,2);
```

</br>
<pre id="IntroExp_1">

```java

/* Simple use of block comment.
   Following are simple ECL syntax
*/

// Defining an attribute
str := 'Hello Word';

// Putting it into action
OUTPUT(str, NAMED('My_First_Program'));

// Defining an action
NumOne := MAX(1,2,5,6);

// Turning to action
OUTPUT(NumOne, NAMED('ActionThis'));

// Simple actions, followings produce result
'my first ECL code';
1 + 4 + 5;
2 * 3;

```
</pre>
<a class="trybutton" href="javascript:OpenECLEditor(['IntroExp_1'])"> Try Me </a>

