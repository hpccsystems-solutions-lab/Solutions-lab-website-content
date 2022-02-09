# BETWEEN

BETWEEN is an operator to check ranges of values. It is the same as <= and =>. It's the same as SQL BETWEEN operator. 

## Syntax

```java
attr_name := seek_val BETWEEN low_val AND high_val;
attr_name := seek_val NOT BETWEEN low_val AND high_val;
```
|*Value*|*Definition*|
|:------|:---------|
attribName | The name by which the variable will be invoked.
seek_val  | The value to be checked. Can be a dataset field too.
BETWEEN | Required.
NOT|Optional, used for certain searches.
Low_val|Low value in the range
AND|Required
high_val|High value in the range


<br>
#### Example

<br>
<pre id = 'BetweenExp_1'>

```java
/*
BETWEEN Example:
Examples using set of values.
*/

SomeInt  := 12;
SomeReal := 120.5;

CheckIntOne := SomeInt BETWEEN 10 AND 200;
CheckIntTwo := SomeInt NOT BETWEEN 10 AND 200;

OUTPUT(CheckIntOne, NAMED('CheckIntOne'));
OUTPUT(CheckIntTwo, NAMED('CheckIntTwo'));


CheckRealOne := SomeReal BETWEEN 50 AND 65;
CheckRealTwo := SomeReal NOT BETWEEN 150 AND 203.6;

OUTPUT(CheckRealOne, NAMED('CheckRealOne'));
OUTPUT(CheckRealTwo, NAMED('CheckRealTwo'));

```
</pre>
<a class="trybutton" href="javascript:OpenECLEditor(['BetweenExp_1'])"> Try Me </a>

**Demo Dataset**

|City|State|Population|
|:----|:---|:---|
Dauphin Island |AL|1335
Guy|AR|778
El Centro|CA|111425
Indio|CA|417059
Englewood|CO|6183
Keywest|FL|31401
Manatee Road|FL|2670
Villa Rica|GA|16058
Atlanta|GA|5449398

<br>
<pre id = 'BetweenExp_2'>

```java
/*
BETWEEN Example:
Examples using dataset.
*/

Pop_Layout := RECORD
STRING   City;
STRING   State;
INTEGER  Population;
END;

Pop_DS := DATASET([
               {'Dauphin Island','AL',1335},
               {'Guy','AR',778},
               {'El Centro','CA',111425},
               {'Indio','CA',417059},
               {'Englewood','CO',6183},
               {'Keywest','FL',31401},
               {'Manatee Road','FL',2670},
               {'Villa Rica','GA',16058},
               {'Atlanta','GA',5449398}],
               Pop_Layout);

PopEval_Layout := RECORD
    STRING  City;
    STRING  State;
    BOOLEAN isMiddleSize;
END;

Eval_Town := PROJECT(Pop_DS,
                TRANSFORM(PopEval_Layout,
                SELF.isMiddleSize := LEFT.Population BETWEEN 5000 AND 30000;
                SELF := LEFT;
                ));

OUTPUT(Eval_Town, NAMED('Eval_Town'));

```
</pre>
<a class="trybutton" href="javascript:OpenECLEditor(['BetweenExp_2'])"> Try Me </a>
