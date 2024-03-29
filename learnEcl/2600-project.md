---
title: Project
slug: project
---

# PROJECT

The PROJECT function processes through all records in the record-set calling the TRANSFORM function on each record in turn.

PROJECT is like SQL's SELECT … INTO TABLE …

**Syntax**
<pre>
    <EclCode 
    code="// Explicit TRANSFORM
    EXPORT project_name := PROJECT(input_dataset,
                                TRANSFORM(
                                    SELF.return_field_name := LEFT.input_Dataset_fieldname;
                                    ...
                                    ...
                                    ...
                                ));

    // Standalone TRANSFORM
    EXPORT project_name := PROJECT(input_dataset,
                                TRANSFORM_name(
                                    LEFT)
                                );">
    </EclCode>
</pre>

| _Value_ | _Definition_ |
| :- | :- |
| EXPORT | Optional, used within MODULEs. |
| project_name | The name by which the project will be invoked. |
| PROJECT | Required. |

Please refer to TRANSFORM for TRANSFORM syntax.

**Demo Dataset**
| StudentID | Name | ZipCode | Age | Major | isGraduated |
| :- | :- | :- | :- | :- | :- |
| 100 | Zorro | 30330 | 26 | History | TRUE |
| 409 | Dan | 40001 | 26 | Nursing | FALSE |
| 300 | Sarah | 30000 | 25 | Art | FALSE |
| 800 | Sandy | 30339 | 20 | Math | TRUE |
| 202 | Alan | 40001 | 33 | Math | TRUE |
| 604 | Danny | 40001 | 18 | N/A | FALSE |
| 305 | Liz | 30330 | 22 | Chem | TRUE |
| 400 | Matt | 30005 | 22 | Nursing | TRUE |

**Example**
<pre>
    <EclCode
    id="ProjectExp_1"
    tryMe="ProjectExp_1"
    code="/*Project Example:*/

    /*
    PROJECT Example:
    Given a student dataset, PROJECT will decide if a student is in-state or not.
    */

    StudentRec := RECORD
    INTEGER  StudentID;
    STRING   Name;
    STRING   ZipCode;
    INTEGER  Age;
    STRING   Major;
    BOOLEAN  isGraduated;
    END;

    StudentDS := DATASET([{100, 'Zorro',  '30330', 26, 'History', TRUE}, {409, 'Dan', '40001', 26, 'Nursing', FALSE},
                        {300, 'Sarah', '30000', 25, 'Art', FALSE}, {800, 'Sandy', '30339', 20, 'Math', TRUE},
                        {202, 'Alan', '40001', 33, 'Math', TRUE}, {604, 'Danny', '40001', 18, 'N/A', FALSE},
                        {305, 'Liz',  '30330', 22, 'Chem', TRUE}, {400, 'Matt', '30005', 22, 'Nursing', TRUE}],
                        studentRec);

    StudentsRes_layout := RECORD
        INTEGER  StudentID;
        BOOLEAN  InState;
        INTEGER  Tuition;
    END;

    ProjResult := PROJECT(StudentDS,
                    TRANSFORM(StudentsRes_layout,
                        SELF.InState := IF(LEFT.ZipCode IN ['30330', '30005', '30000'], TRUE, FALSE);
                        SELF := LEFT; // Assigns StudentID, since it exists in input dataset.

                        // Assigns default values to Tuition since it doesn't exists in input dataset, 
                        // nor it is defined in this TRANSFORM
                        SELF := []    // Assigns default values to Tuition since it doesn't exists in input dataset 
                        ));

    OUTPUT(ProjResult, NAMED('ProjResult'));">
    </EclCode>
</pre>