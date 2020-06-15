# Denormalize

This function is used to combine parent and child recordset.

## Transform

- `LEFT` Combined layout of parent and child layout.
- `RIGHT` Take the child layout.
  `COUNTER` Can be added as an optional parameter
- Transform result outcome is usually the same format as your LEFT record layout.

```java
ParentResultLayout out xFormName (ParentResultLayout L,
                                  childLayout     R,
                                  INTEGER            C) := TRANSFORM
        ....
        ....
END;

AttibName := DENORMALIZE(Parent Dataset, child Dataset,
                        LEFT.fieldName = RIGHT.fieldName,
                        xFormName(LEFT,
                                   RIGHT,
                                   COUNTER //Optional
                                   ));
```

Put it into practice [denormalize.ecl](https://ide.hpccsystems.com/#)
