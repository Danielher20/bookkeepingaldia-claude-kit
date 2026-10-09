# Fase 2: conexión directa a QuickBooks Online (no instalada)

Hoy `qbo-monthly-auditor` trabaja con exportes (Excel o CSV) que Johan sube. La conexión directa por MCP se deja para después por tres razones:

1. Necesita credenciales del QuickBooks de Johan. Se crea una app en https://developer.intuit.com y se completa un acceso OAuth una sola vez. En producción Intuit exige una dirección HTTPS pública para el primer acceso.
2. Los servidores MCP de QuickBooks disponibles también pueden crear y editar datos. Hay que dejarlos en solo lectura o limitar las herramientas antes de usarlos con clientes reales.
3. Los estados bancarios, EIN y datos personales de clientes no deben pasar por código de terceros sin revisar qué permisos pide y dónde guarda los tokens.

## Candidatos

- Oficial de Intuit: https://github.com/intuit/quickbooks-online-mcp-server
- Alternativa con autenticación guiada desde Claude Code: https://github.com/laf-rge/quickbooks-mcp
- Daniel ya tiene BKFlow, que lee QuickBooks en vivo desde el navegador; puede cubrir parte de esto sin MCP.

## Orden recomendado

1. Probar primero con una empresa sandbox de Intuit y datos falsos.
2. Revisar el código de las herramientas expuestas y quitar las de escritura.
3. Guardar tokens en una carpeta fuera de las notas (`~\.quickbooks-mcp\`), nunca en el cerebro.
4. Conectar con la empresa real de un solo cliente y comparar tres reportes contra QuickBooks.
5. Recién ahí añadirlo a la configuración global.
