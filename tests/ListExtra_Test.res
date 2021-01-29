open Jest
open! TestUtil.JestExtra
open Expect
open! TestUtil.ExpectExtra

describe("ListExtra", () => {
  describe("transpose", () =>
    testAll(
      "transpose a list of lists",
      [
        (list{}, list{}),
        (list{list{}}, list{}),
        (list{list{}, list{}}, list{}),
        (list{list{1}, list{}}, list{list{1}}),
        (list{list{1}, list{3, 4}}, list{list{1, 3}, list{4}}),
        (list{list{1, 2, 3}, list{4, 5, 6}}, list{list{1, 4}, list{2, 5}, list{3, 6}}),
        (
          list{list{10, 11}, list{20}, list{}, list{30, 31, 32}},
          list{list{10, 20, 30}, list{11, 31}, list{32}},
        ),
      ],
      ((input, expected)) => expect(ListExtra.transpose(input))->toEqual(expected),
    )
  )

  describe("flatMap", () =>
    testAll(
      "maps a function over an list, and flatten the result",
      [
        (list{}, x => list{x}, list{}),
        (list{1, 2, 3}, x => list{x}, list{1, 2, 3}),
        (list{}, _ => list{1}, list{}),
        (list{1, 2, 3}, x => list{x, x * 2}, list{1, 2, 2, 4, 3, 6}),
      ],
      ((input, f, expected)) => expect(input->ListExtra.flatMap(f))->toEqual(expected),
    )
  )

  describe("intersperse", () =>
    testAll(
      "intersperse a separator with a list's elements",
      [(list{}, 0, list{}), (list{1}, 0, list{1}), (list{1, 2}, 0, list{1, 0, 2})],
      ((input, sep, expected)) => expect(input->ListExtra.intersperse(sep))->toEqual(expected),
    )
  )
})
