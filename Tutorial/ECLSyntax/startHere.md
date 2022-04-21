
ECL is designed to read data (aka logical files) stored on a HPCC cluster, manipulate it and write back clean or analyzed data. Alternatively, ECL can also be used as query language like how SQL is used as a query language to query a relational database. 

__ECL vs SQL__

| SQL | ECL |
| --------- | ---------- |
| Declarative Language  | Declarative Language |
| Database Server | Thor Cluster or Roxie Cluster |
| A SQL Table  | An ECL Logical File  |
| A SQL Editor | VS Code Editor or ECL Cloud IDE |
| A SQL File   | A ECL File |
| Executing SQL means submitting the written SQL to the Database Server which in turn compiles it and executes it| Executing ECL means submitting the written ECL to a Thor or Roxie cluster which in turn compiles and executes it |
| SQL Execution History/Logs | ECL Workunits Database & ECL Watch Workunits View|

<br> 

## Language Highlights 

- ECL is not case sensitive language, but it is recommended to use uppercase for reserved words
- White spaces are ignored, but it is strongly recommended to use white space for clarity and readability
- Declarative Programming Language, which means you specifies what needs to be done rather than how to do it
- Source-to-source compiler
- ECL code translated to C++ that is compiled to shared libraries and executed within a custom frame-work


Please refer [ECL syntax](./syntax.md) to learn about ECL standards. 

[Jump right into coding](./output.md) and skip all the introductions.