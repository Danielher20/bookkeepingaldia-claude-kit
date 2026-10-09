# Kit Claude para Bookkeeping al Día

Claude ya preparado para el trabajo de Johan: reglas de escritura humana, memoria por cliente y skills de bookkeeping y fiscal para LLC de no residentes. Johan escribe el problema y Claude lo resuelve sin pedirle contexto técnico.

## Instalar en la PC de Johan (una vez, 5 minutos)

1. Tener Claude instalado en la PC e iniciar sesión con la cuenta de Johan.
2. Descargar este repo: en GitHub (con tu cuenta, está privado) botón verde **Code**, **Download ZIP**. Descomprimir en el Escritorio.
3. Doble clic en `INSTALAR.cmd`. Esperar el mensaje **TODO INSTALADO**.
4. Abrir Claude (pestaña Code) y elegir la carpeta `Documentos\BookkeepingAlDia-Cerebro`.
5. Probar con: `Johan: escríbeme el correo para un cliente pidiéndole los estados bancarios de septiembre para cerrar el mes.` Tiene que contestar directo, sin preguntas técnicas y sin sonar a IA.

Para actualizar el kit después, descargar el ZIP nuevo y volver a correr `INSTALAR.cmd`. No pisa lo que Claude haya guardado en el cerebro.

## Qué instala

| Qué | Dónde queda |
|---|---|
| Reglas de trabajo y escritura (CLAUDE.md) | `~\.claude\CLAUDE.md` (si ya había uno, lo respeta y deja respaldo) |
| 43 skills propias y de terceros | `~\.claude\skills\` |
| Colección Vibe CPA (46 skills fiscales), bajada del repo oficial | `~\.claude\skills\vibe-cpa-pack\` |
| Cerebro (vault de Obsidian: negocio, voz, fiscal, plantillas, clientes, diario) | `Documentos\BookkeepingAlDia-Cerebro\` |
| Permisos: editar archivos y usar Python sin preguntar cada vez | `~\.claude\settings.json` |

Skills propias (escritas para Bookkeeping al Día): `aprender-de-johan` (se ajusta a sus correcciones y aprobaciones), `foreign-owned-llc-analyzer`, `eci-determination`, `form-5472-reviewer`, `1120-proforma-preparation`, `1065-foreign-partners`, `qbo-monthly-auditor` (con script de revisión probado), `llc-compliance-calendar`.

De terceros (MIT): Receiptor `bookkeeping-skills` (13) y 20 de Open Accountant. Voz y ventas de Johan: `bookkeeping-sales-mentor`, `humanize-writing`.

## Cosas que hay que saber

1. **Licencia de Vibe CPA.** Es Business Source License 1.1. El uso gratis cubre evaluación y la práctica personal de un CPA, EA o abogado con menos de 100 clientes. Bookkeeping al Día maneja más de 900 LLC, así que el uso en producción pide licencia comercial a Kisaes LLC (github.com/KisaesDevLab/vibe-claude-tax-research-skills). El kit baja Vibe del repo oficial y no lo redistribuye. Las 7 skills propias no dependen de Vibe: si se desinstala, siguen funcionando. Para quitarlo, borrar la carpeta `vibe-cpa-pack`.
2. **Open Accountant** habla de "Wilson tools" que no existen en Claude. Cada skill trae una nota que le dice a Claude que trabaje directo sobre los archivos de Johan.
3. **Receiptor** está pensado para Schedule C (residentes con 1040). Para LLC de no residentes mandan las skills propias; el CLAUDE.md ya lo indica.
4. **QuickBooks por MCP no está instalado a propósito.** Necesita credenciales del QuickBooks de Johan y decidir solo lectura. Ver `docs/FASE2-QuickBooks.md`.
5. **Verificado:** instalación completa en carpeta aislada (primera vez, segunda vez sin duplicar nada, respeta CLAUDE.md y settings previos), plugin Vibe cargado en Claude Code, script del auditor con autoprueba. **No verificado:** una conversación real con la cuenta de Johan; hacer la prueba del paso 5.

## Contenido del repo

```
INSTALAR.cmd            doble clic
scripts/instalar.ps1    el instalador
claude/CLAUDE.md        reglas para Claude (con marcas para actualizarse solo)
skills/                 42 skills
vault/                  el cerebro (vault de Obsidian)
docs/                   fase 2 y notas
THIRD_PARTY_LICENSES/   licencias de terceros
```
