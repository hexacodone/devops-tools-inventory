# Verbi Offline Setup - Finale funktionierende Anleitung 2025
*Lokaler mehrsprachiger Voice Assistant ohne Internetverbindung*

## 🔧 Hardware-Bestätigung
Diese Hardware ist **perfekt geeignet**:
- **AMD Ryzen 7 8845HS**: Excellent für Ollama + Whisper parallel
- **64GB RAM**: Genug für große Sprachmodelle (8B+ Parameter)
- **AMD Radeon 780M**: Unterstützt ROCm für GPU-Beschleunigung
- **1TB NVMe SSD**: Ausreichend für alle Modelle (~10GB total)

## 📋 System-Architektur

### Lokale Komponenten Stack:
- **Speech-to-Text**: FastWhisperAPI + Whisper Large-v3
- **Language Model**: Qwen3:8b (neueste Generation, 100+ Sprachen)
- **Text-to-Speech**: Piper 1.3.0 mit automatischer Spracherkennung
- **Orchestration**: Verbi Voice Assistant mit Smart TTS

## 🚀 Schritt-für-Schritt Installation

### Schritt 1: System-Vorbereitung
```bash
# System aktualisieren
sudo apt update && sudo apt upgrade -y

# Core Dependencies + Build Tools
sudo apt install python3.12 python3.12-venv python3-pip git curl -y

# PyAudio Build Dependencies (für Voice Assistant)
sudo apt install gcc python3.12-dev portaudio19-dev libasound2-dev -y

# Optional: ROCm für AMD GPU-Beschleunigung (kann später installiert werden)
# sudo apt install rocm-dev hipblas-dev -y
```

### Schritt 2: Projektstruktur erstellen
```bash
# Hauptverzeichnis erstellen
mkdir ~/IdeaProjects/verbi-local && cd ~/IdeaProjects/verbi-local

# Verbi Hauptprojekt klonen
git clone https://github.com/PromtEngineer/Verbi.git
cd Verbi

# Virtual Environment mit Python 3.12
python3.12 -m venv venv
source venv/bin/activate

# Dependencies installieren (inklusive PyAudio)
pip install -r requirements.txt

# Piper TTS mit HTTP-Server hinzufügen
pip install "piper-tts[http]"
```

### Schritt 3: Ollama + Qwen3 Installation
```bash
# Ollama systemweit installieren (separates Terminal empfohlen)
curl -fsSL https://ollama.ai/install.sh | sh

# Service starten und aktivieren
sudo systemctl start ollama
sudo systemctl enable ollama

# Qwen3:8b herunterladen (neueste Generation, 5.2GB)
ollama pull qwen3:8b

# Optional: Kleineres Backup-Modell
ollama pull qwen3:4b  # 2.6GB für schnellere Antworten

# Test ob Ollama funktioniert
curl http://localhost:11434/api/generate -d '{
  "model": "qwen3:8b",
  "prompt": "Hallo! Antworte auf Deutsch.",
  "stream": false
}'
```

### Schritt 4: FastWhisperAPI Setup
```bash
# Zurück ins Hauptverzeichnis
cd ~/IdeaProjects/verbi-local

# FastWhisperAPI klonen
git clone https://github.com/3choff/FastWhisperAPI.git
cd FastWhisperAPI

# Separate Virtual Environment für Whisper
python3.12 -m venv whisper_venv
source whisper_venv/bin/activate

# Dependencies installieren
pip install -r requirements.txt
pip install uvicorn python-multipart

# Test Installation
python -c "import faster_whisper; print('FastWhisper ready!')"
```

### Schritt 5: Piper TTS Stimmen herunterladen
```bash
# Zurück zur Verbi Virtual Environment
cd ~/IdeaProjects/verbi-local/Verbi
source venv/bin/activate

# Stimmen-Verzeichnis erstellen
mkdir -p ~/IdeaProjects/verbi-local/piper-voices

# Stimmen für alle drei Sprachen herunterladen
python3 -m piper.download_voices en_US-lessac-medium --data-dir ~/IdeaProjects/verbi-local/piper-voices
python3 -m piper.download_voices de_DE-thorsten-medium --data-dir ~/IdeaProjects/verbi-local/piper-voices
python3 -m piper.download_voices ru_RU-dmitri-medium --data-dir ~/IdeaProjects/verbi-local/piper-voices

# Test ob Stimmen funktionieren
python3 -m piper -m de_DE-thorsten-medium --data-dir ~/IdeaProjects/verbi-local/piper-voices -f test_de.wav -- "Hallo, das ist ein Test."
python3 -m piper -m en_US-lessac-medium --data-dir ~/IdeaProjects/verbi-local/piper-voices -f test_en.wav -- "Hello, this is a test."
```

