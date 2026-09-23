# AUDITORIA — histórico de eventos da TRAVA

Append-only. Espelho legível de `.trava/auditoria.jsonl`.
Verifique a integridade da cadeia com: `./trava auditoria --verificar`

| quando (UTC) | evento | decisão | trava/alvo | motivo |
|---|---|---|---|---|
| 2026-09-23T16:03:17Z | PreToolUse | invocado | Write |  |
| 2026-09-23T16:03:17Z | PreToolUse | deny | autoprotecao | tentativa de escrita no cofre |
| 2026-09-23T16:03:17Z | PreToolUse | invocado | Bash |  |
| 2026-09-23T16:03:17Z | PreToolUse | deny | autoprotecao | tentativa de escrita no cofre |
| 2026-09-23T16:03:17Z | PreToolUse | invocado | Bash |  |
| 2026-09-23T16:03:17Z | PreToolUse | deny | autoprotecao | tentativa de escrita no cofre |
| 2026-09-23T16:03:17Z | PreToolUse | invocado | Bash |  |
| 2026-09-23T16:03:17Z | PreToolUse | deny | autoprotecao | tentativa de escrita no cofre |
| 2026-09-23T16:03:17Z | PreToolUse | invocado | Bash |  |
| 2026-09-23T16:03:17Z | PreToolUse | invocado | Task |  |
| 2026-09-23T16:03:17Z | PreToolUse | deny | subagente-nasce-com-contrato | o texto obrigatório '## CONTRATO DE EXECUÇÃO' não está presente na chamada |
| 2026-09-23T16:03:17Z | SubagentStop | invocado |  |  |
| 2026-09-23T16:03:17Z | SubagentStop | bloqueado |  | selo 'relatorio' não existe (esperado em /opt/projetos/evolution/.trava/selos/relatorio.json); arquivo obrigatório ausente: output/relatorio.md |
| 2026-09-23T16:03:18Z | selo | emitido | testes-verdes | rc=0 cmd=true |
| 2026-09-23T16:03:18Z | selo | emitido | lint-limpo | rc=0 cmd=true |
| 2026-09-23T16:03:18Z | selo | recusado | relatorio | rc=1 cmd=false |
| 2026-09-23T16:03:18Z | SubagentStop | fusivel |  | stop_hook_active=true |
| 2026-09-23T16:03:18Z | SubagentStop | invocado |  |  |
| 2026-09-23T16:03:18Z | SubagentStop | bloqueado |  | selo 'relatorio' não existe (esperado em /opt/projetos/evolution/.trava/selos/relatorio.json); arquivo obrigatório ausente: output/relatorio.md |
| 2026-09-23T16:03:18Z | SubagentStop | invocado |  |  |
| 2026-09-23T16:03:18Z | SubagentStop | bloqueado |  | selo 'relatorio' não existe (esperado em /opt/projetos/evolution/.trava/selos/relatorio.json); arquivo obrigatório ausente: output/relatorio.md |
| 2026-09-23T16:03:18Z | SubagentStop | invocado |  |  |
| 2026-09-23T16:03:18Z | SubagentStop | bloqueado |  | selo 'relatorio' não existe (esperado em /opt/projetos/evolution/.trava/selos/relatorio.json); arquivo obrigatório ausente: output/relatorio.md |
| 2026-09-23T16:03:18Z | SubagentStop | invocado |  |  |
| 2026-09-23T16:03:18Z | SubagentStop | cedido |  | 4 tentativas; faltando=['relatorio', 'output/relatorio.md'] |
| 2026-09-23T16:03:18Z | bancada | invalida | verificar_bancada | veredito=APROVADO falhas=12 |
| 2026-09-23T16:10:57Z | SessionStart | inicio |  | origem=startup travas=2 |
| 2026-09-23T16:10:58Z | SessionStart | inicio |  | origem=startup travas=2 |
