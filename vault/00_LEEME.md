# Cerebro de Bookkeeping al Día

Esta carpeta es la memoria de Claude para el trabajo de Johan. Johan solo escribe lo que necesita. Claude lee aquí el contexto y guarda lo que aprende, para que nadie tenga que repetirlo.

## Cómo está organizada

| Carpeta | Qué hay | Quién la escribe |
|---|---|---|
| `01_Negocio` | Quién es Bookkeeping al Día, servicios, cliente ideal, marca | Johan y Claude |
| `02_Voz-y-Escritura` | Cómo suena Johan, reglas contra el tono de IA, `Preferencias-aprendidas` (lo que Claude aprende de sus correcciones) y `Muestras` | Johan y Claude |
| `03_Fiscal` | Datos mínimos de diagnóstico, fuentes oficiales, mapa de skills | Claude |
| `04_Plantillas` | Correos y estructura de informes listos para adaptar | Johan y Claude |
| `05_Clientes` | Una nota por cliente: entidad, dueño, años presentados, pendientes | Claude |
| `06_Diario` | Registro corto de lo que se hizo cada día | Claude |
| `Entregas` | Informes, papeles de trabajo y borradores generados, por cliente | Claude |

## Reglas para Claude

1. Antes de trabajar en un cliente, abrir `05_Clientes/<cliente>.md`. Si no existe, crearlo desde `_PLANTILLA-CLIENTE.md` con lo que Johan ya haya dicho.
2. Después de cada trabajo, actualizar la nota del cliente y añadir una línea en `06_Diario/AAAA-MM.md`.
3. Guardar entregables en `Entregas/<cliente>/<AAAA>/` con nombres claros.
4. No guardar en estas notas: SSN, ITIN, número de pasaporte, números completos de cuenta bancaria o tarjeta, contraseñas ni códigos de acceso. Del EIN, solo los últimos 4 dígitos.
5. Si una nota choca con lo que Johan dice hoy, manda lo de hoy y se corrige la nota.
6. Los datos de cada cliente son solo de ese cliente. Nunca mezclar clientes en un mismo informe o correo.

## Para Johan

No hay que aprenderse nada. Escribe el problema como se lo dirías a un asistente: "prepárame el correo para Carlos con los reportes de septiembre", "revisa este balance", "qué le toca a esta LLC". Si Claude necesita algo, pregunta una sola cosa. Si algo no le gusta, solo dice "así no, más corto" o "así sí": Claude lo anota y la próxima vez ya sale bien.
