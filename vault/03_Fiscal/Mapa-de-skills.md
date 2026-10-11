# Qué skill usar según lo que pida Johan

Claude elige solo. Esta tabla sirve para saber qué hay instalado.

## Para LLC de no residentes (lo propio de Bookkeeping al Día)

| Johan dice | Skill |
|---|---|
| "Revisa esta LLC", "cliente nuevo", "qué le toca" | `foreign-owned-llc-analyzer` |
| "¿Paga impuestos en EE.UU.?", "ECI", "tratado" | `eci-determination` |
| "5472", "aportes y retiros del dueño" | `form-5472-reviewer` |
| "1120 pro forma", "armar el paquete", "7004" | `1120-proforma-preparation` |
| "1065", "K-1", "socio extranjero" | `1065-foreign-partners` |
| "Calendario", "qué vence este mes" | `llc-compliance-calendar` |

## Investigación fiscal (colección Vibe CPA, plugin `vibe-cpa-pack`)

`tax-research-international`, `tax-research-entity`, `tax-research-federal`, `tax-research-procedure`, `tax-research-state-income`, `notice-response`, `due-date-calculator`, `penalty-interest-calc`, `engagement-letter-library`, `irc-section-lookup`, `treas-reg-lookup`, y más de 30 más. Se activan solas por la pregunta.

## Bookkeeping diario (Receiptor)

`bookkeeping-setup`, `receipt-processing`, `expense-categorization`, `bank-reconciliation`, `monthly-close`, `tax-prep`, `contractor-1099`, `depreciation-assets`. Las de Schedule C, oficina en casa, vehículo, comidas y pagos estimados aplican a residentes de EE.UU. con 1040; para LLC de no residentes sin ECI no suelen aplicar.

## Análisis financiero (Open Accountant)

`profit-loss`, `cash-flow-forecast`, `invoice-aging`, `client-profitability`, `revenue-concentration`, `break-even-calc`, `seasonal-patterns`, `pricing-optimizer`, `multi-entity`, `monthly-digest`, `year-end-summary`, `custom-report`, `depreciation-schedule`, `sales-tax-nexus`, `contractor-tracking`, e importadores de Wise, Stripe, PayPal y Square.

## Comunicación y ventas

`humanize-writing` (siempre en textos largos), `bookkeeping-sales-mentor` (responder chats de cliente, objeciones, precios, seguimientos).

## Aprende de Johan

`aprender-de-johan`: cada corrección o aprobación queda guardada en `02_Voz-y-Escritura/Preferencias-aprendidas.md` y la próxima vez ya sale ajustado.
