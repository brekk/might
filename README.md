# might

hypothetically, some value

effects for madlib

based on purescript-effect

[![Madlib Project Badge](https://img.shields.io/badge/madlib-purple?logo=github&logoSize=auto)](//github.com/madlib-lang/madlib) <!-- $MADLIB.projectBadge -->
[![might v0.0.1](https://img.shields.io/badge/v0.0.1-purple?label=version)](//github.com/brekk/might) <!-- $MADLIB.json.version -->

---

## Might

A `Might` is used to model side-effects. It might be a value, if `run`. If it's not run, it remains hypothetical.

```madlib_
hypotheticallyFive = mighty(5)
actuallyFive = run(hypotheticallyFive)
```

A `Might` obeys the monadic laws you'd hope and expect.

```madlib_
map((x) => x * 2, mighty(5)) // Might({} -> 10)
ap(mighty((x) => x * 2), mighty(5)) // Might({} -> 10)
chain(of((x) => x * 2), mighty(5)) // Might({} -> 10)
mighty(["hell"]) ++ mighty(["yes"]) // Might({} -> ["hell", "yes"])
```

You can use the additional Might API functions, such as `until`, `whileM`, `for`, `forEach` to model effectful value operations. See the tests for more details.

## Baton

A `Baton` is a mutable value, used to model mutation in concert with a `Might`.

See `MightWithBaton.spec.mad` for more comprehensive usage details.
