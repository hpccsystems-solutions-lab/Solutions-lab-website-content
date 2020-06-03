

//Calling the simpleModule
/*
ModuleName.attribute;
Note: the attribute you are calling should have EXPORT
*/ 

OUTPUT(SourceCode.simpleModule.strRes, NAMED('Calling_Mod'));
OUTPUT(simpleModule.conCat, NAMED('LocalVarible'));

res := simpleModule.strRes;
OUTPUT(res + 3, NAMED('Using_mod'));