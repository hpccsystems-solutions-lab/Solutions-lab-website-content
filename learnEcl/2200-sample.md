---
title: Sample
slug: sample
---

# SAMPLE

SAMPLE function returns a set of sample records.

## Syntax

<pre>
<EclCode code="SAMPLE(dataset, interval, [, which])">
</EclCode>
</pre>

| _Value_ | _Definition_ |
| :- | :- |
| dataset | Input records to sample. |
| interval | The intervals between records to return. |
| which | Optional. An integer specifying the ordinal number of the sample set to return. This is used to obtain multiple non-overlapping samples from the same recordset. |

### Demo Dataset
| Color | ID |
| :- | :- |
| Red | 100 |
| Blue | 102 |
| Black | 103 |
| Yellow | 104 |
| Orange | 105 |
| White | 106 |
| Green | 107 |
| Purple | 108 |

**Example**

<pre>
<EclCode
id="SampleExp_1"
tryMe="SampleExp_1"
code="/*Sample Example:*/

/*
REAL Example:
Collecting different sample sizes from the input dataset.
*/

Color_Layout := RECORD
    STRING   Color;
    INTEGER ID;
END;

Color_DS := DATASET([
    {'Red', 100},
    {'Blue', 102},
    {'Black', 103},
    {'Yellow', 104},
    {'Orange', 105},
    {'White', 106},
    {'Green', 107},
    {'Purple', 108}],
    Color_Layout);

SampleOne := SAMPLE(Color_DS, 3);
OUTPUT(SampleOne, NAMED('SampleOne'));

SAMPLE(Color_DS, 2, 4);

"></EclCode>
</pre>