# ECL Syntax

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
  /* This is a block comment.
      It can be used to comment out multiple lines.*/
  ```

## Field Access

You can use of object.property to access dataset fields and definitions.
  - `dataset.fieldName`
  - `moduleName.definition`

```java
MyDataset.FieldName

MyModule.ExportedValue
```


## Two Statement Types


### Definition\Expression 

Assigning an expression to an attribute. Definitions always contain `:=`

```java
[attrib_type] attrib_name := value
```

|Value|Definition|
|:----|:---------|
attrib_type | Optional, compiler can infer it from Definition
attrib_name | The name by which the Definition will be invoked
value | Assigned value to the Definition

#### Example

<br>
<pre id = "IntroExp_1">

```java
STRING  Def1  := 'OUTPUT turns definition ';
STRING  Def2  := 'to action.';

// String concatenation 
Def1 + Def2;


Val1 := 12;
Val2 := 50; 
SomeResult := Val1 + Val2;

// Show result
SomeResult;
```
</pre>

<a class="trybutton" href="javascript:OpenECLEditor(['IntroExp_1'])"> Try Me </a>


### Action

Action simply means "do something." Actions trigger execution of a workunit that produces results.

```java
OUTPUT('this is an action');
SUM(1,2);
```

#### Example

```java

</pre>
<a class="trybutton" href="javascript:OpenECLEditor(['IntroExp_2'])"> Try Me </a>


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

