//Defining the layout
CarsLayout := RECORD
		INTEGER price;
		STRING  brand;	
		STRING  model;
		INTEGER year;
		STRING  title_status;
		INTEGER mileage;
		STRING  color;
		STRING  state;
		STRING  country;
END;

//Building an inline dataset

CarsDs := DATASET([
			{10780, 'dodge', 'mpv', 2018, 'clean vehicle', 19420, 'white', 'florida', 'usa'},
			{32012, 'chevrolet', '1500', 2017, 'clean vehicle', 46091, 'white', 'michigan', 'usa'},
			{6800, 'dodge', 'dart', 2016, 'clean vehicle', 49033, 'black', 'michigan', 'usa'},
			{4260, 'dodge', 'mpv', 2018, 'clean vehicle', 33957, 'gray', 'florida', 'usa'},
			{0, 'dodge', 'van', 2008, 'salvage insurance', 177948, 'orange', 'utah', 'usa'},
			{31802, 'chevrolet', 2500, 2017, 'clean vehicle', 19845, 'silver', 'michigan', 'usa'},
			{7210, 'dodge', 'doors', 2018, 'clean vehicle', 38910, 'black', 'florida', 'usa'},
			{0, 'dodge', 'door', 2014, 'salvage insurance', 123660, 'silver', 'utah', 'usa'},
			{28402, 'chevrolet', 1500, 2017, 'clean vehicle', 31234, 'black', 'michigan', 'usa'},
			{6800, 'dodge', 'doors', 2018, 'clean vehicle', 36767, 'gray', 'florida', 'usa'},
			{33300, 'cadillac', 'esv', 2015, 'clean vehicle', 57932, 'gray', 'washington', 'usa'}],
			CarsLayout); //Dataset layout 

OUTPUT(CarsDs, NAMED('Cars_Input_ds'));

//New layout for project result 
PriceCheckLayout := RECORD
		INTEGER price;
		STRING  desc;
		INTEGER year;
		BOOLEAN isOverPriced;
END;

//Standalone transform
PriceCheckLayout xform(CarsDs li) := TRANSFORM
	SELF.desc         := li.brand + ' ' + li.model;
	SELF.isOverPriced := li.price > 15000;  //Assigns TRUE if price of car is over 10K	
	SELF              := li; 			    //for remaining feilds assing the original value
END;

PriceCheck := PROJECT(CarsDS, //Dataset to loop through
                        xForm(LEFT) //Calling transfrom and sending the data set. 
                                    //LEFT refers to CardDS
                      );
											

OUTPUT(PriceCheck, NAMED('PriceCheck_Result'));					


//Let's try blanking some fields
CheckTitle_Layout := RECORD
		STRING  brand;	
		STRING  model;
		STRING  TitleWork;
		INTEGER NewValue;
		STRING  Owener;
END;
			
CheckTitle_Layout yform(CarsDs cd) := TRANSFORM
	SELF.TitleWork := IF(cd.title_status = 'salvage insurance', 'Needs work', 'checked');
	SELF := cd; 			//for remaining feilds assing the original value
	SELF := [] 				//Assign defualt value for the unassinged fields
END;

TitleCheck := PROJECT( CarsDS, //Dataset to loop through
											yform(LEFT) //Calling transfrom and sending the data set. 
											            //LEFT refers to CardDS
											);
											
OUTPUT(TitleCheck, NAMED('TitleCheck_Result'));					



Inline_Layout := RECORD
		INTEGER recCount;
		STRING Model; 
		STRING Brand;    
		STRING State;    
		STRING Owener;
		STRING BuyerName;
END;   


//Inline transform
inlineTrans := PROJECT(CarsDs, //Datset will be refered to as LEFT
						TRANSFORM(Inline_Layout,
							 SELF.recCount := COUNTER, //Adding counter

							 //If State is FL, blank the field, if not get the original state
							 SELF.State    := IF(LEFT.state = 'florida', '', LEFT.State),
							 SELF.Owener   := IF(LEFT.title_status = 'salvage insurance', 'Pre Owned', 'Brand New'),
							 SELF          := LEFT,
							 SELF          := []));
											 
OUTPUT(inlineTrans, NAMED('inline_Transform'));
											 