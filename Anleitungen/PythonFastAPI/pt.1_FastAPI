# 🐍 FastAPI Schritt 1: Hello World

> Wir starten mit dem absoluten Minimum - eine funktionierende FastAPI App

## 🎯 Ziel dieses Schritts
Eine minimal funktionierende API erstellen, die "Hello World" zurückgibt.

## 📋 Was wir lernen
- FastAPI Installation
- Minimale App Struktur
- Server starten
- API testen

---

## 1. Installation & Setup

### Virtual Environment erstellen
```bash
# Neuen Ordner erstellen
mkdir fastapi-todo
cd fastapi-todo

# Python Virtual Environment erstellen
python -m venv venv

# Aktivieren (Linux/Mac)
source venv/bin/activate

# Aktivieren (Windows)
venv\Scripts\activate

# Überprüfen dass es funktioniert
which python  # sollte auf venv zeigen
```

### FastAPI installieren
```bash
# Nur die absolut notwendigen Pakete
pip install fastapi uvicorn
```

---

## 2. Minimale App erstellen

**Datei: `main.py`**
```python
# FastAPI importieren
from fastapi import FastAPI

# App erstellen
app = FastAPI()

# Route definieren
@app.get("/")
def read_root():
    return {"message": "Hello World"}
```

**Das ist alles!** Nur 6 Zeilen Code.

---

## 3. Syntax Erklärung - Zeile für Zeile

```python
from fastapi import FastAPI
```
- `from ... import ...` = Python's Art Module zu importieren
- `FastAPI` = Die Hauptklasse für unsere API
- Ähnlich wie `import "github.com/gin-gonic/gin"` in Go

```python
app = FastAPI()
```
- `app` = Variable die unsere FastAPI Anwendung enthält
- `FastAPI()` = Erstellt eine neue FastAPI Instanz
- Ähnlich wie `r := gin.Default()` in Go

```python
@app.get("/")
```
- `@` = Python **Decorator** (wichtiges Konzept!)
- `app.get` = Definiert eine GET Route
- `"/"` = Der URL Pfad (Root/Homepage)
- Ähnlich wie `r.GET("/", handler)` in Go

```python
def read_root():
```
- `def` = Python Keyword für Funktionsdefinition
- `read_root` = Funktionsname (kann beliebig sein)
- `():` = Keine Parameter, Doppelpunkt startet Funktionsblock

```python
    return {"message": "Hello World"}
```
- `return` = Gibt Wert zurück
- `{"key": "value"}` = Python Dictionary (wie JSON)
- Wird automatisch zu JSON konvertiert

---

## 4. Server starten

```bash
# Im Terminal (venv muss aktiviert sein)
uvicorn main:app --reload

# Was bedeutet das?
# uvicorn     = ASGI Server (wie Go's http.ListenAndServe)
# main        = Dateiname (main.py)
# app         = Variable in der Datei
# --reload    = Automatisch neustarten bei Änderungen
```

**Output sollte sein:**
```
INFO:     Uvicorn running on http://127.0.0.1:8000 (Press CTRL+C to quit)
INFO:     Started reloader process
```

---

## 5. API testen

### Im Browser
Gehe zu: http://localhost:8000

Du solltest sehen:
```json
{"message":"Hello World"}
```

### Mit curl
```bash
curl http://localhost:8000
```

### Automatische Dokumentation
FastAPI erstellt **automatisch** API Dokumentation!

Gehe zu: http://localhost:8000/docs

Das ist **Swagger UI** - komplett automatisch generiert!

---

## 🔍 Python vs Golang - Vergleich

| Python FastAPI | Golang Gin |
|----------------|------------|
| `@app.get("/")` | `r.GET("/", handler)` |
| `def function():` | `func handler(c *gin.Context)` |
| `return {"key": "value"}` | `c.JSON(200, gin.H{"key": "value"})` |
| Automatische JSON Konvertierung | Manuelle JSON Marshaling |
| Automatische Docs | Swagger separat einrichten |

---

## ✅ Was haben wir erreicht?

- [x] Funktionierende FastAPI App
- [x] HTTP GET Endpoint
- [x] JSON Response
- [x] Automatische API Dokumentation
- [x] Development Server

## 🤔 Fragen zum Verständnis

1. **Decorator `@app.get("/")`**: Verstehst du wie das funktioniert?
2. **Return Dictionary**: Warum wird `{"message": "Hello"}` automatisch zu JSON?
3. **uvicorn**: Was ist der Unterschied zu Go's eingebautem HTTP Server?

## 🚀 Nächster Schritt

Im nächsten Schritt fügen wir eine zweite Route hinzu und lernen **Path Parameter**.

**Bereit für Schritt 2, oder hast du Fragen zu diesem Code?**
