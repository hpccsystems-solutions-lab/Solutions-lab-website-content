# TABLE

TABLE is the most commonly-used data aggregation functions in ECL. It creates a new dataset in memory while workunit is running.
The new table inherits the implicit rationality the recordset has (if any), unless the optional expression is used to perform aggregation. There are two types of Table:

**Vertical**
Number of records in the input dataset is equal to generated table, which means no aggregation is involved.

**CrossTab**
There is at least one field using an aggregate function with the keyword Grouping Condition as its first parameter. The number of records produced is equal to the number of distinct values of the expression.

## Syntax

```java
/*** Stand-alone record definition ***/
out_record_def := RECORD
              dataset.field;
              dataset.field;
              ...
              field_name := Agg_Func(GROUP, dataset.field);
              field_name := Agg_Func(GROUP, dataset.field);
              field_name := COUNT(GROUP);
              ....
END;

attr_name := TABLE(dataset,
                    out_record_def,
                    grouping-conditions
                    [, flags]
                    );

```
|*Value*|*Definition*|
|:----|:---------|
out_record_def | Record definition that will contain both the grouping condition results and any new attributes computed as part of the aggregation
dataset.field | field(s) from input dataset
field_name | Newly defined fields
attr_name | The name by which the table will be invoked
TABLE | Required 
dataset | Input dataset to create the table from
grouping_condition | One or more comma-delimited expressions. Please see Grouping Condition for more information
flags | Optional flags that can alter the behavior of TABLE

```java
/*** Implicit record definition ***/
attr_name := TABLE(dataset,
                    {
                      field,  //Calling specific field from input dataset
                      field,
                      ...
                      field_name := Agg_Func(GROUP, dataset.field);
                      field_name := Agg_Func(GROUP, dataset.field);
                      field_name := COUNT(GROUP);
                      ....
                    },
                    grouping_conditions
                    [, flags]
                    );


```
|*Value*|*Definition*|
|:----|:---------|
attr_name | The name by which the table will be invoked
TABLE | Required 
field | field(s) from input dataset
field_name | Newly defined fields
grouping_condition | One or more comma-delimited expressions. Please see Group for more information
flags | Optional flags that can alter the behavior of TABLE


### Grouping Condition

- One or more comma-delimited expressions
- An expression could simply be an attribute name within the dataset; this is the most common usage
- An expression could be a computed value, such as (myValue % 2) to group on even/odd values
- All records within dataset that evaluate to the same set of condition values will be grouped together
- Each group will result in one output record
- Functions evaluated within outrecorddef will operate on the group

</br>

### Optional Flags
Flags can alter the behavior of TABLE. Commonly used flags are MERGE and LOCAL

Flag | Definition
---|---
FEW | Indicates that the expression will result in fewer than 10,000 distinct groups. This allows optimization to produce a significantly faster result.
MANY | Indicates that the expression will result in many distinct groups.
UNSORTED | Specifies that you don't care about the order of the groups. This allows optimization to produce a significantly faster result.
LOCAL | Specifies the operation is performed on each node independently; the operation maintains the distribution of any previous _DISTRIBUT_.
KEYED | Specifies the activity is part of an index read operation, which allows the optimizer to generate optimal code for the operation.
MERGE| Specifies that results are aggregated on each node and then the aggregated intermediaries are aggregated globally. This is a safe method of aggregation that shines particularly well if the underlying data was skewed.
SKEW | Indicates that you know the data will not be spread evenly across nodes.

## GROUP

The GROUP keyword is used within output format parameter (RECORD Structure) of a TABLE definition. <u>_GROUP replaces the recordset parameter_</u> of any aggregate built-in function used in the output to indicate the operation is performed for each group of the expression. This is similar to an SQL "GROUP BY" clause.


**Demo Dataset**

Pickup_Date|Fare|Distance
---|---|---
1/1/2021|25.1|15.5
1/2/2021|40.15,7.2
1/3/2021|25.36|6.5
1/2/2021|120|23
1/3/2021|30|60.75
2/2/2021|25|71
1/2/2021|10|2.2
3/10/2021|45|12.23

