/*
This example is put together by Richard Taylor.
https://hpccsystems.com/blog/Tips_and_Tricks_for_ECL_Part2_PARSE

It shows steps on how to perform date parsing. He parses the text for British and American date type.
In this example we put the entire code together so it is executable and comments are added.
*/

//Test data
InputDS := DATASET([{1,'25 MAY. 2005'},  {2,'30/08/2009'},     {3,'THURSDAY, MARCH 7, 2013 - 1:30 PM'},
                    {4,'7 SEP, 2006'},   {5,'18-09-2008'},     {6,'SAT, 04/27/2013 - 1:30:24 AM'},
                    {7,'25 MARCH 2013'}, {8,'22.01.2013'},     {9,'15-MAR-2004'},
                    {10,'3-14-13'},      {11,'13/03/20'},      {12,'27/08/85 17:45:30'},
                    {13, 'noDate here'}, {14, '03-somedate'},  {15, 'some03/05-2003'},
                    {16, 'this 02?'},    {17, '9 one digit'},  {18, 'no digit here'},
                    {19, '08 9 03'}
                    ],
                    {UNSIGNED1 UID,STRING40 str});

//The "atomic" bits:
PATTERN Alpha := PATTERN('[A-Z]')+;    //any number of alpha characters together
PATTERN Nbr   := PATTERN('[0-9]');     //a single numeric digit
PATTERN Sep   := PATTERN('[-, /.]');   //separators -- note the presence of "space" character

//More complex building blocks

//OPT() is an optional value
PATTERN Ws    := Sep OPT(Sep);         //"white space" = 1 or 2 separators
PATTERN Num12 := OPT(Nbr) Nbr;         //a 1 or 2-digit number

PATTERN Year  := Nbr Nbr OPT(Nbr Nbr);     //a 2 or 4-digit number, explicit

/*
Year can be built using REPEAT or regular expression:

PATTERN Year  := REPEAT(Nbr,2) OPT(REPEAT(Nbr,2));
PATTERN Year  := Nbr*2 OPT(Nbr*2);
*/

/*
The AMPM pattern is a numeric pattern ending with a non-optional Alpha pattern.
So that's a one or two digit number followed by a colon, followed by another one or two digit number,
optionally followed by another colon and another one or two digit number,
but always followed by Alpha characters (in our example data, that's always going to be AM or PM).

Zulu is a purely numeric pattern -- three instances of Num12 delimited by colons, giving us hours, minutes and seconds.
*/
PATTERN AMPM  := Num12 ':' Num12 OPT(':' Num12) ' ' Alpha;
PATTERN Zulu  := Num12 ':' Num12 ':' Num12;
PATTERN Time  := (AMPM | Zulu);

/*
Validating detected patterns:

Start by defining our 12 months.
isValidMonth is an inline function which receives the first three characters of the found text,
and check to see if it's in SetMoth.

VALIDATE(pattern, isValidExpression)
Month is the VALIDATE function, which returns Boolean wether month is found or not
MATCHTEXT: Returns the matching ASCII text the Pattern found.
*/
SetMonths := ['JAN','FEB','MAR','APR','MAY','JUN','JUL','AUG','SEP','OCT','NOV','DEC'];
isValidMonth(STRING txt) := txt[1..3] IN SetMonths;
PATTERN Month := VALIDATE(Alpha, isValidMonth(MATCHTEXT)) ;


/*
Final parsing patterns we need for dates:
ws+ : means one or more

NumDate: 1 or 2 digit number followed by space, followed by 1 or 2 digit number followed by space,
         followed by 2 or 4-digit number, optionally can have more than one space followed by
         AMPM or ZULU style

AlphaDate1: A 3 char month followed by space, 1 or 2 digit number followed by space,
            followed by 2 or 4-digit number, optionally can have more than one space followed by
            AMPM or ZULU style
*/
PATTERN NumDate    := Num12 Ws Num12 Ws Year OPT(ws+ Time); //Fully numeric pattern
PATTERN AlphaDate1 := Month Ws Num12 Ws Year OPT(ws+ Time); //US Date
PATTERN AlphaDate2 := Num12 Ws Month Ws Year OPT(ws+ Time); //British Date

/*
RULE to actually do the pattern matching:
Putting all patterns together, using a logical OR (|)
These three patterns are treated as Tokens.

TOKEN acts similar to a PATTERN, but once matched,
the parser doesn't backtrack to find alternative matches as it would with PATTERN.

*/
RULE DateRule := (NumDate | AlphaDate1 | AlphaDate2);

//Defining our result layout
OutRec := RECORD
  UNSIGNED1 UID;
  UNSIGNED1 PatternType;   //exactly which pattern the DateRule matched
  STRING40  InputToParse;  //input data
  STRING2   Day;           //granular detail of how those values were parsed
  STRING2   Month;
  STRING4   Year;
  STRING8   YYYYMMDD;     //the standardized formats that we want to carry forward to build our data
  STRING12  FinalTime;
END;

//****************************************************************************************************
//****************************************************************************************************
//PARSE Using a TRANSFORM

