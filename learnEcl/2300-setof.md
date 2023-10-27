---
title: Set Of
slug: set-of
---
# SET OF

SET OF is a data type, similar to an array in other languages, which defines attributes that are a collection of items or data elements. All values must be a scalar data type or, in certain circumstances, datasets. Indexing in SET OF start with 1. Since data isn't distributed it has to fit in memory. SET can also be defined in brackets `[ ]` without the need of a dataset.

## Syntax

<pre>
<EclCode code="SET OF <dataType> attr_name := [elem1, elem2, ... elemN]">
</EclCode>
</pre>

| _Value_    | _Definition_                                         |
| :- | :- |
| dataType | Element data type. |
| attr_name | The name by which the operation will be invoked. |
| [...] | Input values. |

**Example**

<pre>
<EclCode
code="/*SET OF Example:*/

/*
SET OF Example:
Showing different examples of SET OF.
*/

SET OF INTEGER IntSet := [1,3,3,5];
OUTPUT(IntSet, NAMED('IntSet'));

SET OF DECIMAL3_1 DecSet := [12, 12.1, 90.7, 90];
OUTPUT(DecSet, NAMED('DecSet'));

"></EclCode>
</pre>