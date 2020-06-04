Parent_layout := RECORD
  // This number defines, how many times transform should execute per record
  INTEGER expilicitCount; 
  STRING  lastName; 
  STRING  phoneOne;
  STRING  phoneTwo;
  STRING  addressOne;
  STRING  addressTwo;
  STRING  addressThree;
END;

//Parent Dataset
parentDS := DATASET([
                {2, 'Alexa', '7701234567',  '', '123 Main Str', '404 capital cr', ''},
                {2, 'Smith', '', '8890002323', '504 Sunset Blvd', '990 Rose highway', ''},
                
                //Notice Adam has two phone numbers, but assinging 1 for number of execution
                {1, 'Adam', '6789991111', '4445679000', '', '', ''},
                {2, 'Black', '5694023457' ,'', '777 Formal Str', '111 Batman Corner', ''},
                {3, 'Rosy', '2209875437', '', '8749 OceanFron main Rd','5671 North Lake Str', '2323 Washington RD'}],
                      Parent_layout);



child_layout := RECORD
  INTEGER    countIt;
  STRING     Name;
  STRING     phone; 
  STRING     address;
END;


child_layout xForm(Parent_layout Li, INTEGER counting) := TRANSFORM

        SELF.countIt    := counting;      
        SELF.name       := Li.lastName;
        SELF.phone      := CHOOSE(counting, Li.phoneOne, Li.phoneTwo);
        SELF.address    := CHOOSE(counting, Li.addressOne, Li.addressTwo, Li.addressThree);
END;
  
extractChild := NORMALIZE(parentDS,
                          //Number of times transform should go through a record
                          LEFT.expilicitCount, 
                          xForm(LEFT,COUNTER));


OUTPUT(parentDS, NAMED('parentDS'));   
OUTPUT(extractChild, NAMED('extractChild'));