//IMPORT DataDetectors;
IMPORT Std;

EXPORT Date := MODULE //(DataDetectors.Models.Heuristic._Base)

    EXPORT STRING MODEL_NAME := 'calendar.date';

    SHARED _TestDataset(testValues, fieldName) := FUNCTIONMACRO

        PATTERN sws := PATTERN('[ \t\r\n]');
        PATTERN ws := sws+;
        PATTERN dateSep := PATTERN('[/\\.\\-]');
        PATTERN digit := PATTERN('[0-9]');
        PATTERN month := (['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Sept','Oct','Nov','Dec'] OPT('.')) |
                         ['January','February','March','April','May','June','July','August','September','October','November','December'];

        PATTERN digit2 := digit*2;
        PATTERN digit4 := digit*4;

        PATTERN date_year2 := digit2;
        PATTERN date_year4 := digit4;
        PATTERN date_year := date_year2 | date_year4;

        PATTERN date_month1 := VALIDATE(digit, (INTEGER)MATCHTEXT >= 1 and (INTEGER)MATCHTEXT <= 12);
        PATTERN date_month2 := VALIDATE(digit2, (INTEGER)MATCHTEXT >= 1 and (INTEGER)MATCHTEXT <= 12);
        PATTERN date_month := date_month1 | date_month2;

        PATTERN date_mday1 := VALIDATE(digit, (INTEGER)MATCHTEXT >= 1 and (INTEGER)MATCHTEXT <= 31);
        PATTERN date_mday2 := VALIDATE(digit2, (INTEGER)MATCHTEXT >= 1 and (INTEGER)MATCHTEXT <= 31);
        PATTERN date_mday := date_mday1 | date_mday2;

        PATTERN date_dmy_num := (date_mday dateSep date_month dateSep date_year) |
                                (date_mday sws date_month sws date_year);

        PATTERN date_dmy_mname := date_mday OPT(['th','st','nd']) ws OPT('of' ws) month OPT('.') OPT(ws date_year);

        PATTERN date_dmy := date_dmy_num | NOCASE(date_dmy_mname);

        PATTERN date_mdy_num := (date_month dateSep date_mday dateSep date_year) |
                                (date_month sws date_mday OPT(',') sws date_year)
                                (date_month2 date_mday2 date_year4);

        PATTERN date_mdy_mname := month OPT('.') ws date_mday OPT(['th','st','nd']) OPT(OPT(',') ws date_year);

        PATTERN date_mdy := date_mdy_num | NOCASE(date_mdy_mname);

        PATTERN date_ymd_num := (date_year dateSep date_month dateSep date_mday) |
                                (date_year4 date_month2 date_mday2);

        PATTERN date_ymd_mname := date_year ws month ws date_mday;

        PATTERN date_ymd := date_ymd_num | NOCASE(date_ymd_mname);

        PATTERN date_all := ((date_mdy | date_ymd | date_dmy) AFTER FIRST BEFORE LAST);

        LOCAL matchedRecs := PARSE
            (
                testValues,
                fieldName,
                date_all,
                TRANSFORM(LEFT),
                FIRST, NOSCAN
            );

        RETURN matchedRecs;
    ENDMACRO;

    EXPORT DATASET(DataDetectors.Layouts.ValueTestResult) Test(DATASET(DataDetectors.Layouts.ValueTestResult) testData, STRING fieldNameStr) := FUNCTION
        matchedRecs := _TestDataset(testData, value);
        
        results := PROJECT
            (
                matchedRecs,
                TRANSFORM
                    (
                        RECORDOF(LEFT),
                        SELF.model := MODEL_NAME,
                        SELF := LEFT
                    )
            );
        
        RETURN results;
    END;

    EXPORT UNSIGNED8 SummaryTest(DATASET(DataDetectors.Layouts.SingleStringValueRec) testData, STRING fieldNameStr) := FUNCTION
        testValues := TABLE
            (
                testData(value != ''),
                {
                    value,
                    UNSIGNED4   cnt := COUNT(GROUP)
                },
                value,
                MERGE
            );

        matchedRecsWithCounts := _TestDataset(testValues, value);

        RETURN SUM(matchedRecsWithCounts, cnt);
    END;

END;
