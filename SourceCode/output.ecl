STRING myfunc (STRING val) := FUNCTION
   Result := 'Hello ' + val + ' , welcome to this function';
  RETURN Result;
END;

//Using myfunc
res := myfunc('Jonny');
OUTPUT(res, NAMED('res'));
OUTPUT(myfunc('Sunny'), NAMED('Sunny'));

//******************************************************

mathFunc() := FUNCTION
    numOne := RANDOM();
    str    := IF(numOne % 2 = 0, 'Even', 'Odd');
    
    RETURN numOne + ' is an ' + str + ' number';
END;

OUTPUT(mathFunc(), NAMED('mathFunc'));

//*******************************************************
// Including outputs in your function

checkMath(SET numList, INTEGER val) := FUNCTION

    getMax := MAX(numList);
    getMin := MIN(numList);
    getAvg := ROUND(AVE(numList));
    timesVal := val * val;

  sideActions := PARALLEL
     (
         OUTPUT(numList, NAMED('Evaluated_List'));
         OUTPUT(getMax, NAMED('MaxValue'));
         OUTPUT(getMin, NAMED('MinValue'));
         OUTPUT(getAvg, NAMED('AvgValue'));
     );

  RETURN WHEN(timesVal, sideActions);
END;

PowerOfTwo := checkMath([4,7,3,90,67,2,12], 12);

OUTPUT(PowerOfTwo, NAMED('PowerOfTwo'));

//*******************************************************
// One Line Function

INTEGER checkMax (SET OF INTEGER numList) := MAX(numList);

OUTPUT(checkMax([2,5,8,10,45,11]), NAMED('checkMath'));

isEven(INTEGER num) := num % 2 = 0;

checkEven := isEven(40);

OUTPUT(checkEven, NAMED('checkEven'));

SalaryAvg_Layout := RECORD
    STRING Job;
    STRING Category;
    STRING City;
    STRING2 State;
    INTEGER Avg_Salary;
    INTEGER LowerBand;
    INTEGER Upperband;
END;

//Please note this is a made-up dataset :)
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

//Let's see how we can label them
OUTPUT(SalaryAvg_DS, NAMED('SalaryAvg_DS'));

//We can filter dataset too
OUTPUT(SalaryAvg_DS(city = 'Atlanta'), 
            NAMED('Atlanta_Salary'));

OUTPUT(SalaryAvg_DS(Avg_Salary >= 100000), 
            NAMED('Over_100K_Salary'));


