# 🐍 FastAPI Schritt 2: Path Parameter & Mehrere Routes

> Erweitern unsere API um dynamische URLs und mehrere Endpoints

## 🎯 Ziel dieses Schritts
- Mehrere Routes hinzufügen
- Path Parameter verwenden
- Verschiedene HTTP Response Codes

## 📋 Was wir lernen
- Path Parameter Syntax `{parameter}`
- Mehrere `@app.get()` Decorators
- Python Type Hints
- FastAPI automatische Validierung

---

## 1. Erweiterte App

**Datei: `main.py` (ersetze den kompletten Inhalt)**
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

## 2. Syntax Erklärung - Neue Zeilen

### Route mit Path Parameter
```python
@app.get("/hello/{name}")
def say_hello(name: str):
    return {"message": f"Hello {name}!"}
```

**Zeile für Zeile:**
- `"/hello/{name}"` = URL Pattern mit **Path Parameter**
- `{name}` = Variable Teil der URL (wie Go's `:name`)
- `name: str` = **Type Hint** - sagt "name ist ein String"
- `f"Hello {name}!"` = **f-string** - String mit Variable (wie Go's fmt.Sprintf)

### Integer Path Parameter
```python
@app.get("/items/{item_id}")
def read_item(item_id: int):
    return {"item_id": item_id, "message": "Item found"}
```

**Was neu ist:**
- `item_id: int` = **Type Hint** für Integer
- FastAPI **validiert automatisch** - nur Zahlen sind erlaubt!

---

## 3. Python Konzepte erklärt

### Type Hints
```python
# Python Type Hints (seit Python 3.5)
def function(parameter: typ) -> return_typ:
    pass

# Beispiele:
name: str        # String
item_id: int     # Integer  
price: float     # Float
is_active: bool  # Boolean
```

**Golang Vergleich:**
```go
// Go: Types sind Pflicht
func sayHello(name string) string

// Python: Type Hints sind optional, aber empfohlen
def say_hello(name: str) -> str:
```

### f-strings (String Formatting)
```python
name = "World"
message = f"Hello {name}!"  # → "Hello World!"

# Alternativen:
message = "Hello {}!".format(name)      # Ältere Syntax
message = "Hello " + name + "!"         # String concatenation
```

**Golang Vergleich:**
```go
// Go
message := fmt.Sprintf("Hello %s!", name)

// Python f-string
message = f"Hello {name}!"
```

---

## 4. Server testen

**Server ist noch am laufen?** Dann siehst du automatisch die Änderungen (wegen `--reload`)!

### Neue Routes testen:

```bash
# Hello Route mit Name
curl http://localhost:8000/hello/Max
# → {"message":"Hello Max!"}

curl http://localhost:8000/hello/Python
# → {"message":"Hello Python!"}

# Item Route mit Nummer
curl http://localhost:8000/items/42
# → {"item_id":42,"message":"Item found"}

curl http://localhost:8000/items/123
# → {"item_id":123,"message":"Item found"}
```

### Validierung testen:
```bash
# Das sollte einen Fehler geben:
curl http://localhost:8000/items/not-a-number
```

**Ergebnis:** FastAPI gibt automatisch einen 422 Validierungsfehler zurück!

---

## 5. Automatische Dokumentation

Gehe zu: http://localhost:8000/docs

**Was siehst du jetzt?**
- 3 Endpoints sind automatisch dokumentiert
- Path Parameter sind beschrieben
- Du kannst die API direkt testen!

**Try it out** Button klicken und verschiedene Werte eingeben.

---

## 6. URL Patterns verstehen

| URL | Pattern | Parameter | Wert |
|-----|---------|-----------|------|
| `/hello/Max` | `/hello/{name}` | `name` | `"Max"` |
| `/hello/Python` | `/hello/{name}` | `name` | `"Python"` |
| `/items/42` | `/items/{item_id}` | `item_id` | `42` |
| `/items/abc` | `/items/{item_id}` | ❌ Error | - |

**FastAPI macht automatisch:**
- String Parameter → String
- Int Parameter → Integer + Validierung
- Fehler bei falschen Typen

---

## 🔍 Python vs Golang - Vergleich

| Python FastAPI | Golang Gin |
|----------------|------------|
| `@app.get("/hello/{name}")` | `r.GET("/hello/:name", handler)` |
| `name: str` | `c.Param("name")` |
| `f"Hello {name}!"` | `fmt.Sprintf("Hello %s!", name)` |
| Automatische Validierung | Manuelle Validierung |
| Type Hints optional | Types Pflicht |

---

## ✅ Was haben wir gelernt?

- [x] **Path Parameter** mit `{parameter}` Syntax
- [x] **Type Hints** für automatische Validierung
- [x] **f-strings** für String Formatting
- [x] **Mehrere Routes** in einer App
- [x] **Automatische Validierung** und Fehlerbehandlung

## 🤔 Test dein Verständnis

1. **Was passiert bei `/items/abc`?** (Tipp: Probier es aus!)
2. **Wie würdest du einen float Parameter hinzufügen?**
3. **Was ist der Unterschied zwischen `name: str` und `name`?**

## 🚀 Nächster Schritt

Schritt 3: **Query Parameter** und **Request Body** (POST Requests)

**Bereit für Schritt 3, oder Fragen zu Path Parametern?**
