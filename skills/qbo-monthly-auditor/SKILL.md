---
name: qbo-monthly-auditor
description: Audita los libros de QuickBooks Online de un cliente antes de cerrar el mes. Detecta duplicados, cuentas sin clasificar, saldos negativos o raros, aportes y retiros del dueño mal clasificados, fechas fuera de período y partidas pendientes. Usar cuando pidan "revisa el QuickBooks", "auditar el mes", "libros listos para cerrar", "algo no cuadra", o al subir un exporte de QuickBooks (Excel o CSV).
---

# Auditor mensual de QuickBooks

Trabaja sobre exportes que Johan suba (Excel o CSV). Si en el futuro hay conexión directa a QuickBooks, se usará solo en modo lectura.

## Exportes que pedir (si no los trae)

1. Transaction List by Date (o General Ledger) del período, con todas las columnas.
2. Trial Balance al cierre del período.
3. Balance Sheet y Profit and Loss del período.
4. Reconciliation Reports de cada cuenta bancaria, si hay.
5. Opcional: A/R y A/P Aging.

Pedir solo lo que falte, en una sola frase.

## Revisión automática

Ejecutar el script incluido sobre el exporte de transacciones:

```
python <carpeta de esta skill>/scripts/auditar_qbo.py <archivo.csv> --desde AAAA-MM-DD --hasta AAAA-MM-DD
```

Si el archivo viene en Excel, convertirlo a CSV primero (con pandas u openpyxl; instalar con `pip install openpyxl` si falta). El script marca: posibles duplicados, transacciones sin cuenta o en "Uncategorized", movimientos del dueño (aportes, retiros, préstamos) y en qué cuenta están, fechas fuera del período, montos redondos grandes y montos cero.

## Revisión manual guiada (con Balance Sheet y Trial Balance)

- Opening Balance Equity distinto de cero.
- Undeposited Funds con saldo viejo.
- Bancos o tarjetas con saldo negativo que no corresponde (ver sobregiros reales).
- Saldos de cuentas por cobrar o pagar muy viejos.
- Cuentas de ingresos con retiros o aportes mezclados.
- Gastos personales del dueño dentro de gastos del negocio.
- Pagos a contratistas sin W-9 y sobre el umbral de 1099 (si aplica).
- Diferencias de tipo de cambio sin explicación (clientes que cobran en moneda extranjera).
- Cuenta de retiros o aportes con saldo contrario a su naturaleza.
- Período ya cerrado en QuickBooks pero con movimientos nuevos (revisar Audit Log).
- Conciliación bancaria: saldo final del banco = saldo de QuickBooks al cierre.

## Salida

1. Veredicto en una frase: listo para cerrar / se puede cerrar con ajustes / no se puede cerrar todavía.
2. Hallazgos en tabla: severidad (alta, media, baja), qué es, dónde está, impacto y qué hacer. Máximo 15 filas; si hay más, agrupar.
3. Lista de preguntas para el cliente, redactadas en el estilo de Johan.
4. Ajustes propuestos como asientos sugeridos. No los registres en QuickBooks.

Después de este paso, usar `monthly-close` para cerrar y `form-5472-reviewer` si el cliente es LLC con dueño extranjero.

## Límites

Solo lectura. Sin credenciales de QuickBooks guardadas en ninguna nota. Cifras que no cuadran se reportan tal cual, nunca se ajustan para que cuadren.
