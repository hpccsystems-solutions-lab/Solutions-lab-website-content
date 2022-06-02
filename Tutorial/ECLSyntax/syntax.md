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
  - `dataset.fieldName` Referencing an attribute from a module
  - `moduleName.definition` Referencing a field from dataset

```java
MyDataset.FieldName

MyModule.ExportedValue
```


## Statement Types
There are two types of coding in ECL. Definitions and Actions. 

#### Example

<br>
<pre id = "IntroExp_1">

```java
/*
Action vs Definition Examples.
*/
STRING  Def1  := 'OUTPUT turns definition ';
STRING  Def2  := 'to action.';

// Action: String concatenation 
Def1 + Def2;


Val1 := 12;
Val2 := 50; 

// Definition
SomeResult := Val1 + Val2;

// Action: print result
SomeResult;
```
</pre>
<a class="trybutton" href="javascript:OpenECLEditor(['IntroExp_1'])"> Try Me </a>

</br>
</br>



### Definition 

Assigning an expression to an attribute. Definitions can't not be executing unless it is wrapped in an action and are defined by `:=`. Let's take a look at an example:

`Val := 23;` is a Definition. Attribute Val is defined and value 23  is assigned to it. To turn `Val` to an action we can wrap it in an OUTPUT.

 `OUTPUT(Val);` is an Action and result would be 23. 

```java
[attrib_type] attrib_name := value
```

|Value|Definition|
|:----|:---------|
attrib_type | Optional, compiler can infer it from Definition.
attrib_name | The name by which the Definition will be invoked
value | Assigned value to the Definition.

### Action

Action simply means "do something." Actions trigger execution of a workunit that produces results.

```java
OUTPUT('this is an action');
SUM(1,2);
```
</br>

#### Example 

<br>
<pre id = 'IntroExp_2'>

```java
/*
Action vs Definition Examples.
*/

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
2 * 3;

```
</pre>
<a class="trybutton" href="javascript:OpenECLEditor(['IntroExp_2'])"> Try Me </a>

</br>
</br>