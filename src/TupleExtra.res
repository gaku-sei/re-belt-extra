@@ocaml.doc("Extra functions for the tuple2 and tuple3 types.
We call Tuple2 tuples that carry 2 values, and Tuple3 tuples that carry 3 values.
In general if a structure contains more than 3 values it's considering having a record type instead.")

module Tuple2 = {
  @ocaml.doc("Get the first element of a Tuple2")
  let first = ((a, _)) => a

  @ocaml.doc("Get the second element of a Tuple2")
  let second = ((_, b)) => b

  @ocaml.doc("Maps the first value of a Tuple2

  ```
  assert ((1, 2)->mapFirst(x => x * 3) == (3, 2))
  ```
  ")
  let mapFirst = (f, (a, b)) => (f(a), b)

  @ocaml.doc("Maps the second value of a Tuple2

  ```
  assert ((1, 2)->mapSecond(x => x * 3) == (1, 6))
  ```
  ")
  let mapSecond = (f, (a, b)) => (a, f(b))

  @ocaml.doc("Converts a Tuple2 to an array

  ```
  assert ((1, 2)->toArray == [1, 2])
  ```
  ")
  let toArray = ((a, b)) => [a, b]

  @ocaml.doc("Makes a Tuple2 from 2 values.
  Convenient when used with functions partial application.
  _Prefer tuple literal when possible._

  ```
  assert (make(1, 2) == (1, 2))
  ```
  ")
  let make = (a, b) => (a, b)
}

module Tuple3 = {
  @ocaml.doc("Get the first element of a Tuple3")
  let first = ((a, _, _)) => a

  @ocaml.doc("Get the second element of a Tuple3")
  let second = ((_, b, _)) => b

  @ocaml.doc("Get the third element of a Tuple3")
  let third = ((_, _, c)) => c

  @ocaml.doc("Maps the first value of a Tuple3

  ```
  assert ((1, 2, 3)->mapFirst(x => x * 3) == (3, 2, 3))
  ```
  ")
  let mapFirst = (f, (a, b, c)) => (f(a), b, c)

  @ocaml.doc("Maps the second value of a Tuple3

  ```
  assert ((1, 2, 3)->mapSecond(x => x * 3) == (1, 6, 3))
  ```
  ")
  let mapSecond = (f, (a, b, c)) => (a, f(b), c)

  @ocaml.doc("Maps the third value of a Tuple3

  ```
  assert ((1, 2, 3)->mapThird(x => x * 3) == (1, 2, 9))
  ```
  ")
  let mapThird = (f, (a, b, c)) => (a, b, f(c))

  @ocaml.doc("Converts a Tuple3 to an array

  ```
  assert ((1, 2, 3)->toArray == [1, 2, 3])
  ```
  ")
  let toArray = ((a, b, c)) => [a, b, c]

  @ocaml.doc("Makes a Tuple3 from 3 values.
  Convenient when used with functions partial application.
  _Prefer tuple literal when possible._

  ```
  assert (make(1, 2, 3) == (1, 2, 3))
  ```
  ")
  let make = (a, b, c) => (a, b, c)
}
