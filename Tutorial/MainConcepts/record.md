# RECORD

Defines the layout of fields in the dataset, order of the fields should be exactly the same as the dataset columns.

There are two ways to define the record structure. Doesn't matter which one you pick results would be the same.

## 1- Recommended Way
<br>

```java
attr_layout := RECORD
    data_type    field1;
    ...
    ...
    ...
    data_type    field100;
END;
```

## 2- Inline Record Definition

```java
attr_layout := {data_type field1, ..., data_type field100};
```

|*Value*|*Definition*|
|:----|:---------|
attr_layout | The name by which the dataset will be invoked 
data_type   | Data type for the field
field1 ... field100 | Name of your fields/columns

#### Example

```java
// Recommended way
salaryAvg_1 := RECORD
    STRING job;
    STRING category;
    STRING city;
    STRING2 state;
    INTEGER avgSalary;
    INTEGER lowerBand;
    INTEGER upperband;
END;

// Inline record definition
salaryAvg_2 := {STRING  job,
                STRING  category,
                STRING  city,
                STRING2 state,
                INTEGER avgSalary,
                INTEGER lowerBand,
                INTEGER upperband
                }
```


