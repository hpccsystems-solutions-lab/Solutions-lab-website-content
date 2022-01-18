/*
PROJECT Example:
Given a student dataset, PROJECT will decide if a student is in-state or not.
*/

StudentRec := RECORD
  INTEGER StudentID;
	STRING  Name;
	STRING  ZipCode;
  INTEGER Age;
  STRING  Major;
  BOOLEAN isGraduated;
END;

StudentDS := DATASET([{100, 'Zoro',  '30330', 26, 'History', TRUE}, {409, 'Dan', '40001', 26, 'Nursing', FALSE},
                     {300, 'Sarah', '30000', 25, 'Art', FALSE}, {800, 'Sandy', '30339', 20, 'Math', TRUE},
                     {202, 'Alan', '40001', 33, 'Math', TRUE}, {604, 'Danny', '40001', 18, 'N/A', FALSE},
                     {305, 'Liz',  '30330', 22, 'Chem', TRUE}, {400, 'Matt', '30005', 22, 'Nursing', TRUE}],
                    studentRec);

StudentsRes_layout := RECORD
    INTEGER StudentID;
    BOOLEAN InState;
    INTEGER Tution;
END;

ProjResult := PROJECT(StudentDS,
                TRANSFORM(StudentsRes_layout,
                    SELF.InState := IF(LEFT.ZipCode IN ['30330', '30005', '30000'], TRUE, FALSE);
                    SELF := LEFT; // Assings StudentID, since it exists in input dataset.

                    // Assigns defualt values to Tution since it doesn't exists in input dataset, 
                    // nor it is defined in this TRANFORM
                    SELF := []    // Assigns defualt values to Tution since it doesn't exists in input dataset 
                    ));

OUTPUT(ProjResult, NAMED('ProjResult'));