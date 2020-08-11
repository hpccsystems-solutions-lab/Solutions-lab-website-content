# Dashboards

In the ECL cloud ide, a Dashboard is a specifically structured output that can be used to
display a series of charts of various types. First, we show an example. Following the example,
you will find all of the available chart types, and the relevant options for those charts.

### Example

```java
cases := DATASET([{'May 1', 10000}, {'May 2', 9000}, {'May 3', 11000}], {STRING day, REAL value});

recovered := DATASET([{'May 1', 560}, {'May 2', 805}, {'May 3', 730}], {STRING day, REAL value});

cases_country := DATASET([{'May 1', 'US', 3000},
                          {'May 2', 'US' , 4000},
                          {'May 3', 'US' , 5200},
                          {'May 1', 'UK', 3800},
                          {'May 2', 'UK' , 4100},
                          {'May 3', 'UK' , 4800}], {STRING day, STRING country, REAL value});

OUTPUT(cases,,NAMED('cases'));
OUTPUT(recovered,,NAMED('recovered'));
OUTPUT(cases_country,,NAMED('cases_country'));

dashData := DATASET(
  [{
    'Daily Cases',                          // the label of the chart
    'cases',                                // name of the dataset to use as the data source
    'Bar',                                  // the type of chart
    '{"xField": "day", "yField": "value"}'  // options for the chart
  }, {
    'Daily Cases Recovered',
    'recovered',
    'Line',
    '{"radiusField": "value", "angleField": "day"}'
  }, {
    'Daily Cases By Country',
    'cases_country',
    'GroupedBar',
    '{"xField": "value", "yField": "day", "groupField": "country"}'
  }], {
    // the dataset layout for the records above
    STRING title,
    STRING data_source,
    STRING chart_type,
    STRING options
 });

OUTPUT(dashData,,NAMED('_dashboard')); // a Dashboard output should always be named "_dashboard"
```

Please note that the options shown below are written in JSON object notation with whitespace / indentation
for legibility. But when used in actual ECL (as part of a record, as shown in the example above) they are
strings in the records, and should be written as a single line e.g.:

```js
  {
    "xField": "day",
    "yField": "value"
  }
```

in ECL, would actually be written as:

```js
  { ...other columns..., '{"xField": "day", "yField": "value"}' }
```

### Types of Charts, and relevant options

#### Column

```js
  {
    "xField": "",           // the field to use on the x-axis
    "yField": ""            // the field to use on the y-axis
  }
```

#### GroupedColumn

```js
  {
    "xField": "",           // the field to use on the x-axis
    "yField": "",           // the field to use on the y-axis
    "groupField": ""        // the field used to group data
  }
```

#### StackedColumn

```js
  {
    "xField": "",           // the field to use on the x-axis
    "yField": "",           // the field to use on the y-axis
    "stackField": ""        // the field used for stacking data
  }
```

#### RangeColumn

```js
  {
    "xField": "",           // the field to use on the x-axis
    "yField": ""            // the field to use on the y-axis
  }
```

#### Line

```js
  {
    "xField": "",           // the field to use on the x-axis
    "yField": ""            // the field to use on the y-axis
  }
```

#### StepLine

```js
  {
    "xField": "",           // the field to use on the x-axis
    "yField": ""            // the field to use on the y-axis
  }
```

#### Area

```js
  {
    "xField": "",           // the field to use on the x-axis
    "yField": ""            // the field to use on the y-axis
  }
```

#### StackedArea

```js
  {
    "xField": "",           // the field to use on the x-axis
    "yField": "",           // the field to use on the y-axis
    "stackField": ""        // the field used for stacking data
  }
```

#### Bar

```js
  {
    "xField": "",           // the field to use on the x-axis
    "yField": ""            // the field to use on the y-axis
  }
```

#### StackedBar

```js
  {
    "xField": "",           // the field to use on the x-axis
    "yField": "",           // the field to use on the y-axis
    "stackField": ""        // the field used for stacking data
  }
```

#### GroupedBar

```js
  {
    "xField": "",           // the field to use on the x-axis
    "yField": "",           // the field to use on the y-axis
    "groupField": ""        // the field used to group data
  }
```

#### RangeBar

```js
  {
    "xField": "",           // the field to use on the x-axis
    "yField": ""            // the field to use on the y-axis
  }
```

#### Pie

```js
  {
    "angleField": "",       // the field representing the size of a pie slice
    "colorField": ""        // the field representing the labels of the pie slices
  }
```
