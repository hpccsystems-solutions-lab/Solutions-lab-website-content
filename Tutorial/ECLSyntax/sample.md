# SAMPLE

SAMPLE function returns a sample set of dataset. Returned value is a dataset. 

## Syntax 

```java
SAMPLE(dataset, interval, [, which])
```

|Value|Definition|
|:----|:---------|
SAMPLE | Required.
dataset | Input dataset to process. 
interval | The intervals between records to return.
which | Optional. An integer specifying the ordinal number of the sample set to return. This is used to obtain multiple non-overlapping samples from the same recordset.

 <br>

**Demo Dataset**

|Color|ID|
|:----|:---|
Red | 100
Blue | 102
Black | 103
Yellow | 104
Orange | 105
White | 106
Green | 107
Purple| 108

<br>

 #### Example

<br>
<pre id="SampleExp_1">

```java
/*
REAL Example:
Collecting different sample sizes from the input dataset.
*/

Color_Layout := RECORD
    STRING   Color;
    INTEGER ID;
END;

Color_DS := DATASET([
                     {'Red', 100},    {'Blue', 102},   {'Black', 103},
                     {'Yellow', 104}, {'Orange', 105}, {'White', 106},
                     {'Green', 107},  {'Purple', 108}],
                     Color_Layout);

SampleOne := SAMPLE(Color_DS, 3);
OUTPUT(SampleOne, NAMED('SampleOne'));

SAMPLE(Color_DS, 2, 4);
```
</pre>
<a class="trybutton" href="javascript:OpenECLEditor(['SampleExp_1'])"> Try Me </a>
