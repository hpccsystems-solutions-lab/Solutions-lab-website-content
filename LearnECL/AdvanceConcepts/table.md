# TABLE

TABLE is the most commonly-used data aggregation functions in ECL. It creates a new dataset in memory while workunit is running.
The new table inherits the implicit relationality the recordset has (if any), unless the optional expression is used to perform aggregation. There are two types of Table:

**Vertical**
Number of records in the input dataset is equal to generated table, which means no aggregation is involved.

**CrossTab**
There is at least one field using an aggregate function with the keyword GROUP as its first parameter. The number of records produced is equal to the number of distinct values of the expression.

```java
attr_name := TABLE(dataset,
                    out_record_def,
                    grouping_conditions
                    [, flags]);
```

- dataset
  - Input dataset to create the table from
- out_record_def
  - Record definition that will contain both the grouping condition results and any new attributes computed as part of the aggregation
  - Functions that operate on TABLE groups
    - SUM, MAX, MIN, COUNT, AVE, VARIANCE, COVARIANCE, CORRELATION
    - When used within TABLE, these functions accept the keyword GROUP to denote currently-grouped table data
- grouping_conditions
  - One or more comma-delimited expressions
    - An expression could simply be an attribute name within the dataset; this is the most common usage
    - An expression could be a computed value, such as (myValue % 2) to group on even/odd values
  - All records within dataset that evaluate to the same set of condition values will be grouped together
    - Each group will result in one output record
    - Functions evaluated within out_record_def will operate on the group
- flags
  - Optional flags that can alter the behavior of TABLE
  - Commonly used flags
    - MERGE: Evaluate the data on stored on each Thor node independently, then merge those results into a final result
    - LOCAL: Evaluate the data stored on each Thor node independently and do not merge the results
      - Useful only when the data has been explicitly distributed

![fare dataset](./Images/fare_ds.jpg)

## Optional Flags##

**FEW**
Indicates that the expression will result in fewer than 10,000 distinct groups. This allows optimization to produce a significantly faster result.

**MANY**
Indicates that the expression will result in many distinct groups.

**UNSORTED**
Specifies that you don't care about the order of the groups. This allows optimization to produce a significantly faster result.
**LOCAL**
Specifies the operation is performed on each node independently; the operation maintains the distribution of any previous <u>DISTRIBUT</u>.

**KEYED**
Specifies the activity is part of an index read operation, which allows the optimizer to generate optimal code for the operation.

**MERGE**
Specifies that results are aggregated on each node and then the aggregated intermediaries are aggregated globally. This is a safe method of aggregation that shines particularly well if the underlying data was skewed.

**SKEW**
Indicates that you know the data will not be spread evenly across nodes.

```java
//Out definition: Defining all fields for the table
crossTabLayout  :=  RECORD
   fareDS.pickup_date; //Calling specific field from input dataset
   avgFare   := AVE(GROUP, fareDS.fare); //Calculating avg fare per each group
   totalFare := SUM(GROUP, fareDS.fare); //Calculating total fare per each group
END;

crossTabDs := TABLE(fareDS, //Input dataset. please see dataset above
                     crossTabLayout, //Result table definition
                     pickup_date //Grouping field
                     );

OUTPUT(crossTabDs, NAMED('crossTabDs'));

```

![fare table result](./Images/fare_table.jpg)

## Resources

[Put it into practice](Put it into practice [table.ecl](https://ide.hpccsystems.com/workspaces/share/291d17d9-e5cb-4fac-83c2-ac5997c28a31)

Please see [TABLE Function](https://hpccsystems.com/training/documentation/ecl-language-reference/html/TABLE.html) for more information.
