# Module

## Quick Look

Is a container that allows you to group related definitions. The parameters passed to the module are shared by all the related members definitions.\
Output can't be used within a module.

Notes:

- For modules to be called/used from outside, `EXPORT` is required.
- Module name should match the file name. if not "Error: Definition must contain EXPORT or SHARED " is generated.
- to call a module: `ModuleName.attributeName;`

### Variable Scope

**LOCAL** definitions are visible only up to an EXPORT or SHARED.\
**SHARED** definitions are visible through module.\
**EXPORT** definitions are visible within and outside of a module.

Modules can contain multiple, SHARED and EXPORT values.

```java
EXPORT modulename [ ( parameters ) ] := MODULE
    ...
    SHARED
    ...
    ...
    EXPORT
END
```

```java
myMod := MODULE
   SHARED x := 12;
   STRING str := 'abc';

   EXPORT result  := x * 12;
   EXPORT printIt := 'Mod is used';
END;

//Calling it
myMod.printIt();
```

Put it into practice

- To create a module: [simpleModule.ecl](https://ide.hpccsystems.com/workspaces/share/291d17d9-e5cb-4fac-83c2-ac5997c28a31)
- To call a module: [simpleModuleCall.ecl](https://ide.hpccsystems.com/workspaces/share/291d17d9-e5cb-4fac-83c2-ac5997c28a31)
