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

//Ascending
A_SortedLastName := SORT(allPeople, lastName);
OUTPUT(A_SortedLastName, NAMED('Asc_SortedLastName'));

A_SortedIncome := SORT(A_SortedLastName, avgHouseIncome);
OUTPUT(A_SortedIncome, NAMED('Asc_SortedIncome'));

//Descending
D_SortedIncome := SORT(allPeople, -avgHouseIncome);
OUTPUT(D_SortedIncome, NAMED('Des_SortedIncome'));

//sort per multiple fields
OUTPUT(SORT(allPeople, firstName, lastName, avgHouseIncome),
						NAMED('Sort_Couple_Fields'));
