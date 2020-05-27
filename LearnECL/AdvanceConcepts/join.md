# JOIN

## Quick Look

The join function produces a result set based on the intersection of two datasets or indexes.

- INNER: Only those records that exist in both datasets.
- LEFT OUTER: At least one record for every record in the left.
- RIGHT OUTER: At least one record for every record in the right.
- LEFT ONLY: One record for each left record with no match in the left.
- RIGHT ONLY: One record for each left record with no match in the right.
- FULL ONLY: One record for each left and right record with no match in the opposite.

Employee Information, EmpDS\
![Employee Dataset](./images/EmpID_DS.JPG)

Job Category, JobCatDS\
![Job Category Dataset](./images/EmpCat_DS.JPG)

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

Inner Join Result\
![Inner Join Result](./images/EmpInnerJoin.JPG)

Left Only Join Result\
![Inner Join Result](./images/EmpLeftOnly.JPG)

Left Outer Join Result\
![Inner Join Result](./images/EMp_LeftOuter.JPG)

\
Put it into practice [join.ecl](/source/ecl/join.ecl)
