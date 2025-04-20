#!/bin/bash
set -e

echo " Installing Docker..."
sudo apt update
sudo apt install -y ca-certificates curl gnupg lsb-release

# Set up Docker repo
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
 https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
 sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

echo "Docker installed."

echo "Installing Ollama..."
curl -fsSL https://ollama.com/install.sh | sh

echo "Waiting for Ollama service to start..."
for i in {1..30}; do
  if curl -s http://localhost:11434 > /dev/null; then
    echo "Ollama is running."
    break
  else
    sleep 1
  fi
done

echo " Attempting to download mistral model..."
if OLLAMA_HOST=127.0.0.1 ollama pull mistral; then
  echo " Model downloaded."
  echo " Creating alias 'mistral-clean'..."
  ollama create mistral-clean -f Modelfile && echo " Alias created."
else
  echo "⚠ Model download failed (likely due to network)."
  echo "   You can try manually after setup finishes:"
  echo ""
  echo "     OLLAMA_HOST=127.0.0.1 ollama pull mistral"
  echo "     ollama create mistral-clean -f Modelfile"
  echo ""
fi

echo ""
echo " SETUP COMPLETE!"
echo " Now run: docker compose up -d"
echo " Then open: http://localhost:8080"
echo "update firewall port 8080 for network a access"

