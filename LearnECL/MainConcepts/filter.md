# Filter

Data filtering is the process of choosing a smaller part of your data set and using that subset for viewing or analysis. When filtering the complete dataset will remain the same.

Let's start by defining our dataset.

```java
// Define record layout
Layout_Person := RECORD
  UNSIGNED  PersonID;
  STRING15  FirstName;
  STRING25  LastName;
  BOOLEAN   isEmployed;
  UNSIGNED  avgHouseIncome;
END;

//Inline dataset
allPeople := DATASET([ {102,'Fred','Smith', FALSE, 0},
                       {012,'Joe','Blow', TRUE, 11250},
                       {085,'Blue','Moon', TRUE, 185000},
                       {055,'Silver','Jo', FALSE, 5000},
                       {265,'Darling','Jo', TRUE, 5000},
                       {333,'Jane','Smith', FALSE, 50000}]
											 ,Layout_Person);
OUTPUT(allPeople, NAMED('allPeople'));
```

Complete people dataset:

![Complete People Dataset](./Images/allPeople.JPG)

Filter by income:

![Filter Income](./Images/Poeple_FilterIncome.JPG)

Filter by last name and income:

![Filter last-name income](./Images/PeopleAndFilter.JPG)

## Resources

Put it into practice [filter.ecl](https://ide.hpccsystems.com/workspaces/share/291d17d9-e5cb-4fac-83c2-ac5997c28a31)
