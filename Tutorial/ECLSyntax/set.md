## SET 

SET converts values from a field/column in a `dataset` to a [SET OF](.\setof.md). SET can also be defined in brackets [ ] without need of a dataset.

Keep in mind that SET doesn't order the list nor it will remove duplicates.

## Syntax
```java
attr_name := SET(dataset_name, field_name)
attr_name := SET[val1, val2, .... , valn]
```


#### Example

<br>
<pre id="SetExp_1">

```java
// A set of strings
NameSet := ['alex', 'Joe', 'Sam']; 
OUTPUT(NameSet, NAMED('NameSet'));

// A set of integers
NumSet  := [56, -100, -96, 89, -100]; 
OUTPUT(NumSet, NAMED('NumSet'));

// A string definition can be in a set
StreetType := 'street';
StreetSet  := ['st', 'ct', 'dr', 'cir', streetType, 'blvd'];
OUTPUT(StreetSet, NAMED('StreetSet'));


CountRes := COUNT(1,2,3,3,3);
IntSet   := [9, 12, countRes];
OUTPUT(IntSet, NAMED('IntSet'));

```
</pre>
<a class="trybutton" href="javascript:OpenECLEditor(['SetExp_1'])"> Try Me </a>

### Covering dataset field to SET

**Demo Dataset**

|City|State|County|Population|
|:----|:---|:---|:----|
Dauphin Island |AL|Mobile|1335
Guy|AR|Faulkner|778
El Centro|CA|Imperial|111425
Indio|CA|Riverside|417059
Englewood|CO|Arapahoe|6183
Keywest|FL|Monroe|31401


#### Example

<br>
<pre id="SetExp_2">

```java
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
                {'Keywest','FL','Monroe',31401}
                 ], Pop_Layout);

// Converting a field to SET
CitySet := SET(Pop_DS, City);
OUTPUT(CitySet, NAMED('CitySet'));
```
</pre>
<a class="trybutton" href="javascript:OpenECLEditor(['SetExp_2'])"> Try Me </a>

