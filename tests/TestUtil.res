module JestExtra = {
  @ocaml.doc("Similar to built-in testAll function, but accepts an array instead of a list")
  let testAll = (name, inputs) => Jest.testAll(name, inputs->List.fromArray)
}

module ExpectExtra = {
  @ocaml.doc("Flipped version on toEqual")
  let toEqual = (b, p) => Jest.Expect.toEqual(p, b)

  @ocaml.doc("Flipped version on toBe")
  let toBe = (b, p) => Jest.Expect.toBe(p, b)
}
