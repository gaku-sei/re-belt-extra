@ocaml.doc("Type safe equality operator for ints, simple alias for the `==` operator")
let eq = (x: int, y: int) => x == y

@ocaml.doc("Safely convert a string to an int

```
assert (\"12\"->fromString == Some(12))

assert (\"12foo\"->fromString == None)

assert (\"foo\"->fromString == None)
```
")
let fromString = str =>
  switch str->Int.fromString {
  | None => None
  // This checks the strings that start with a number but still containing characters are not parsed
  | Some(x) when x->Int.toString->Js.String2.length != str->Js.String2.length => None
  | Some(x) => Some(x)
  }
