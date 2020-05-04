# Quick Look

Transform function, loops through an entire dataset, and performs an operation on every field in the dataset.
When defining a transform you need to tell the function what it needs to do for each field in the input dataset, and what the output dataset should look like.\
Transform can be used with PROJECT, JOIN, ITERATE, ROLLUP and more.

```java
//Means that every field in output that doesn't have a defined operationed should be set to blank.
SELF := [];

//Get the orginal values from input dataset for all fields that don't have an operation defined.
SELF := LEFT;
SELF := RIGHT;
```
## Standalone Transform
If you need the transforms to be used in multiple places, or your dataset contains many fields, you want to define an standalone transform(a function that can be called multiple times)

```java
NameOutRec CatThem(NameRec L, INTEGER C) := TRANSFORM
```
* Left side includes the result layout.
* It should have a name
* Contains parameter list
* SELF: refers to fields in result type.

Let's take a look at an example:

```java
NameOutRec
```

For executable code please see [transform.ecl](/source/ecl/transform.ecl)