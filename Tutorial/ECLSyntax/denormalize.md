# Denormalize

This function is used to combine parent and child recordsets. In another word DENORMALIZE means adding precomputed data to a rational database which will result in improved readability and maintainability. 


There are two ways to perform DENORMALIZE:

## Form One
In this form TRANSFORM function takes at least two parameters: 
- A LEFT record of the same format as the combined ParentDataset and ChildDataset (the resulting de-normalized record structure)
- A RIGHT record of the same format as the ChildDataset. 
- Optional: An integer COUNTER specifying the number of times the transform has been called for the current set of parent/child pairs (Keep track of number of children added to each parent).
- The __result__ of the TRANSFORM the same format as the __LEFT__ record which is parent and child combined record.
- TRANSFORM is called per number of children. The input to the first TRANSFORM is the parent and one child. The input to the 2nd call is the output of 1st TRANSFORM and another child. The input to the 3rd call is the output of 2nd call and another child ……

### Parameters
- `ParentDataset` The set of parent records to process, already in the format that will contain the denormalized parent and child records.
- `ChildDataset` The set of child records to process.
- `Condition`  An expression that specifies how to match records between the ParentDataset and ChildDataset.
- `TRANSFORM` The TRANSFORM function perform denormalize.
- `Flags` Optional



</br>

**Demo Dataset**
</br>

Child Dataset
|LastName|PhoneNum|Address|
|:----|:---|:---|
Carpenter| | 123 Main Str|
Carpenter| '7701234567| '404 capital cr|
Smith| '40401234567| '990 Rose highway|
Black| | '504 Sunset Blvd|
Adam| '6789991111|
Black| '5694023457|
Smith| '2209875437|
Black| | '8749 OceanFront main Rd|
Smith| | '5671 North Lake Str'

</br>

Parent Dataset
|LastName|CountIt|PhoneNumOne|PhoneNumTwo|AddressOne|AddressTwo|AddressThree
|:---|:---|:---|:---|:---|:---|:---
Carpenter|0
Smith|0
Jackson|0
Black|0
Raymond|0
Adam|0

</br>

 #### Example

<br>
<pre className="ecl_example">
<pre id="ecl_data">

```java
/*
DENORMALIZE Example:
Example on form one denormalization.
*/

child_layout := RECORD
  STRING     lastName;
  STRING     phoneNum := '';   //Default to blank
  STRING     address  := '';
END;

Parent_layout := RECORD
    STRING  lastName; 
    INTEGER CountIt         := 0;
    STRING  phoneNumOne     := '';
    STRING  phoneNumTwo     := '';
    STRING  addressOne      := '';
    STRING  addressTwo      := '';
    STRING  addressThree    := '';
END;

// Creating child dataset
// In child layout phoneNum and address are defaulted to ''.
// If we want to fill one field and not the other, we need to keep the order.

childDS := DATASET([{'Carpenter',  '',             '123 Main Str'},
                    {'Carpenter',  '7701234567',   '404 capital cr'},
                    {'Smith',      '40401234567',  '990 Rose highway'},
                    {'Black',      '',             '504 Sunset Blvd'},
                    {'Adam',       '6789991111'                     },
                    {'Black',      '5694023457'                     },
                    {'Smith',      '2209875437'                     },
                    {'Black',      '',             '8749 OceanFront main Rd'},
                    {'Smith',      '',             '5671 North Lake Str'}],
                            child_layout);

// In parents layout all fields besides lastName is defaulted to '', because they are getting populated
// by child dataset.

ParentDS := DATASET([{'Carpenter'},{'Smith'},
                     {'Jackson'},  {'Black'},
                     {'Raymond'},  {'Adam'}],
                            Parent_layout);
											

Parent_layout xForm(Parent_layout Le, childDS Ri, INTEGER C) := TRANSFORM

    SELF.phoneNumOne := IF   (C = 1, Ri.phoneNum, Le.phoneNumOne);
    SELF.phoneNumTwo  := IF  (C = 2, Ri.phoneNum, Le.phoneNumTwo);
    SELF.addressOne   := IF  (C = 1, Ri.address, Le.addressOne);
    SELF.addressTwo   := IF  (C = 1, Ri.address, Le.addressTwo);
    SELF.addressThree := IF  (C = 1, Ri.address, Le.addressThree);
    SELF.CountIt      := C;
  
  
    SELF := Le;
    self := [];

END;
```
</pre>
<pre id='ecl_code'>

