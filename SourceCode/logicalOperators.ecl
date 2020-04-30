
/*
Logical Operators
- AND
- OR
- NOT
*/

// Define record layout
Layout_Person := RECORD
  UNSIGNED  personID;
  STRING15  firstName;
  STRING25  lastName;
  INTEGER   age;
  BOOLEAN   isEmployed;
  UNSIGNED  avgHouseIncome; 
  INTEGER   numHousePoeple;
  BOOLEAN   isMarried;
END;

//Inline dataset
allPeople := DATASET([ {102,'Fred','Smith', 12, FALSE, 0, 3, FALSE},
                       {102,'Fact','Smith', 42, TRUE, 200000, 4, TRUE},
                       {012,'Jakcson','Blow', 65, TRUE, 11250, 3, TRUE},
                       {085,'Blue','Moon', 40,TRUE, 185000, 2, FALSE},
                       {055,'Silver','Jo', 38, FALSE, 5000, 1, FALSE},
                       {265,'Darling','Jo', 21, TRUE, 5000, 5, TRUE},
                       {265,'Blue','Silver', 27, TRUE, 75000, 3, TRUE},
                       {333,'Jane','Smith', 18, FALSE, 50000, 2, FALSE},
                       {255,'Dancer','Jo', 40, FALSE, 5000, 5, TRUE},
                       {333,'Funny','Joke', 23, FALSE, 450, 1, FALSE}]
                         ,Layout_Person);

OUTPUT(allPeople, NAMED('allPeople'));

//AND Operator
marriedWithIncome := allPeople(isMarried = TRUE AND
                               avgHouseIncome > 25000);

OUTPUT(marriedWithIncome, NAMED('marriedWithIncome'));

//OR Operator

youngeOrLowIncome := allPeople(age < 20 OR
                               avgHouseIncome <= 10000);

OUTPUT(youngeOrLowIncome, NAMED('youngeOrLowIncome'));


//NOT Operator
removeJoFamily := allPeople(lastName != 'Jo');

OUTPUT(removeJoFamily, NAMED('removeJoFamily'));


//*****************************************************************************************
//Multiple Operators
//When creating complex logics always make sure your rules are not contradicting each other. 
//For example if you want Silver family not be included in result you need to make sure, your other logics won't include that last name either.
//Sometimes complex logics will result to duplicate rows, in this case DEDUP will be used.
combinedLogic := allPeople((lastName = 'Smith' AND isMarried = FALSE)
                            OR
                            (numHousePoeple >= 3 AND isEmployed = TRUE AND lastName != 'Silver')
                            OR
                            (isEmployed = TRUE AND isMarried = TRUE AND avgHouseIncome > 50000 AND lastName != 'Silver')
                            );

OUTPUT(combinedLogic, NAMED('combinedLogic'));            

//******************************************************************************************
//For simplicity, you can remove all exclusion first and then continue with your combined logic
RemoveSilver := allPeople(lastName != 'Silver');

combinedLogic2 := RemoveSilver((lastName = 'Smith' AND isMarried = FALSE)
                            OR
                            (numHousePoeple >= 3 AND isEmployed = TRUE)
                            OR
                            (isEmployed = TRUE AND isMarried = TRUE AND avgHouseIncome > 50000)
                            );

OUTPUT(combinedLogic2, NAMED('combinedLogic2'));            

