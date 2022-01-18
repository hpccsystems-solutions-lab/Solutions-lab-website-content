# SORT

Sorting refers to ordering data in an increasing or decreasing fashion. Sort can be done on one field or multiple fields. 

### Syntax
```java
attr_name := SORT(dataset_name, [-]field(s));
```
 

|Value|Definition|
|:----|:---------|
attr_name | The name by which the function will be invoked.
SORT  | Required.
dataset_name | The dataset to perform action on.
\- | Optional, used when sorting descending /decreasing 
field(s) | field or fields for sort.

<br> 

**Demo Dataset**

|PersonID|FirstName|LastName|isEmployed|avgHouseIncome|
|:----|:---|:---|:----|:---|
102 | Fred | Smith | FALSE | 0
012 | Joe | Blow | TRUE | 11250
085 | Blue | Moon | TRUE | 185000
155 | Dan | Jo | FALSE | 4000
255 | Silver | Jo | TRUE | 6000
265 | Darling | Jo | TRUE | 5000
333 | Jane | Smith | FALSE | 50000

</br>

## Ascending Sort

Sorting from A to Z or 0 to 9.

#### Example

</br>
<pre id="SortExp_1">

```java
/*
SORT Example:
Sorting a dataset based on different fields and ascendingly.
*/

// Define record layout
Layout_Person := RECORD
  UNSIGNED  PersonID;
  STRING15  FirstName;
  STRING25  LastName;
  BOOLEAN   isEmployed;
  UNSIGNED  avgHouseIncome;
END;

// Inline dataset
AllPeople := DATASET([ 
                    {102,'Fred','Smith', FALSE, 0},
                    {012,'Joe','Blow', TRUE, 11250},
                    {085,'Blue','Moon', TRUE, 185000},
                    {155,'Dan','Jo', FALSE, 4000},
                    {255,'Silver','Jo', TRUE, 6000},
                    {265,'Darling','Jo', TRUE,5000},   
                    {333,'Jane','Smith', FALSE, 50000}],
                    Layout_Person);


// Sort using one field
SortedLastName := SORT(AllPeople, LastName);
OUTPUT(SortedLastName, NAMED('Asc_SortedLastName'));

// Sort using multiple fields
SortedIncome := SORT(AllPeople, LastName, avgHouseIncome);
OUTPUT(SortedIncome, NAMED('Asc_SortedIncome'));

```
</pre>
<a class="trybutton" href="javascript:OpenECLEditor(['SortExp_1'])"> Try Me </a>



## Descending Sort

Sorting Z to A or 9 to 0. 

#### Example

<br>
<pre id="SortExp_2">

```java
/*
SORT Example:
Sorting a dataset based on different fields and desscendingly.
*/

// Define record layout
Layout_Person := RECORD
  UNSIGNED  PersonID;
  STRING15  FirstName;
  STRING25  LastName;
  BOOLEAN   isEmployed;
  UNSIGNED  avgHouseIncome;
END;

// Inline dataset
AllPeople := DATASET([ 
                    {102,'Fred','Smith', FALSE, 0},
                    {012,'Joe','Blow', TRUE, 11250},
                    {085,'Blue','Moon', TRUE, 185000},
                    {155,'Dan','Jo', FALSE, 4000},
                    {255,'Silver','Jo', TRUE, 6000},
                    {265,'Darling','Jo', TRUE,5000},   
                    {333,'Jane','Smith', FALSE, 50000}],
                    Layout_Person);


// Sort using one field
SortFirstName := SORT(AllPeople, -FirstName);
OUTPUT(SortFirstName, NAMED('SortFirstName'));

// Sort using more than one field
SortedIncome := SORT(AllPeople, -LastName, avgHouseIncome);
OUTPUT(SortedIncome, NAMED('Asc_SortedIncome'));

```
</pre>
<a class="trybutton" href="javascript:OpenECLEditor(['SortExp_2'])"> Try Me </a>
