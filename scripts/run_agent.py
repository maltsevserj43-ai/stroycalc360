import os, sys, subprocess, yaml
from pathlib import Path
import httpx

AGENT_ID = sys.argv[1] if len(sys.argv) > 1 else "A"
cfg = yaml.safe_load(Path("agents/config.yaml").read_text(encoding="utf-8"))
agent = cfg["agents"][AGENT_ID]
prompt_files = sorted(Path("agents/prompts").glob(f"{AGENT_ID}_*.md"))
prompt = prompt_files[0].read_text(encoding="utf-8")

print(f"Отправляем запрос к Ollama для агента {AGENT_ID}...")
base = os.getenv("OLLAMA_API_BASE", "http://127.0.0.1:11434")
model = os.getenv("OLLAMA_MODEL", "qwen2.5-coder:1.5b")

try:
    r = httpx.post(
        f"{base}/api/generate",
        json={"model": model, "prompt": prompt, "stream": False, "options": {"temperature": 0.1}},
        timeout=600
    )
    r.raise_for_status()
    plan = r.json().get("response", "")
except Exception as e:
    print(f"Ошибка Ollama: {e}")
    sys.exit(1)

if not plan:
    print("Ollama вернула пустой ответ")
    sys.exit(1)

Path(f"/tmp/plan_{AGENT_ID}.md").write_text(plan, encoding="utf-8")

subprocess.run([
    "aider", "--yes", "--no-auto-commits", "--no-stream",
    "--model", f"ollama/{model}",
    "--message-file", f"/tmp/plan_{AGENT_ID}.md"
], check=True)

subprocess.run(["git", "checkout", "-B", agent["branch"]], check=True)
subprocess.run(["git", "add", "-A"], check=True)
subprocess.run(["git", "commit", "-m", f"{AGENT_ID}: {agent['name']} — auto"], check=True)
print("Успех!")