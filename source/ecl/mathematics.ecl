someMath_Layout := RECORD
    INTEGER ID;
		STRING  lastName;
		DECIMAL9_2 monthlyIncome;
		DECIMAL9_2 monthlyExp;
		INTEGER numOfHousehold;
END;

someMathDS := DATASET([{100,'Sunshine', 56000, 3200.4, 5},
                       {200,'Smith', 2545.65, 3122.45, 7},
                       {300,'Jimmy', 5632.78, 4598.88, 2},
                       {400,'Moon', 1200, 2523.78, 4},
                       {600,'Open', 7800, 6545.12, 4},
                       {900,'Close', 2265.45, 2245.12, 3},
                       {800,'Tiger', 8515, 4798.68, 3}
                        ]
                        ,someMath_layout);
												
OUTPUT(someMathDS, NAMED('someMathDS'));

//******************************************************
//SUM function

OUTPUT(SUM(1,2,3,4,5), NAMED('SimpleSum'));
OUTPUT(SUM(someMathDS, monthlyIncome), NAMED('Sum_Dataset'));



//******************************************************
//COUNT Function

OUTPUT(COUNT(1,1,2,2,3,5,6), NAMED('SimpleCount'));

//num of rows in a dataset
OUTPUT(COUNT(someMathDS), NAMED('ds_Count'));

//Count a specific field
OUTPUT(COUNT(someMathDS(numOfHousehold > 3)), NAMED('Count_condition'));


//******************************************************
//AVE Funtion: average 

OUTPUT(AVE(1,1,2,2,3,5,6), NAMED('SimpleAvg'));

OUTPUT(AVE(someMathDS, monthlyExp), NAMED('Avg_exp'));

//******************************************************
//MIN Funtion 

OUTPUT(MIN(1,1,2,2,3,5,6), NAMED('SimpleMin'));

OUTPUT(MIN(someMathDS, monthlyIncome), NAMED('Min_income'));

//******************************************************
//MAX Funtion 

OUTPUT(MAX(1,1,2,2,3,5,6), NAMED('SimpleMax'));

OUTPUT(MAX(someMathDS, monthlyExp), NAMED('Max_exp'));

//******************************************************
//ROUND Funtion 

OUTPUT(ROUND(3.45), NAMED('R1'));
OUTPUT(ROUND(3.65), NAMED('R2'));
OUTPUT(ROUND(SUM(someMathDS, monthlyExp)), NAMED('R3'));



