# RECORD

Defines the layout of fields in the dataset, order of the fields should be exactly the same as the dataset columns. There are two ways to define the record structure. Doesn't matter which one you use results would be exactly the same.

Keep in mind that you can't output RECORD as it is a definition.  RECORD can be used with other  functions such as DATASET, and TABLE. 

## SQL vs. ECL

RECORD functions the same way as CREATE TABLE in SQL.

| SQL   | ECL     |
| ----- | --------|
CREATE TABLE (<br>&emsp;&emsp;PersonID&emsp;INTEGER,<br>&emsp;&emsp;Name &emsp;&emsp;      STRING,<br>&emsp;&emsp;Age &emsp;&emsp;&emsp;INTEGER,<br>&emsp;&emsp;Wages &emsp;&emsp;REAL,<br>&emsp;&emsp;hasHome&emsp;INTEGER<br>); | RECORD<br>&emsp;&emsp;INTEGER&emsp;PersonID;<br>&emsp;&emsp;STRING &emsp; Name ;<br>&emsp;&emsp;INTEGER&emsp;  Age;<br>&emsp;&emsp;REAL&emsp;&emsp;&emsp;Wages;<br>&emsp;&emsp;INTEGER&emsp;  hasHome;<br>END;


</br>

## Using Keywords


### Syntax

```java
attr_layout := RECORD
    data_type    field1;
    data_type    field2;
    ...
    ...
    ...
    data_type    field100;
END;
```

## Using Braces { }

### Syntax

```java
attr_layout := {
               data_type field1;
               data_type field2;
               ...
               ...
               data_type field100
               };
```

|*Value*|*Definition*|
|:----|:---------|
attr_layout | The name by which the dataset will be invoked. 
data_type   | Data type for the field.
field1 ... field100 | Name of your fields/columns.

#### Example

```java
// Using keywords
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
                };
```


</br>
</br>