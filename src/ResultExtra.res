@@ocaml.doc("Extra functions for the result type")

@ocaml.doc("Transforms a result to an option, dropping the error in the conversion.

```
assert (Ok(42)->toOption == Some(42))

assert (Error(\"An error occured\")->toOption == None)
```
")
let toOption = result =>
  switch result {
  | Error(_) => None
  | Ok(x) => Some(x)
  }

@ocaml.doc("Same as Result.map, but for error.
Can be useful when you need to discard or transform an error.

```
assert (Ok(42)->mapError(_ => \"Will not be called\") == Ok(42))

assert (
  Error(\"Ooops!\")->mapError(message => `${message} an error occured`) ==
    Error(\"Ooops! an error occured\")
)
```
")
let mapError = (result, f) =>
  switch result {
  | Error(error) => Error(f(error))
  | Ok(_) as ok => ok
  }
