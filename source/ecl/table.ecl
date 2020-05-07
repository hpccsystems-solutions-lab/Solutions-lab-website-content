fare_Layout := RECORD
    STRING10 pickup_date;
    DECIMAL8_2 fare;
    DECIMAL8_2 distance;
END;
fareDS  :=  DATASET([{'2015-01-01', 25.10, 5.5},  
                 {'2015-01-02', 40.15, 7.2},  
								 {'2015-01-02', 30.10, 6.65}, 
								 {'2015-02-03', 25.36, 6.78}, 
								 {'2015-02-03', 65.2, 28.45}, 
								 {'2015-03-05', 34.2, 15.5}, 
								 {'2015-04-04', 15.15, 4}], 
								 fare_Layout);

OUTPUT(fareDS, NAMED('fareDS'));

crossTabLayout  :=  RECORD 
   fareDS.pickup_date;
   avgFare := AVE(GROUP, fareDS.fare);
   totalFare := SUM(GROUP, fareDS.fare);
END;

crossTabDs := TABLE(fareDS, crossTabLayout, pickup_date);

OUTPUT(crossTabDs, NAMED('crossTabDs'));
