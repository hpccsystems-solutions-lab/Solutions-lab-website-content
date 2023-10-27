---
title: Transform
slug: transform
---

# TRANSFORM

TRANSFORM functions perform data transformations on datasets. They allow you to apply a series of operations to a record creating a new record of a given type.

They may accept arguements or use global context variables.

Transform can be used with PROJECT, JOIN, ITERATE, ROLLUP and more.

## Syntax

<pre>
<EclCode code="EXPORT [return_dataset_layout] transform_name ([input_arguments_types]+ arg_name ) := TRANSFORM
      SELF.return_field_name := arg_name.input_dataset_fieldname;
      SELF := arg_name;
      SELF := [];
END;">
</EclCode>
</pre>

| _Value_ | _Definition_ |
| :- | :- |
| EXPORT | Optional. Used in MODULEs |
| return_dataset_layout | Record-definition/layout of result dataset. |
| transform_name | The name by which the transform will be invoked. |
| input_arguments_types | The argument’s data type. If passing a dataset, the data type is DATASET(record_definition). |
| arg_name | Used to reference your argument in the transform. |
| TRANSFORM | Required. |
| SELF | Reference the field in the return_data_type. |
| return_field_name | Refers to the field in result dataset. |
| input_Dataset_fieldname |	Refers to the field in the input dataset. |
| SELF := [ ] | Assign default value for every field in result dataset that doesn't have a defined operation or doesn't exists in the input dataset. For example if there is a INTEGER field in the result dataset, that transform didn't assign a definition to it, the field will receive a 0 which is the default value for INTEGER. |
| END | Required. |

## Transform Type One (Standalone TRANSFORM)

If you need the transform to be used in multiple places, or if it contains many fields or child datasets, you may want to define a standalone transform (a function that can be called multiple times)

### Demo Dataset

| FirstName | LastName |
| :- | :- |
| Sun | Shine |
| Blue | Moon |
| Silver | Rose |

**Example**

<pre>
<EclCode
id="TransformExp_1"
tryMe="TransformExp_1"
code="/*Transform Example:*/

/*
TRANSFORM Example: 
Using an input dataset, concat names and count the number of rows in the input dataset. 
PROJECT results always have the same number of rows as input dataset. 
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
NameOutRec: Result of the project gets saved in this record layout.
CatThem: TRANSFORM name.
Names_layout L: Left dataset that’s passed through project.
INTEGER C: Counter.
*/
NameOutRec CatThem(Names_layout L, INTEGER C) := TRANSFORM

  // Concatenating FirstName with LastName and adding space between them
  SELF.CatValues := L.FirstName + ' ' + L.LastName; 
  SELF.RecCount := C; // Counter

  // Performs a name-wise copy of fields that have not already been assigned, using 'L' as a source
  SELF := L; 

END;

/*
Result: Result dataset.
PROJECT: Required. Can be replaced by other functions.
Name_DS: Input dataset.
CatThem: TRANSFORM name.
LEFT: Refers to the left dataset. PROJECT always takes one dataset. So, LEFT is the only reference used.
COUNTER: Counting the number of rows.
*/
Result := PROJECT(Names_DS,
                 CatThem(LEFT, COUNTER));

OUTPUT(Result, NAMED('Result'));

"></EclCode>
</pre>

## Transform Type Two (Explicit TRANSFORM)

Often times TRANSFORM is small enough to be used within PROJECT, JOIN, ROLLUP and other functions. Let's take a look at how it can be used within PROJECT. Similar principal is applied in using transform with other functions mentioned above, at transform definition.

<pre>
<EclCode code="EXPORT project_name := PROJECT(input_dataset,
                            TRANSFORM(
                                return_dataset_layout
                                SELF.return_field_name := LEFT.input_Dataset_fieldname;
                                SELF := LEFT;
                                SELF := [];
                            ));
">
</EclCode>
</pre>

| _Value_ | _Definition_ |
| :- | :- |
| EXPORT | Optional. Used for constants, or in modules. |
| project_name | The name by which the project will be invoked. |
| PROJECT | Required. JOIN, ROLLUP and other functions can be used here. |
| input_dataset | Input dataset itself and not the record definition. |
| TRANSFORM | Required. |
| return_dataset_layout | Record-definition/layout of result dataset. |
| SELF | Reference the field in the return_data_type. |
| return_field_name | Refers to the field in result dataset. |
| input_Dataset_fieldname | Refers to the field in the input dataset. |
| SELF := LEFT | Get the original values from input (left) dataset for all fields that don't have an operation defined. |
| SELF := [ ] | Assign default value for every field in result dataset that doesn't have a defined operation or doesn't exists in the input dataset. For example if there is a INTEGER field in the result dataset, that transform didn't assign a definition to it, the field will receive a 0 which is the default value for INTEGER. |

**Example**

<pre>
<EclCode
id="TransformExp_2"
tryMe="TransformExp_2"
code="/*Transform Example:*/

/*
TRANSFORM Example: 
Using an input dataset, concat names and count the number of rows in the input dataset. 
PROJECT results always have the same number of rows as input dataset. 

This TRANSFORM example, utilizing PROJECT, provides the same exact result as the above example. 
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

"></EclCode>
</pre>