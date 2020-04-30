/*
Join 
- Conditions  
- Types 
*/

Emp_Layout := RECORD
    INTEGER EmpID;
    STRING  Name;
    INTEGER HireYear;
END;

EmpDS := DATASET([
                  {1000,'Jack', 2014},  
                  {2000,'Blue', 2016},   
                  {3000,'Mary', 2016},   
                  {5000,'Mart', 2000},   
                  {8000,'Cat',  2002}],
                      Emp_Layout);

OUTPUT(EmpDS, NAMED('EmpDS'));
										 
JobCat_Layout := RECORD
    INTEGER EmpID;
    STRING  Department;
    STRING  Title;

END;

JobCatDS := DATASET([
                    {1000, 'IT', 'developer'},
                    {2000, 'Biz', 'Manager'},
                    {4000, 'Fin', 'accountant'},
                    {8000, 'IT', 'analyst'},
                    {7000, 'SoftEng', 'Programmar'},
                    {9000, 'Fin', 'CFO'}],
                        JobCat_Layout);

OUTPUT(JobCatDS, NAMED('JobCatDS'));

//Result layout												 
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

//FULL OUTER Join
FullOuterJoin := JOIN(EmpDS, JobCatDS,
                        LEFT.EmpID = RIGHT.EmpID,
                        TRANSFORM(EmpResult_Layout,
                        				SELF := LEFT,
                        				SELF := RIGHT),
                        				FULL OUTER);
														
OUTPUT(FullOuterJoin, NAMED('FullOuterJoin'));



/* JOIN with stand alone Transfer */
///Right Outer Join 

//Create Transfomr to be called in Join
EmpResult_Layout xForm (Emp_Layout Li, JobCat_Layout Ri) := TRANSFORM
     SELF.Title := Ri.title + ' ' + Ri.department;
     SELF := Li,
     SELF := Ri,
END;

//Create Join
RightOuterJoin := JOIN(EmpDS, JobCatDS,
                        LEFT.EmpID = RIGHT.EmpID,
                        xForm(LEFT, RIGHT),
                        RIGHT OUTER);

OUTPUT(RightOuterJoin, NAMED('RightOuterJoin'));


// Full Outer Join
FulltOuterJoin := JOIN(EmpDS, JobCatDS,
                        LEFT.EmpID = RIGHT.EmpID,
                        xForm(LEFT, RIGHT),
                        FULL OUTER);

OUTPUT(FulltOuterJoin, NAMED('FulltOuterJoin'));
