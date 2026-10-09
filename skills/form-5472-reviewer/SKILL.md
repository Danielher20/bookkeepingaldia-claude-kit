---
name: form-5472-reviewer
description: Revisa y concilia las transacciones entre una LLC de EE.UU. y su dueño o partes relacionadas extranjeras para preparar el Form 5472. Usar cuando pidan "5472", "transacciones reportables", "aportes y retiros del dueño", "revisar el QuickBooks para el 5472", "multa de 25,000", o al cerrar el año de una LLC con dueño extranjero.
---

# Revisor de Form 5472

El 5472 se arma desde la contabilidad. Este skill recorre el libro del año, encuentra toda transacción con partes relacionadas, la concilia contra el banco y deja la información lista para llenar el formulario vigente.

## Cuándo aplica (verificar en las instrucciones del año)

- Corporación de EE.UU. con 25% o más en manos de un extranjero, y LLC de un solo miembro con dueño extranjero (se trata como corporación solo para el reporte, Treas. Reg. 301.7701-2(c)(2)(vi)).
- Se presenta si hubo transacciones reportables con una parte relacionada extranjera en el año. Un aporte de capital o un retiro cuenta. "Cero ingresos" no es lo mismo que "cero transacciones reportables".
- Penalidad por no presentar o por no mantener registros: US$25,000 por formulario por año, más US$25,000 por cada 30 días después de un aviso del IRS (IRC §6038A(d)). Confirmar el monto y las reglas en la versión vigente.
- Se adjunta a un 1120 pro forma (ver `1120-proforma-preparation`). Fecha límite igual a la de la 1120; prórroga con Form 7004.

## Datos que necesitas

- Libro mayor (General Ledger) o lista de transacciones del año completo, exportado de QuickBooks en Excel o CSV.
- Estados bancarios de todas las cuentas de la LLC y de plataformas (Wise, Stripe, PayPal, Payoneer).
- Identificación del dueño y de cualquier parte relacionada: nombre, país, dirección, número de identificación fiscal extranjero si existe, relación.
- Prestamos del dueño a la LLC o al revés, con saldo inicial y final.
- Gastos de la LLC pagados con tarjeta o cuenta personal del dueño, y gastos personales pagados desde la LLC.

## Flujo

1. Identificar partes relacionadas: dueño, familiares cercanos, otras empresas del dueño dentro o fuera de EE.UU., cualquier entidad bajo control común.
2. Buscar en el libro, por nombre y por cuentas: `Owner's Contributions`, `Owner's Draws / Distributions`, `Loan from Owner`, `Due to/from`, `Opening Balance Equity`, y toda transacción con nombre de la parte relacionada, aunque esté en otra cuenta (ingresos, gastos, pagos de software).
3. Clasificar cada movimiento por tipo de transacción del formulario: aportes de capital, distribuciones, préstamos recibidos y pagados, servicios recibidos o prestados, compras y ventas, rentas, regalías, intereses, reembolsos. Usar las categorías de la versión vigente del Form 5472.
4. Conciliar: el total de aportes y retiros del libro debe cuadrar con los movimientos reales del banco. Anotar diferencias de tipo de cambio y el criterio usado para convertir a dólares.
5. Detectar errores de contabilización: aportes registrados como ingreso, retiros registrados como gasto, gastos personales del dueño dentro de gastos del negocio, pagos al dueño sin documentar.
6. Entregar el papel de trabajo (ver abajo) y la lista de dudas.
7. Pedir a Johan la revisión antes de llenar el formulario. El formulario lo firma una persona autorizada de la LLC.

## Papel de trabajo (Excel)

Hoja 1 Resumen por tipo de transacción y por parte relacionada. Hoja 2 Detalle (fecha, descripción, cuenta, monto USD, moneda original, tipo de cambio, documento de soporte, tipo de transacción para el 5472). Hoja 3 Conciliación con el banco. Hoja 4 Dudas y ajustes propuestos (no los hagas en QuickBooks sin aprobación).

## Banderas rojas

- Retiros grandes sin aporte previo: puede ser préstamo, no distribución.
- Pagos al dueño etiquetados como "sueldo" o "honorarios": tienen otro tratamiento.
- Cuentas con saldo negativo de capital.
- Dos LLC del mismo dueño que se pagan entre sí: cada una reporta la otra como parte relacionada.
- Años anteriores sin presentar: avisar a Johan para que decida la ruta (presentación tardía con explicación de causa razonable, etc.).

## Límites

Tú preparas el análisis y el papel de trabajo. Johan decide qué se reporta y firma. No llenes ni envíes el formulario por tu cuenta. Si el IRS ya mandó un aviso, usa `notice-response` (de la colección Vibe CPA) y detén todo lo demás.
