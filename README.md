## Ollama + Open WebUI Quick Deploy (Multi-user Ready)

This setup allows you to quickly deploy Ollama + Open WebUI with GPU support, multi-user registration, and persistent configuration.

##  Features

- Local LLM (Mistral via Ollama)
- Clean model alias: `mistral-clean`
- Open WebUI with multi-user login support
- Host network mode for GPU + local API access
- Dockerized for easy redeployment

---

##  How to use

```bash
git clone https://your-repo.com/ollama-webui-deploy.git
cd ollama-webui-deploy
bash setup.sh
docker compose up -d

use api ends
curl http://localhost:11434/api/generate -d '{
  "model": "mistral-clean",
  "prompt": "Give me 5 ideas for a YouTube channel about space.",
  "stream": false
}' | jq -r .response

