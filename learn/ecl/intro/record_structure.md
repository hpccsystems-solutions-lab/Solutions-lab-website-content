
# Record Structure
## Quick Look

Defines the layout o fields in the dataset, order of the fields should be the same as the dataset.

![record set example](./images/RecordLayout.JPG)

The layout for above dataset would be:

```java
//SalaryAvg is the name of layout.
SalaryAvg := RECORD
    STRING Job;
    STRING Category;
    STRING City;
    STRING2	State;
    INTEGER	Avg Salary;
    INTEGER	LowerBand;
    INTEGER	Upperband;
END;
```
# Deep Look


```java
attrLayout := RECORD  
    data_type    field1;
    ...
    ...
    ...  
    data_type    field100;
END;

//Or
attrLayout := {data_type field1, ..., data_type field100};

//Defining a reference to saved data
attrName := DATASET(path, record_structure, file_type);
```
### File Type
* __FLAT__: Native file type for Thor; also used for fixed-length raw records
* __CSV__:  Any kind of delimited data, including CSV-encoded data
* __JSON__: Data stored as a series of JSON objects
* __XML__:  Data stored as a series of XML documents
* __PIPE__: Data obtained dynamically via process calls
