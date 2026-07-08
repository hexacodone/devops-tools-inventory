# Python Environments — Reference

## Why a venv?

Python packages are installed *somewhere* on your system. Without isolation, every project shares one global package pool.

Problem: Project A needs `requests==2.28`, Project B needs `requests==2.31`. Global install can only hold one version. Conflict.

A **venv** (virtual environment) is a self-contained directory with its own Python interpreter copy and its own `site-packages` (package install location). Each project gets its own sandbox. No cross-contamination, no version conflicts, no need for `sudo pip install` polluting the OS Python.

Terraform analogy: think of it like `.terraform/` per workspace — isolated provider/plugin state per project, not a global shared one.

## `python3 -m venv venv`

- `-m venv`: run the stdlib `venv` module as a script.
- Second `venv`: the *name* of the directory to create (convention, could be `.venv` or anything).
- Result: a folder `venv/` containing:
  - `venv/bin/python` — a copy/symlink of the interpreter
  - `venv/bin/pip` — pip scoped to this environment
  - `venv/lib/.../site-packages/` — where installed packages land

Nothing is "active" yet — it's just a directory on disk.

## `source venv/bin/activate`

- Runs a shell script that modifies your **current shell session**:
  - Prepends `venv/bin` to `$PATH` → typing `python` or `pip` now resolves to the venv's copies, not the system ones.
  - Sets `$VIRTUAL_ENV` env var.
  - Changes your prompt (usually prefixes it with `(venv)`).
- `source` (not `./activate`) is required because the script needs to modify *your current shell*, not run in a subshell that exits immediately.
- Effect is temporary and per-terminal-session. Close the terminal or run `deactivate` → back to normal.

## `pip install ruamel.yaml`

- With the venv active, `pip` = `venv/bin/pip`.
- Installs `ruamel.yaml` **into** `venv/lib/.../site-packages/`, not system-wide.
- Only visible to Python processes launched from this venv.

## Practical workflow

```bash
python3 -m venv venv          # once, when creating the project
source venv/bin/activate      # every time you open a new terminal for this project
pip install ruamel.yaml       # once per new dependency
deactivate                    # when done (optional, or just close terminal)
```

## Checking you're in a venv

```bash
which python     # should point into your project's venv/bin/python
echo $VIRTUAL_ENV
```

## `requirements.txt` — freezing dependencies

```bash
pip freeze > requirements.txt     # snapshot exact installed versions
pip install -r requirements.txt   # reproduce environment elsewhere (CI, teammate's machine)
```

This is your Terraform-lockfile equivalent — pins exact versions so CI and local match.

## Note on `.gitignore`

Never commit `venv/`. Add to `.gitignore`:

```
venv/
__pycache__/
*.pyc
```

## Later upgrade path

- `uv` (Astral) — much faster drop-in replacement for `venv` + `pip`, increasingly standard in 2025/2026 tooling. Worth adopting once comfortable with the basics above.
- `pyproject.toml` — modern dependency declaration, replaces bare `requirements.txt` in more structured projects.

---
*(extend this file as you hit new venv/packaging questions)*
