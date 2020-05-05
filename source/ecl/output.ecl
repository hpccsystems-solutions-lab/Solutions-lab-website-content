SalaryAvg_Layout := RECORD
    STRING Job;
    STRING Category;
    STRING City;
    STRING2	State;
    INTEGER	Avg_Salary;
    INTEGER	LowerBand;
    INTEGER	Upperband;
END;

//Please note this is a madeup dataset :)
SalaryAvg_DS := DATASET([
                {'Manager', 'IT', 'Atlanta', 'GA', 87000, 62000, 114000},
                {'Director', 'IT', 'Atlanta', 'GA', 119000, 84000, 156000},
                {'Director', 'Art-Entertainment', 'Atlanta', 'GA', 100000, 70000, 133000},
								{'Manager', 'Sale', 'Frankfort', 'KY', 99000, 62000, 120000},
                {'Director', 'Art-Entertainment', 'Augusta', 'ME', 80000, 70000, 120000},
                {'Director', 'Art-Entertainment', 'Atlanta', 'GA', 100000, 70000, 133000},
                {'CIO', 'IT', 'Tampa', 'FL', '112000', '69000', 131000},
                {'Sales', 'General', 'Chicago', 'IL', 55000, 32000, 121000}
                ], SalaryAvg_Layout //Layout definition
                );

//Output with no lable, following will display the dataset without labling the output
OUTPUT(SalaryAvg_DS);


//Looking for an easier way :)
//Note: too many outputs with no lables, you won't know what you are looking at.
SalaryAvg_DS; 
SalaryAvg_DS(state = 'IL'); 

//Sting matching are case senstive
OUTPUT(SalaryAvg_DS(state = 'il'), 
            NAMED('case_sensetive')); 

//Let's see how we can lable them
OUTPUT(SalaryAvg_DS, NAMED('SalaryAvg_DS'));

//We can filter dataset too
OUTPUT(SalaryAvg_DS(city = 'Atlanta'), 
						NAMED('Atlanta_Salary'));

OUTPUT(SalaryAvg_DS(Avg_Salary >= 100000), 
						NAMED('Over_100K_Salary'));
