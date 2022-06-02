
# ECL 

ECL - Enterprise Control Language is designed to handle and manipulate immense datasets which makes it a prefect language to solve big data problems. ECL can be used for both ETL (Extract, Transform, and Load) and querying data. ECL is a declarative language which allows processing big data without the need of programmer being involved with details and in-depth of imperative decisions. 



## ECL vs SQL
ECL and SQL can both be used to query a relational database. Following tables displays similar features between ECL and SQL. 

| SQL | ECL |
| --------- | ---------- |
| Declarative Language  | Declarative Language |
| Database Server | Thor Cluster or Roxie Cluster |
| A SQL Table  | An ECL Logical File  |
| A SQL Editor | VSCode Editor or ECL Cloud IDE |
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


Please refer [ECL syntax](./syntax.md) to learn about ECL standards. Or, 
[jump right into coding](./output.md) and skip all the introductions.

</br>
</br>