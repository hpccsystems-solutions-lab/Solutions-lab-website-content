# ROWS 

ROWS keyword indicates the parameter being passed to the TRANSFORM function is a <u>data set</u>. ROWS is used in functions where a dataset is being passed, such as ROLLUP, JOIN, and DENORMALIZE when the GROUP option is used.


#### Example 

<br>
<pre id = 'Rows_Exp1'>

```java
/*
ROWS Example:
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
<a class="trybutton" href="javascript:OpenECLEditor(['Rows_Exp1'])"> Try Me </a>

</br>
</br>



## Syntax 

When using ROWS you need to pass the dataset you are pointing to in the TRANSFORM. So ROWS can be used as ROWS(LEFT) or ROWS(RIGHT).

```java
function(LEFT_Dataset, RIGHT_Dataset,
                            LEFT.fieldName  = RIGHT.fieldName,
                            GROUP,
                            xForm(LEFT,ROWS(RIGHT)));
```

|*Value*|*Definition*|
|:----|:---------|
function | function that's calling transform, such as JOIN
LEFT_Dataset | Left dataset of the join. LEFT is the first dataset passed to JOIN
RIGHT_Dataset | Right dataset of the join. RIGHT is the second dataset passed to JOIN 
LEFT.fieldName = RIGHT.fieldName | Matching condition
GROUP| keyword
Transform/xForm | Explicit or stand-alone TRANSFORM
LEFT|Left dataset being passed to transform
ROWS|Keyword
RIGHT|Right dataset being passed to ROWS 

