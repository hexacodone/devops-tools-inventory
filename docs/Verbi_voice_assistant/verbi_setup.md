# Verbi Offline Setup - Final Working Guide 2025
*Local multilingual voice assistant without an internet connection*

## 🔧 Hardware Confirmation
This hardware is **perfectly suited**:
- **AMD Ryzen 7 8845HS**: Excellent for running Ollama + Whisper in parallel
- **64GB RAM**: Enough for large language models (8B+ parameters)
- **AMD Radeon 780M**: Supports ROCm for GPU acceleration
- **1TB NVMe SSD**: Enough space for all models (~10GB total)

## 📋 System Architecture

### Local component stack:
- **Speech-to-Text**: FastWhisperAPI + Whisper Large-v3
- **Language Model**: Qwen3:8b (latest generation, 100+ languages)
- **Text-to-Speech**: Piper 1.3.0 with automatic language detection
- **Orchestration**: Verbi Voice Assistant with Smart TTS

## 🚀 Step-by-Step Installation

### Step 1: System Preparation
```bash
# Update the system
sudo apt update && sudo apt upgrade -y

# Core dependencies + build tools
sudo apt install python3.12 python3.12-venv python3-pip git curl -y

# PyAudio build dependencies (for the voice assistant)
sudo apt install gcc python3.12-dev portaudio19-dev libasound2-dev -y

# Optional: ROCm for AMD GPU acceleration (can be installed later)
# sudo apt install rocm-dev hipblas-dev -y
```

### Step 2: Create the Project Structure
```bash
# Create the main directory
mkdir ~/IdeaProjects/verbi-local && cd ~/IdeaProjects/verbi-local

# Clone the main Verbi project
git clone https://github.com/PromtEngineer/Verbi.git
cd Verbi

# Virtual environment with Python 3.12
python3.12 -m venv venv
source venv/bin/activate

# Install dependencies (including PyAudio)
pip install -r requirements.txt

# Add Piper TTS with the HTTP server
pip install "piper-tts[http]"
```

### Step 3: Ollama + Qwen3 Installation
```bash
# Install Ollama system-wide (a separate terminal is recommended)
curl -fsSL https://ollama.ai/install.sh | sh

# Start and enable the service
sudo systemctl start ollama
sudo systemctl enable ollama

# Download Qwen3:8b (latest generation, 5.2GB)
ollama pull qwen3:8b

# Optional: smaller backup model
ollama pull qwen3:4b  # 2.6GB for faster responses

# Test whether Ollama works
curl http://localhost:11434/api/generate -d '{
  "model": "qwen3:8b",
  "prompt": "Hallo! Antworte auf Deutsch.",
  "stream": false
}'
```

### Step 4: FastWhisperAPI Setup
```bash
# Back to the main directory
cd ~/IdeaProjects/verbi-local

# Clone FastWhisperAPI
git clone https://github.com/3choff/FastWhisperAPI.git
cd FastWhisperAPI

# Separate virtual environment for Whisper
python3.12 -m venv whisper_venv
source whisper_venv/bin/activate

# Install dependencies
pip install -r requirements.txt
pip install uvicorn python-multipart

# Test the installation
python -c "import faster_whisper; print('FastWhisper ready!')"
```

### Step 5: Download Piper TTS Voices
```bash
# Back to the Verbi virtual environment
cd ~/IdeaProjects/verbi-local/Verbi
source venv/bin/activate

# Create the voices directory
mkdir -p ~/IdeaProjects/verbi-local/piper-voices

# Download voices for all three languages
python3 -m piper.download_voices en_US-lessac-medium --data-dir ~/IdeaProjects/verbi-local/piper-voices
python3 -m piper.download_voices de_DE-thorsten-medium --data-dir ~/IdeaProjects/verbi-local/piper-voices
python3 -m piper.download_voices ru_RU-dmitri-medium --data-dir ~/IdeaProjects/verbi-local/piper-voices

# Test whether the voices work
python3 -m piper -m de_DE-thorsten-medium --data-dir ~/IdeaProjects/verbi-local/piper-voices -f test_de.wav -- "Hallo, das ist ein Test."
python3 -m piper -m en_US-lessac-medium --data-dir ~/IdeaProjects/verbi-local/piper-voices -f test_en.wav -- "Hello, this is a test."
```

