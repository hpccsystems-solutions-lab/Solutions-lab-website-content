# Coding Best Practices

Imagine you inherit a project that multiple people have worked on it in the past. There are new features to be added, you are asked to add these new futures and present the code and result to customer. Excited about your new project and having a chance to present the result to your managers and customers, you start looking into code and face your new nightmare!

Every person that has worked on this code, followed their own style, rarely you see a comment added, and you hardly know where the code starts and finishes, yet you need to understand this code and present it. Welcome to the world of coding with no common standards to follow!
Maintaining these massive projects, adding new features, or finding bugs are really painful. These projects tends to get so messy that no body wants to look at them, and this is why common best practices are important for all organizations and developers to follow.

# General Principals

## Consistency

Try to use the same standards all over your work, regardless of the size or importance of the work.

## Meaningful Name

Use names that if you come back to your code six month from today, those names can help you remember what you did. Avoid foo, boo, testthis, somefeatures, etc.

## Be Polite

Mad at your code not working? don't add your anger to code while creating new items. Remember your boss might see them during code review!

## Use spaces

Spaces are fantastic for readability, use new lines, add spaces between your parameters. Do your best not to put very thing in one line. Also, putting code in multiple lines will omit the constant left and right scrolling. Let's look at following and find out which one is easier to read.

```java
denorm := DENORMALIZE(preppedParents,childrenDS,LEFT.lname = RIGHT.lname,TRANSFORM(ParentChildLayout1,SELF.children := LEFT.children + ROW({RIGHT.fname, RIGHT.age}, EmbeddedChildLayout),SELF := LEFT));
```

```java
addChildren := DENORMALIZE
    (
        ParentsDS,
        childrenDS,
        LEFT.lname = RIGHT.lname, //match on last name
        TRANSFORM
            (
                ParentChildLayout,
                SELF.children := LEFT.children + ROW({RIGHT.fname, RIGHT.age}, EmbeddedChildLayout),
                SELF := LEFT
            )
    );
```

## Update Comments

Try to add as many comments as possible. Update the old comments if needed. The code is making sense to you, how about the junior who is going to maintain it after you?

## Positive Name

how about using isDefined, or isEnabled instead of notDefined, or notCounted?

## Folder Name

Use CamelCap for naming folders:
`C://AddressMapping/MainFeatures/StreetMap`

## File Name

start wit lowercase:
`StreetMap/checkStreetName.ecl`
`StreetMap/addNewStreet.ecl`

## Separate for Simplicity

Too many things in one statement can be confusing, and sometimes hard to trace. Try to break the code.

```java
res := COUNT(Property((Property.Bedrooms = 3 AND
(size(Property.bathrooms) BETWEEN 1 AND 3))
 OR  EXISTS(homePrice((homePrice.Bedrooms = 3 AND
 (size(homePrice.price)BETWEEN 1 AND 3))))));
```

We can break this code into smaller pieces and make it easier to read.

```java
isBedBathGood := propertyDS.bedrooms = 3 AND
                      (getSize(propertyDS.bathrooms) BETWEEN 1 AND 3);

isPriceGood   := homePrice(homePrice.bedrooms = 3 AND
                      (getSize(homePrice.price)BETWEEN 1 AND 3));

isHouseGood   := COUNT(IsBedAndYearGood OR EXISTS(IsTaxBedYearGood));
```

## Reserved keyword

For reserved keywords, use all caps `EXPORT`, `TRANSFORM`.

## Indention

For better readability, use the same principal applied in Python for alignment.
