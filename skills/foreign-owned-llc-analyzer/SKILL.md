---
name: foreign-owned-llc-analyzer
description: Analiza una LLC de EE.UU. con dueño extranjero (no residente) y arma el mapa de obligaciones federales y estatales. Usar cuando Johan pida "revisa esta LLC", "qué le toca presentar a este cliente", "diagnóstico de LLC", "LLC sin movimiento", "cliente nuevo", o cuando se nombre una LLC con dueño fuera de EE.UU. Primer paso antes de eci-determination, form-5472-reviewer, 1120-proforma-preparation o 1065-foreign-partners.
---

# Analizador de LLC con dueño extranjero

Convierte los datos sueltos de un cliente en un diagnóstico de una página: qué es la entidad, quién la posee, qué formularios probablemente le tocan y qué falta para confirmarlo. Johan revisa y decide; tú preparas.

## Regla madre

No concluyas nada definitivo sin los datos de `03_Fiscal/Datos-minimos-diagnostico` del vault (los mismos de las reglas fiscales de seguridad). Si falta algo, el diagnóstico sale igual, pero con la sección "Falta confirmar" arriba y sin frases tipo "no tiene que declarar nada".

## Datos mínimos

1. Nombre legal, estado de formación, fecha de formación, EIN (en notas solo los últimos 4 dígitos).
2. Número de miembros y quién es cada uno: persona o empresa, país de residencia fiscal, ciudadanía.
3. Clasificación federal elegida: por defecto (disregarded / partnership) o con Form 8832 / 2553. Pedir la carta CP 575 o 147C y cualquier elección.
4. Actividad real, dónde se presta el servicio o se hace el trabajo, dónde están los clientes, si hay empleados, oficina, inventario o agentes en EE.UU.
5. Cuentas bancarias y plataformas de cobro (Mercury, Wise, Stripe, Payoneer, PayPal...) y desde cuándo.
6. Declaraciones y reportes ya presentados en años anteriores (5472, 1120 pro forma, 1065, annual report estatal).
7. Movimientos entre el dueño y la LLC: aportes, retiros, préstamos, gastos personales pagados desde la LLC o al revés.

## Flujo

1. Leer `05_Clientes/<cliente>.md` si existe y completar con lo que Johan acabe de decir.
2. Clasificar la entidad:
   - 1 miembro, sin elección: ignorada (disregarded) para impuesto federal. Con dueño extranjero aplica el régimen de 5472 + 1120 pro forma si hubo transacciones reportables (ver `form-5472-reviewer`).
   - 2 o más miembros, sin elección: partnership. Aplica `1065-foreign-partners`.
   - Con Form 8832 o 2553 vigente: se trata como corporación. No es "pro forma", es una 1120 o 1120-S real y el análisis cambia. Avisar a Johan.
3. Pasar la actividad por `eci-determination` para saber si hay ingreso conectado con negocio en EE.UU. (esto decide si hay impuesto federal o solo reporte).
4. Armar la lista de obligaciones con `llc-compliance-calendar` (federal + estado de formación + estados donde opere).
5. Marcar banderas rojas: años sin presentar, EIN sin confirmar, dueño que viaja y trabaja desde EE.UU., socios nuevos o cambio de dueño, préstamos del dueño, pagos a partes relacionadas, cuentas en el extranjero de la LLC.
6. Redactar la salida y guardarla en `05_Clientes/<cliente>.md` (sección "Diagnóstico" con fecha) y en `Entregas/<cliente>/`.

## Salida (una página)

- Resumen en 3 líneas: qué es la LLC y qué probablemente le toca.
- Tabla: obligación, formulario, fecha límite, estado (presentado / pendiente / por confirmar), base legal.
- Falta confirmar: lista corta de datos y documentos.
- Riesgos: lo que cuesta no presentar (por ejemplo, la penalidad por formulario 5472 no presentado) dicho con calma y sin exagerar.
- Siguiente paso concreto y a quién le toca.

## Fuentes oficiales (verificar vigencia del año fiscal)

- IRS: instrucciones del Form 5472 y del Form 1120; Pub. 519 (U.S. Tax Guide for Aliens); Pub. 901 (tratados).
- eCFR: Treas. Reg. 301.7701-2 y 301.7701-3 (clasificación), 1.6038A-1 y 1.6038A-2 (reporte).
- IRC: secciones 864, 871, 881, 6038A.
- Sitio del estado de formación (annual report / franchise tax).

Nunca inventes citas. Si no puedes abrir la fuente, escribe "verificar en [fuente]" y no des el dato como firme.

## Límites

Esto es un borrador de trabajo para un profesional. No presentes nada ante el IRS ni le digas al cliente que está "en regla" sin que Johan lo apruebe.
