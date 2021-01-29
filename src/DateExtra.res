@@ocaml.doc("Extra functions for the date type")

@ocaml.doc("Safe date parse function that relies solely on the native API.
Returns `None` if the provided string is invalid")
let fromString = str =>
  try {
    let date = Js.Date.fromString(str)

    date->Js.Date.getTime->Js.Float.isNaN ? None : Some(date)
  } catch {
  | _ => None
  }

@ocaml.doc("Works the same way as `fromString`, but accepts a `Js.Json.t` value instead
_The json value should be a string at runtime._")
let fromJson = json => json->Js.Json.decodeString->Option.flatMap(fromString)

@ocaml.doc("Get the full year as a string")
let getFullYear = date => date->Js.Date.getFullYear->Float.toString

@ocaml.doc("Get the month as a string.
_Notice that unlike the native API this function is one-based and return the actual month!_
See https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/getMonth for more")
let getMonth = date => date->Js.Date.getMonth->(month => month +. 1.0)->Float.toString

@ocaml.doc("Get the day as a string")
let getDate = date => date->Js.Date.getDate->Float.toString

@ocaml.doc(
  "Get the hours as a string of length 2. If the value is `2`, the function will return `\"02\"`"
)
let getHours = date =>
  date->Js.Date.getHours->Float.toString->StringExtra.padStart(~targetLength=2, ~padString="0")

@ocaml.doc(
  "Get the minutes as a string of length 2. If the value is `8`, the function will return `\"08\"`"
)
let getMinutes = date =>
  date->Js.Date.getMinutes->Float.toString->StringExtra.padStart(~targetLength=2, ~padString="0")

@ocaml.doc("The full date type, carries the year, month, and date (day)")
type fullDate = {year: string, month: string, date: string}

@ocaml.doc("Takes a date and returns a `fullDate` type.

```
let {date, month, year} = myDate->getFullDate
```")
let getFullDate = date => {year: getFullYear(date), month: getMonth(date), date: getDate(date)}

@ocaml.doc("The full date time type, carries the year, month, date (day), hour, and minute")
type fullDateTime = {year: string, month: string, date: string, hour: string, minute: string}

@ocaml.doc("Takes a date and returns a `fullDateTime` type.

```
let {minute, hour, date, month, year} = myDate->getFullDateTime
```")
let getFullDateTime = date => {
  year: getFullYear(date),
  month: getMonth(date),
  date: getDate(date),
  hour: getHours(date),
  minute: getMinutes(date),
}
