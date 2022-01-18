# TRANSFORM

TRANSFORM function, defines specific operations that will be performed on every field in result dataset. TRANSFORM functions starts from row one and covers the entire dataset row by row.
When defining a transform you need to tell the function what it needs to be done on each field in the result dataset by using input datasets fields or creating new definitions for the fields.\
Transform can be used with PROJECT, JOIN, ITERATE, ROLLUP and more.

## Syntax
```java
EXPORT [return_dataset_layout] transform_name ([input_arguments_types]+ arg_name ) := TRANSFORM
      SELF.return_field_name := arg_name.input_dataset_fieldname;
      SELF := arg_name;
      SELF := [];
END;
```

|Value|Definition|
|:----|:---------|
EXPORT | Optional, used in MODULEs.
return_dataset_layout | Record-definition/layout of result dataset.
transform_name | The name by which the transform will be invoked.
input_arguments_types | The argument’s data type. If passing a dataset, the data type is DATASET(record_definition).
arg_name |Used to reference your argument in the transform.
TRANSFORM | Required.
SELF | Reference the field in the return_data_type.
return_field_name | Refers to the field in result dataset.
input_Dataset_fieldname | Refers to the field in the input dataset.
SELF := [ ] | Assign default value for every field in result dataset that doesn't have a defined operation or doesn't exists in the input dataset. For example if there is a INTEGER field in the result dataset, that transform didn't assign a definition to it, the field will receive a 0 which is the default value for INTEGER.
END | Required.

<br>

## Transform Type One (Standalone TRANSFORM)

If you need the transform to be used in multiple places, or it contains many fields or child datasets, you may want to define a standalone transform (a function that can be called multiple times)

**Demo Dataset**

|FirstName|LastName|
|:----|:---|
Sun | Shine
Blue | Moon
Silver | Rose


#### Example

<br>
<pre id="TransformExp_1">


```java
/*
TRANSFORM Example: 
Using an input dataset, to concat names and count the number of rows in the input dataset. 
PROJECT result always have the same number of rows as input dataset. 
*/


// Defining record layout
Names_layout := RECORD 
    STRING FirstName;
    STRING LastName;
END;

// Creating Explicit dataset
Names_DS := DATASET([
              {'Sun','Shine'},
              {'Blue','Moon'},
              {'Silver','Rose'}],
              Names_layout);

// Defining new layout for the project result
NameOutRec := RECORD
    STRING  FirstName;
    STRING  LastName;
    STRING  CatValues;
    INTEGER RecCount; //Counter
END;

/*
NameOutRec: Result of the project gets saved in this record layout
CatThem: TRANSFORM name
Names_layout L: Left datasets that’s passed through project
INTEGER C: Counter
*/
NameOutRec CatThem(Names_layout L, INTEGER C) := TRANSFORM

  // Contacting FirstName with LastName and adding space between them
  SELF.CatValues := L.FirstName + ' ' + L.LastName; 
  SELF.RecCount := C; // Counter
  // Assign default values to all fields that are in result dataset and haven't been define in this TRANSFORM
  SELF := L; 

END;

/*
Result: result dataset.
PROJECT: Required, it can be replaced by other functions.
Name_DS: Input dataset
CatThem: TRANSFORM name
LEFT: Refers to the left dataset. PROJECT always takes one dataset. So, LEFT is the only reference used.
COUNTER: Counting the number of rows.
*/
Result := PROJECT(Names_DS,
                 CatThem(LEFT, COUNTER));

OUTPUT(Result, NAMED('Result'));
```
</pre>
<a class="trybutton" href="javascript:OpenECLEditor(['TransformExp_1'])"> Try Me </a>

<br> 

## TRANSFORM Type Two (Explicit TRANSFORM)

Often times TRANSFORM is small enough to used within PROJECT, JOIN, ROLLUP and other functions. Let's take a look at how it can be used within PROJECT. Similar principal is applied in using transform with other functions mentioned above, at transform definition.

```java
EXPORT project_name := PROJECT(input_dataset,
                            TRANSFORM(
                                return_dataset_layout
                                SELF.return_field_name := LEFT.input_Dataset_fieldname;
                                SELF := LEFT;
                                SELF := RIGHT;
                                SELF := [];
                            ));

```

|Value|Definition|
|:----|:---------|
EXPORT | Optional, used for constants, or in modules.
project_name | The name by which the project will be invoked.
PROJECT | Required. JOIN, ROLLUP and other functions can be used here.
input_dataset | Input dataset itself and not the record definition.
TRANSFORM | Required.
return_dataset_layout | Record-definition/layout of result dataset.
SELF | Reference the field in the return_data_type.
return_field_name | Refers to the field in result dataset.
input_Dataset_fieldname | Refers to the field in the input dataset.
SELF := LEFT | Get the original values from input (left) dataset for all fields that don't have an operation defined.
SELF := RIGHT | Used where there are two input dataset like JOIN. Get the original values from input (right) dataset for all fields that don't have an operation defined.
SELF := [ ] | Assign default value for every field in result dataset that doesn't have a defined operation or doesn't exists in the input dataset. For example if there is a INTEGER field in the result dataset, that transform didn't assign a definition to it, the field will receive a 0 which is the default value for INTEGER.


#### Example

<br>
<pre id="TransformExp_2">


```java

/*
TRANSFORM Example: 
Using an input dataset, to concat names and count the number of rows in the input dataset. 
PROJECT result always have the same number of rows as input dataset. 

This TRANSFORM, PROJECT example provides the exact same result as above example. 
The only difference is the way TRANSFORM is written and called.
*/

// Defining record layout
Names_layout := RECORD 
    STRING FirstName;
    STRING LastName;
END;

// Creating inline dataset
Names_DS := DATASET([
              {'Sun','Shine'},
              {'Blue','Moon'},
              {'Silver','Rose'}],
              Names_layout);

// Defining new layout for the project result
NameOutRec := RECORD
    STRING  FirstName;
    STRING  LastName;
    STRING  CatValues;
    INTEGER RecCount; //Counter
END;

ProjResult := PROJECT(Names_DS,
                    TRANSFORM(NameOutRec,
                      // Concat FirstName and LastName
                      SELF.CatValues := LEFT.FirstName + ' ' + LEFT.LastName; 
                      SELF.RecCount := COUNTER; // Counter
                      SELF := LEFT // Assign everything from left recordset
                    ));

OUTPUT(ProjResult, NAMED('ProjResult'));

```
</pre>
<a class="trybutton" href="javascript:OpenECLEditor(['TransformExp_2'])"> Try Me </a>

<br> 
