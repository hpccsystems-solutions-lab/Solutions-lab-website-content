# DATASET

A Dataset is a set of records that an ECL program can manipulate. A Dataset can be initialized using a logical file (File Dataset), inline data (Inline Dataset) or by another ECL function that filters, queries or transforms data (Derived Dataset).

When defining DATASET you need to define the [RECORD(layout)](./record.md) of the dataset first. 


## SQL vs. ECL

DATASET is similar to TABLE in SQL.

SQL|ECL
---|---|
SimpleTable = select * from '~simpledata.csv'  type csv layout SimpleLayout as simpleDS offset 1;| simpleDS := DATASET('~simpledata.csv', SimpleLayout, CSV);



## Inline Dataset

A temporary dataset that's created and used while job is running. Inline dataset definition can be used for small datasets.

### Syntax

```java
attr_layout := RECORD
    data_type    field1;
    ...
    ...
    ...
    data_type    field100;
END;

// Inline Dataset
attr_name := DATASET(
                        [ 
                            {'', '', 0, '', FALSE, ..., ''}, 
                            {'', '', 0, '', FALSE, ..., ''},
                            {...},
                            {...},
                            {'', '', 0, '', FALSE, ..., ''}
                        ],
                        attr_layout
                    );
```

<br> 

|*Value*|*Definition*|
|:----|:---------|
attr_name   | The name by which the dataset will be invoked.
DATASET     | Required.
[ ... ]       | Contains all rows for dataset.
{ ... }       | Defines one row.
attr_layout | Name of your Record layout.

<br>

**Demo Dataset**

|Job|Category|City|State|Avg_Salary|LowerBand|Upperband|
|:--|:--|:--|:--|:--|:--|:--|
Manager|IT|Atlanta|GA|87000|62000|114000
Director|IT|Atlanta|GA|119000|84000|156000
Director|Art-Entertainment|Atlanta|GA|100000|70000|133000
CIO|IT|Tampa|FL|112000|69000|131000
Sales|General|Chicago|IL|55000|32000|121000


#### Example

<br>
<pre id="ds_example1">

``` java
/*
DATASET Example:
Creating an inline dataset.
*/

// Defining record layout
SalaryAvg_Layout := RECORD
    STRING   Job;
    STRING   Category;
    STRING   City;
    STRING2  State;
    INTEGER  Avg_Salary;
    INTEGER  LowerBand;
    INTEGER  Upperband;
END;

// Creating the dataset
SalaryAvg_DS := DATASET([
                    {'Manager', 'IT', 'Atlanta', 'GA', 87000, 62000, 114000},
                    {'Director', 'IT', 'Atlanta', 'GA', 119000, 84000, 156000},
                    {'Director', 'Art-Entertainment', 'Atlanta', 'GA', 100000, 70000, 133000},
                    {'CIO', 'IT', 'Tampa', 'FL', '112000', '69000', 131000},
                    {'Sales', 'General', 'Chicago', 'IL', 55000, 32000, 121000}], 
                    SalaryAvg_Layout);


OUTPUT(SalaryAvg_DS, NAMED('SalaryAvg_DS'));


```
</pre>

<a class="trybutton" href="javascript:OpenECLEditor(['ds_example1'])"> Try Me </a>

</br>

## Logical File

A sprayed file on cluster. HPCC Systems supports different file formats such as XML, JSON, THOR, and CSV. 

### Syntax

```java
attr_layout := RECORD
    data_type    field1;
    ...
    ...
    ...
    data_type    field100;
END;

path := '~some::sample::path';

//File Dataset
attr_name := DATASET(path,
                       attr_layout,
                       file_type);
```

<br>

|*Value*|*Definition*|
|:----|:---------|
attr_name   | The name by which the dataset will be invoked.
DATASET     | Required.
path        | Logical file name stored on the cluster.
attr_layout | Name of your Record layout.
file_type   | Type of file (XML, CSV, JSON, THOR, BLOB, FIXED).


#### Example

``` java
/*
DATASET Example:
Defining a logical file as input dataset.
*/

// Defining record layout
SalaryAvg_Layout := RECORD
    STRING   Job;
    STRING   Category;
    STRING   City;
    STRING2  State;
    INTEGER  Avg_Salary;
    INTEGER  LowerBand;
    INTEGER  Upperband;
END;

// Getting the dataset
SalaryAvg_DS := DATASET('~sample::average::salary::dataset', SalaryAvg_Layout, THOR);

```


### File Types

- **THOR**: Native file type for Thor; also used for fixed-length raw records
- **CSV**:  Any kind of delimited data, including CSV-encoded data
- **JSON**: Data stored as a series of JSON objects
- **XML**:  Data stored as a series of XML documents
- **PIPE**: Data obtained dynamically via process calls

</br>
</br>