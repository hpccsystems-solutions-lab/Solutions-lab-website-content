/*
Output
- Differnt ways of writiing an output
- NAMED option
- Some functions within output
*/

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
salaryAvg_DS := DATASET([
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
OUTPUT(salaryAvg_DS);


//Looking for an easier way :)
//Note: too many outputs with no lables, you won't know what you are looking at.
salaryAvg_DS; 
salaryAvg_DS(state = 'IL'); 


//Let's see how we can lable  them
//NAMED option
OUTPUT(salaryAvg_DS, NAMED('salaryAvg_DS'));

//Filter result
OUTPUT(
        salaryAvg_DS(city = 'Atlanta'), 
						NAMED('Atlanta_Salary'));


//Sting matching are case senstive
OUTPUT(
        salaryAvg_DS(state = 'il'), 
                        NAMED('case_sensetive')); 

//Sort result
OUTPUT(
        Sort(salaryAvg_DS, State),
						NAMED('Sortby_State'));

//Math funtiosn
OUTPUT(
         MAX(salaryAvg_DS, Avg_Salary),
                        NAMED('Max_Salary'));

