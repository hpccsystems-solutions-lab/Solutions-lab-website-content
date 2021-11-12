
<html lang="en" data-color-mode="auto" data-light-theme="dark" data-dark-theme="dark">

<div class="edit-github pull-right">
                <a href="https://github.com/hpccsystems-solutions-lab/Learn-ECL/blob/16f6d0374864dae731604adf591ac7bebe8e947f/LearnECL/MainConcepts/filter.md"  target="_blank" style="position: absolute; right:0; z-index:900;">
                    <button type="button" role="presentation" title="Edit this document" aria-label="Edit current document on GitHub" style="padding:5px 20px;cursor:pointer;"><span class="hidden-xs">Edit</span></button>
                </a>
</div>



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

<<<<<<< HEAD
</br>

## Filter Example
<br>
<pre id="code_1">

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
    {102,'Fred','Smith','FALSE','0},
    {012,'Joe','Blow','TRUE','11250},
    {085,'Blue','Moon','TRUE','185000},
    {055,'Silver','Jo','FALSE','5000},
    {265,'Darling','Jo','TRUE','5000},
    {333,'Jane','Smith','FALSE','50000}
    ]);

// Filter Smith last name
GetSmith := Emp_DS(LastName='Smith');

OUTPUT(GetSmith, NAMED('GetSmith'));

// Filter unemployed with income
IsWorking := Emp_DS(IsEmp = FALSE AND
                    RoundedIncome > 0);

OUTPUT(IsWorking, NAMED('IsWorking));
                  

</pre>

<button onclick="OpenECLEditor(['code_1'])" style="color: black; background-color: #04AA6D; margin-bottom:10px; cursor:pointer; padding:5px 15px;">Try Me</button> 

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



  <style>
    a, input.ecl {
      text-decoration: none;
      display: inline-block;
      padding: 8px 20px;
      border: none;
      border-radius: 5px;
    }

    a:hover, input.ecl:hover {
      color: black;
      text-decoration: none;
    }

    textarea.code {
      min-height: 120px;
    }

    .previous {
      background-color: #04AA6D;
      color: black;
    }

    .next {
      background-color: #04AA6D;
      color: black;
      position: absolute;
      right: 0
    }

    .code {
      width: 100%;

    }
  </style>

  <br>
  <br>

  <a href="#" class="previous">&laquo; Previous</a>
  <a href="https://hpccsystems-solutions-lab.github.io/hpcc/LearnECL/MainConcepts/sort" class="next">Next &raquo;</a>


