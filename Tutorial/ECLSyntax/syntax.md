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

### Definition 

Assigning an expression to an attribute. Definitions can't not be executing unless it is wrapped in an action. Definitions are defined by `:=`. Let's take a look at an example:

`Val := 23;` is a definition. Attribute Val is defined and value 23  is assigned to it. To turn `Val` to an action we can wrap it in an OUTPUT.

 `OUTPUT(Val);` is executable if you run this, the result would be 23. 

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

// Show result. An action
SomeResult;
```
</pre>
<a class="trybutton" href="javascript:OpenECLEditor(['IntroExp_1'])"> Try Me </a>

</br>

### Action

Action simply means "do something." Actions trigger execution of a workunit that produces results.

```java
OUTPUT('this is an action');
SUM(1,2);
```
</br>

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

</br>
</br>