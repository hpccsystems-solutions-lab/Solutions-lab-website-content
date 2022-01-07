# Filter

Data filtering is the process of choosing a smaller part of your data set and using that subset for further processing. It’s recommended to filter down to the desire dataset before any processing. 
When using filter on STRING values keep in mind that STRING values are case sensitive. For example Sun, sun, SUN are not the same. 

### Syntax  

```java
attr_name := dataset_name (filtering condition(s));
```

|Value|Definition|
|:----|:---------|
attr_name | The name by which the function will be invoked
dataset_name | The dataset to perform action on 
Filtering condition(s) | field or fields and required filtering conditions. Logical operators can be used to execute multiple filters.

<br>


**Demo Dataset**

|PersonID|FirstName|LastName|isEmployed|avgHouseIncome|
|:----|:---|:---|:----|:---|
102 | Fred | Smith | FALSE | 0
012 | Joe | Blow | TRUE | 11250
085 | Blue | Moon | TRUE | 185000
055 | Silver | Jo | FALSE | 5000
265 | Darling | Jo | TRUE | 5000
333 | Jane | Smith | FALSE | 50000

<br>


#### Example

<br>
<pre id="FilterExp_1">

``` java
// Creating record layout
Emp_layout := RECORD
    INTEGER  PersonID; 
    STRING   FirstName; 
    STRING   LastName; 
    BOOLEAN  IsEmp;
    INTEGER  RoundedIncome;
END; 

// Creating an inline dataset
Emp_DS := DATASET([
                {102,'Fred','Smith',FALSE,0},
                {012,'Joe','Blow',TRUE,11250},
                {085,'Blue','Moon',TRUE,185000},
                {055,'Silver','Jo',FALSE,5000},
                {265,'Darling','Jo',TRUE,5000},
                {333,'Jane','Smith',FALSE,50000}],
                Emp_layout);

// Filter Smith last name
GetSmith := Emp_DS(LastName='Smith');
OUTPUT(GetSmith, NAMED('GetSmith'));

// Notice that following filter will return an empty dataset
OUTPUT(Emp_DS(LastName='smith'), NAMED('Case_Sensitive'));


// Filter unemployed with income using logical operators
IsWorking := Emp_DS(IsEmp = FALSE AND
                    RoundedIncome > 0);

OUTPUT(IsWorking, NAMED('IsWorking'));

// Capturing everyone that is employed 
// Following filter is the same as: 
// Emp_DS(IsEmp = TRUE)
OUTPUT(Emp_DS(IsEmp), NAMED('Employed'));


```
</pre>

<a class="trybutton" href="javascript:OpenECLEditor(['FilterExp_1'])"> Try Me </a>
<br>
<br>


## Logical Operators 

|Operator|Description|
|:----|:---|
=	  | Equal
\>  | Greater than
<	  | Less than
\>= | Greater than or equal	
<=  | Less than or equal	
<>  | Not equal
!=  | Not equal
AND | Logical AND
OR  | Logical OR
IN  | To specify multiple possible values for a field/column
NOT IN  | To specify multiple possible values that are not in a field/column
BETWEEN | Between a certain range

<br></br>