### Step 6: Configure Verbi for the Local Setup
```bash
cd ~/IdeaProjects/verbi-local/Verbi

# 1. Adjust the config - fix the TTS model
sed -i 's/TTS_MODEL = "piper_http"/TTS_MODEL = "piper"/' voice_assistant/config.py
sed -i 's/OLLAMA_LLM="llama3:8b"/OLLAMA_LLM="qwen3:8b"/' voice_assistant/config.py

# 2. Add the Smart TTS integration
cat > voice_assistant/smart_tts.py << 'EOF'
import requests
import logging
import re
from voice_assistant.config import Config

logger = logging.getLogger(__name__)

def detect_language(text):
    """Intelligent language detection based on text content."""
    text_lower = text.lower().strip()
    text_clean = re.sub(r'<think>.*?</think>', '', text_lower, flags=re.DOTALL).strip()
    
    # Russian characters
    if any(char in text_clean for char in 'абвгдеёжзийклмнопрстуфхцчшщъыьэюя'):
        return 'ru'
    
    # German indicators
    german_indicators = ['der', 'die', 'das', 'und', 'ist', 'eine', 'ich', 'du', 'mit', 'auf', 'für', 'von', 'zu', 'im', 'am', 'beim', 'oder', 'aber', 'können', 'haben', 'sein']
    if any(char in text_clean for char in 'äöüß'):
        return 'de'
    
    german_word_count = sum(1 for word in german_indicators if f' {word} ' in f' {text_clean} ')
    if german_word_count >= 2:
        return 'de'
    
    return 'en'

def get_voice_for_language(language):
    """Voice mapping."""
    voice_mapping = {
        'en': 'en_US-lessac-medium',
        'de': 'de_DE-thorsten-medium', 
        'ru': 'ru_RU-dmitri-medium'
    }
    return voice_mapping.get(language, voice_mapping['en'])

def smart_text_to_speech(text, output_file="output.wav"):
    """Main function for smart TTS."""
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

# 3. Wire Smart TTS into text_to_speech.py
python3 -c "
import re
with open('voice_assistant/text_to_speech.py', 'r') as f:
    content = f.read()

# Add the Smart TTS import
if 'from voice_assistant.smart_tts import smart_text_to_speech' not in content:
    content = 'from voice_assistant.smart_tts import smart_text_to_speech\n' + content

# Replace the piper section
old_piper = r'elif model == \"piper\":.*?except Exception as e:'
new_piper = '''elif model == \"piper\":  # Smart TTS with language detection
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

### Terminal 1: Ollama Service (runs as a system service)
```bash
# Check whether Ollama is running
sudo systemctl status ollama

# If not active:
sudo systemctl start ollama

# Test - should show qwen3:8b
ollama list

# Service test
curl -s http://localhost:11434/api/generate -d '{"model":"qwen3:8b","prompt":"Test","stream":false}' | head -3
```

### Terminal 2: FastWhisperAPI Server
```bash
# Switch to the FastWhisperAPI directory
cd ~/IdeaProjects/verbi-local/FastWhisperAPI

# Activate the virtual environment
source whisper_venv/bin/activate

# Start the server (runs on port 8000)
uvicorn main:app --host 0.0.0.0 --port 8000

# The server is ready when you see:
# INFO: Uvicorn running on http://0.0.0.0:8000
```

### Terminal 3: Piper TTS HTTP Server
```bash
# Switch to the Verbi directory
cd ~/IdeaProjects/verbi-local/Verbi

# Activate the Verbi virtual environment
source venv/bin/activate

# Start the Piper HTTP server (runs on port 5000)
python3 -m piper.http_server \
  -m de_DE-thorsten-medium \
  --data-dir ~/IdeaProjects/verbi-local/piper-voices \
  --host 0.0.0.0 \
  --port 5000

# The server is ready when you see:
# * Running on http://127.0.0.1:5000
```

### Terminal 4: Verbi Voice Assistant
```bash
# Switch to the Verbi directory
cd ~/IdeaProjects/verbi-local/Verbi

