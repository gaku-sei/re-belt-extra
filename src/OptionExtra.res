@@ocaml.doc("Extra functions for the option type")

@ocaml.doc("Applies an option of function to an option of value, extracting both values.

```
let f = Some(x => x * 2)
let x = Some(21)

assert (f->apply(x) == Some(42))
```

It's especially useful when mapping several option values:

```
let f = (x, y) => x * y
let x = Some(21)
let y = Some(2)

assert (x->Option.map(f)->apply(y) == Some(42))
```
")
let apply = (f, option) =>
  switch (f, option) {
  | (Some(f), Some(option)) => Some(f(option))
  | _ => None
  }

// TODO: Find a better name
// See https://hackage.haskell.org/package/relude-0.7.0.0/docs/Relude-Functor-Fmap.html#v:flap
@ocaml.doc("Unlike apply, flap takes an option of function and a non option value.

```
let f = Some(x => x * 2)
let x = 21

assert (f->flap(x) == Some(42))
```

It's especially useful when mapping several option and non option values:

```
let f = (x, y, z) => x * y * z
let x = Some(10.5)
let y = 2.0
let z = Some(2.0)

assert (x->Option.map(f)->flap(y)->apply(z) == Some(42.0))
```
")
let flap = (f, x) => f->Option.map(f => f(x))

@ocaml.doc("Takes an option of option and returns a flat option.

```
assert (Some(Some(42))->flatten == Some(42))
```

`None` values will always return `None`:

```
assert (None->flatten == None)
assert (Some(None)->flatten == None)
```
")
let flatten = option =>
  switch option {
  | None => None
  | Some(option) => option
  }

@ocaml.doc("Takes 2 option values, and returns the first one that's not None.
If both values are None, returns None.

```
assert (Some(1)->or(Some(2)) == Some(1))

assert (None->or(Some(2)) == Some(2))

assert (None->or(None) == None)
```
")
let or = (option1, option2) =>
  switch (option1, option2) {
  | (Some(_), _) => option1
  | _ => option2
  }

@ocaml.doc("Transforms a `None` value to an empty array,
and a `Some(_)` to an array containing the value `x`

```
assert (Some(1)->toArray == [1])

assert (None->toArray == [])
```
")
let toArray = option =>
  switch option {
  | None => []
  | Some(x) => [x]
  }
