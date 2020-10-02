# TRANSFORM

Transform function, loops through an entire dataset, and performs an operation on every field in the dataset.
When defining a transform you need to tell the function what it needs to do for each field in the input dataset, and what the output dataset should look like.\
Transform can be used with PROJECT, JOIN, ITERATE, ROLLUP and more.

```java
EXPORT [return_dataset_layout] transform_name ([input_arguments_types]+ arg_name ) := TRANSFROM
      SELF.return_field_name := arg_name.input_dataset_fieldname;
      SELF := arg_name;
      SELF := [];
END;
```

- EXPORT
  - ECL Keyword
  - Optional, used for constants, or in modules.
- return_dataset_layout
  - Record-definition/layout of result dataset.
- transform_name
  - The name by which the transform will be invoked
- input_arguments_types
  - The argument’s data type
  - If passing a dataset, the data type is DATASET(record_definition)
- arg_name
  - Used to reference your argument in the transform
- TRANSFROM
  - ECL Keyword
  - Required
- SELF
  - Reference the field in the return_data_type
- arg_name.input_Dataset_fieldname
  - Refers to the field in the input dataset
- SELF := LEFT
- SELF := RIGHT
  - Get the original values from input dataset for all fields that don't have an operation defined.
- SELF := []
  - For every field in result layout that doesn't have a defined operation or doesn't exists in input dataset, assign default value. For example if there is a STRING field in result layout, that transform didn't assign a definition for, it will be assign to blank.

## Standalone Transform

If you need the transform to be used in multiple places, or it contains many fields or child datasets, you may want to define a standalone transform(a function that can be called multiple times)

```java
NameRec := RECORD //defining record layout
	STRING FirstName;
	STRING LastName;
END;

//creating inline dataset
NameDS := DATASET([
              {'Sun','Shine'},
              {'Blue','Moon'},
              {'Silver','Rose'}],
              NameRec);

//defining new layout for the project result
NameOutRec := RECORD
	STRING FirstName;
	STRING LastName;
	STRING CatValues;
 	INTEGER RecCount; //counter
END;

/*
NameOutRec: result of the project gets saved in this record layout
CatThem: Tranform name
NameRec L: Left datasets thats passed through project
INTEGER C: counter
*/
NameOutRec catThem(NameRec L, INTEGER C) := TRANSFORM
	SELF.CatValues := L.FirstName + ' ' + L.LastName; // concact fname and last name
  	SELF.RecCount := C; //counting
	SELF := L; //assing everything from left recordset
END;

```

## Inline TRANSFORM

Often times transform is used within Project, Join, etc. Let's take a look at how it can be used with a PROJCET. Similar principal is applied in using transform with other functions mentioned above, at transform definition.

```java
EXPORT project_name := PRJECT(input_dataset,
                            TRANSFORM(
                                return_dataset_layout
                                SELF.return_field_name := LEFT.input_Dataset_fieldname;
                                SELF := LEFT;
                                SELF := [];
                            ));

```

- EXPORT
  - ECL Keyword
  - Optional, used for constants, or in modules.
- project_name
  - The name by which the project will be invoked
- PROJECT
  - ECL Keyword
  - Required
- input_dataset
  - Input dataset itself and not the record definition
- TRANSFORM
  - ECL Keyword
  - Required
- return_dataset_layout
  - Record-definition/layout of result dataset.
- SELF.return_field_name
- SELF := LEFT
- SELF := RIGHT
  - Please see above explanations for each of them.

```java
CatThemDS := PROJECT(NameDS,
                        TRANSFORM(
                            NameOutRec,
                            SELF.CatValues := LEFT.FirstName + ' ' + LEFT.LastName; // concact fname and last name
  	                        SELF.RecCount := COUNTER; //counting
	                        SELF := LEFT; //Assign everything from left recordset
                            SELF := []; //If undefined assign default value
                        ));


```

[Put it into practice](Put it into practice [transform.ecl](https://ide.hpccsystems.com/workspaces/share/291d17d9-e5cb-4fac-83c2-ac5997c28a31)
)\
[Learn PROJECT](./project.md)\
[Learn JOIN](./join.md)
