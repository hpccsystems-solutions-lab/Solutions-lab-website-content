---
title: Output
slug: output
---

# OUTPUT

OUTPUT is an action that allows users to view results. OUTPUT can be used to save dataset results in a file.
There are a few ways to generate output.

The following examples demonstrate how you can simply view results. 'NAMED' allows you to label your outputs making it very useful when you have multiple outputs.

**Example**

<pre>
<EclCode
id="OutputExample"
tryMe="OutputExample"
code="// OUTPUT Examples.

// Outputting numeric value
OUTPUT(100 + 200, NAMED('myFirst'));

// Assigning a STRING value to an attribute
someVal := 'My First String';

// Outputting the attribute
OUTPUT(someVal, NAMED('someVal'));
"></EclCode>
</pre>

## SQL vs. ECL

OUTPUT is similar to SELECT in SQL.

| SQL                                   | ECL                                                   |
| :------------------------------------ | :---------------------------------------------------- |
| `SELECT * From PeopleDSeDS;`          | `OUTPUT(peopleDS);`                                   |
| `SELECT name, address FROM PeopleDS;` | `OUTPUT(TABLE(common.PeopleDSeDS, {name, address}));` |

## Syntax

<pre>
<EclCode
code="OUTPUT(dataset_name/attr_name);
OUTPUT(dataset_name/attr_name, Named('display-name'));"

> </EclCode>
</pre>

| Value | Definition |
| :- | - |
| OUTPUT | Required. The name of the dataset to output the result to. |
| dataset_name | The name of the dataset you want to output the result to. |
| attr_name | The attribute (field) in the dataset. |
| NAMED | Optional but recommended, especially when multiple outputs are being viewed. Specifies a label for the result. The given name must not start with numbers and should avoid spaces or hyphens. |

**Demo Dataset**

| Job      | Category          | City    | State | Avg_Salary | LowerBand | Upperband |
| :------- | :---------------- | :------ | :---- | :--------- | :-------- | :-------- |
| Manager  | IT                | Atlanta | GA    | 87000      | 62000     | 114000    |
| Director | IT                | Atlanta | GA    | 119000     | 84000     | 156000    |
| Director | Art-Entertainment | Atlanta | GA    | 100000     | 70000     | 133000    |
| CIO      | IT                | Tampa   | FL    | 112000     | 69000     | 131000    |
| Sales    | General           | Chicago | IL    | 55000      | 32000     | 121000    |

**Example**

<pre>
<EclCode
id="DatasetExample"
tryMe="DatasetExample"
code="
// OUTPUT Examples. Outputting a dataset.

// Defining record layout
SalaryAvg_Layout := RECORD
STRING Job;
STRING Category;
STRING City;
STRING2 State;
INTEGER Avg_Salary;
INTEGER LowerBand;
INTEGER Upperband;
END;

// Creating the dataset
SalaryAvg_DS := DATASET([
{'Manager', 'IT', 'Atlanta', 'GA', 87000, 62000, 114000},
{'Director', 'IT', 'Atlanta', 'GA', 119000, 84000, 156000},
{'Director', 'Art-Entertainment', 'Atlanta', 'GA', 100000, 70000, 133000},
{'CIO', 'IT', 'Tampa', 'FL', '112000', '69000', 131000},
{'Sales', 'General', 'Chicago', 'IL', 55000, 32000, 121000}],
SalaryAvg_Layout);

// Output with no label
// Note: When you have multiple outputs with no labels(NAMED option),
// it might be difficult to identify them.

OUTPUT(SalaryAvg_DS);
SalaryAvg_DS;

// Using NAMED
OUTPUT(SalaryAvg_DS, NAMED('SalaryAvg_DS'));"></EclCode>
</pre>
