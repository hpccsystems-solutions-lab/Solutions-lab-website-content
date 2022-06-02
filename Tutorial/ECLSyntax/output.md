# OUTPUT

OUTPUT is an action that allows user to view results. OUTPUT can be used to save dataset result in a file. 
There are a few ways to generate output.

Following examples show how you can simply view results. 'NAMED' allows you to label your outputs, and it's very useful when you have many outputs. 

#### Example

<br>
<pre id="OutputExample">

``` java
/*
OUTPUT Examples.
*/

// Outputting numeric value
OUTPUT(100 + 200, NAMED('myFirst'));

// Assigning a STRING value to an attribute
someVal := 'My First String';

// Outputting the attribute
OUTPUT(someVal, NAMED('someVal'));
```
</pre>

<a class="trybutton" href="javascript:OpenECLEditor(['OutputExample'])"> Try Me </a>
</br>
</br>

## SQL vs. ECL

OUTPUT is similar to SELECT in SQL.

SQL|ECL
---|---
SELECT * From PeopleDSeDS; | OUTPUT(peopleDS);
SELECT name, address FROM PeopleDS; | OUTPUT(TABLE(common.PeopleDSeDS, {name, address}));

</br>


## Syntax


```java
OUTPUT(dataset_name/attr_name);
OUTPUT(dataset_name/attr_name, Named('display-name'));
```
<br> 

|*Value*|*Definition*|
|:----|:---------|
OUTPUT | Required.
dataset_name | Dataset name.
attr_name | Attribute.
NAMED | Optional, recommended when multiple outputs are being viewed. NAMED specifies the label for the result. Given name can't start with numbers and shouldn't include spaces or -

</br>

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
<pre id="DatasetExample">

``` java
/*
OUTPUT Examples.
Outputting a dataset.
*/

// Defining record layout
SalaryAvg_Layout := RECORD
    STRING    Job;
    STRING    Category;
    STRING    City;
    STRING2   State;
    INTEGER   Avg_Salary;
    INTEGER   LowerBand;
    INTEGER   Upperband;
END;

// Creating the dataset
SalaryAvg_DS := DATASET([
                    {'Manager', 'IT', 'Atlanta', 'GA', 87000, 62000, 114000},
                    {'Director', 'IT', 'Atlanta', 'GA', 119000, 84000, 156000},
                    {'Director', 'Art-Entertainment', 'Atlanta', 'GA', 100000, 70000, 133000},
                    {'CIO', 'IT', 'Tampa', 'FL', '112000', '69000', 131000},
                    {'Sales', 'General', 'Chicago', 'IL', 55000, 32000, 121000}], 
                    SalaryAvg_Layout);

/*
 Output with no label
 Note: When you have multiple  outputs with no labels(NAMED option), 
it might be difficult to identify them.
*/

OUTPUT(SalaryAvg_DS);
SalaryAvg_DS;

// Using NAMED
OUTPUT(SalaryAvg_DS, NAMED('SalaryAvg_DS'));
```
</pre>

<a class="trybutton" href="javascript:OpenECLEditor(['DatasetExample'])"> Try Me </a>


</br>
</br>