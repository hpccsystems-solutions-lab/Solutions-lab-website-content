---
layout: page
title: Project
permalink: '/docs/functions_actions/project'
---

# Quick Look
The PROJECT function processes through all records in the record-set performing the transform function on each record in turn.

```java
NameRec := RECORD //defining record layout
	STRING FirstName;
	STRING LastName;
END;

//creating inline dataset
NameDS := DATASET([{'Sun','Shine'}, {'Blue','Moon'}, {'Silver','Rose'}], NameRec);

//defining new layout for the project result
NameOutRec := RECORD
	STRING FirstName;
	STRING LastName;
	STRING CatValues;
 	INTEGER RecCount; //counter
END;
/*
NameOutRec: result of the project gets saved in this record layout
CatThem: Tranform name
NameRec L: Left datasets thats passed through project 
INTEGER C: counter
*/
NameOutRec CatThem(NameRec L, INTEGER C) := TRANSFORM
	SELF.CatValues := L.FirstName + ' ' + L.LastName; // concact fname and last name 
  	SELF.RecCount := C; //counting
	SELF := L; //assing everything from left recordset 
END;


CatRecs := PROJECT(NameDS, //inline dataset, left recordset
                  CatThem(LEFT,COUNTER) //Transform name
                  );
```

Let's take a look at result:\
![project fname lname exp](/learn/ecl/functions_actions/images/project_Fname.jpg)
