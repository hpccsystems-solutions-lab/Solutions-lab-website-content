# TABLE

## Quick Look

Creates a temporary dataset in memory, GROUP option can be used.

![fare dataset](./Images/fare_ds.JPG)

```java
crossTabLayout  :=  RECORD
   fareDS.pickup_date;
   avgFare := AVE(GROUP, fareDS.fare);
   totalFare := SUM(GROUP, fareDS.fare);
END;

crossTabDs := TABLE(fareDS, crossTabLayout, pickup_date);

OUTPUT(crossTabDs, NAMED('crossTabDs'));

```

![fare table result](./Images/fare_table.JPG)

\
Put it into practice [table.ecl](https://ide.hpccsystems.com/#)
