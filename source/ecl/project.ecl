// Project with standalone Transform

Person_Layout := RECORD
	STRING FirstName;
	STRING LastName;
END;

NameDS := DATASET([{'Sun','Shine'}, 
				   {'Blue','Sun'}, 
				   {'Jo','Black'}, 
				   {'Sunny','Boy'}, 
				   {'Silver','Rose'}], 
					  Person_Layout);

NameOutRec := RECORD
    INTEGER RecCount;
	STRING FirstName;
	STRING LastName;
	STRING CatValues;
END;

NameOutRec CatThem(Person_Layout L, INTEGER C) := TRANSFORM
	SELF.CatValues := L.FirstName + ' ' + L.LastName; //Defines value for new field
    SELF.RecCount := C;  // Adding Counter
	SELF := L;			// Assign everything with same field name from NameDS
END;

CombinePeople := PROJECT(NameDS, // Dataset to loop through 
					CatThem  //Transform name
					(LEFT,	 //Left dataset which is NameDS
					COUNTER	 //Simpler Counter
					));

OUTPUT(CombinePeople, NAMED('CombinePeople'));


//-----------------------------------------------------
//-----------------------------------------------------
//PROJECT with inline TRANSFORM 

Resident_Layout := RECORD
	INTEGER PersonalID;
	STRING  FirstName;
	STRING  LastName;
    STRING  haveCity;
END;

Resident_DS := DATASET([{100, 'Jo', 'Smith', ''}, 
                        {203, 'Dan', 'Carpenter', 'London'}, 
                        {498, 'Sally', 'Fryman', 'Rome'}, 
                        {567, 'Mary', 'Cool', 'Ankara'}, 
                        {098, 'Sun', 'Shin', 'NewYork'}, 
                        {302, 'Silver', 'Rose', ''}], 
                            Resident_Layout);

FutureResident_Layout := RECORD
    INTEGER RecCount;
	INTEGER PersonalID;
	STRING  PersonName;
	STRING  FutureAddress;
    STRING  FutureCity;
    INTEGER FutureZipCode;
    BOOLEAN HaveJob;
END;

FinalResidents := PROJECT(Resident_DS, 
                        TRANSFORM(FutureResident_Layout,  
                            SELF.PersonName := LEFT.FirstName + ' ' + LEFT.LastName;
                            SELF.RecCount   := COUNTER;
                            SELF.FutureCity := IF(LEFT.haveCity != '', LEFT.haveCity, '');
                            SELF.HaveJob    := SELF.FutureCity != '';
                            //HaveJob is equal to:
                            //SELF.HaveJob := IF(SELF.FutureCity != '', TRUE, FALSE);
                            SELF            := LEFT;
                            SELF			   := [];
                                ));

OUTPUT(FinalResidents, NAMED('FinalResidents'));

