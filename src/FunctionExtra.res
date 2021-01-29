@@ocaml.doc("Some useful functions that can be used globally in an app")

@ocaml.doc("Takes 2 params and returns the first one only, discarding the second one

```
assert (const(1, 2) == 1)
```

Works with any types

```
assert (const(\"foo\", true) == \"foo\")
```
")
let const: 'a 'b. ('a, 'b) => 'a = (a, _) => a

@ocaml.doc("Takes a param and returns it

```
let initialArray = [1, 2, 3]

let identicalArray = initialArray->Js.Array2.map(id)

assert (initialArray == identicalArray)
```
")
let id: 'a. 'a => 'a = a => a
