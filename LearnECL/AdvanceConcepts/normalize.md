# Normalize

This function pulls child record set out of parent record set.

There are two ways to create normalize.

## One parameter transform

It processes through all records in the recordset executing transform function through all the child dataset records in each record. This method is used when we have embedded child dataset.

- Must have a `RIGHT` record of the same format as the child dataset.
- The resulting record set format does not need to be the same as the input.
- Child layout is being called as an embedded dataset.

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

attribName := NORMALIZE(parent dataset,
                         LEFT.Children, //Sending only the child dataset only
                         xForm(RIGHT));


```

## Two parameter transform

Process through all records in the recordset executing transform function the expect number of times on each record.

- Must have a `LEFT` record of the same format as the recordset.
- `COUNTER` specifying the number of times the transform will be executing per record. For example if a record has 3 address you want to extract, you assign three, and if the next record only has 2 addresses, and you want only the first address, you assign one.
- The resulting record set format does not need to be the same as the input.

```java

Parent_layout := RECORD
  // This number defines, how many times transform should execute per record
  INTEGER numOfExe;
  fieldOne;
  fielsTwo;
  ...
  ...
END;

//Child layout being extracted
child_layout := RECORD
  result;
  ...
  ...
END;


child_layout xForm(Parent_layout Li, INTEGER counting) := TRANSFORM

        //counting will only execute the number of times defined by expilicitCount
        SELF.result     := CHOOSE(counting, Li.fieldOne, Li.fieldTwo);
       ...
       ...

END;

extractChild := NORMALIZE(Paret Dataset,
                          //Number of times transform should go through a record
                          LEFT.expilicitCount,
                          xForm(LEFT,COUNTER));

```

Put it into practice [normalize.ecl](https://ide.hpccsystems.com/workspaces/share/291d17d9-e5cb-4fac-83c2-ac5997c28a31)
