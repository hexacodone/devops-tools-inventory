# Python Learning Path — Part 1: Fundamentals

Values, collections, and small building blocks. Grounded in `temp/detection_rule.py`.

## Functions basics

- **`return`** — Ends a function/method immediately and hands a value back to whoever called it. Without `return`, a function gives back nothing useful.
- **f-string (`f"..."`)** — A string with an `f` right before the opening quote. Anything inside `{}` gets evaluated and inserted into the string, e.g. `f"{self.name} says woof!"` with `self.name == "Rex"` produces `"Rex says woof!"`.

## Collections — the four built-in containers

- **list** — An ordered, changeable sequence of values, written `[a, b, c]`. `VALID_LEVEL = ["informational", "low", "medium", "high", "critical"]` is a list.
- **tuple** — An ordered, *unchangeable* sequence, written `(a, b)`. Used when a group of values is fixed and returned together, e.g. `_detect_relationship` returns a `tuple[CustomizedRule, Path]` — always exactly two values, in that order.
- **dict** (dictionary) — Unordered key → value pairs, written `{"key": "value"}`. Looked up by key, not position, e.g. `RelatedField` data or a loaded YAML rule.
- **set** — An unordered collection of *unique* values, written `{a, b, c}`. Used when you only care "is this value in here at all," not order or duplicates: `RULE_NEEDS_VALIDATION_STATUS = {"production", "integration", "testing"}`.

## Comprehension

- **comprehension** — A one-line way to build a list/dict/set from another one, instead of writing a `for` loop that appends. `{k: None if v == "None" else v for k, v in d.items()}` builds a new dict by walking `d.items()` and transforming each pair.

## Error handling

- **`try` / `except`** — Runs code that might fail (`try:`), and if it raises an error, runs recovery code instead of crashing (`except:`). `is_valid_uuid` wraps `uuid.UUID(self.id)` in `try`/`except` because invalid input raises an error, and here that just means "return `False`" instead of crashing the program.

## Useful built-ins & methods

- **`isinstance(value, Type)`** — Checks whether a value is of a given type at runtime, returning `True`/`False`. Used in `get_sigma_fields` to check `isinstance(value, dict)` before treating something like a dict.
- **`getattr(obj, "name")`** — Fetches an attribute off an object using its name as a *string*, instead of writing `obj.name` directly. Lets you loop over a list of field names and check each one dynamically, as `has_required_fields` does.
- **`all(...)` with a generator expression** — `all(getattr(self, name) is not None for name in _REQUIRED_FIELDS)` reads as "is this condition true for every item in this list?" The part before `for` is checked for every item; `all()` returns `True` only if every check passed.
- **string/path methods** — `.split("|")[0]` splits a string into a list and takes the first piece; `.endswith("_isecng")` checks a string's ending. `pathlib.Path` objects have similar helpers: `.stem` (filename without extension), `.with_stem(...)` (same path, different filename), `.exists()` (is there really a file there).