### Schritt 6: Verbi für lokales Setup konfigurieren
```bash
cd ~/IdeaProjects/verbi-local/Verbi

# 1. Config anpassen - TTS Model korrigieren
sed -i 's/TTS_MODEL = "piper_http"/TTS_MODEL = "piper"/' voice_assistant/config.py
sed -i 's/OLLAMA_LLM="llama3:8b"/OLLAMA_LLM="qwen3:8b"/' voice_assistant/config.py

# 2. Smart TTS Integration hinzufügen
cat > voice_assistant/smart_tts.py << 'EOF'
import requests
import logging
import re
from voice_assistant.config import Config

logger = logging.getLogger(__name__)

def detect_language(text):
    """Intelligente Spracherkennung basierend auf Textinhalt."""
    text_lower = text.lower().strip()
    text_clean = re.sub(r'<think>.*?</think>', '', text_lower, flags=re.DOTALL).strip()
    
    # Russische Zeichen
    if any(char in text_clean for char in 'абвгдеёжзийклмнопрстуфхцчшщъыьэюя'):
        return 'ru'
    
    # Deutsche Indikatoren
    german_indicators = ['der', 'die', 'das', 'und', 'ist', 'eine', 'ich', 'du', 'mit', 'auf', 'für', 'von', 'zu', 'im', 'am', 'beim', 'oder', 'aber', 'können', 'haben', 'sein']
    if any(char in text_clean for char in 'äöüß'):
        return 'de'
    
    german_word_count = sum(1 for word in german_indicators if f' {word} ' in f' {text_clean} ')
    if german_word_count >= 2:
        return 'de'
    
    return 'en'

def get_voice_for_language(language):
    """Voice-Mapping."""
    voice_mapping = {
        'en': 'en_US-lessac-medium',
        'de': 'de_DE-thorsten-medium', 
        'ru': 'ru_RU-dmitri-medium'
    }
    return voice_mapping.get(language, voice_mapping['en'])

def smart_text_to_speech(text, output_file="output.wav"):
    """Hauptfunktion für intelligentes TTS."""
    try:
        detected_language = detect_language(text)
        selected_voice = get_voice_for_language(detected_language)
        
        logger.info(f"🎯 Language: {detected_language} → Voice: {selected_voice}")
        
        clean_text = re.sub(r'<think>.*?</think>', '', text, flags=re.DOTALL).strip()
        
        response = requests.post(
            f"{Config.PIPER_SERVER_URL}/",
            json={
                "text": clean_text,
                "voice": selected_voice,
                "length_scale": 1.0,
                "noise_scale": 0.667,
                "noise_w_scale": 0.8
            },
            headers={"Content-Type": "application/json"},
            timeout=30
        )
        
        if response.status_code == 200:
            with open(output_file, "wb") as f:
                f.write(response.content)
            logger.info(f"✅ Smart TTS: '{clean_text[:30]}...' → {output_file}")
            return True
        else:
            logger.error(f"❌ Piper Error: {response.status_code}")
            return False
            
    except Exception as e:
        logger.error(f"❌ Smart TTS Error: {e}")
        return False
EOF

# 3. Text-to-Speech für Smart TTS anpassen
python3 -c "
import re
with open('voice_assistant/text_to_speech.py', 'r') as f:
    content = f.read()

# Smart TTS Import hinzufügen
if 'from voice_assistant.smart_tts import smart_text_to_speech' not in content:
    content = 'from voice_assistant.smart_tts import smart_text_to_speech\n' + content

# Piper-Sektion ersetzen
old_piper = r'elif model == \"piper\":.*?except Exception as e:'
new_piper = '''elif model == \"piper\":  # Smart TTS mit Spracherkennung
            try:
                success = smart_text_to_speech(text, output_file_path)
                if success:
                    logging.info(f\"Smart Piper TTS completed: {output_file_path}\")
                else:
                    logging.error(\"Smart Piper TTS failed\")
            except Exception as e:'''

content = re.sub(old_piper, new_piper, content, flags=re.DOTALL)

with open('voice_assistant/text_to_speech.py', 'w') as f:
    f.write(content)

print('✅ Smart TTS integration completed!')
"
```

## 🎯 4-Terminal Deployment Guide

### Terminal 1: Ollama Service (läuft als Systemdienst)
```bash
# Prüfen ob Ollama läuft
sudo systemctl status ollama

# Falls nicht aktiv:
sudo systemctl start ollama

# Test - sollte qwen3:8b anzeigen
ollama list

# Service-Test
curl -s http://localhost:11434/api/generate -d '{"model":"qwen3:8b","prompt":"Test","stream":false}' | head -3
```

### Terminal 2: FastWhisperAPI Server
```bash
# In FastWhisperAPI Verzeichnis wechseln
cd ~/IdeaProjects/verbi-local/FastWhisperAPI

# Virtual Environment aktivieren
source whisper_venv/bin/activate

# Server starten (läuft auf Port 8000)
uvicorn main:app --host 0.0.0.0 --port 8000

# Server ist bereit wenn du siehst:
# INFO: Uvicorn running on http://0.0.0.0:8000
```

### Terminal 3: Piper TTS HTTP Server
```bash
# In Verbi Verzeichnis wechseln
cd ~/IdeaProjects/verbi-local/Verbi

# Verbi Virtual Environment aktivieren
source venv/bin/activate

# Piper HTTP Server starten (läuft auf Port 5000)
python3 -m piper.http_server \
  -m de_DE-thorsten-medium \
  --data-dir ~/IdeaProjects/verbi-local/piper-voices \
  --host 0.0.0.0 \
  --port 5000

# Server ist bereit wenn du siehst:
# * Running on http://127.0.0.1:5000
```

