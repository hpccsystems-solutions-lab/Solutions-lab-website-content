# SET OF

SET OF is an array of data element with the same data type. Indexing in SET OF start with 1. Since data isn't distributed it has to fit in the memory.

## Syntax

```java
SET OF <dataType> attr_name := [elem1, elem2, ... elemN]
```
|Value|Definition|
|:----|:---------|
SET OF | Required.
dataType | Elements type.
attr_name | The name by which the operation will be invoked.
[ .. ] | Input values.

<br>

#### Example

<br>
<pre id="SetOfExp_1">

```java
/*
SET Example:
Showing different examples  of SET OF.
*/

SET OF INTEGER IntSet := [1,3,3,5];
OUTPUT(IntSet, NAMED('IntSet'));

SET OF DECIMAL3_1 DecSet := [12, 12.1, 90.7, 90];
OUTPUT(DecSet, NAMED('DecSet'));

```
</pre>
<a class="trybutton" href="javascript:OpenECLEditor(['SetOfExp_1'])"> Try Me </a>
