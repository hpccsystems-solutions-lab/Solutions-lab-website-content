# DEDUP

The DEDUP function removes duplicates from a dataset based on the defined conditions. The result is dataset with unique values for selected fields. 

**Note**
To use DEDUP you dataset must be **sorted**. 
## Syntax

```java
DEDUP(dataset, [, condition])
```
|Value|Definition|
|:----|:---------|
DEDUP | Required.
dataset | Input dataset to process.
condition | A comma-delimited list of expressions or key fields in the dataset that defines "duplicate" records.

<br>

**Demo Dataset**

|StudentID|Name|City|State|ZipCodeDepartment|
|:----|:---|:---|:---|:---|
300 | Sarah| Dallas|	Te|	30000|	Art
400 | Matt|	 	 |    |         Medical
305 | Liz|	 Atlanta|	GA|	30330|  Math	
305 | Liz|	 smyrna|	GA|	30330|  	
100 | Zoro|	 Atlanta|	GA|	30330|  	
100 | Zoro|  smyrna|	GA|	30330|  	
800 | Sandy|  |  || Science
604 | Danny| Newyork|	NY|	40001|  	
409 | Dan|   Newyork|	NY|	40001|	Medical
300 | Sarah| Dallas|	TX|	30000|	Math
<br>

 #### Example

<br>
<pre id="DedupExp_1">


```java
/*
DEDUP Example:
Deduping the input dataset based on different fields.
Keep in mind that for DEDUP your dataset must be sorted.
*/

Student_Rec := RECORD
  INTEGER   StudentID;
  STRING    Name;
  STRING    City;
  STRING2   State;
  STRING5   ZipCode;
  STRING    Department;
END;

Student_DS := DATASET([
              {300,	'Sarah', 'Dallas',	'Te',	'30000',	'Art'},
              {400,	'Matt',	 	'',		     '',  '',       'Medical'},
              {305,	'Liz',	 'Atlanta',	'GA',	'30330',  'Math'},	
              {305,	'Liz',	 'smyrna',	'GA',	'30330',  ''},	
              {100,	'Zoro',	 'Atlanta',	'GA',	'30330',  ''},	
              {100,	'Zoro',  'smyrna',	'GA',	'30330',  ''},	
              {800,	'Sandy', '',		     '',  '',       'Science'},
              {604, 'Danny', 'Newyork',	'NY',	'40001',  ''},	
              {409,	'Dan',   'Newyork',	'NY',	'40001',	'Medical'},
              {300,	'Sarah', 'Dallas',	'Te',	'30000',	'Math'}],
              Student_Rec);


// Above dataset is already sorted.

DupMe := DEDUP(SortDS, StudentID, Name);
OUTPUT(DupMe, NAMED('DupMe'));

DupExp := DEDUP(SortDS, Name, Department);
OUTPUT(DupExp, NAMED('DupExp'));

```

</pre>
<a class="trybutton" href="javascript:OpenECLEditor(['DedupExp_1'])"> Try Me </a>
