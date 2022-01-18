# CHOOSEN

CHOOSEN function allows you to display certain number of rows from a dataset. It can start either from row one, or the row you defined. 

## Syntax

```java
attr_name := CHOOSEN(dataset_name,
                    n,
                    [start_position])
```

|Value|Definition|
|:----|:---------|
attr_name | The name by which the function will be invoked.
CHOOSEN | Required.
n | number of records to return.
start_position |  Optional, to indicate which row to start with. Default is row 1.


<br>

**Demo Dataset**

|City|State|County|Population|
|:----|:---|:---|:----|
Dauphin Island |AL|Mobile|1335
Guy|AR|Faulkner|778
El Centro|CA|Imperial|111425
Indio|CA|Riverside|417059
Englewood|CO|Arapahoe|6183
Keywest|FL|Monroe|31401
Manatee Road|FL|Levy|2670
Villa Rica|GA|Carroll|16058
Atlanta|GA|Fulton|5449398

#### Example

<br>
<pre id="ChoosnExp_1">

```java
/*
CHOOSEN Example:
Displaying  different rows from the input dataset.
*/

Pop_Layout := RECORD
STRING   City;
STRING   State;
STRING   County;
INTEGER  Population;
END;

Pop_DS := DATASET([
               {'Dauphin Island','AL','Mobile',1335},
               {'Guy','AR','Faulkner',778},
               {'El Centro','CA','Imperial',111425},
               {'Indio','CA','Riverside',417059},
               {'Englewood','CO','Arapahoe',6183},
               {'Keywest','FL','Monroe',31401},
               {'Manatee Road','FL','Levy',2670},
               {'Villa Rica','GA','Carroll',16058},
               {'Atlanta','GA','Fulton',5449398}],
               Pop_Layout);

// Display the first 3 rows
DisRow := CHOOSEN(Pop_DS, 3);
OUTPUT(DisRow, NAMED('DisRow'));

// Displaying 2 rows from row 4
OUTPUT(CHOOSEN(Pop_DS, 2, 4));
```
</pre>

<a class="trybutton" href="javascript:OpenECLEditor(['ChoosnExp_1'])"> Try Me </a>

