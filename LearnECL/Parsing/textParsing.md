# Text Parsing

Text or string parsing is finding records whose data contains a match for the pattern you defined. If the pattern finds multiple matches in the data, then a result record is generated for each match. Each match for a PARSE is effectively a single path through the pattern. If there is more than one path that matches, then the result transform is either called once for each path, or if the BEST option is used, the path with the lowest penalty is selected.

Let's look at some simple text parsing:

```java
str := DATASET([
         {'Recent advances in color matching have been driven by market demand.'},
         {'Improved shade guides, availability of shade-taking devices..'},
         {'color vision have improved to achieve excellent color-matched restorations.'},
         {'Colors are fun to play with.'},
         {'We can match colors like blue and whilt to have fun.'},
         {'When is comes to colors, shade matching is important.'}],
         {STRING val});
```

\
![color input ds](./Images/colorInput.JPG)
