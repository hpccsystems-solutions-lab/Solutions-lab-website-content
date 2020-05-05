
# Dataset
## Quick Look
There are a few ways to generate output.

Using the following dataset, let's look at some examples
![record set example](./images/RecordLayout.JPG)


The layout for above dataset:

```java
//SalaryAvg is the name of layout.
SalaryAvg_Layout := RECORD
    STRING Job;
    STRING Category;
    STRING City;
    STRING2	State;
    INTEGER	Avg_Salary;
    INTEGER	LowerBand;
    INTEGER	Upperband;
END;

// creating an inline dataset
SalaryAvg_DS := DATASET([
                {'Manager', 'IT', 'Atlanta', 'GA', 87000, 62000, 114000},
                {'Director', 'IT', 'Atlanta', 'GA', 119000, 84000, 156000},
                {'Director', 'Art-Entertainment', 'Atlanta', 'GA', 100000, 70000, 133000},
                {'CIO', 'IT', 'Tampa', 'FL', '112000', '69000', 131000},
                {'Sales', 'General', 'Chicago', 'IL', 55000, 32000, 121000}
                ], SalaryAvg_Layout //Layout definition
                );

//Output with no lable, following will display the dataset without labling the output
OUTPUT(SalaryAvg_DS);


//Looking for an easier way :)
//Note: too many outputs with no lables, you won't know what you are looking at.
SalaryAvg_DS; 

//Let's see how we can lable them
OUTPTU(SalaryAvg_DS, NAMED('SalaryAvg_DS'));
```
![record set example](./images/filterOutput.JPG)

Put it into practice [output.ecl](/source/ecl/output.ecl)