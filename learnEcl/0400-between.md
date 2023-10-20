---
title: Between
slug: between
---

# BETWEEN

BETWEEN is an ECL operator to select values within a given range. It's the same as `>= and <=` and the same as the SQL BETWEEN operator.

## Syntax

<pre>
<EclCode code="attr_name := seek_val BETWEEN low_val AND high_val;
attr_name := seek_val NOT BETWEEN low_val AND high_val;">
</EclCode>
</pre>

| _Value_    | _Definition_ |
| :- | :- |
| attribName | The name by which the variable will be invoked. |
| seek_val | The value to be checked. Can be a dataset field too. |
| BETWEEN | Required. |
| NOT | Optional, used for certain searches. |
| Low_val | Low value in the range. |
| AND | Required. |
| high_val | High value in the range. |

**Example**

<pre>
<EclCode
id = "BetweenExp_1"
tryMe="BetweenExp_1"
code="// BETWEEN Examples:

SomeInt := 12;
SomeReal := 120.5;

CheckIntOne := SomeInt BETWEEN 10 AND 200;
CheckIntTwo := SomeInt NOT BETWEEN 10 AND 200;

OUTPUT(CheckIntOne, NAMED('CheckIntOne'));
OUTPUT(CheckIntTwo, NAMED('CheckIntTwo'));

CheckRealOne := SomeReal BETWEEN 50 AND 65;
CheckRealTwo := SomeReal NOT BETWEEN 150 AND 203.6;

OUTPUT(CheckRealOne, NAMED('CheckRealOne'));
OUTPUT(CheckRealTwo, NAMED('CheckRealTwo'));"></EclCode>
</pre>

### Demo Dataset

| City           | State | Population |
| :------------- | :---- | :--------- |
| Dauphin Island | AL    | 1335       |
| Guy            | AR    | 778        |
| El Centro      | CA    | 111425     |
| Indio          | CA    | 417059     |
| Englewood      | CO    | 6183       |
| Keywest        | FL    | 31401      |
| Manatee Road   | FL    | 2670       |
| Villa Rica     | GA    | 16058      |
| Atlanta        | GA    | 5449398    |

<pre>
<EclCode
id = "BetweenExp_2"
tryMe="BetweenExp_2"
code = "//BETWEEN Examples:
//Examples using an inline dataset.

Pop_Layout := RECORD
STRING City;
STRING State;
INTEGER Population;
END;

Pop_DS := DATASET([
{'Dauphin Island','AL',1335},
{'Guy','AR',778},
{'El Centro','CA',111425},
{'Indio','CA',417059},
{'Englewood','CO',6183},
{'Keywest','FL',31401},
{'Manatee Road','FL',2670},
{'Villa Rica','GA',16058},
{'Atlanta','GA',5449398}],
Pop_Layout);

PopEval_Layout := RECORD
STRING City;
STRING State
BOOLEAN isMiddleSize;
END;

Eval_Town := PROJECT(Pop_DS,
TRANSFORM(PopEval_Layout,
SELF.isMiddleSize := LEFT.Population BETWEEN 5000 AND 30000;
SELF := LEFT;
));

OUTPUT(Eval_Town, NAMED('Eval_Town'));">
</EclCode>

</pre>
