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
//Including outputs in your function

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
//One Line Function

INTEGER checkMax (SET OF INTEGER numList) := MAX(numList);

OUTPUT(checkMax([2,5,8,10,45,11]), NAMED('checkMath'));


isEven(INTEGER num) := num % 2 = 0;

checkEven := isEven(40);

OUTPUT(checkEven, NAMED('checkEven'));