``` java
DeNorm := DENORMALIZE(ParentDS, childDS,
                        LEFT.lastName = RIGHT.lastName,
                        xForm(LEFT,RIGHT,COUNTER));

// Viewing child dataset
OUTPUT(childDS, NAMED('childDS'));

// Viewing parent dataset
OUTPUT(ParentDS, NAMED('ParentDS'));

// Viewing denormalize result
OUTPUT(DeNorm, NAMED('DeNorm'));
```
</pre>
</pre>
<a class="trybutton" href="javascript:OpenECLEditor(['ecl_code'], ['ecl_data'])"> Try Me </a>

</br>
</br>

### Form One Syntax 

```java

Child_Layout := RECORD
    ...
    ...
END;

//Parent Layout with child dataset
Parent_Layout := RECORD
    INTEGER TheCounter;
    ParentField1;
    ...
    ChildField1;
    ChildField2;
    ChildField3;
    ...
END;

Parent_Layout xForm(Parent_layout Le, Child_Layout Ri, INTEGER OptCont) := TRANSFORM

    SELF.ChildField1 := IF(OptCont = 1, Ri.ChildField, Le.ChildField1); 
    SELF.ChildField2 := IF(OptCont = 2, Ri.ChildField, Le.ChildField2); 

    SELF.ChildField3 := IF(OptCont = 1, Ri.ChildField, Le.ChildField3); 
    SELF.ChildField4 := IF(OptCont = 2, Ri.ChildField, Le.ChildField4); 
    SELF.ChildField5 := IF(OptCont = 3, Ri.ChildField, Le.ChildField5); 

    //Optional 
    SELF.TheCounter := OptCont;

    SELF := Le;
END;

DeNorm := DENORMALIZE(ParentDS, ChildrenDS,
                        //Condition
                        LEFT.MatchingField = RIGHT.MatchingField,
                        xForm(LEFT, RIGHT, COUNTER)
                        [,flags]);

```
</br>

|Value|Definition|
|:----|:---------|
Parent_Layout | Parent and child layouts combined
xForm | TRANSFORM to perform denormalization
ChildField1 | If counter is equal 1 it gets the first matching record value
ChildField2 | If counter is equal 1 it gets the second matching record value
MatchingField | Field(s) that exists both in  parent and child

</br>
</br>

## Form Two

In this format TRANSFORM function takes at least two parameters. The difference from form one is instead of listing the fields in parents records, we can nest the children's dataset(s) 

- A LEFT record of the same format as the combined ParentDataset and ChildDataset (the resulting de-normalized record structure)
- ROWS(RIGHT) dataset of the same format as the child layout. 
- The result of the TRANSFORM must be the same format as the LEFT record.
- PROJECT can be used to make room for nested child dataset

</br>

#### Example 

<br>
<pre id = 'Denorm2_Exp1'>