<br>
<pre id = 'TableExp_1'>

```java
/*
TABLE Example:
TABLE is used with aggregations
*/

// Input layout
Fare_Layout  :=  RECORD
    STRING Pickup_Date;
    REAL   Fare;
    REAL   Distance;
END;

// Input dataset
FareDS := DATASET([
                   {'1/1/2021', 25.1, 15.5}, {'1/2/2021', 40.15,7.2},
                   {'1/3/2021', 25.36, 6.5}, {'1/2/2021', 120, 23},
                   {'1/3/2021', 30, 60.75}, {'2/2/2021', 25, 71},
                   {'1/2/2021', 10, 2.2}, {'3/10/2021', 45, 12.23}],
                   Fare_Layout);

// Defining all fields for the table
AvgRide_Layout := RECORD
   fareDS.pickup_date;                   // Calling specific field from input dataset
   avgFare   := AVE(GROUP, fareDS.fare); // Calculating avg fare per each group
   totalFare := SUM(GROUP, fareDS.fare); // Calculating total fare per each group
END;

crossTabDs := TABLE(FareDS,           // Input dataset. please see dataset above
                     AvgRide_Layout,  // Result table definition
                     pickup_date      // Grouping field
                     );

OUTPUT(crossTabDs, NAMED('crossTabDs'));

```
</pre>
<a class="trybutton" href="javascript:OpenECLEditor(['TableExp_1'])"> Try Me </a>

</br>
</br>

**Demo Dataset**

PersonID|FirstName|LastName|isEmployed|AvgIncome|EmpGroupNum
|:----|:---|:---|:---|:---|:---
1102|Fred|Smith|FALSE|1000|900
3102|Fact|Smith|TRUE|200000|100
1012|Joe|Blow|TRUE|11250|200
2085|Blue|Moon|TRUE|185000|500
3055|Silver|Jo|FALSE|5000|900
1265|Darling|Jo|TRUE|5000|100
1265|Darling|Alex|TRUE|5000|100
5265|Blue|Silver|TRUE|75000|200
7333|Jane|Smith|FALSE|50000|900
6023|Alex|Silver|TRUE|102000|200
1024|Nancy|Moon|TRUE|201100|700


<br>
<pre id = 'TableExp_2'>

```java
/*
TABLE Example:
Cross table example.
*/

AllPeople_Layout := RECORD
  UNSIGNED  PersonID;
  STRING15  FirstName;
  STRING25  LastName;
  BOOLEAN   isEmployed;
  UNSIGNED  AvgIncome; 
  INTEGER   EmpGroupNum;
END;


AllPeopleDS := DATASET([ 
                       {1102,'Fred','Smith', FALSE, 1000, 900},
                       {3102,'Fact','Smith', TRUE, 200000, 100},
                       {1012,'Joe','Blow', TRUE, 11250, 200},
                       {2085,'Blue','Moon', TRUE, 185000, 500},
                       {3055,'Silver','Jo', FALSE, 5000, 900},
                       {1265,'Darling','Jo', TRUE, 5000, 100},
                       {1265,'Darling','Alex', TRUE, 5000, 100},
                       {5265,'Blue','Silver', TRUE, 75000, 200},
                       {7333,'Jane','Smith', FALSE, 50000, 900},
                       {6023,'Alex','Silver',TRUE, 102000, 200},
                       {1024,'Nancy','Moon', TRUE, 201100, 700}],
                       AllPeople_Layout);

VerticalSlice := Table(AllPeopleDS,
                        {
                          LastName,
                          isEmployed
                        },
                        LastName, isEmployed);
OUTPUT(VerticalSlice, NAMED('VerticalSlice'));


AvgIncome := TABLE(AllPeopleDS,
                    {
                      LastName,
                      AvgHouseIncome := AVE(GROUP, AvgIncome)
                    },
                    LastName);

OUTPUT(AvgIncome, NAMED('AvgIncome'));
```
</pre>
<a class="trybutton" href="javascript:OpenECLEditor(['TableExp_2'])"> Try Me </a>

</br>









