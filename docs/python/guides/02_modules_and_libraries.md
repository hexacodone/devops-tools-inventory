# Python Learning Path — Part 2: Modules & Libraries

Organizing code into files, and using code other people wrote. Grounded in `temp/detection_rule.py`.

- **module** — A single `.py` file, treated as one importable unit. `detection_rule.py` is a module; other files do `from detection_rule import DetectionRule` to reuse it.
- **library / package** — A bundle of pre-written modules you install and reuse instead of writing yourself. `pydantic` is a library — someone else wrote it, published it, and you `pip install pydantic` to use it.
- **how libraries work** — Install once (`pip install pydantic`) into your environment, then `import` it in any script. The library's code isn't copied into your file — Python finds it in the environment (e.g. your venv's `site-packages/`) at run time and runs it from there. You only see the parts it exposes (its classes/functions), not its internals, unless you go read its source yourself.
- **pydantic** — A library for defining **schemas** as Python classes, and getting automatic data validation for free. Instead of manually checking "is this field a string, is that field missing," you declare the shape once (a class inheriting from `BaseModel`) and Pydantic checks incoming data against it.
- **schema** — A definition of the expected *shape* of data: which fields must exist, and what type each one is. `DetectionRule` is a schema for "what a valid detection-rule YAML file must contain." It doesn't hold real data itself — it's the rulebook data gets checked against.
