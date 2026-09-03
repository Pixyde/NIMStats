# 1. Fetch all models available to your API key
curl -s https://integrate.api.nvidia.com/v1/models \
  -H "Authorization: Bearer $NVIDIA_API_KEY" \
  | jq -r '.data[].id' | sort -u > /tmp/nim_all.txt

# 2. Your current list (from test_models.py)
cat <<'EOF' | sort -u > /tmp/nim_existing.txt
deepseek-ai/deepseek-v4-flash-0731
z-ai/glm-5.2
minimaxai/minimax-m3
nvidia/nemotron-3-super-120b-a12b
nvidia/nemotron-3-nano-omni-30b-a3b-reasoning
nvidia/llama-3.3-nemotron-super-49b-v1.5
moonshotai/kimi-k2.6
openai/gpt-oss-120b
google/gemma-4-31b-it
meta/llama-3.3-70b-instruct
meta/llama-3.2-90b-vision-instruct
stepfun-ai/step-3.7-flash
thinkingmachines/inkling
nvidia/nemotron-3-ultra-550b-a55b
nvidia/nemotron-3.5-lightning-30b-a3b
openai/gpt-oss-20b
moonshotai/kimi-k3
deepseek-ai/deepseek-v4-pro-0813
wan-ai/wan2.2-animate-2-14b
meta/muse-glimmer-30b
nvidia/riva-translate-4b-instruct-v2
nvidia/ising-calibration-1.5-31b
nvidia/nemotron-3-embed-1b
poolside/laguna-xs-2.1
nvidia/qwen-image-edit-nvpcb-ovsl2sl
nvidia/nemotron-ocr-v2
google/diffusiongemma-26b-a4b-it
resembleai/chatterbox-multilingual-tts
nvidia/nemotron-3.5-content-safety
nvidia/cosmos3-nano
nvidia/cosmos3-nano-reasoner
qwen/qwen-image
qwen/qwen-image-edit
EOF

# 3. Diff and print the add commands
comm -23 /tmp/nim_all.txt /tmp/nim_existing.txt \
  | sed 's/^/python3 scripts\/manage_models.py add /'
