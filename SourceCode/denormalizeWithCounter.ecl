child_layout := RECORD
  INTEGER    ID;
  STRING     lastName;
  STRING     phoneNum := '';   //Defualt to blank
  STRING     address  := '';
END;

Parent_layout := RECORD
  STRING  lastName; 
  STRING  phoneNumOne     := '';
  STRING  phoneNumTwo     := '';
  STRING  addressOne      := '';
  STRING  addressTwo      := '';
  STRING  addressThree    := '';
END;

//Creating child Dataset
//In child layout phoneNum and address are defulted to ''.
//If we want to fill one field and not the other, we need to keep the order.
childDS := DATASET([{'Carpenter',  '',             '123 Main Str'},
                       {'Carpenter',  '7701234567',   '404 capital cr'},
                       {'Smith',      '40401234567',  '990 Rose highway'},
                       {'Black',      '',             '504 Sunset Blvd'},
                       {'Adam',       '6789991111'},
                       {'Black',      '5694023457'},
                       {'Smith',      '2209875437'},
                       {'Black',      '',             '8749 OceanFron main Rd'},
                       {'Smith',      '',             '5671 North Lake Str'}],
                            child_layout);

//In parents layout all fields besides lastName is defulted to '', because they are getting pupolated
//by child dataset.
ParentDS := DATASET([{'Carpenter'},{'Smith'},
                     {'Jackson'},  {'Black'},
                     {'Raymond'},  {'Adam'}],
                            Parent_layout);
											

Parent_layout xForm(Parent_layout Le, childDS Ri, INTEGER C) := TRANSFORM

    SELF.phoneNumOne := IF (C = 1, Ri.phoneNum, Le.phoneNumOne);
    SELF.phoneNumTwo := IF (C = 2, Ri.phoneNum, Le.phoneNumTwo);
  
  
    SELF := Le;
    self := [];

END;

DeNorm := DENORMALIZE(ParentDS, childDS,
                        LEFT.lastName = RIGHT.lastName,
                        xForm(LEFT,RIGHT,COUNTER));

DeNorm;