# Record Structure

Defines the layout o fields in the dataset, order of the fields should be the same as the dataset.

```java
attrLayout := RECORD
    data_type    field1;
    ...
    ...
    ...
    data_type    field100;
END;

//Inline record structure
attrLayout := {data_type field1, ..., data_type field100};
```

![record set example](./Images/RecordLayout.JPG)

The layout for above dataset would be:

```java
//salaryAvg is the name of layout.
salaryAvg := RECORD
    STRING job;
    STRING category;
    STRING city;
    STRING2 state;
    INTEGER avgSalary;
    INTEGER lowerBand;
    INTEGER upperband;
END;

//Inine layout definition
salaryDS := {STRING  job,
             STRING  category,
             STRING  city,
             STRING2 state,
             INTEGER avgSalary,
             INTEGER lowerBand,
             INTEGER upperband
             }
```

## Embedded record layouts

### Embed all layouts

layouts can be called to a new layout you are building.

```java
Personnell_layout := RECORD
    STRING firstName;
    STRING lastName;
    SalaryAvg;
END;
```

You can also call specific fields from a record layout.

```java
Personnell_layout := RECORD
    STRING firstName;
    STRING lastName;
    SalaryAvg.AvgSalary;
    SalaryAvg.job;
END;
```

### Embedded dataset

Child datasets can be embedded in record layouts.

```java
Personnell_layout := RECORD
    STRING firstName;
    STRING lastName;
    DATASET(SalaryAvg)  salaryInfo;
END;
```

## Field Supplements

Followings can be used for field definitions.

**MAXLENGTH**
`{ MAXLENGTH(length ) }`\
Specifies the maximum number of characters allowed in the field.

**MAXCOUNT**
`{ MAXCOUNT(records ) }`\
Specifies the maximum number of records allowed in a child
DATASET field

**XPATH**
`{ XPATH('tag') }` \
Specifies the XML or JSON tag that contains the data, in a
RECORD structure that defines XML or JSON data. This overrides the default tag name (the lowercase field identifier)

**XMLDEFAULT**
`{ XMLDEFAULT('value') }`\
Specifies a default XML value for the field. The value must be
**constant**.

**DEFAULT**
`{ DEFAULT( value ) }`\
Specifies a default value for the field. The value must be **constant**.
This value will be used:

1. When a DICTIONARY lookup returns no match.
2. When an out-of-range record is fetched using ds[n] (as in ds[5]
   when ds contains only 4 records).
3. In the default records passed to TRANSFORM functions in nonINNER JOINS where there is no corresponding row.
4. When defaulting field values in a TRANSFORM using SELF
   = [ ].

**VIRTUAL, File Position**
`{ VIRTUAL( fileposition ) }`\
Specifies the field is a VIRTUAL field containing the relative byte
position of the record within the entire file (the record pointer).
This must be an **UNSIGNED8** field and must be the **last field**, because it only truly exists when the file is loaded into memory from
disk (hence, the "virtual").

**VIRTUAL, Local File Position**
`{ VIRTUAL( localfileposition ) }`\
Specifies the local byte position within a part of the distributed file on a single node: the first bit is set, the next 15 bits specify the
part number, and the last 48 bits specify the relative byte position
within the part. This must be an **UNSIGNED8** field and must be
the **last field**, because it only truly exists when the file is loaded
into memory from disk (hence, the "virtual").

**VIRTUAL, Logical Filename**
`{ VIRTUAL( logicalfilename ) }`\
Specifies the logical file name of the distributed file. This must be
a **STRING** field. If reading from a superfile, the value is the current
logical file within the superfile.

**BLOB**
`{ BLOB }`\
Specifies the field is stored separately from the leaf node entry in
the INDEX. This is applicable specifically to fields in the payload
of an INDEX to allow more than 32K of data per index entry. The
BLOB data is stored within the index file, but not with the rest of
the record. Accessing the BLOB data requires an additional seek.

```java
sampleLayout := RECORD
    STRING someName {MAXLENGTH(400)};
    DATASET(SalaryAvg)  salaryInfo {MAXCOUNT(100)};
    STRING someXML {xpath('a/b<>')};
    STRING Fname{xpath('Fname')}; ////matches: <Fname>xxxxx</Fname>
    UNSIGNED8 fpos {VIRTUAL(fileposition)};
END;

```

## Resources

[Learn Dataset](./dataset.md)
