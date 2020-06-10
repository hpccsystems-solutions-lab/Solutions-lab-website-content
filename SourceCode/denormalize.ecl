ParentLayout := RECORD
    STRING      fname;
    STRING      lname;
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
//------------------------------------------------
ChildrenLayout := RECORD
    STRING      fname;
    STRING      lname;
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
//------------------------------------------------
EmbeddedChildLayout := RECORD
    STRING      fname;
    UNSIGNED1   age;
END;
ParentChildLayout1 := RECORD
    ParentLayout;
    DATASET(EmbeddedChildLayout)    children;
END;
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
denorm1 := DENORMALIZE
    (
        preppedParents,
        childrenDS,
        LEFT.lname = RIGHT.lname,
        TRANSFORM
            (
                ParentChildLayout1,
                SELF.children := LEFT.children + ROW({RIGHT.fname, RIGHT.age}, EmbeddedChildLayout),
                SELF := LEFT
            )
    );
OUTPUT(preppedParents, NAMED('preppedParents'));
OUTPUT(denorm1, NAMED('example_1'));
//------------------------------------------------
ParentChildLayout2 := RECORD
    ParentLayout;
    SET OF STRING   children;
END;
denorm2 := DENORMALIZE
    (
        parentDS,
        childrenDS,
        LEFT.lname = RIGHT.lname,
        GROUP,
        TRANSFORM
            (
                ParentChildLayout2,
                SELF.children := SET(ROWS(RIGHT), fname),
                SELF := LEFT
            )
    );
OUTPUT(denorm2, NAMED('example_2'))