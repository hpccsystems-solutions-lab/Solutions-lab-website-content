# JOIN

The join function produces a result dataset based on the intersection of two datasets or indexes.

```java
attribName := JOIN(LEFT_DatasetName,
                   RIGHT_DatasetName,
				   // AND/OR/NOT_Equal Conditions
					LEFT.fieldName  = RIGHT.fieldName AND
					(LEFT.fieldName = RIGHT.fieldName OR,
					LEFT.fieldName != RIGHT.fieldName),
					TRANSFORM(Result_RecordLayout,
							SELF := LEFT,
							SELF := RIGHT),
					        JOINType);
```

**Condition**

- Boolean test of arbitrary complexity
- Normally contains at least one equality test
- Reference attributes within the input datasets via LEFT and RIGHT - ds1 = LEFT - ds2 = RIGHT

**Transform**

- If using an explicit TRANSFORM, it should accept at least two arguments
  - One representing a LEFT record and the other representing a RIGHT record
  - Ex: BazRec MakeBaz(FooRec rec1, BarRec rec2) := TRANSFORM … END;
- If using an inline TRANSFORM, use LEFT and RIGHT to reference input data

**Flags**

- Optional flags that can alter the behavior of the JOIN
- Commonly used flags
  - LOOKUP: The RIGHT dataset is relatively small and there should be only one match for anyLEFT record
  - ALL: The RIGHT dataset is relatively small and can be copied to every node in its entirety
    - Can have multiple matches (unlike LOOKUP)
    - Supports join conditions that contain no equalities
    - Required if there are no equality tests in the condition

### Join Types

- **INNER**: Keep only those records that exist in both datasets.
- **LEFT OUTER** Keep all records from LEFT, even if there are no matches.
- **RIGHT OUTER** Keep all records from RIGHT, even if there are no matches.
- **LEFT ONLY** One record for each left record with no match in the left.
- **RIGHT ONLY** One record for each left record with no match in the right.
- **FULL ONLY** One record for each left and right record with no match in the opposite.

Employee Information, EmpDS\
![Employee Dataset](./Images/EmpID_DS.JPG)

Job Category, JobCatDS\
![Job Category Dataset](./Images/EmpCat_DS.JPG)

```java
EmpResult_Layout := RECORD
    INTEGER EmpID;
	STRING  Name;
	STRING  Title;
	STRING  Department;
END;


//Inner Join
InnerJoin := JOIN(EmpDS, JobCatDS,
					LEFT.EmpID = RIGHT.EmpID,
					TRANSFORM(EmpResult_Layout,
						SELF := LEFT,
						SELF := RIGHT));

OUTPUT(InnerJoin, NAMED('InnerJoin'));

//LEFT ONLY Join
LeftOnlyJoin := JOIN(EmpDS, JobCatDS,
					LEFT.EmpID = RIGHT.EmpID,
					TRANSFORM(EmpResult_Layout,
							SELF := LEFT,
							SELF := RIGHT),
							LEFT ONLY);

OUTPUT(LeftOnlyJoin, NAMED('LeftOnlyJoin'));

//LEFT OUTER Join
LeftOuterJoin := JOIN(EmpDS, JobCatDS,
						LEFT.EmpID = RIGHT.EmpID,
						TRANSFORM(EmpResult_Layout,
							SELF := LEFT,
							SELF := RIGHT),
							LEFT OUTER);

OUTPUT(LeftOuterJoin, NAMED('LeftOuterJoin'));

```

<p style="text-align: center"> Inner Join Result</p>
<img align="center" src="./Images/EmpInnerJoin.JPG" />

<p style="text-align: center"> Left Only Join Result</p>
<img align="center" src="./Images/EmpLeftOnly.JPG" />

<p style="text-align: center"> Left Outer Join Result</p>
<img align="center" src="./Images/EMp_LeftOuter.JPG" />

## Resources

Put it into practice [join.ecl](https://ide.hpccsystems.com/workspaces/share/291d17d9-e5cb-4fac-83c2-ac5997c28a31)

Please see [JOIN Function](https://hpccsystems.com/training/documentation/ecl-language-reference/html/JOIN.html) for more information.
