---
title: Exists
slug: exists
---

# EXISTS

EXISTS function checks to see if there are any records in the dataset and returns TRUE if there is at least 1 record in the dataset.

EXISTS is more efficient than COUNT, since COUNT will count all the rows in dataset, where EXISTS aborts as soon as it determines that the dataset is non-empty.

## Syntax

<pre>
<EclCode code="EXISTS(recordset)
EXISTS(value_set)">

</EclCode>
</pre>

| Value     | Definition                     |
| :-------- | :----------------------------- |
| EXISTS    | Required.                      |
| recordset | Dataset to be checked.         |
| value_set | Values in a SET to be checked. |

**Demo Dataset**

| City           | State | County    | Population |
| :------------- | :---- | :-------- | :--------- |
| Dauphin Island | AL    | Mobile    | 1335       |
| Guy            | AR    | Faulkner  | 778        |
| El Centro      | CA    | Imperial  | 111425     |
| Indio          | CA    | Riverside | 417059     |
| Englewood      | CO    | Arapahoe  | 6183       |
| Keywest        | FL    | Monroe    | 31401      |
| Manatee Road   | FL    | Levy      | 2670       |
| Villa Rica     | GA    | Carroll   | 16058      |
| Atlanta        | GA    | Fulton    | 5449398    |

**Example**

<pre>
<EclCode
id="ExistsExp_1"
tryMe="ExistsExp_1"
code="
Pop_Layout := RECORD
STRING   City;
STRING   State;
STRING   County;
INTEGER  Population;
END;

Pop_DS := DATASET([
{'Dauphin Island','AL','Mobile',1335},
{'Guy','AR','Faulkner',778},
{'El Centro','CA','Imperial',111425},
{'Indio','CA','Riverside',417059},
{'Englewood','CO','Arapahoe',6183},
{'Keywest','FL','Monroe',31401}],
Pop_Layout);

// Check to see if Pop_DS dataset has values
HasData := EXISTS(Pop_DS);
OUTPUT(HasData, NAMED('HasData'));">
</EclCode>
</pre>

**Example**

<pre >
<EclCode 
id="ExistsExp_2"
tryMe="ExistsExp_2"
code="/*
EXISTS Example:
Showing different examples of EXIST function values.
*/

CheckMe := EXISTS(4,8,16,2,1);
OUTPUT(CheckMe, NAMED('CheckMe'));

NullSet := [];
CheckIt := EXISTS(NullSet);
OUTPUT(CheckIt, NAMED('CheckIt'));">
</EclCode>
</pre>
