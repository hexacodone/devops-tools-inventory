# GPG Commit Signing — Reference Sheet
> Stack: GPG · Git · GitHub · IntelliJ · Arch/Debian/Ubuntu Linux

---

## 1. Create a New GPG Key

```bash
gpg --full-generate-key
```

Recommended settings:
- Type: `RSA and RSA` or `ECC (Ed25519)`
- Key size: `4096` (RSA) or default (Ed25519)
- Expiry: `0` (no expiry) or `2y`
- Email: **must match** your GitHub account email

---

## 2. Inspect Keys

```bash
# List public keys (shows fingerprint + key ID)
gpg --list-keys --keyid-format=long

# List secret keys
gpg --list-secret-keys --keyid-format=long

# Key ID is the part after rsa4096/ or ed25519/
# e.g. pub rsa4096/8F1B6FD4774CC1DA → ID: 8F1B6FD4774CC1DA
# Full fingerprint: D3A2D26708C914D2B7D68EACC6F2B42A7AE30B27
```

---

## 3. Export Public Key (for GitHub)

```bash
gpg --armor --export YOUR_KEY_ID
```

Copy full output including `-----BEGIN PGP PUBLIC KEY BLOCK-----`  
→ GitHub → Settings → SSH and GPG keys → **New GPG key**

---

## 4. Configure Git to Use GPG Key

```bash
# Set signing key
git config --global user.signingkey YOUR_KEY_ID

# Enable signing on all commits
git config --global commit.gpgsign true

# Set correct author identity
git config --global user.name "hexacodone"
git config --global user.email "hexacodone@pm.me"

# Verify
git config --global --get user.signingkey
git config --global --get commit.gpgsign
git config --global --get user.name
git config --global --get user.email
```

---

## 5. Check for Local Repo Overrides

Local config overrides global — always check when something acts unexpectedly:

```bash
git config --local --get user.signingkey
git config --local --get commit.gpgsign
git config --local --get user.name
git config --local --get user.email

# Remove local overrides to fall back to global
git config --local --unset user.signingkey
git config --local --unset user.name
git config --local --unset user.email
```

---

## 6. Test Signing Works

```bash
# Test GPG signing directly
echo "test" | gpg --clearsign --default-key YOUR_KEY_ID

# Test commit signing
git commit --allow-empty -m "test: gpg signing"

# Verify signature on last commit
git log --show-signature -1
# Should show: gpg: Good signature from "hexacodone <hexacodone@pm.me>"
```

---

## 7. Fix a Wrong Author on Last Commit

```bash
# Amend author on last commit (uses current git config)
git commit --amend --reset-author --no-edit

# If already pushed
git push --force-with-lease
```

---

## 8. Key Rotation

```bash
# 1. Generate new key (see section 1)
# 2. Get new key ID
gpg --list-secret-keys --keyid-format=long

# 3. Export and add to GitHub (see section 3)

# 4. Update git config
git config --global user.signingkey NEW_KEY_ID

# 5. Revoke old key (optional but recommended)
gpg --gen-revoke OLD_KEY_ID > revoke.asc
gpg --import revoke.asc

# 6. Remove old key from GitHub
# GitHub → Settings → SSH and GPG keys → delete old key
```

---

## 9. IntelliJ Setup

IntelliJ delegates to the global `~/.gitconfig` — **no separate config needed**.

After updating git config:
1. Restart IntelliJ
2. Make a test commit — IntelliJ will trigger the GPG pinentry dialog for passphrase
3. Settings → Version Control → Git — verify no conflicting local key is set

### GitHub Auth in IntelliJ (Token, not OAuth)

If OAuth loop / token not persisting:

1. GitHub → Settings → Developer Settings → Personal Access Tokens → **Tokens (classic)**
2. Scopes: `repo`, `workflow`
3. IntelliJ → Settings → Version Control → GitHub → **+** → Login with Token

### Token Not Persisting (Wayland/Sway)

IntelliJ needs `libsecret` to store credentials in the system keyring:

```bash
# Check if libsecret is available
ls /usr/lib/x86_64-linux-gnu/libsecret-1.so*

# Install if missing
sudo apt install libsecret-1-0 libsecret-tools

# Check if a keyring daemon is running
ps aux | grep -E "kwallet|gnome-keyring|secret"
```

---

## 10. Quick Diagnostics

```bash
# Full config dump (global)
git config --global --list | grep -E "user|signing|gpg"

# Full config dump (local repo)
git config --local --list | grep -E "user|signing|gpg"

# Check GPG agent is running
gpg-agent --daemon 2>/dev/null || echo "already running"

# Re-test signing
echo "test" | gpg --clearsign --default-key YOUR_KEY_ID
```
