# Dataset

A physical data file on disk. It can be defined directly as an inline dataset, or can be brought in from outside.

## Inline Dataset

A temporary dataset that's created and used while job is running. Inline dataset definition can be used for small datasets.

```java
attr_layout := RECORD
    data_type    field1;
    ...
    ...
    ...
    data_type    field100;
END;

//Inline Dataset
attr_name := DATASET(
                        [
                            {'', '', 0, '', FALSE, ..., ''},
                            {'', '', 0, '', FALSE, ..., ''},
                            ...
                            ...
                            {'', '', 0, '', FALSE, ..., ''}
                        ],
                        attr_layout
                    );
```

- attr_name
  - Dataset name
- DATASET
  - ECL Keyword
- (...)
  - Contains all dataset information
- [...]
  - Contains all rows for dataset
- attr_layout
  - Record structure the dataset is using

![record set example](./Images/RecordLayout.JPG)

The layout for above dataset:

```java
//Record layout
salaryAvg_Layout := RECORD
    STRING job;
    STRING category;
    STRING city;
    STRING2 state;
    INTEGER avg_Salary;
    INTEGER lowerBand;
    INTEGER upperband;
END;

salaryAvg_DS := DATASET([
                {'Manager', 'IT', 'Atlanta', 'GA', 87000, 62000, 114000},
                {'Director', 'IT', 'Atlanta', 'GA', 119000, 84000, 156000},
                {'Director', 'Art-Entertainment', 'Atlanta', 'GA', 100000, 70000, 133000},
                {'CIO', 'IT', 'Tampa', 'FL', 112000, 69000, 131000},
                {'Sales', 'General', 'Chicago', 'IL', 55000, 32000, 121000}
                ], salaryAvg_Layout //Layout definition
                );
```

## File Dataset

This dataset is import or created on disk and can be called for a job.

```java
attr_layout := RECORD
    data_type    field1;
    ...
    ...
    ...
    data_type    field100;
END;

path := '~some::sample::path';

//File Dataset
attr_name := DATASET(path,
                       attr_layout,
                       file_type);
```

- attr_name
  - Dataset name
- DATASET
  - ECL Keyword
- ( )
  - Contains all dataset information
- path
  - Physical address of file, where file is stored on disk.
  - ~ : Global search for the file
- attr_layout
  - Record structure the dataset is using
- file_type
  - Type of file (XML, CSV, logical, etc). Please see below for file types.

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

### File Type

- **FLAT**: Native file type for Thor; also used for fixed-length raw records
- **CSV**: Any kind of delimited data, including CSV-encoded data
- **JSON**: Data stored as a series of JSON objects
- **XML**: Data stored as a series of XML documents
- **PIPE**: Data obtained dynamically via process calls

## Resources

Put it into practice [dataset.ecl](https://ide.hpccsystems.com/workspaces/share/291d17d9-e5cb-4fac-83c2-ac5997c28a31)

Please visit [DATASET](https://hpccsystems.com/training/documentation/ecl-language-reference/html/DATASET.html) for more information.
