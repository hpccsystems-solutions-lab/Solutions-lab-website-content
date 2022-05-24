# NORMALIZE

NORMALIZE gets a parent-child (DENORMALIZED)  dataset and extract the child dataset from it. The purpose is to take variable-length flat-file records and split out the child information. 


There are two ways to normalize a child dataset:
- All Records: Processing all child records
- With Counter: Using counter for a certain number of children

## Normalize All Records

This form processes through __all__ records in the recordset executing transform function through all the child dataset records in each record. This method is used when we have embedded child dataset.

You can think of this as a specialized [JOIN](./join.md) where the TRANSFORM is called with, 
LEFT as the “main” record being processed and RIGHT as one of the records from the child dataset.

In this form TRANSFORM is called for each parent record with child record pair. 

### Parameters

- Must have a RIGHT record of the same format as the child dataset.
- The resulting record set format does not need to be the same as the input.
- Child layout is being called as an embedded dataset.


</br>


#### Example 

<br>
<pre id = 'NormExp_1'>

```java
/*
Normalize Example:
NORMALIZE All Records
*/

// Child layout that's being extract  from parent
Child_Layout := RECORD
    INTEGER1 NameID;
    STRING20 Addr; 
END;

// Parent Layout with child dataset 
Parent_Layout := RECORD
    INTEGER1 NameID;
    STRING20 Name;
    DATASET(Child_Layout) Children; //Embedded child layout
END;

// Parent dataset with child dataset
parentDS := DATASET([ 
                       {1,'Kevin',   [ {1, '290 Downtown Abby'}] },
                       {2,'Liz',     [ {2, '2345 Lake View Rd'}, {2, '776  Action Cir'}] },
                       {3,'Jacob',   [ ]},
                       {4,'Alex',    [ {4, '9000 Sunset Blvd'}] },
                       {5,'Sally',   [ {5, '345 Fresh Start Str'}, {5,  '433 Union Dr'} ,
                                       {5,  '777 Lookup Court'},   {5,  '222 Movie Str'} ] }
                    ], Parent_Layout);

OUTPUT(parentDS, NAMED('parentDS'));


Child_Layout xForm(Child_Layout Ri) := TRANSFORM
     SELF := Ri;
END;

ExtractChild := NORMALIZE(parentDS,
                         LEFT.Children, //Sending only the child dataset
                         xForm(RIGHT));


OUTPUT(ExtractChild, NAMED('ExtractChild'));

```

</pre>
<a class="trybutton" href="javascript:OpenECLEditor(['NormExp_1'])"> Try Me </a>

</br>

</br>

### All Records Syntax

```java
Child_Layout := RECORD
    FieldOne;
    FieldTwo;
END;

//Parent Layout with child dataset
Parent_Layout := RECORD
    ...
    ...
    DATASET(Child_Layout) Children; //Embedded child layout
END;

Child_Layout xForm(Child_Layout Ri) := TRANSFORM
     SELF := Ri;
END;

attribName := NORMALIZE(ParentsDS,
                         //Sending only the child dataset
                         LEFT.Children, 
                         xForm(RIGHT)
                         [,flags]);
```

## Normalize With COUNTER

This NORMALIZE form calls TRANSFORM <n> times for each parent record.  <n> does not need to be the same value for every record. The TRANSFORM function must take at least a **LEFT** record of the same format as the input recordset. The resulting record set format does not need to be the same as the input.

#### Example

<br>
<pre id = 'Norm2Exp_1'>

```java
/*
NORMALIZE with COUNTER Example
*/

Parent_layout := RECORD
  // The explicitCount defines:
  // how many times transform should execute per record.
  INTEGER explicitCount; 
  STRING  lastName; 
  STRING  phoneOne;
  STRING  phoneTwo;
  STRING  addressOne;
  STRING  addressTwo;
  STRING  addressThree;
END;

// Parent Dataset
parentDS := DATASET([
                {2, 'Alexa', '7701234567',  '', '123 Main Str', '404 capital cr', ''},
                {2, 'Smith', '', '8890002323', '504 Sunset Blvd', '990 Rose highway', ''},
                
                //Notice Adam has two phone numbers, but assigning 1 for number of execution
                {1, 'Adam', '6789991111', '4445679000', '', '', ''},
                {2, 'Black', '5694023457' ,'', '777 Formal Str', '111 Batman Corner', ''},
                {3, 'Rosy', '2209875437', '', '8749 OceanFront main Rd','5671 North Lake Str', '2323 Washington RD'}],
                      Parent_layout);


OUTPUT(parentDS, NAMED('parentDS'));

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
                          LEFT.explicitCount, 
                          xForm(LEFT,COUNTER));

OUTPUT(extractChild, NAMED('extractChild'));


```
</pre>
<a class="trybutton" href="javascript:OpenECLEditor(['Norm2Exp_1'])"> Try Me </a>

</br>
</br>

### With COUNTER Syntax

```java

Child_Layout := RECORD
    ...
    ...
END;

//Parent Layout with child dataset
Parent_Layout := RECORD
    INTEGER TheCounter;
    ...
    ...
END;


Child_Layout xForm(Parent_layout Li, INTEGER counting) := TRANSFORM

        //counting will only execute the number of times defined by expression
        SELF.Result     := CHOOSE(Counting, Li.FieldOne, Li.FieldTwo, ...);
       ...
       ...

END;

ExtractChildren := NORMALIZE(ParentDS,
                            Expression, //Left.TheCounter
                            xForm(LEFT,COUNTER)
                            [,flags]);

```

## Flags

|Options|Description|
|---|---|
UNORDERED|Specifies the output record order is not significant
ORDERED|Specifies the significance of the output record order
STABLE|Specifies the input record order is significant
PARALLEL|Try to evaluate this activity in parallel