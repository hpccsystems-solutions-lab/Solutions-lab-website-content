# RECORD

Defines the layout of fields in the dataset, order of the fields should be exactly the same as the dataset columns. There are two ways to define the record structure. Doesn't matter which one you use results would be exactly the same.

Keep in mind that you can't output RECORD as it is a definition.  RECORD can be used with other  functions such as DATASET, and TABLE. 

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
            STRING  job;
            STRING  category;
            STRING  city;
            STRING2 state;
            INTEGER avgSalary;
            INTEGER lowerBand;
            INTEGER upperband;
END;

// Using { }
salaryAvg_2 := {
                STRING  job;
                STRING  category;
                STRING  city;
                STRING2 state;
                INTEGER avgSalary;
                INTEGER lowerBand;
                INTEGER upperband;
                };
```


