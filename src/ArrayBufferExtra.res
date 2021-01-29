@@ocaml.doc("Additional functions for the buffer array structures")

@ocaml.doc("The TypedArray module type is used in the `toArray` function for conversion")
module type TypedArray = {
  type t

  let fromBuffer: Js.TypedArray2.ArrayBuffer.t => t

  let reduce: (t, (. 'b, int) => 'b, 'b) => 'b
}

@ocaml.doc("This function will convert a buffer array to an array.
A typed array module can be provided (Uint8 by default),
and will be used as a bottleneck during the conversion")
let toArray = (~typedArray=module(Js.TypedArray2.Uint8Array: TypedArray), array) => {
  module TypedArray = unpack(typedArray)

  array->TypedArray.fromBuffer->TypedArray.reduce((. acc, x) => acc->Js.Array2.concat([x]), [])
}
