# might

hypothetically, some value

effects for madlib

based on purescript-effect

[![Madlib Project Badge](https://img.shields.io/badge/madlib-purple?logo=github&logoSize=auto)](//github.com/madlib-lang/madlib) <!-- $MADLIB.projectBadge -->
[![might v0.0.1](https://img.shields.io/badge/v0.0.1-purple?label=version)](//github.com/brekk/might) <!-- $MADLIB.json.version -->

---

## Why use `might`?

### Problem

Madlib is eager. A function that performs an effect does so at call-time. Effects cannot be passed around as values.

```madlib
import IO from "IO"

greet = (name) => IO.putLine("hello " ++ name)

twice = (value) => {
  IO.pTrace("unit", value)
  return value
}
main = () => {
  twice(greet("there"))
}
```

`greet` is a side effect. `greet("there")` runs it and prints "hello there". `twice` receives nothing / the unit `{}` value. You can't repeat, reorder or delay things from `twice`. The above would only print once.

### Solution

An effect is wrapped in a thunk. Building it does nothing, but it can be `run` to perform the actual effect.

```madlib
import IO from "IO"
import Might from "might"

greet = (name) => Might.Might(() => greet(name))

twice = (value) => do {
  _ <- value
  return value
}

main = () => {
  Might.run(twice(greet("world")))
}
```

This prints twice. With `might`, effects are values can be created, composed, transformed and passed around. They are lazy and execute only when invoked with `Might.run`

This power lends itself to modeling any process which has otherwise opaque side-effects, giving users more control over both the effect and the accuracy of the representation.

### Modeling mutable values

We can use `might`'s `Baton` module to provide a mutable value that is read and written through a `Might` instance.

```madlib
import IO from "IO"
import Might from "might"
import Baton from "might/Baton"

twice = (value) => do {
  _ <- value
  return value
}

main = () => {
  IO.pTrace(
    "RAW",
    Might.run(
      do {
        n <- Baton.might(0)
        built = twice(Baton.changeDrop((c) => c + 1, n))
        // 0: built, not run
        before <- Baton.grab(n)
        _ <- built
        // 2
        after <- Baton.grab(n)
        return Might.mighty(#[before, after])
      },
    ),
  )
}
```
