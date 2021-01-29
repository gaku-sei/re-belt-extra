type t<'a> = array<'a>

let fromValue = x => [x]

external toArray: t<'a> => array<'a> = "%identity"

let fromArray = xs =>
  switch xs {
  | [] => None
  | xs => Some(xs)
  }

let length = xs => xs->Js.Array2.length

let some = (xs, pred) => xs->Js.Array2.some(pred)

let concat = (xs, ys) => xs->Js.Array2.concat(ys)

let reduce = (xs, default, f) => xs->Js.Array2.reduce(f, default)

let map = (xs, f) => xs->Js.Array2.map(f)

let make = (x, xs) => Array.concat([x], xs)

let findIndex = (pred, xs) => xs->toArray->ArrayExtra.findIndex(pred)

let first = xs => xs->toArray->ArrayExtra.first->Option.getExn

let last = xs => xs->toArray->ArrayExtra.last->Option.getExn
