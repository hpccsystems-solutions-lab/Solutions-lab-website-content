/*
Module
*/

//Creating the module
EXPORT simpleModule := MODULE
   SHARED x := 12;
   STRING str := 'abc';   
   EXPORT strRes := x + str;

  //Following will result in sytax error: Unknown identifier "str"
  //Reason is local varibles are not visible after EXPORT
  //errorItIs := str + 'Local variable is not visible after an EXPORT';

  str := 'Local Variable';
  EXPORT conCat := str + ' ' + (x * 2);
END;


