# Filter

Data filtering is the process of choosing a smaller part of your data set and using that subset for further processing. It’s recommended to filter down to the desire dataset before any processing. 
When using filter on STRING values keep in mind that STRING values are case sensitive. For example Sun, sun, SUN are not the same. 


## SQL vs. ECL

Filter is similar to SELECT. In ECL the filtering fields are in ( ).

```java
// SQL 
SELECT name, address FROM PeopleDS WHERE name = 'Jo';

// ECL
OUTPUT(peopleDS(name = 'Jo'));
```

### Syntax  

```java
attr_name := dataset_name (filtering condition(s));
```

|Value|Definition|
|:----|:---------|
attr_name | The name by which the function will be invoked.
dataset_name | The dataset to perform action on.
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
/*
FILTER Example:
Showing different examples of FILTER function 
based on different fields or logical operator.
*/

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
IN  | To specify multiple possible values for a field/column.
NOT IN  | To specify multiple possible values that are not in a field/column.
BETWEEN | Between a certain range.

</br>
</br>




#### Example
<br>
<pre className="FilterExp_2">
<pre id="file2" className="ecl_data">

```java
/*
Filter Example
*/

/*
Filter Example
*/
StrokRec := RECORD
    STRING   ID;	
    STRING   Gender;	
    INTEGER  Age;	
    BOOLEAN  Hypertension;	
    BOOLEAN  Heart_Disease;	
    STRING   Ever_Married;	
    STRING   Work_Type;	
    STRING   Residence_Type;	
    STRING   Avg_Glucose_Level;	
    STRING   BMI;	
    STRING   Smoking_status;	
    BOOLEAN  Stroke;
END;


StrokDS := DATASET('~raw::healthcare-dataset-stroke-data.csv', StrokRec, CSV(HEADING(1)));

```
</pre>
<pre id='code2' className="ecl_code">

``` java
// Filtering men over age of 80
Over80 := StrokDS(Age >= 80);
OUTPUT(Over80, NAMED('Over80'));

```
</pre>
</pre>
<a class="trybutton" href="javascript:OpenECLEditor(['code2'], ['file2'])"> Try Me </a>
</br>
</br>


#### Example
<br>
<pre className="FilterExp_3">
<pre id="file3" className="ecl_data">

```java
/*
Filter Example
*/

/*
Filter Example
*/
StrokRec := RECORD
    STRING   ID;	
    STRING   Gender;	
    INTEGER  Age;	
    BOOLEAN  Hypertension;	
    BOOLEAN  Heart_Disease;	
    STRING   Ever_Married;	
    STRING   Work_Type;	
    STRING   Residence_Type;	
    STRING   Avg_Glucose_Level;	
    STRING   BMI;	
    STRING   Smoking_status;	
    BOOLEAN  Stroke;
END;


StrokDS := DATASET('~raw::healthcare-dataset-stroke-data.csv', StrokRec, CSV(HEADING(1)));

```
</pre>
<pre id='code3' className="ecl_code">

``` java
// Over 80 years old men with heart disease 
OUTPUT(StrokDS(Gender = 'Male' AND Age >= 80 AND Heart_Disease), NAMED('Males'));
```
</pre>
</pre>
<a class="trybutton" href="javascript:OpenECLEditor(['code3'], ['file3'])"> Try Me </a>
</br>
</br>
