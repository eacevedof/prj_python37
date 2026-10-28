"""voice_mod — Claude Code por voz (core).

Fase 1 del roadmap: la SALIDA. Al terminar cada respuesta, el hook `Stop` de
Claude Code (`public/main_voice_hook.py`) lee la última respuesta del
transcript, la limpia de markdown y la lee en alto con el TTS de Fish Audio.
La entrada por voz y la fachada `voice_mcp` llegan en fases posteriores.

Fuente (lo que se replica): short de Linkfy, «Así puedes convertir a Claude en
tu propio Jarvis» -> https://youtube.com/shorts/5CRrrmbQQ7Q
"""
