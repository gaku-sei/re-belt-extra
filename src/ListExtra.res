@@ocaml.doc("You probably don't need this module too often and should consider using Array instead.
This module provides some advanced functions to operate on Lists.")

@ocaml.doc("Takes a list, and return a list of tuple containing the value and the index

```
assert (list{\"foo\", \"bar\"}->zipWithIndex == list{(\"foo\", 0), (\"bar\", 1)})
```
")
let zipWithIndex = xs => xs->List.zip(List.fromArray(Array.range(0, xs->List.length - 1)))

@ocaml.doc("Maps over a list applying the provided function,
the function is expected to return a list that will be flattened.

```
assert (list{1, 2, 3}->flatMap(x => list{x, x + 1}) == list{1, 2, 2, 3, 3, 4})
```
")
let flatMap = (xs, f) => xs->List.reduce(list{}, (acc, x) => acc->List.concat(f(x)))

// The code is a translation of https://hackage.haskell.org/package/base-4.12.0.0/docs/src/Data.OldList.html#transpose
@ocaml.doc("The 'transpose' function transposes the rows and columns of its argument.

```
assert (list{list{1, 2, 3}, list{4, 5, 6}}->transpose == list{list{1, 4}, list{2, 5}, list{3, 6}})
```

If some of the rows are shorter than the following rows, their elements are skipped:
```
assert (
  list{list{10, 11}, list{20}, list{}, list{30, 31, 32}}->transpose ==
    list{list{10, 20, 30}, list{11, 31}, list{32}}
)
```
")
let rec transpose: list<list<'a>> => list<list<'a>> = x =>
  switch x {
  | list{} => list{}
  | list{list{}, ...xss} => transpose(xss)
  | list{list{x, ...xs}, ...xss} => list{
      list{x, ...xss->List.keepMap(List.head)},
      ...transpose(list{xs, ...xss->List.keepMap(List.tail)}),
    }
  }

@ocaml.doc("Returns true if the list is empty")
let isEmpty = xs =>
  switch xs {
  | list{} => true
  | _ => false
  }

@ocaml.doc("Takes a list and a separator, and insert the separator between each element of the list
  
```
assert (list{\"foo\", \"bar\"}->intersperse(\"and\") == list{\"foo\", \"and\", \"bar\"})
```
")
let intersperse = (xs, sep) =>
  xs->zipWithIndex->flatMap(((x, index)) => index == 0 ? list{x} : list{sep, x})
