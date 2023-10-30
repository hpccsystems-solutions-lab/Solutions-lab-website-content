---
title: Learn ECL
slug: introduction
---

# WHAT IS ECL?

ECL - Enterprise Control Language is designed to handle and manipulate immense datasets which make it a perfect language to solve big data problems. ECL can be used for both ETL (Extract, Transform, and Load) and querying data. ECL is a declarative language which allows processing big data without the need of a programmer being involved with details and in-depth imperative decisions.

## ECL vs SQL

ECL and SQL can both be used to query a relational database. Following is a table displaying similar features between ECL and SQL.

| SQL | ECL |
| :- | :- |
| Declarative Language | Declarative Language |
| Database Server | Thor Cluster or Roxie Cluster |
| An SQL Table | An ECL Logical File |
| An SQL Editor | VSCode Editor or ECL Cloud IDE |
| An SQL File | An ECL File |
| Executing SQL means submitting the written SQL to the Database Server which in turn compiles it and executes it | Executing ECL means submitting the written ECL to a Thor or Roxie cluster which in turn compiles and executes it |
| SQL Execution History/Logs | ECL Workunits Database & ECL Watch Workunits View |

## Language Highlights

- ECL is not a case sensitive language, but it is recommended to use uppercase for reserved words
- White spaces are ignored, but it is strongly recommended to use white space for clarity and readability
- ECL is a declarative programming language, which means you specify what needs to be done rather than how to do it
- Source-to-source compiler
- ECL code gets translated to C++ that is compiled to shared libraries and executed within a custom framework

Please refer [ECL syntax](../ecl-syntax) to learn about ECL standards.
