# 🐍 FastAPI Step 1: Hello World

> We start with the absolute minimum - a working FastAPI app

## 🎯 Goal of This Step
Create a minimally working API that returns "Hello World".

## 📋 What We Learn
- FastAPI installation
- Minimal app structure
- Starting the server
- Testing the API

---

## 1. Installation & Setup

### Create a virtual environment
```bash
# Create a new folder
mkdir fastapi-todo
cd fastapi-todo

# Create a Python virtual environment
python -m venv venv

# Activate it (Linux/Mac)
source venv/bin/activate

# Activate it (Windows)
venv\Scripts\activate

# Verify it worked
which python  # should point into venv
```

### Install FastAPI
```bash
# Only the absolutely necessary packages
pip install fastapi uvicorn
```

---

## 2. Creating the Minimal App

**File: `main.py`**
```python
# Import FastAPI
from fastapi import FastAPI

# Create the app
app = FastAPI()

# Define a route
@app.get("/")
def read_root():
    return {"message": "Hello World"}
```

**That's it!** Just 6 lines of code.

---

## 3. Syntax Explanation - Line by Line

```python
from fastapi import FastAPI
```
- `from ... import ...` = Python's way of importing modules
- `FastAPI` = The main class for our API
- Similar to `import "github.com/gin-gonic/gin"` in Go

```python
app = FastAPI()
```
- `app` = Variable holding our FastAPI application
- `FastAPI()` = Creates a new FastAPI instance
- Similar to `r := gin.Default()` in Go

```python
@app.get("/")
```
- `@` = Python **decorator** (an important concept!)
- `app.get` = Defines a GET route
- `"/"` = The URL path (root/homepage)
- Similar to `r.GET("/", handler)` in Go

```python
def read_root():
```
- `def` = Python keyword for defining a function
- `read_root` = Function name (can be anything)
- `():` = No parameters, the colon starts the function block

```python
    return {"message": "Hello World"}
```
- `return` = Returns a value
- `{"key": "value"}` = Python dictionary (like JSON)
- Automatically converted to JSON

---

## 4. Starting the Server

```bash
# In the terminal (venv must be activated)
uvicorn main:app --reload

# What does that mean?
# uvicorn     = ASGI server (like Go's http.ListenAndServe)
# main        = Filename (main.py)
# app         = Variable in the file
# --reload    = Automatically restart on changes
```

**Output should be:**
```
INFO:     Uvicorn running on http://127.0.0.1:8000 (Press CTRL+C to quit)
INFO:     Started reloader process
```

---

## 5. Testing the API

### In the browser
Go to: http://localhost:8000

You should see:
```json
{"message":"Hello World"}
```

### With curl
```bash
curl http://localhost:8000
```

### Automatic documentation
FastAPI **automatically** generates API documentation!

Go to: http://localhost:8000/docs

That's **Swagger UI** - generated entirely automatically!

---

## 🔍 Python vs Golang - Comparison

| Python FastAPI | Golang Gin |
|----------------|------------|
| `@app.get("/")` | `r.GET("/", handler)` |
| `def function():` | `func handler(c *gin.Context)` |
| `return {"key": "value"}` | `c.JSON(200, gin.H{"key": "value"})` |
| Automatic JSON conversion | Manual JSON marshaling |
| Automatic docs | Swagger set up separately |

---

## ✅ What Have We Achieved?

- [x] A working FastAPI app
- [x] An HTTP GET endpoint
- [x] JSON response
- [x] Automatic API documentation
- [x] Development server

## 🤔 Questions to Check Your Understanding

1. **Decorator `@app.get("/")`**: Do you understand how it works?
2. **Return dictionary**: Why does `{"message": "Hello"}` automatically become JSON?
3. **uvicorn**: What's the difference to Go's built-in HTTP server?

## 🚀 Next Step

In the next step, we'll add a second route and learn about **path parameters**.

**Ready for Step 2, or do you have questions about this code?**
