
/*
Filter
*/

// Define record layout
Layout_Person := RECORD
  UNSIGNED  personID;
  STRING15  firstName;
  STRING25  lastName;
  BOOLEAN   isEmployed;
  UNSIGNED  avgHouseIncome; 
END;

//Inline dataset
allPeople := DATASET([ {102,'Fred','Smith', FALSE, 0},
                       {102,'Fact','Smith', TRUE, 200000},
                       {012,'Joe','Blow', TRUE, 11250},
                       {085,'Blue','Moon', TRUE, 185000},
                       {055,'Silver','Jo', FALSE, 5000},
                       {265,'Darling','Jo', TRUE, 5000},
                       {265,'Blue','Silver', TRUE, 75000},
                       {333,'Jane','Smith', FALSE, 50000},
                       {333,'Funny','Joke', FALSE, 450}]
                         ,Layout_Person);

OUTPUT(allPeople, NAMED('allPeople'));

//Show employed people
OUTPUT(allPeople(isEmployed), NAMED('isEmployed'));

//Capture None Smith last names and save the result.
//<> or != can be used for not equal 
//Strings are case sensitive
noSmith := allPeople(lastName != 'Smith');

OUTPUT(noSmith, NAMED('noSmith'));

//Show income > 100000 or Jo last name
allPeople(lastName = 'Jo' OR avgHouseIncome > 100000);

