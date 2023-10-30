---
title: Dataset
slug: dataset
---

# DATASET

A Dataset is a set of records that an ECL program can manipulate. A Dataset can be initialized using a logical file (File Dataset), inline data (Inline Dataset) or by another ECL function that filters, queries or transforms data (Derived Dataset).

When defining a DATASET you need to define the [RECORD](../record) of the dataset first.

## SQL vs. ECL

DATASET is similar to TABLE in SQL.

| SQL | ECL |
| - | - |
| SimpleTable = select \* from '~simpledata.csv' type csv layout SimpleLayout as simpleDS offset 1; | simpleDS := DATASET('~simpledata.csv', SimpleLayout, CSV); |

## Inline Dataset

A (typically small) static dataset defined in the code.

### Syntax

<pre>
<EclCode code="attr_layout := RECORD
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
                    );">
</EclCode>
</pre>

| Value       | Definition                                     |
| :---------- | :--------------------------------------------- |
| attr_name   | The name by which the dataset will be invoked. |
| DATASET     | Required.                                      |
| `[ ... ]`   | Contains all rows for dataset.                 |
| `{ ... }`   | Defines one row.                               |
| attr_layout | Name of your Record layout.                    |

**Demo Dataset**

| Job      | Category          | City    | State | Avg_Salary | LowerBand | Upperband |
| :------- | :---------------- | :------ | :---- | :--------- | :-------- | :-------- |
| Manager  | IT                | Atlanta | GA    | 87000      | 62000     | 114000    |
| Director | IT                | Atlanta | GA    | 119000     | 84000     | 156000    |
| Director | Art-Entertainment | Atlanta | GA    | 100000     | 70000     | 133000    |
| CIO      | IT                | Tampa   | FL    | 112000     | 69000     | 131000    |
| Sales    | General           | Chicago | IL    | 55000      | 32000     | 121000    |

**Example**

<pre >
<EclCode 
id="ds_example1"
tryMe="ds_example1"
code="/*DATASET Example:
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
">
</EclCode>
</pre>

## Logical File

Logical files are any file saved on the cluster. Using a logical file's single name refers to all the file's data even if it's distributed among many storage locations. HPCC Systems supports different file formats such as XML, JSON, THOR, and CSV.

### Syntax

<pre>
<EclCode
code="attr_layout := RECORD
    data_type    field1;
    ...
    ...
    ...
    data_type    field100;
END;

path := '~some::sample::path';

// File Dataset
attr_name := DATASET(path,
                       attr_layout,
                       file_type);"
>

</EclCode>
</pre>

| _Value_     | _Definition_                                      |
| :---------- | :------------------------------------------------ |
| attr_name   | The name by which the dataset will be invoked.    |
| DATASET     | Required.                                         |
| path        | Path where the Logical file is stored on the cluster. |
| attr_layout | Name of your Record layout.                       |
| file_type   | Type of file (XML, CSV, JSON, THOR, BLOB, FIXED). |

**Example**

<pre>
<EclCode 
code="/*
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

// Logical file dataset
SalaryAvg_DS := DATASET('~sample::average::salary::dataset', SalaryAvg_Layout, THOR);
">
</EclCode>
</pre>

## File Types

- **THOR**: Native file type for Thor; also used for fixed-length raw records
- **CSV**: Any kind of delimited data, including CSV-encoded data
- **JSON**: Data stored as a series of JSON objects
- **XML**: Data stored as a series of XML documents
- **PIPE**: Data obtained dynamically via process calls
