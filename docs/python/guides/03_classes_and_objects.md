# Python Learning Path — Part 3: Classes & Objects

Defining your own custom data types. Working example:

```python
class Dog:
    def __init__(self, name):
        self.name = name

    def bark(self):
        return f"{self.name} says woof!"
```

- **class** — A blueprint for creating things. `class Dog:` defines what every dog will have (a name) and be able to do (bark). It doesn't create an actual dog by itself.
- **object / instance** — An actual thing built from a class. `rex = Dog("Rex")` creates one instance of `Dog`.
- **method** — A function that lives inside a class and belongs to its objects. `bark` is a method; you call it on an instance: `rex.bark()`.
- **`__init__`** — A special method that runs automatically the moment you create an instance (`Dog("Rex")` triggers it). It's where you set up the object's starting data.
- **dunder** — Short for "double underscore." `__init__` is a dunder method. Python reserves this `__name__` pattern for special methods it recognizes and calls automatically — it's a naming convention that signals "Python-internal", not something you invent yourself for ordinary methods.
- **`self`** — Refers to "the specific object this method was called on." Every method automatically receives it as the first parameter (e.g. `(self, name)`). You never pass it yourself — Python fills it in for you when you call `rex.bark()`.
- **attribute** — A variable that belongs to an object, e.g. `rex.name`. Usually set inside `__init__`.
- **`self.name = name`** — Takes the `name` value passed in and stores it on the object as an attribute, so it sticks around and can be read later via `rex.name`.
