---
layout: page
title: Getting Started
permalink: /main/
---

# Getting Started
## HPCC
HPCC System is big data processing platform. Features include high speed processing, near real time result.\
It's functionalities are end to end configuration, scalability, high performance and it includes plugins and extensions for major tools like SQL.

## ECL
Enterprise Control Language (ECL) has been designed specifically for huge data projects using the LexisNexis High Performance Computer Cluster (HPCC). ECL's extreme scalability comes from a design that allows you to leverage
every query you create for re-use in subsequent queries as needed. 


## ECL Cloud IDE
For practicing, you can take advantage of our [ECL Could IDE](https://ide.hpccsystems.com/auth/login).

For creating a new account and a quick guide on how to use the Could IDE, use 
[this instruction manual](/references/cloudide_setup.md)

<!-- ![ Cloud IDE screenshot](/docs/intro/images/cloudIDE.jpg) -->
<img width="600" alt="portfolio_view" src="images/cloudIDE.jpg">

```java
OUTPUT(analysis_mod.top_user_rating_count, NAMED('user_rating_count'));

EXPORT analysis_mod := MODULE
  EXPORT top_user_rating_count := TOPN( TABLE(clean_mod.games_ds, {name, user_rating_count}) , 10, -user_rating_count);     
END;

EXPORT clean_mod := MODULE
		EXPORT games_layout := RECORD
       STRING50 name;
       REAL price;
       REAL avg_user_rating;
       INTEGER user_rating_count;
    END;
     
    EXPORT games_ds := PROJECT(raw_mod.games_ds, TRANSFORM (games_layout, SELF:=LEFT));
END;

```
