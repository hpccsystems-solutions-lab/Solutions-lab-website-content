---
title: Record
slug: record
---

# RECORD

Defines the layout of fields in the dataset; the order of the fields should be exactly the same as the dataset columns. There are two ways to define the record structure. It doesn't matter which one you use, the results will be exactly the same.

Keep in mind that you can't output a RECORD as it is a layout definition, similar to a data type. Similar to trying to output UNSIGNED -- it is a data type, not a value.

## SQL vs. ECL

In both SQL and ECL, the RECORD structure serves a fundamental purpose: defining the structure and layout of a data entity. While the concept is shared between the two languages, there are nuances in how they achieve this goal.

### SQL - CREATE TABLE:

In SQL, the CREATE TABLE statement is used to define a new table in a relational database. This statement specifies the table's name and the data types of its columns. The SQL snippet below illustrates the creation of a hypothetical Person table:

<pre><EclCode code="CREATE TABLE (
  PersonID INTEGER,
  Name    STRING,
  Age    INTEGER,
  Wages   REAL,
  hasHome INTEGER
);"></EclCode></pre>

### ECL - RECORD:

Similarly, in ECL, the RECORD structure fulfills the role of defining data structures. It defines a composite data type that can hold multiple fields, each with its own data type. The example below demonstrates how the RECORD structure is used to define a Person data type in ECL:
### Here, each column's name is followed by its data type definition. The CREATE TABLE statement in SQL is essentially a blueprint for how the table should be structured, and it specifies the types of data that can be stored in each column.

 <pre><EclCode code="RECORD
  INTEGER PersonID;
  STRING   Name ;
  INTEGER  Age;
  REAL   Wages;
  INTEGER  hasHome;
END;"></EclCode></pre>

In ECL, the RECORD structure encapsulates the fields within the Person data type. Each field is associated with a data type, just like the columns in an SQL table. However, unlike SQL's CREATE TABLE, ECL's RECORD doesn't create a physical table; rather, it defines a new data structure that can be used to hold and manipulate data.

## Using Keywords

### Syntax

<pre>
<EclCode 
code="attr_layout := RECORD
    data_type    field1;
    data_type    field2;
    ...
    ...
    ...
    data_type    field100;
END;">
</EclCode>
</pre>

## Using Braces { }

### Syntax

<pre>
<EclCode
code="attr_layout := {
               data_type field1;
               data_type field2;
               ...
               ...
               data_type field100
               };">
</EclCode>
</pre>

| Value               | Definition                                     |
| :------------------ | :--------------------------------------------- |
| attr_layout         | The name by which the dataset will be invoked. |
| data_type           | Data type for the field.                       |
| field1 ... field100 | Name of your fields/columns.                   |

**Example**

<pre>
<EclCode
code="// Using keywords
salaryAvg_1 := RECORD
            STRING  Job;
            STRING  Category;
            STRING  City;
            STRING2 State;
            INTEGER AvgSalary;
            INTEGER LowerBand;
            INTEGER Upperband;
END;

// Using { }
salaryAvg_2 := {
                STRING  Job;
                STRING  Category;
                STRING  City;
                STRING2 State;
                INTEGER AvgSalary;
                INTEGER LowerBand;
                INTEGER Upperband;
                };">
</EclCode>
</pre>
