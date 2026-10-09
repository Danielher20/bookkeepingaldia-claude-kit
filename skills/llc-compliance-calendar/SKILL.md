---
name: llc-compliance-calendar
description: Construye y mantiene el calendario de vencimientos federales, estatales y de extensiones por cliente (LLC de no residentes y de residentes). Usar cuando pidan "calendario fiscal", "qué vence este mes", "fechas de mis clientes", "annual report", "franchise tax", "recordatorio de 5472", "qué le toca a esta LLC".
---

# Calendario de cumplimiento por LLC

Genera, por cliente, la lista de fechas y quién debe hacer qué. Lo mejor de este calendario es que no depende de la memoria de nadie: sale de los datos del cliente.

## Datos por cliente

Tipo de entidad y clasificación federal, fin de año fiscal (casi siempre diciembre), estado de formación, estados donde opera o tiene empleados o nexo, dueño(s) residente o no residente, si tiene payroll, si tiene cuentas en el extranjero, si importa o vende con sales tax.

## Fechas federales base (año calendario). Confirmar cada año en IRS.gov

| Obligación | Aplica a | Fecha base | Extensión |
|---|---|---|---|
| 1120 pro forma + 5472 | LLC unipersonal con dueño extranjero | 15 de abril | Form 7004, 6 meses |
| 1120 | LLC o empresa que eligió corporación C | 15 de abril | Form 7004, 6 meses |
| 1120-S | Elección S | 15 de marzo | Form 7004, 6 meses |
| 1065 y K-1 | LLC multimiembro | 15 de marzo | Form 7004, 6 meses |
| 1040 | Dueño residente (Schedule C) | 15 de abril | Form 4868 |
| 1040-NR | Dueño no residente con ECI u otra obligación | 15 de abril (con salarios retenidos) o 15 de junio (sin ellos) | Form 4868 |
| 1099-NEC / W-2 | Empresas con pagos a contratistas o empleados | 31 de enero | Limitada |
| FBAR (FinCEN 114) | LLC con cuentas financieras en el extranjero sobre el umbral | 15 de abril | Prórroga automática a octubre |
| Pagos estimados | Dueños y entidades que deban | Trimestrales | No aplica |

Si el 15 cae en fin de semana o feriado federal, pasa al siguiente día hábil. Usa `due-date-calculator` para la fecha exacta del año.

## Estatales (ejemplos que Johan ve seguido, confirmar vigencia y monto en el sitio de cada estado)

- Delaware: impuesto anual de LLC, vence el 1 de junio.
- Wyoming: annual report e impuesto anual por licencia, vence el primer día del mes de aniversario.
- Florida: annual report, entre 1 de enero y 1 de mayo.
- New Mexico: sin annual report.
- California: impuesto anual de LLC y fee por ingresos; revisar fechas y primer año.
- Texas: franchise tax report, 15 de mayo.

Para cualquier otro estado: abrir el sitio de la Secretaría de Estado o del Departamento de Ingresos y anotar la fuente de cada fecha.

## Flujo

1. Leer la lista de clientes en `05_Clientes/` (o la que pase Johan).
2. Por cliente, derivar las obligaciones con `foreign-owned-llc-analyzer`.
3. Generar el calendario en Excel (una hoja por mes y una hoja resumen), con columnas: cliente, obligación, fecha, estado, responsable, documentos pendientes, fuente de la fecha.
4. Resaltar lo que vence en los próximos 30 y 60 días y lo vencido.
5. Para cada vencimiento próximo, dejar redactado el recordatorio al cliente en el estilo de Johan, listo para copiar.
6. Anotar en `06_Diario/` la fecha en que se generó el calendario y qué fuentes se consultaron.

## Qué no hacer

- No afirmar una fecha sin fuente. Si no se pudo verificar: "por confirmar".
- No programar ni enviar recordatorios solos. Johan los envía.
- No mezclar año fiscal calendario con años fiscales distintos sin preguntar.
