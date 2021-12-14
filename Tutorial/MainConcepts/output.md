# OUTPUT

OUTPUT is an action that allows user to view results. OUTPUT can be used to save recordset result in a file. 
There are a few ways to generate output.

Following example shows how you can simply view the result. Please pay attention that your results are named liked  `Result 1`, and  `Result 2`. 

#### Example

<br>
<pre id="OutputExample">

``` java
// Outputting numeric value
OUTPUT(100, NAMED('myFirst'));

// Assigning a STRING value to an attribute
someVal := 'My First String';

// Outputting the attribute
OUTPUT(someVal, NAMED('someVal'));
```
</pre>

<a class="trybutton" href="javascript:OpenECLEditor(['OutputExample'])"> Try Me </a>

## Syntax
<br>

```java
OUTPUT(dataset_name/attr_name);
OUTPUT(dataset_name/attr_name, Named('display-name'));
```
|*Value*|*Definition*|
|:----|:---------|
OUTPUT | Required 
dataset_name | The dataset you want to view 
attr_name | The attribute you want to view
NAMED | Optional, recommended when multiple outputs are being viewed. NAMED specifies the result names. Given name can't start with numbers and shouldn't include spaces or -



Let's try to output a small dataset. 

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
// Defining record layout
SalaryAvg_Layout := RECORD
    STRING Job;
    STRING Category;
    STRING City;
    STRING2	State;
    INTEGER	Avg_Salary;
    INTEGER	LowerBand;
    INTEGER	Upperband;
END;

// Getting the dataset
SalaryAvg_DS := DATASET('~sample::average::salary::dataset', SalaryAvg_Layout, THOR);

// Output with no label, following will display the dataset without labeling the output
OUTPUT(SalaryAvg_DS);


// Looking for an easier way :)
// Note: too many outputs with no labels, you won't know which result you are looking at.
SalaryAvg_DS;

// Let's see how we can label outputs
OUTPUT(SalaryAvg_DS, NAMED('SalaryAvg_DS'));
```
</pre>

<a class="trybutton" href="javascript:OpenECLEditor(['DatasetExample'])"> Try Me </a>


