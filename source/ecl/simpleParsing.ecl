InputDS := DATASET([
        {1, 'Recent advances in color matching have been driven by the market demand.'},
        {2, 'Improved ColoR guides, availability of shade-taking devices.'}, 
        {3, '     color     vision have improved to achieve excellent color-matched restorations.'},
        {4, 'Colors        are fun to play with.'},
        {5, 'No words matching here!'},
        {6, 'We can match colors_like       blue and red COLORS to have fun.'},
        {7, 'When is comes to colors, shade matching is important.'},
        {8, 'Is ColorING and coloring in shade of blues is relaxing?'},
        {9, 'ToColor, and toblue, here we go!!'},
        {10,'This 21color51 and blue2 are amazing.'}
        ],
        {INTEGER num, STRING val});
                    
OUTPUT(InputDS, NAMED('inputDS'));

//*********************************************************
//Match on any exact lowercase "blue" and "color" only.
//Since this is a simple search no transform is required.

//Note: in this example since we are only defining, color and blue and no
//extra pattern, the result will only return color and blue and dropps the surranding 
//letters, spaces, digits, etc

//Defining color set
//Only all lowercase is defined
PATTERN colorSet := ['color', 'blue'];

//Pattern value 
PATTERN colorPattern    := colorSet;

//Building our search 
onlyColor_Rec := RECORD

    //Input Index
    INTEGER ID  := InputDS.num;

    //string that is evaluated
    STRING input := InputDS.val;

    //If match is found
    //MATCHTEXT: Returns the matching text
    STRING found := MATCHTEXT(colorPattern);

END;

findColor := PARSE(
                   InputDS,        //Input dataset 
                   val,            //Input text 
                   colorPattern,   //Final pattern
                   onlyColor_Rec   //Result layout
                   );

OUTPUT(findColor, NAMED('Color_Blue'));

//*********************************************************
//Match on repuired space with any lowercase "blue" and "color"  
//Space is only before search string 

//Note: in this example since we are only defining, only one spance 
//and words "color" or "blue"
//Returned resuslt will capture A space with exact word "color" or "blue"
//Result is like: " color" or " blue"

//Defining one white space
PATTERN ws := [' ','\t',',']; 

//Space followed by color set
PATTERN wsColor := ws colorSet;

spaceColor_Rec := RECORD
    //Input Index
    INTEGER ID  := InputDS.num;

    //string that is evaluated
    STRING input := InputDS.val;

    //If match is found
    //MATCHTEXT: Returns the matching text
    STRING found := MATCHTEXT(wsColor);

END;

findWsColor := PARSE(
                   InputDS,        //Input dataset 
                   val,            //Input text 
                   wsColor,       //Final pattern
                   spaceColor_Rec   //Result layout
                   );

OUTPUT(findWsColor, NAMED('ws_color'));

//*********************************************************
//Match on optional space with any lowercase "blue" and "color", 
//followed by A required space

//Note: in this example since we are only defining, an optional space followed 
//by words "color" or "blue" and a required space
//Returned resuslt will capture an optional space with exact word "color" or "blue" and a space
//Results could be like: " color",  " blue ", "blue "

//Optional space followed by colorset followed by space
PATTERN wsColorws := opt(ws) colorSet ws;

wsColorws_Rec := RECORD
    //Input Index
    INTEGER ID  := InputDS.num;

    //string that is evaluated
    STRING input := InputDS.val;

    //If match is found
    //MATCHTEXT: Returns the matching text
    STRING found := MATCHTEXT(wsColorws);

END;

findWsColorws := PARSE(
                   InputDS,        //Input dataset 
                   val,            //Input text 
                   wsColorws,       //Final pattern
                   wsColorws_Rec   //Result layout
                   );

OUTPUT(findWsColorws, NAMED('ws_color_ws'));

//********************************************************
//Match on color and blue 
//with only ONE surrounding character or number

//Defining all alphabets and digits
PATTERN alpha := PATTERN('[a-zA-Z0-9]');

//Optional space followed by colorset followed by space
PATTERN someComb := opt(alpha) colorSet opt(alpha);

someComb_Rec := RECORD
    //Input Index
    INTEGER ID  := InputDS.num;

    //string that is evaluated
    STRING input := InputDS.val;

    //If match is found
    //MATCHTEXT: Returns the matching text
    STRING found := MATCHTEXT(someComb);

END;

findSomeComb := PARSE(
                   InputDS,        //Input dataset 
                   val,            //Input text 
                   someComb,       //Final pattern
                   someComb_Rec   //Result layout
                   );

OUTPUT(findSomeComb, NAMED('findSomeComb'));

//*********************************************************
//Match on only color and blue with all sopurding characters, digits or spaces

//Note: this will return any match combination on "color" and "blue

//Defining all alphabets and digits
//+ : to capture one or more letter or digit
PATTERN AllAlpha := PATTERN('[a-zA-Z0-9]+');

//Optional space followed by colorset followed by space
//+: one or more white spaces
PATTERN allComb := opt(ws +) opt(AllAlpha) colorSet opt(AllAlpha) opt(ws +);

allComb_Rec := RECORD
    //Input Index
    INTEGER ID  := InputDS.num;

    //string that is evaluated
    STRING input := InputDS.val;

    //If match is found
    //MATCHTEXT: Returns the matching text
    STRING found := MATCHTEXT(allComb);

END;

findAllComb := PARSE(
                   InputDS,        //Input dataset 
                   val,            //Input text 
                   allComb,       //Final pattern
                   allComb_Rec,   //Result layout
                   FIRST          //brings the fist match it finds, this helps removes duplicates on white spaces for example 
                   );

OUTPUT(findAllComb, NAMED('allComb'));



