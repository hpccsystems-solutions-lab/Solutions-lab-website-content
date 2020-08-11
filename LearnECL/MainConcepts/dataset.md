# Dataset

## Quick Look

A physical data file on disk. It can be defined directly as an inline dataset, or can be brought in from outside.

![record set example](./Images/RecordLayout.JPG)

The layout for above dataset:

```java
//SalaryAvg is the name of layout.
SalaryAvg_Layout := RECORD
    STRING Job;
    STRING Category;
    STRING City;
    STRING2	State;
    INTEGER	Avg_Salary;
    INTEGER	LowerBand;
    INTEGER	Upperband;
END;

SalaryAvg_DS := DATASET([
                {'Manager', 'IT', 'Atlanta', 'GA', 87000, 62000, 114000},
                {'Director', 'IT', 'Atlanta', 'GA', 119000, 84000, 156000},
                {'Director', 'Art-Entertainment', 'Atlanta', 'GA', 100000, 70000, 133000},
                {'CIO', 'IT', 'Tampa', 'FL', 112000, 69000, 131000},
                {'Sales', 'General', 'Chicago', 'IL', 55000, 32000, 121000}
                ], SalaryAvg_Layout //Layout definition
                );
```

### Inline Dataset

Inline dataset definition can be used for small datasets.

```java

attr := DATASET(path, record_structure, file_type);

```

```java

recName := RECORD
   STRING  valOne;
   STRING  valTwo;
   INTEGER numOne;
   BOOLEAN isName;
END;

fileDS := DATASET(~test::file::cvs, //File Name
                  recName, //defined record structure/layout
                  CVS     //File Type
                  );

```
