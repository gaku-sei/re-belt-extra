open Jest
open! TestUtil.JestExtra
open Expect
open! TestUtil.ExpectExtra

describe("OptionExtra", () =>
  describe("take", () =>
    testAll(
      "take n elements from xs",
      [
        (None, None, None),
        (Some(1), None, Some(1)),
        (None, Some(1), Some(1)),
        (Some(1), Some(2), Some(1)),
      ],
      ((option1, option2, expected)) => expect(option1->OptionExtra.or(option2))->toEqual(expected),
    )
  )
)
