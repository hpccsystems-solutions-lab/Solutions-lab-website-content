# TOPN

In a <t style='color:pink'>sorted dataset </t> TOPN returns the n number of records from the row 1 of the dataset. 


#### Example 

<br>
<pre id = 'TopnExp_1'>

```java
/*
TOPN Example:
*/
MyRec := RECORD
    INTEGER  ID;
    INTEGER  Income;
    STRING   LastName;
END;

MyDS := DATASET([{100, 28000, 'Sunny'}, {200, 5000, 'Jack'}, {300, 5000, 'Smith'},
                 {200, 1000, 'Danny'}, {200, 7000, 'Able'},  {100, 25000, 'Doable'},
                 {200, 1000, 'Nancy'}],
                 MyRec);


LastName := TOPN(MyDS, 5, LastName);
OUTPUT(LastName, NAMED('LastName'));

OUTPUT(TOPN(MyDS, 3, -Income), NAMED('Sorted_Income'));


```

</pre>
<a class="trybutton" href="javascript:OpenECLEditor(['TopnExp_1'])"> Try Me </a>

</br>
</br>

## Syntax 

```java
TOPN(Dataset, Count, SortValues[,flag(s)]);
```

|*Value*|*Definition*|
|:----|:---------|
Dataset|Input dataset
Count   |    Number of records to displat
SortValues|   Fields that sorting will be executed on 
flags      |  Optional

</br>

## Flags

|Options|Description|
|---|---|
UNORDERED|Specifies the output record order is not significant
ORDERED|Specifies the significance of the output record order
STABLE|Specifies the input record order is significant
PARALLEL|Try to evaluate this activity in parallel
LOCAL|Specifies the operation is performed on each node independently, without requiring interaction with all other nodes to acquire data
GROUP|Specifies the recordset is GROUPed and the ROLLUP operation will produce a single output record for each group