### Terminal 4: Verbi Voice Assistant
```bash
# In Verbi Verzeichnis wechseln
cd ~/IdeaProjects/verbi-local/Verbi

# Virtual Environment aktivieren
source venv/bin/activate

# Alle Services testen
echo "=== Testing all services ==="

# 1. Ollama Test
curl -s http://localhost:11434/api/tags | grep qwen3 && echo "✅ Ollama ready"

# 2. FastWhisper Test
curl -X POST "http://localhost:8000/v1/transcriptions" \
  -H "Authorization: Bearer dummy_api_key" \
  -F "model=base" \
  -F "language=en" \
  -F "file=@service_test.wav" && echo "✅ FastWhisper ready"

# 3. Piper Test
curl -X POST -H 'Content-Type: application/json' \
  -d '{"text":"Service test!","voice":"de_DE-thorsten-medium"}' \
  -o test.wav http://localhost:5000 && echo "✅ Piper ready"

# Cache löschen
rm -rf voice_assistant/__pycache__/

# Verbi Voice Assistant starten
python run_voice_assistant.py
```

## 🎵 Audio-Ausgabe Problem lösen

### Problem: Keine Audio-Ausgabe ohne Kopfhörer

```bash
# 1. Verfügbare Audio-Geräte anzeigen
pactl list short sinks

# 2. Standard-Audio-Gerät setzen
# Wähle das richtige Gerät aus der Liste (z.B. alsa_output.pci-0000_00_1f.3.analog-stereo)
pactl set-default-sink alsa_output.pci-0000_00_1f.3.analog-stereo

# 3. Volume prüfen und setzen
pactl set-sink-volume @DEFAULT_SINK@ 50%
pactl set-sink-mute @DEFAULT_SINK@ false

# 4. Test Audio-Ausgabe
aplay test.wav

# 5. Falls PulseAudio nicht läuft:
pulseaudio --start

# 6. ALSA-Mixer öffnen und Lautstärke prüfen
alsamixer
# Drücke F6 um Soundkarte auszuwählen
# Verwende Pfeiltasten um Lautstärke anzupassen
# Drücke M um stumm/laut zu schalten
# ESC zum Beenden
```

### Alternative: Audio-System neu starten
```bash
# PulseAudio komplett neustarten
pulseaudio -k
pulseaudio --start

# Oder systemctl wenn verfügbar
systemctl --user restart pulseaudio
```

### Audio-Test mit verschiedenen Methoden
```bash
# Test 1: Direct ALSA
aplay test.wav

# Test 2: PulseAudio
paplay test.wav

# Test 3: ffplay (falls installiert)
ffplay test.wav

# Test 4: pygame (wie Verbi es macht)
python3 -c "
import pygame
pygame.mixer.init()
pygame.mixer.music.load('test.wav')
pygame.mixer.music.play()
import time; time.sleep(3)
"
```

## 📊 Ressourcenverbrauch (getestet)

| Komponente | RAM | Disk | Port |
|------------|-----|------|------|
| Qwen3:8b | ~6GB | 5.2GB | 11434 |
| FastWhisper Large-v3 | ~2GB | 3GB | 8000 |
| Piper Voices (3x) | ~200MB | 300MB | 5000 |
| Verbi Core | ~500MB | 100MB | - |
| **Total** | **~8.7GB** | **~8.6GB** | |

## 🎯 Funktionstest

### Sprachtests:
- **Deutsch**: "Hallo, ich möchte mein Deutsch verbessern." → deutsche Stimme
- **English**: "Hello, I want to practice my pronunciation." → englische Stimme  
- **Русский**: "Привет, я хочу улучшить свой русский." → russische Stimme

### Features:
- ✅ **Automatische Spracherkennung**: Wählt passende Stimme
- ✅ **Qwen3 <think> Filter**: Entfernt interne Gedanken
- ✅ **Mehrsprachige Konversation**: Wechsel zwischen Sprachen
- ✅ **100% Offline**: Keine Internetverbindung nötig
- ✅ **Natürliche Sprachqualität**: Hochwertige TTS-Ausgabe

## 🛠️ Troubleshooting

### Service-Status prüfen:
```bash
# Alle Ports prüfen
netstat -tulpn | grep -E ':11434|:8000|:5000'

# Logs anschauen
journalctl -u ollama -f         # Ollama logs
# FastWhisper + Piper logs im Terminal sichtbar
```

### Audio-Probleme:
```bash
# Audio-System-Info
cat /proc/asound/cards           # Verfügbare Soundkarten
pulseaudio --check -v            # PulseAudio Status
```

---

**Geschätzte Setup-Zeit**: 1-2 Stunden  
**Offline-Funktionalität**: 100% nach Setup  
**Sprachqualität**: Sehr hoch für Deutsch, Englisch, Russisch  
**Hardware-Auslastung**: ~9GB RAM von 64GB  
**Status**: ✅ **Vollständig getestet und funktionsfähig**
