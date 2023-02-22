# EXISTS 

EXISTS functions checks to see if there are any rows int the dataset. EXISTS returns TRUE if there is at least 1 record in the dataset.

EXISTS is more efficient than COUNT, since COUNT will count all the rows in dataset, versus EXITS just checks to see row 1 exists. 

## Syntax 

 ```java
EXISTS(recordset])
EXISTS(value_set)
```

|Value|Definition|
|:----|:---------|
EXISTS | Required.
recordset | Dataset to be checked.
value_set | Values in a SET to be check.

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
<pre id="ExistsExp_1">

```java
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
                {'Keywest','FL','Monroe',31401}], 
                Pop_Layout);

// Converting a field to SET
HasData := EXISTS(Pop_DS);
OUTPUT(HasData, NAMED('HasData'));

// Creating an empty dataset
Emp_DS := DATASET([], Pop_Layout);

// Check to see if dataset has values
OUTPUT(Emp_DS, NAMED('Emp_DS'));
```
</pre>
<a class="trybutton" href="javascript:OpenECLEditor(['ExistsExp_1'])"> Try Me </a>


#### Example

<br>
<pre id="ExistsExp_2">

```java
/*
EXISTS Example:
Showing different examples of EXIST function values.
*/

CheckMe := EXISTS(4,8,16,2,1); 
OUTPUT(CheckMe, NAMED('CheckMe'));

NullSet := [];
CheckIt := EXISTS(NullSet); 
OUTPUT(CheckIt, NAMED('CheckIt'));

```
</pre>
<a class="trybutton" href="javascript:OpenECLEditor(['ExistsExp_2'])"> Try Me </a>

