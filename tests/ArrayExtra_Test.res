open Jest
open! TestUtil.JestExtra
open Expect
open! TestUtil.ExpectExtra

describe("ArrayExtra", () => {
  describe("take", () =>
    testAll(
      "take n elements from xs",
      [
        ([], 0, []),
        ([1], 0, []),
        ([], -1, []),
        ([1], -1, []),
        ([1], 1, [1]),
        ([1, 2], 2, [1, 2]),
        ([1, 2, 3], 2, [1, 2]),
        ([1, 2, 3], 4, [1, 2, 3]),
      ],
      ((xs, n, expected)) => expect(xs->ArrayExtra.take(n))->toEqual(expected),
    )
  )

  describe("drop", () =>
    testAll(
      "drop n elements from the beginning of xs",
      [
        ([], 0, []),
        ([], -1, []),
        ([1], -1, [1]),
        ([1], 1, []),
        ([1], 2, []),
        ([1, 2], 1, [2]),
        ([1, 2, 3, 4], 2, [3, 4]),
      ],
      ((xs, n, expected)) => expect(xs->ArrayExtra.drop(n))->toEqual(expected),
    )
  )

  describe("flatMap", () =>
    testAll(
      "maps a function over an array, and flatten the result",
      [
        ([], x => [x], []),
        ([1, 2, 3], x => [x], [1, 2, 3]),
        ([], _ => [1], []),
        ([1, 2, 3], x => [x, x * 2], [1, 2, 2, 4, 3, 6]),
      ],
      ((input, f, expected)) => expect(input->ArrayExtra.flatMap(f))->toEqual(expected),
    )
  )

  describe("flatten", () => {
    testAll(
      "flatten an array of arrays",
      [
        ([[1, 2], [3], [4]], [1, 2, 3, 4]),
        ([[], [3], [4]], [3, 4]),
        ([[], [5, 6, 7], []], [5, 6, 7]),
      ],
      ((input, expected)) => expect(input->ArrayExtra.flatten)->toEqual(expected),
    )
  })

  describe("intersperse", () =>
    testAll(
      "intersperse a separator with a list's elements",
      [([], 0, []), ([1], 0, [1]), ([1, 2], 0, [1, 0, 2])],
      ((input, sep, expected)) => expect(input->ArrayExtra.intersperse(sep))->toEqual(expected),
    )
  )

  describe("interleave", () => {
    testAll(
      "interleave 2 arrays",
      [
        ([1, 2, 3, 8], [4, 5], [1, 4, 2, 5, 3, 8]),
        ([1, 2], [4, 5], [1, 4, 2, 5]),
        ([1], [4, 5, 6, 7], [1, 4, 5, 6, 7]),
        ([], [2, 3, 4], [2, 3, 4]),
        ([], [], []),
        ([1, 2], [], [1, 2]),
      ],
      ((xs, ys, expected)) => expect(ArrayExtra.interleave(xs, ys))->toEqual(expected),
    )
  })

  describe("keepSomes", () =>
    testAll(
      "keeps only some values",
      [
        ([], []),
        ([Some(1), None, Some(2)], [1, 2]),
        ([None, None], []),
        ([Some(1), Some(2)], [1, 2]),
      ],
      ((input, expected)) => expect(input->ArrayExtra.keepSomes)->toEqual(expected),
    )
  )
})