```java
/*
DENORMALIZE Example:
Example on form two denormalization.
*/

ParentLayout := RECORD
    STRING      fName;
    STRING      lName;
END;


parentDS := DATASET
    (
        [
            {'Jane', 'Carpenter'},
            {'Bill', 'Smith'},
            {'Orville', 'Black'}
        ],
        ParentLayout
    );

OUTPUT(parentDS, NAMED('parentDS'));


ChildrenLayout := RECORD
    STRING      fName;
    STRING      lName;
    UNSIGNED1   age;
END;

childrenDS := DATASET
    (
        [
            {'Fiona', 'Black', 9},
            {'Jack', 'Black', 18},
            {'Martin', 'Carpenter', 10},
            {'Stacey', 'Smith', 5},
            {'Allison', 'Smith', 7}
        ],
        ChildrenLayout
    );

OUTPUT(childrenDS, NAMED('childrenDS'));


EmbeddedChildLayout := RECORD
    STRING      fName;
    UNSIGNED1   age;
END;

// Denorm result layout
ParentChildLayout1 := RECORD
    ParentLayout;
    DATASET(EmbeddedChildLayout)    children;
END;

// Making room for child fields in parent layout
preppedParents := PROJECT
    (
        parentDS,
        TRANSFORM
            (
                ParentChildLayout1,
                SELF := LEFT,
                SELF := []
            )
    );

OUTPUT(preppedParents, NAMED('preppedParents'));

denorm := DENORMALIZE
    (
        preppedParents,
        childrenDS,
        LEFT.lName = RIGHT.lName,
        TRANSFORM
            (
                ParentChildLayout1,
                SELF.children := LEFT.children + ROW({RIGHT.fName, RIGHT.age}, EmbeddedChildLayout),
                SELF := LEFT
            )
    );
OUTPUT(denorm, NAMED('denorm'));
```

</pre>
<a class="trybutton" href="javascript:OpenECLEditor(['Denorm2_Exp1'])"> Try Me </a>


</br>
</br>

### Form Two Syntax 
```java
ChildLayout := RECORD
    Field1;
    Field2;
    ...
END;

ParentLayout := RECORD
    INTEGER1 Num; //Optional
    Field1;
    Field2;
    ...
    DATASET(ChildLayout) Children;
END;

//PROJECT can be used to create parents datasets with embedded  children

Parent_Layout xForm(ParentsDS Le, ChildrenDS Ri, INTEGER C) := TRANSFORM
    SELF.Num := C;
    SELF.Children := Le.Children + Ri;
    SELF := Le;
END;

DeNorm := DENORMALIZE(ParentLayout, ChidLayout,
                        LEFT.Field = RIGHT.Field,
                        
                        //Grouping the child layout records based on the matching condition
                        GROUP,
                        xFORM(LEFT,
                                ROWS(RIGHT),
                                COUNTER // Optional
                                ));

```

#### Example 

<br>
<pre id = 'Denorm2_Exp2'>

```java
/*
DENORMALIZE Example:
Example on form two denormalization using GROUP.
*/

ParentLayout := RECORD
    STRING      fName;
    STRING      lName;
END;


parentDS := DATASET
    (
        [
            {'Jane', 'Carpenter'},
            {'Bill', 'Smith'},
            {'Orville', 'Black'}
        ],
        ParentLayout
    );

OUTPUT(parentDS, NAMED('parentDS'));


ChildrenLayout := RECORD
    STRING      fName;
    STRING      lName;
    UNSIGNED1   age;
END;

childrenDS := DATASET
    (
        [
            {'Fiona', 'Black', 9},
            {'Jack', 'Black', 18},
            {'Martin', 'Carpenter', 10},
            {'Stacey', 'Smith', 5},
            {'Allison', 'Smith', 7}
        ],
        ChildrenLayout
    );

OUTPUT(childrenDS, NAMED('childrenDS'));

ParentChildLayout2 := RECORD
    ParentLayout;
    SET OF STRING   children;
END;

denorm2 := DENORMALIZE
    (
        parentDS,
        childrenDS,
        LEFT.lName = RIGHT.lName,
        GROUP,
        TRANSFORM
            (
                ParentChildLayout2,
                SELF.children := SET(ROWS(RIGHT), fName),
                SELF := LEFT
            )
    );

OUTPUT(denorm2, NAMED('denorm2'))
```

</pre>
<a class="trybutton" href="javascript:OpenECLEditor(['Denorm2_Exp2'])"> Try Me </a>

</br>
</br>

## Flags

|Options|Description|
|---|---|
UNORDERED|Specifies the output record order is not significant
ORDERED|Specifies the significance of the output record order
STABLE|Specifies the input record order is significant
PARALLEL|Try to evaluate this activity in parallel
LOCAL|Specifies the operation is performed on each node independently, without requiring interaction with all other nodes to acquire data
GROUP|Specifies the recordset is GROUPed and the ROLLUP operation will produce a single output record for each group
