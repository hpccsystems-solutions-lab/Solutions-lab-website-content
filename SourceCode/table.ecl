/*
Table
- GROUP option
*/

// Fare Table
//Defining record layout
fareLayout := RECORD
    STRING10 pickup_date;
    DECIMAL8_2 fare;
    DECIMAL8_2 distance;
END;

//Inline dataset
fareDS  :=  DATASET([
                {'2015-01-01', 25.10, 5.5},  
                {'2015-01-02', 40.15, 7.2},  
                {'2015-01-02', 30.10, 6.65}, 
                {'2015-02-03', 25.36, 6.78}, 
                {'2015-02-03', 65.2, 28.45}, 
                {'2015-03-05', 34.2, 15.5}, 
                {'2015-04-04', 15.15, 4}], 
                fareLayout);

OUTPUT(fareDS, NAMED('fareDS'));

//Defining table fields
crossTabLayout  :=  RECORD
   fareDS.pickup_date; //Calling specific field from input dataset
   avgFare   := AVE(GROUP, fareDS.fare); //Calculating avg fare per each group
   totalFare := SUM(GROUP, fareDS.fare); //Calculating total fare per each group
END;

crossTabDs := TABLE(fareDS, //Input dataset. please see dataset above
                     crossTabLayout, //Result table definition
                     pickup_date //Grouping field
                     );
OUTPUT(crossTabDs, NAMED('crossTabDs'));

// Person Table

//Creating record layout
personLayout := RECORD
    UNSIGNED4 id;
    STRING    name;
    STRING5   zip_code;
END;

personDS := DATASET([
    {1000, 'Moon', 30330}, {1001, 'Tardy', 40445}, {1005, 'Black', 30330},
    {2000, 'Zoon', 30000}, {2002, 'Snow', 30330},  {2005, 'Rainy', 40440},
    {3000, 'Blue', 30501}, {3003, 'White', 40445}, {3008, 'Call', 30501}
],
personLayout);

OUTPUT(personDS, NAMED('personDS'));

//Create table
people_Count := TABLE(
                   personDS,
                   {
                       zip_code; //Calling specific field from input dataset
                       UNSIGNED4 count_people := COUNT(GROUP);   //Aggregated field                    
                   },
                   zip_code, //Grouping condition
                   MERGE     //Flag 
                    );

OUTPUT(people_Count, NAMED('people_Count'));