<html lang="en" data-color-mode="auto" data-light-theme="dark" data-dark-theme="dark">

# Filter

Data filtering is the process of choosing a smaller part of your data set and using that subset for viewing or analysis. When filtering the complete dataset will remain the same.

## Demo Dataset

|PersonID|FirstName|LastName|isEmployed|avgHouseIncome|
|:----|:---|:---|:----|:---|
102 | Fred | Smith | FALSE | 0
012 | Joe | Blow | TRUE | 11250
085 | Blue | Moon | TRUE | 185000
055 | Silver | Jo | FALSE | 5000
265 | Darling | Jo | TRUE | 5000
333 | Jane | Smith | FALSE | 50000

</br>

## Filter Example
<br>
<pre id="code_1">

``` java
// Creating record layout
Emp_layout := RECORD
    EmpID  PersonID; 
    STRING FirstName; 
    STRING LastName; 
    BOOLEAN IsEmp;
    INTEGER RoundedIncome;
END; 

// Creating inline dataset
Emp_DS := DATASET([
    {102,'Fred','Smith','FALSE',0},
    {012,'Joe','Blow','TRUE',11250},
    {085,'Blue','Moon','TRUE',185000},
    {055,'Silver','Jo','FALSE',5000},
    {265,'Darling','Jo','TRUE',5000},
    {333,'Jane','Smith','FALSE',50000}
    ]);

// Filter Smith last name
GetSmith := Emp_DS(LastName='Smith');

OUTPUT(GetSmith, NAMED('GetSmith'));

// Filter unemployed with income
IsWorking := Emp_DS(IsEmp = FALSE AND
                    RoundedIncome > 0);

OUTPUT(IsWorking, NAMED('IsWorking));
                  
```
</pre>

<a class="trybutton" href="javascript:OpenECLEditor(['code_1'])"> Try Me </a>

## Filter Operators 

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

<br>
</div>
    test-0
