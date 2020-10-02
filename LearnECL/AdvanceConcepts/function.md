# Function

A function is a set of statements that take inputs, does some specific computation and produces an output or return a result. Result could be a value or a dataset.

Notes:

- For function to be called/used from outside, `EXPORT` is required.
- Function name should match the file name. if not "Error: Definition must contain EXPORT or SHARED " is generated.

```java
EXPORT [return_data_type] function_name (data_type arg [, data_type arg]+) := FUNCTION

    ecl_code
    RETURN return_value;

END;
```

- return_data_type
  - Optional (compiler can infer it from return_value)
  - If returning a dataset, the data type is DATASET(record_definition)
- function_name
  - The name by which the function will be invoked
- data_type
  - The argument’s data type
  - If passing a dataset, the data type is DATASET(record_definition)
- ecl_code
  - Whatever code is needed to build return_value
  - Conversely, if the code does not contribute to return_value then it is ignored
  - Attributes defined here are scoped to the function
- return_value
  - The result of the function

```java
EXPORT myfunc (STRING val) := FUNCTION
   Result := 'Hello ' + val + ' , welcome to this function';
  RETURN Result;
END;

//Using myfunc
res := myfunc('Jonny');
OUTPUT(res, NAMED('res'));

OUTPUT(myfunc('Sunny'), NAMED('Sunny'));
```

## Outputs in Function - Using WHEN

`OUPUT` can be used to return multiple results from a function. `PARALLEL` and `WHEN` are the keywords used to generate multiple results.\
`PARALLEL` let's you run actions in parallel and `WHEN` behaves as a trigger. WHEN is used in scheduling.

```java
Foo(DATASET ds) := FUNCTION

    x := DoSomeThing(ds);

  sideActions := PARALLEL
     (
         OUTPUT(DS, NAMED('DS'));
         OUTPUT(normDS, NAMED('normDS'));
         OUTPUT(clean0, NAMED('clean0'));
     );

  RETURN WHEN(x, sideActions);
END;
```

## One Line Function

If you don’t have any ecl_code for the function, it is a one-liner. \
`FUNCTION`, `RETURN` and `END` keywords are omitted.

```java
UNSIGNED2 Squared(UNSIGNED1 n) := n * n;

isEven(INTEGER num) := num % 2 = 0;
```

Put it into practice [function.ecl](https://ide.hpccsystems.com/workspaces/share/291d17d9-e5cb-4fac-83c2-ac5997c28a31)
