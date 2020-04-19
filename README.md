# EnvironmentVars_MTC

A Xojo class for handling environment variables

## What Is This?

Using environment variables in Xojo usually means creating constants with the variable name and possibly using a class or module that links those environment variables to properties. This project envisions a different way.

## Setting Up

Open the Harness project included here and copy the `EnvironmentVars_MTC` class to your project, then create a subclass. (For illustration, we'll call the subclass `MyEnvVars`.)

Add a Computed property to `MyEnvVars`, either Regular or Shared (more on this later), using the name of your environment variable exactly, then set the Get and Set methods like this:

```
Computed Property MY_ENV_VAR As String
Get
  return ValueFor( CurrentMethodName )

Set
  ValueFor( CurrentMethodName ) = value
	// ... or nothing here if it's read-only
```

(Those aren't placeholders for anything, you can copy-and-paste directly into your code editor.)

If your environment variable represents a Boolean value, you can use `BooleanValueFor` instead.

```
Computed Property MY_BOOL_VAR As Boolean
Get
  return BooleanValueFor( CurrentMethodName )

Set
  BooleanValueFor( CurrentMethodName ) = value
```

(If you prefer, you can start with one of the example subclasses included in the Harness project and rename those properties instead.)

To create new properties, duplicate an existing one and rename it with the environment variable name. That's it.

## Shared vs. Regular Computed Properties

You can add the Computed Property as either Regular (member of an instance) or Shared (member of the class). The advantage of using Shared is that you will not have to create an instance of your subclass to use it so the subclass will act like a module. For example:

```
MyEnvVars.SHARED_ENV_VAR = "1" // Shared Computed Property
MyEnvVars.REG_ENV_VAR = "2" // Compiler error!

dim vars as new MyEnvVars
vars.SHARED_ENV_VAR = "3" // Still works
vars.REG_ENV_VAR = "4" // Regular Computed Property requires instance
```

The Harness project has examples of each type.

## Advantages

The advantages of using this scheme are:

* Ease of setup. Once you've set up the first property, setting up the rest is just a matter of duplicate-and-rename.
* Ease of tracking. All of your environment variables are in one place and you can use the included methods to list or manipulate them (see below).
* Project visibility. Because the environment variables are linked to computed properties automatically, you can see them all listed in your project viewer and access them via auto-complete.

## Included Methods

`EnvironmentVars_MTC` includes functions that let you manipulate and list your environment variables. All of these require an instance of your subclass.

* `ClearWriteableVars()` will clear the values of any environment variables that includes a Set method.

* `GetDisplayValue(varName As String[, useUnsetValue As String[, useHiddenValue As String]]) As String` will let you access the display value of a given variable. (See below.) Use in conjunction wtih `GetVarNames`.

* `GetVarNames() As String()` will return a string array of the existing variable names. Use in conjunction with `GetDisplayValue`.

* `FromBoolean(value As Boolean[, valueSet As BooleanValueSets]) As String` is a **Shared** function that will convert a Boolean value to String using the given enum value as a guide. (YesNo is default, or TrueFalse or OneZero.) Use this directly if you want greater control of how Booelan values are stored.

* `ToBoolean(stringValue As String) As Boolean` is a **Shared** function that will interpret a string as a Boolean value. A string that is "y", "yes", "t", or "true", regardless of case, or any non-zero number will be intereted as True.

* `ToDictionary() As Dictionary` will return a Dictionary with the environment variable as the key linked to its value.

## Listing Variables

You may want to create of list of enviroment variables for display. For example, a "help" option might show the known environment variables and their values. You can use `GetDisplayValue` in conjuction with `GetVarNames` for this purpose.

### Getting A List

For example, the help screen in a console app might include a section like this:

```
dim vars as new MyEnvVars // Requires an instance

for each varName as string in vars.GetVarNames
  dim value as string = vars.GetDisplayValue( varName )
  print varName + " = " + value
next
```

The output might look something like this:

```
VAR1 = something
VAR2 = <NOT SET>
PW = <SET>
```

(The "set" and "unset" values can be optionally supplied to `GetDisplayValue`.)

### Hiding A Value

Notice in that example that the environment variable `PW` is listed as "\<SET\>" rather than its actual value? That's because it was configured to hide its value by adding the attribute "HideValue" to the property. `GetDisplayValue` will substitute "\<SET\>" (or whatever you specify) whenever it sees that attribute.

(A constant `kAttributeHideValue` has been included as a convenient reminder, even though it cannot be used directly.)

# License

See the included LICENSE file within the project.

# Comments and Contributions

All contributions to this project will be gratefully considered. Fork this repo to your own, then submit your changes via a Pull Request.

All comments are also welcome.

# Who Did This?!?

This project was created by and is maintained by Kem Tekinay (ktekinay@mactechnologies -dot- com).

# Release Notes

**1.0** (Apr. ___, 2020)

- Initial release.