# Activate the virtual environment
source venv/bin/activate

# Test all services
echo "=== Testing all services ==="

# 1. Ollama test
curl -s http://localhost:11434/api/tags | grep qwen3 && echo "✅ Ollama ready"

# 2. FastWhisper test
curl -X POST "http://localhost:8000/v1/transcriptions" \
  -H "Authorization: Bearer dummy_api_key" \
  -F "model=base" \
  -F "language=en" \
  -F "file=@service_test.wav" && echo "✅ FastWhisper ready"

# 3. Piper test
curl -X POST -H 'Content-Type: application/json' \
  -d '{"text":"Service test!","voice":"de_DE-thorsten-medium"}' \
  -o test.wav http://localhost:5000 && echo "✅ Piper ready"

# Clear the cache
rm -rf voice_assistant/__pycache__/

# Start the Verbi voice assistant
python run_voice_assistant.py
```

## 🎵 Fixing the Audio Output Problem

### Problem: No audio output without headphones

```bash
# 1. Show available audio devices
pactl list short sinks

# 2. Set the default audio device
# Choose the correct device from the list (e.g. alsa_output.pci-0000_00_1f.3.analog-stereo)
pactl set-default-sink alsa_output.pci-0000_00_1f.3.analog-stereo

# 3. Check and set the volume
pactl set-sink-volume @DEFAULT_SINK@ 50%
pactl set-sink-mute @DEFAULT_SINK@ false

# 4. Test the audio output
aplay test.wav

# 5. If PulseAudio isn't running:
pulseaudio --start

# 6. Open the ALSA mixer and check the volume
alsamixer
# Press F6 to select the sound card
# Use the arrow keys to adjust the volume
# Press M to mute/unmute
# ESC to quit
```

### Alternative: Restart the Audio System
```bash
# Fully restart PulseAudio
pulseaudio -k
pulseaudio --start

# Or via systemctl if available
systemctl --user restart pulseaudio
```

### Audio Test with Different Methods
```bash
# Test 1: direct ALSA
aplay test.wav

# Test 2: PulseAudio
paplay test.wav

# Test 3: ffplay (if installed)
ffplay test.wav

# Test 4: pygame (the way Verbi does it)
python3 -c "
import pygame
pygame.mixer.init()
pygame.mixer.music.load('test.wav')
pygame.mixer.music.play()
import time; time.sleep(3)
"
```

## 📊 Resource Usage (tested)

| Component | RAM | Disk | Port |
|------------|-----|------|------|
| Qwen3:8b | ~6GB | 5.2GB | 11434 |
| FastWhisper Large-v3 | ~2GB | 3GB | 8000 |
| Piper Voices (3x) | ~200MB | 300MB | 5000 |
| Verbi Core | ~500MB | 100MB | - |
| **Total** | **~8.7GB** | **~8.6GB** | |

## 🎯 Functional Test

### Language tests:
- **German**: "Hallo, ich möchte mein Deutsch verbessern." → German voice
- **English**: "Hello, I want to practice my pronunciation." → English voice  
- **Russian**: "Привет, я хочу улучшить свой русский." → Russian voice

### Features:
- ✅ **Automatic language detection**: Picks the matching voice
- ✅ **Qwen3 `<think>` filter**: Strips internal reasoning
- ✅ **Multilingual conversation**: Switching between languages
- ✅ **100% offline**: No internet connection needed
- ✅ **Natural voice quality**: High-quality TTS output

## 🛠️ Troubleshooting

### Check service status:
```bash
# Check all ports
netstat -tulpn | grep -E ':11434|:8000|:5000'

# View logs
journalctl -u ollama -f         # Ollama logs
# FastWhisper + Piper logs are visible in their terminals
```

### Audio problems:
```bash
# Audio system info
cat /proc/asound/cards           # Available sound cards
pulseaudio --check -v            # PulseAudio status
```

---

**Estimated setup time**: 1-2 hours  
**Offline functionality**: 100% after setup  
**Voice quality**: Very good for German, English, Russian  
**Hardware usage**: ~9GB RAM out of 64GB  
**Status**: ✅ **Fully tested and working**
