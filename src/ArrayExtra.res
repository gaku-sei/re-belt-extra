@ocaml.doc("Takes an array, and return an array of tuple containing the value and the index

```
assert ([\"foo\", \"bar\"]->zipWithIndex == [(\"foo\", 0), (\"bar\", 1)])
```
")
let zipWithIndex = xs => xs->Array.zip(Array.range(0, xs->Js.Array2.length - 1))

@ocaml.doc("Takes an array and a predicate function.
Calls the predicate function and returns `Some(index)` if said function returns true,
returns `None` if there is no match.

```
assert ([1, 2, 3]->findIndex(x => x == 2) == Some(1))

assert ([1, 2, 3]->findIndex(x => x == 5) == None)
```
")
let findIndex = (xs, pred) =>
  xs->zipWithIndex->Js.Array2.find(((x, _)) => pred(x))->Option.map(TupleExtra.Tuple2.second)

@ocaml.doc("Init an array with one value

```
assert (fromValue(1) == [1])
```
")
let fromValue = x => [x]

@ocaml.doc("Safer alternative to Js.Array2.includes, where you can provide a custom equal function.
Especially useful when you need to check for objects equality,
or if you need loose equality (comparing blank strings for instance).
_Providing the equality function is strongly encouraged, especially for non trivial types._

```
// By default this function call:
assert ([1, 2]->includes(1) == true)

// Is equivalent to this:
assert ([1, 2]->includes(~eq=(x, y) => x == y, 1) == true)
```

You can use your own equality logic

```
assert (
  [\"  \"]->includes(
    ~eq=(x, y) => x->Js.String2.trim == y->Js.String2.trim,
    \"\",
  )
  == true)
```
")
let includes = (xs, ~eq=(x, y) => x == y, y) => xs->Js.Array2.some(x => x->eq(y))

@ocaml.doc("Takes n element from an array. Smart alias for the Js.Array2.slice function

```
assert ([1, 2, 3, 4]->take(2) == [1, 2])
```

Negative indexes, or 0, will return an empty array

```
assert ([1, 2, 3, 4]->take(0) == [])
assert ([1, 2, 3, 4]->take(-100) == [])
```
")
let take = (xs, n) => n <= 0 ? [] : xs->Js.Array2.slice(~start=0, ~end_=n)

@ocaml.doc("Drops the first n elements from an array.
If n > length, returns an empty array,
if n is negative, returns the provided array

```
assert ([1, 2, 3, 4]->drop(2) == [3, 4])

assert ([1, 2, 3, 4]->drop(0) == [1, 2, 3, 4])

assert ([1, 2, 3, 4]->drop(4) == [])
```
")
let drop = (xs, n) =>
  switch n {
  | _ if n <= 0 => xs
  | _ if n > Js.Array2.length(xs) => []
  | _ => Js.Array2.slice(xs, ~start=n, ~end_=Js.Array2.length(xs))
  }

@ocaml.doc("Takes an array, optionally an equal function, and the element to remove from the array.
To provide your own equality function is especially useful when you need to check for objects equality,
or if you need loose equality (comparing blank strings for instance).
_Providing the equality function is strongly encouraged, especially for non trivial types._

```
// By default this function call:
assert ([1, 2]->remove(1) == [2])

// Is equivalent to this:
assert ([1, 2]->remove(~eq=(x, y) => x == y, 1) == [2])
```

You can use your own equality logic

```
assert (
  [\"  \", \"foo\"]->remove(
    ~eq=(x, y) => x->Js.String2.trim == y->Js.String2.trim,
    \"\",
  )
  == [\"foo\"])
```
")
let remove = (xs, ~eq=(x, y) => x == y, y) => xs->Js.Array2.filter(x => !eq(x, y))

@ocaml.doc("Returns true if an array is empty, false otherwise")
let isEmpty = xs => xs->Js.Array2.length == 0

@ocaml.doc("Maps over an array applying the provided function, the function is expected to return an array that will be flattened.
  
```
assert ([1, 2, 3]->flatMap(x => [x, x + 1]) == [1, 2, 2, 3, 3, 4])
```
")
let flatMap = (xs, f) => xs->Js.Array2.reduce((acc, x) => acc->Js.Array2.concat(f(x)), [])

@ocaml.doc("Flattens an array of arrays

```
assert ([[1, 2], [3]]->flatten == [1, 2, 3])
```
")
let flatten = xs => xs->flatMap(FunctionExtra.id)

@ocaml.doc("Takes a array and a separator, and insert the separator between each element of the array
  
```
assert ([\"foo\", \"bar\"]->intersperse(\"and\") == [\"foo\", \"and\", \"bar\"])
```
")
let intersperse = (xs, sep) =>
  xs->zipWithIndex->flatMap(((x, index)) => index == 0 ? [x] : [sep, x])

@ocaml.doc("Returns the last element of an array. Returns `None` if the array is empty

```
assert ([]->last == None)

assert ([1, 2, 3]->last == Some(3))
```
")
let last = xs => xs[Js.Array2.length(xs) - 1]

@ocaml.doc("Returns a tuple: the list excluding the last element, and the last element

```
assert (viewR([1, 2, 3]) == Some([1, 2], 3))
```
")
let viewR = xs =>
  xs[Js.Array2.length(xs) - 1]->Option.map(l => (
    xs->Array.slice(~offset=0, ~len=Js.Array2.length(xs) - 1),
    l,
  ))

@ocaml.doc("Interleave 2 arrays, the returned array length will always be equal
to the sum of the length of the 2 provided arrays.

```
assert ([1, 3]->interleave([2, 4]) == [1, 2, 3, 4])
```

Arrays can have a different length

```
assert ([]->interleave([1, 2]) == [1, 2])

assert ([]->interleave([]) == [])

assert ([1, 2]->interleave([]) == [1, 2])
```
")
let interleave = (xs, ys) => {
  switch (xs, ys) {
  | ([], []) => []
  | ([], ys) => ys
  | (xs, []) => xs
  | (xs, ys) =>
    let minLength = min(Js.Array2.length(xs), Js.Array2.length(ys))
    let rear = drop(Js.Array2.length(xs) < Js.Array2.length(ys) ? ys : xs, minLength)

    Array.zipBy(xs, ys, (x, y) => [x, y])->flatten->Js.Array2.concat(rear)
  }
}

@ocaml.doc("Will keep only some values in a array of options

```
assert ([Some(1), None, Some(2)]->ArrayExtra.keepSomes == [1, 2])
```
")
let keepSomes = xs => xs->Array.keepMap(x => x)

@ocaml.doc("Safely gets an element from an array, alias for the `[]` operator.
_You should use the `[]` operator as often as you can instead, and use this only in pipeline context_


```
assert ([1, 2, 3]->get(0) == Some(1))

assert ([1, 2, 3]->get(5) == None)
```
")
let get = (xs, index) => xs[index]

@ocaml.doc("Returns the first element of an array.
_You should use the `[0]` operator as often as you can instead, and use this only in pipeline context_")
let first = xs => xs[0]