OutRec XForm (RECORDOF (InputDS) L) := TRANSFORM


    //Determine which pattern matched:
    //WHICH function returns the ordinal position of the first Boolean expression parameter that is true.
    //MATCHED function is specific to PARSE use, and it returns a BOOLEAN indicating "Did this pattern match or not?
    WhichPtn := WHICH(
            MATCHED(NumDate),MATCHED(AlphaDate1),MATCHED(AlphaDate2));

    //Output the pattern type and matching input string
    SELF.PatternType     := WhichPtn;
    SELF.InputToParse    := L.str;
    SELF.UID             := L.UID;

    //Determine if numeric date is in "dd mm" format instead of "mm dd":
    //MATCHTEXT function is specific to PARSE use, and it returns a the text that matches the parameter it's given.

    //P1, that's the first instance of Num12 within NumDate.
    P1 := IF(WhichPtn = 1,
              MATCHTEXT(NumDate / Num12[1]),
              '');

    //P2, that's the second instance of Num12 within NumDate.
    P2 := IF(WhichPtn = 1,
              MATCHTEXT(NumDate / Num12[2]),
              '');

    //If first pair of digits can't be a month, flag as "B"ritish, else "A"merican format
    P3 := IF((UNSIGNED1)P1 > 12, 'B', 'A');

																						 
											 

   
    //The CHOOSE function uses the WhichPtn integer to control where to extract that information
    //from (P1 or P2 if it was pattern 1 match).
    DayNum := (UNSIGNED1)CHOOSE(WhichPtn,
                              IF(P3 = 'B', P1, P2),           //pattern 1
                              MATCHTEXT(AlphaDate1 / Num12),  //pattern 2
                              MATCHTEXT(AlphaDate2 / Num12)); //pattern 3

    //Ensures that the result is a 2-digit string.
    SELF.Day := IF(DayNum < 10,
                     INTFORMAT(DayNum, 2, 1),
                     (STRING2)DayNum);

    //Determine how the month is represented
    //The M1 and M2 definitions translate month names to just the standard 2-digit number for the month.
    M1 := CHOOSE(WhichPtn,
                 '',                             //pattern 1
                 MATCHTEXT(AlphaDate1 / Alpha),  //pattern 2
                 MATCHTEXT(AlphaDate2 / Alpha)); //pattern 3

    M2 := CASE(M1[1..3],'JAN' => '01','FEB' => '02','MAR' => '03','APR' => '04','MAY' => '05','JUN' => '06',
                        'JUL' => '07','AUG' => '08','SEP' => '09','OCT' => '10','NOV' => '11','DEC' => '12','');

    //FmtMonth function ensures a 2-digit month number string
    FmtMnth(STRING2 m) := IF(LENGTH(TRIM(m)) = 1,
                               '0' + m,
                                m);

    SELF.Month := IF(WhichPtn = 1,
                     IF(P3 = 'B', FmtMnth(P2), FmtMnth(P1)), //pattern 1
                     M2);                                    //pattern 2 & 3


    //handle 2 vs 4-digit years
    PYear := CHOOSE(WhichPtn,
                    MATCHTEXT(NumDate / Year),      //pattern 1
                    MATCHTEXT(AlphaDate1 / Year),   //pattern 2
                    MATCHTEXT(AlphaDate2 / Year));  //pattern 3

    //This code assumes that any 2-digit year value greater than or equal to 80
    //must be a 20th century date,
    //and all others are assumed to be 21st century

    SELF.Year := IF(LENGTH(PYear) = 4,
                    PYear,
                    IF(PYear >= '80',
                          '19'+ Pyear,
                          '20'+ Pyear));

    //Put it all together in a standard format
    SELF.YYYYMMDD := SELF.Year + SELF.Month + SELF.Day;

    //And standardize the time
    //The format we're going for here is the Zulu format (24 hour clock -- AKA "military" time), as in HH:MM:SS.

    //AM or PM?
    isAMPMtime  := MATCHED(Time / AMPM);

    //Are seconds represented
    isAMPMSecs  := MATCHED(Time / AMPM / Num12[3]);

    //Hour value (with the AMPMhour definition)
    AMPMhour    := (UNSIGNED1)MATCHTEXT(Time / AMPM / Num12[1]);

    //Whether you need to add 12 to that for a PM hour
    //INTFORMAT function returns the value as a right-justified string.
    AMPMhourStr := IF(MATCHTEXT(Time / AMPM / Alpha)='PM',
                      ((STRING2)(AMPMhour + 12)),
                      INTFORMAT(AMPMhour, 2, 1));

    //Final standard format

    SELF.FinalTime  := MAP(isAMPMtime AND isAMPMSecs =>
                                                AMPMhourStr + ':' + MATCHTEXT(Time/AMPM/Num12[2])
                                                            + ':' + MATCHTEXT(Time/AMPM/Num12[3]),

                            isAMPMtime AND NOT isAMPMSecs =>
                                                AMPMhourStr + ':' + MATCHTEXT(Time/AMPM/Num12[2]) + ':00',

                            MATCHTEXT(Time/Zulu));

    SELF := [];
END;

parseIt := PARSE(InputDS,       //Input Dataset
                 str,           //Field within input dataset to parse
                 DateRule,      //Pattern RULE to process
                 XForm(LEFT),   //TRANSFORM to go over input data
                 BEST);         //Path with the lowest penalty is selected

OUTPUT(InputDS, NAMED('Input_Dataset'));
OUTPUT(parseIt, NAMED('Parsing_Result'));

