@@ocaml.doc("Safe NonEmptyArray implementation that comes with no cost at runtime.
You must use the fromArray, or pure functions to create a NonEmptyArray.")

@ocaml.doc("The main type of non empty array")
type t<'a>

@ocaml.doc("Init a non empty array with one value

```
let: t<int> = fromValue(1)
```
")
let fromValue: 'a => t<'a>

@ocaml.doc("Turns a non empty array to an array, no conversion and no runtime costs are involved")
let toArray: t<'a> => array<'a>

@ocaml.doc("Tries to convert an array to a non empty array.
While there is no conversion,
the operation comes with a very small runtime cost checking the length of the provided array.")
let fromArray: array<'a> => option<t<'a>>

@ocaml.doc("Returns the length of the non empty array, guaranteed to be greater or equal to 1")
let length: t<'a> => int

@ocaml.doc("Identical to the Js.Array2.some function but for non empty arrays")
let some: (t<'a>, 'a => bool) => bool

@ocaml.doc("Identical to the Js.Array2.concat function but for non empty arrays")
let concat: (t<'a>, t<'a>) => t<'a>

@ocaml.doc("Identical to the Js.Array2.reduce function but for non empty arrays.
The argument order is flipped for readability.")
let reduce: (t<'a>, 'b, ('b, 'a) => 'b) => 'b

@ocaml.doc("Identical to the Js.Array2.map function but for non empty arrays")
let map: (t<'a>, 'a => 'b) => t<'b>

@ocaml.doc("Takes a value and an array (that can be empty) and builds a type safe non empty array")
let make: ('a, array<'a>) => t<'a>

@ocaml.doc("Takes a non empty array and a predicate function.
Calls the predicate function and returns `Some(index)` if said function returns true,
returns `None` if there is no match.

```
let xs = make(1, [2, 3])

assert (xs->findIndex(x => x == 2) == Some(1))

assert (xs->findIndex(x => x == 5) == None)
```
")
let findIndex: ('a => bool, t<'a>) => option<int>

@ocaml.doc("Returns the first element of a non empty array.
Unlike normal arrays, non empty arrays first value is guaranteed to exist at runtime and compile time.

```
assert (make(1, [2, 3])->first == 1)

assert (make(2, [])->first == 2)
```
")
let first: t<'a> => 'a

@ocaml.doc("Returns the last element of a non empty array.
Unlike normal arrays, non empty arrays last value is guaranteed to exist at runtime and compile time.

```
assert (make(1, [2, 3])->last == 3)

assert (make(2, [])->last == 2)
```
")
let last: t<'a> => 'a
