# 🐍 FastAPI Step 2: Path Parameters & Multiple Routes

> Extending our API with dynamic URLs and multiple endpoints

## 🎯 Goal of This Step
- Add multiple routes
- Use path parameters
- Different HTTP response codes

## 📋 What We Learn
- Path parameter syntax `{parameter}`
- Multiple `@app.get()` decorators
- Python type hints
- FastAPI's automatic validation

---

## 1. Extended App

**File: `main.py` (replace the entire contents)**
```python
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Hello World"}

@app.get("/hello/{name}")
def say_hello(name: str):
    return {"message": f"Hello {name}!"}

@app.get("/items/{item_id}")
def read_item(item_id: int):
    return {"item_id": item_id, "message": "Item found"}
```

---

## 2. Syntax Explanation - New Lines

### Route with a path parameter
```python
@app.get("/hello/{name}")
def say_hello(name: str):
    return {"message": f"Hello {name}!"}
```

**Line by line:**
- `"/hello/{name}"` = URL pattern with a **path parameter**
- `{name}` = variable part of the URL (like Go's `:name`)
- `name: str` = **type hint** - says "name is a string"
- `f"Hello {name}!"` = **f-string** - a string with a variable (like Go's fmt.Sprintf)

### Integer path parameter
```python
@app.get("/items/{item_id}")
def read_item(item_id: int):
    return {"item_id": item_id, "message": "Item found"}
```

**What's new:**
- `item_id: int` = **type hint** for an integer
- FastAPI **automatically validates** - only numbers are allowed!

---

## 3. Python Concepts Explained

### Type hints
```python
# Python type hints (since Python 3.5)
def function(parameter: typ) -> return_typ:
    pass

# Examples:
name: str        # String
item_id: int     # Integer  
price: float     # Float
is_active: bool  # Boolean
```

**Golang comparison:**
```go
// Go: types are mandatory
func sayHello(name string) string

// Python: type hints are optional, but recommended
def say_hello(name: str) -> str:
```

### f-strings (string formatting)
```python
name = "World"
message = f"Hello {name}!"  # → "Hello World!"

# Alternatives:
message = "Hello {}!".format(name)      # Older syntax
message = "Hello " + name + "!"         # String concatenation
```

**Golang comparison:**
```go
// Go
message := fmt.Sprintf("Hello %s!", name)

// Python f-string
message = f"Hello {name}!"
```

---

## 4. Testing the Server

**Is the server still running?** Then you'll see the changes automatically (thanks to `--reload`)!

### Testing the new routes:

```bash
# Hello route with a name
curl http://localhost:8000/hello/Max
# → {"message":"Hello Max!"}

curl http://localhost:8000/hello/Python
# → {"message":"Hello Python!"}

# Item route with a number
curl http://localhost:8000/items/42
# → {"item_id":42,"message":"Item found"}

curl http://localhost:8000/items/123
# → {"item_id":123,"message":"Item found"}
```

### Testing validation:
```bash
# This should produce an error:
curl http://localhost:8000/items/not-a-number
```

**Result:** FastAPI automatically returns a 422 validation error!

---

## 5. Automatic Documentation

Go to: http://localhost:8000/docs

**What do you see now?**
- 3 endpoints are automatically documented
- Path parameters are described
- You can test the API directly!

Click the **Try it out** button and enter different values.

---

## 6. Understanding URL Patterns

| URL | Pattern | Parameter | Value |
|-----|---------|-----------|------|
| `/hello/Max` | `/hello/{name}` | `name` | `"Max"` |
| `/hello/Python` | `/hello/{name}` | `name` | `"Python"` |
| `/items/42` | `/items/{item_id}` | `item_id` | `42` |
| `/items/abc` | `/items/{item_id}` | ❌ Error | - |

**FastAPI automatically does:**
- String parameter → String
- Int parameter → Integer + validation
- Error on wrong types

---

## 🔍 Python vs Golang - Comparison

| Python FastAPI | Golang Gin |
|----------------|------------|
| `@app.get("/hello/{name}")` | `r.GET("/hello/:name", handler)` |
| `name: str` | `c.Param("name")` |
| `f"Hello {name}!"` | `fmt.Sprintf("Hello %s!", name)` |
| Automatic validation | Manual validation |
| Type hints optional | Types mandatory |

---

## ✅ What Have We Learned?

- [x] **Path parameters** with `{parameter}` syntax
- [x] **Type hints** for automatic validation
- [x] **f-strings** for string formatting
- [x] **Multiple routes** in one app
- [x] **Automatic validation** and error handling

## 🤔 Test Your Understanding

1. **What happens with `/items/abc`?** (Hint: try it!)
2. **How would you add a float parameter?**
3. **What's the difference between `name: str` and `name`?**

## 🚀 Next Step

Step 3: **Query parameters** and **request body** (POST requests)

**Ready for Step 3, or questions about path parameters?**
