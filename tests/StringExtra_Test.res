open Jest
open! TestUtil.JestExtra
open Expect
open! TestUtil.ExpectExtra

describe("StringExtra", () =>
  describe("charAt", () =>
    testAll(
      "return the char value when the requested position is valid",
      [
        ("", 0, None),
        ("", -1, None),
        ("", 1, None),
        ("foa", 0, Some("f")),
        ("foa", 2, Some("a")),
        ("foa", -1, None),
        ("foa", 3, None),
      ],
      ((str, position, expected)) => expect(str->StringExtra.charAt(position))->toEqual(expected),
    )
  )
)
