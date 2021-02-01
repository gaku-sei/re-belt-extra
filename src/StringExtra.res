@@ocaml.doc("Extra functions for the string type")

@ocaml.doc("Returns `true` if the string is empty")
let isEmpty = str => str == ""

@ocaml.doc("Returns `true` if the string is not empty")
let isNotEmpty = str => str != ""

@ocaml.doc("Returns `true` if a string is blank,
that is, if it contains only characters that can be trimmed.

```
assert (\"\"->isBlank == true)

assert (\"   \"->isBlank == true)

assert (\"foo\"->isBlank == false)
```
")
let isBlank = str => str->Js.String2.trim->isEmpty

@ocaml.doc("Returns `true` if a string is not blank,
that is, if it contains at least one character that can't be trimmed.

```
assert (\"    x     \"->isNotBlank == true)

assert (\"   \"->isNotBlank == false)

assert (\"\"->isNotBlank == false)
```
")
let isNotBlank = str => !(str->isBlank)

@ocaml.doc("Type safe equality operator for strings, simple alias for the `==` operator")
let eq = (str1: string, str2: string) => str1 == str2

@ocaml.doc("Will convert a provided string to an `option<string>` if said string is not empty.
Returns `None` if the string is empty.

```
assert (\"\"->toNonEmpty == None)

assert (\"foobar\"->toNonEmpty == Some(\"foobar\"))
```
")
let toNonEmpty = str => isEmpty(str) ? None : Some(str)

@ocaml.doc("Returns the character from a string at requested position.
Returns `None` if position is negative or if it's greater than the string's length.

```
assert (\"\"->charAt(0) == None)

assert (\"foo\"->charAt(0) == Some(\"f\"))

assert (\"foo\"->charAt(10) == None)
```
")
let charAt = (str, position) =>
  if position < str->Js.String2.length && position >= 0 {
    Some(Js.String2.charAt(str, position))
  } else {
    None
  }

@ocaml.doc("Repeat a string n times.

```
assert (\"foo\"->repeat(2) == \"foofoo\")
```
")
let repeat = (str, times) => Array.makeBy(times, _ => str)->Js.Array2.joinWith("")

@ocaml.doc("Simple bindings for the native `padStart` function.
_Doesn't work with all browsers._

See https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/padStart for more.

```
assert (\"2427\"->padStart(~targetLength=12, ~padString=\"*\") == \"********2427\")
```
")
@send
external padStart: (string, ~targetLength: int, ~padString: string) => string = "padStart"
