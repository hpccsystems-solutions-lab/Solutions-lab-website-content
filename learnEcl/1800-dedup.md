---
title: Dedup
slug: dedup
---

# DEDUP

The DEDUP function removes duplicates from a dataset based on the defined conditions. The result is a dataset with unique values for selected fields.

**Note** DEDUP compares only adjacent records, therefore your dataset must be sorted beforehand.

**Syntax**
<pre>
  <EclCode 
  code="DEDUP(dataset, [, condition])">
  </EclCode>
</pre>

| Value | Definition |
| :- | :- |
| DEDUP | Required. |
| dataset | Input dataset to process. |
| condition | A comma-delimited list of expressions or key fields in the dataset that defines "duplicate" records. |

**Demo Dataset**
| StudentID | Name | City | State | ZipCode | Department |
| :- | :- | :- | :- | :- | :- |
| 300 | Sarah | Dallas | TX | 30000 | Art |
| 400 | Matt  | | | | Medical |
| 305 | Liz | Atlanta | GA | 30330 | Math |
| 305 | Liz | Smyrna | GA | 30330 | |
| 100 | Zoro | Atlanta | GA | 30330 | |
| 100 | Zoro | Smyrna | GA | 30330 | |
| 800 | Sandy | | | | Science |
| 604 | Danny | New York | NY | 40001 | |
| 409 | Dan | New York | NY | 40001 | Medical |
| 300 | Sarah | Dallas | TX | 30000 | Math |

**Example**
<pre>
  <EclCode 
  id="DedupExp_1"
  tryMe="DedupExp_1"
  code="/*
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

  // Sorting Student_DS dataset 
  SortDS := SORT(Student_DS, StudentID, Name, City, State, ZipCode, Department);

  DupMe := DEDUP(SortDS, StudentID, Name);
  OUTPUT(DupMe, NAMED('DupMe'));

  DupExp := DEDUP(SortDS, Name, Department);
  OUTPUT(DupExp, NAMED('DupExp'));">
  </EclCode>
</pre>
