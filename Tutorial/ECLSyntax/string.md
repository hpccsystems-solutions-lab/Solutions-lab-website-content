# STRING
STRING data type is a sequence of characters, digits, and special characters including space. STRINGs are wrapped in  single quotation (' ').

## Syntax 

```java
STRING[n] attribName
```

|*Value*|*Definition*|
|:------|:---------|
STRING | Optional.
[n] | Optional, if omitted, the string will store entire value.
attribName | The name by which the variable will be invoked.

<br>

#### Example

</br>
<pre id = 'String_Exp_1'>

```java

/*
STRING Example:
Examples of defining string values, concatenation, and using them in OUTPUT.
*/

Address := '123 Main Rd, ATL, 30300, USA.';
OUTPUT(Address, NAMED('Address'));

// Defining sting vale with defined length
STRING8 Addr := '123 Main Rd, ATL, 30300, USA.';
OUTPUT(Addr, NAMED('Addr'));

// String concatenation 
STRING FirstName := 'Sun';
STRING LastName  := 'Shine';

OUTPUT(FirstName + ' ' + LastName, NAMED('Concatenation'));
```

</pre>
<a class="trybutton" href="javascript:OpenECLEditor(['String_Exp_1'])"> Try Me </a>

</br>
</br>
