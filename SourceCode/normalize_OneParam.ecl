//child layout that's being extract  from parent
Child_Layout := RECORD
    INTEGER1 NameID;
    STRING20 Addr; 
END;

//Parent Layout with child dataset 
Parent_Layout := RECORD
    INTEGER1 NameID;
    STRING20 Name;
    DATASET(Child_Layout) Children; //Embedded child layout
END;

//Parent dataset, with address as child dataset
parentDS := DATASET([ 
                       {1,'Kevin',   [ {1, '290 Downtown Abby'}] },
                       {2,'Liz',     [ {2, '2345 Lake View Rd'}, {2, '776  Action Cir'}] },
                       {3,'Jacob',   [ ]},
                       {4,'Alex',    [ {4, '9000 Sunset Blvd'}] },
                       {5,'Sally',   [ {5, '345 Fresh Start Str'}, {5,  '433 Union Dr'} ,
                                       {5,  '777 Lookup Court'},   {5,  '222 Movie Str'} ]}
                    ], Parent_Layout);



Child_Layout xForm(Child_Layout Ri) := TRANSFORM
     SELF := Ri;
END;

ExtractChild := NORMALIZE(parentDS,
                         LEFT.Children, //Sending only the child dataset
                         xForm(RIGHT));

OUTPUT(parentDS, NAMED('parentDS'));
OUTPUT(ExtractChild, NAMED('ExtractChild'));