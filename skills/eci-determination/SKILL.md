---
name: eci-determination
description: Organiza los hechos de un dueño no residente para evaluar si su LLC genera ingreso conectado con un negocio en EE.UU. (ECI / ETBUS), qué ingresos son FDAP con retención, y si un tratado cambia el resultado. Usar cuando se pregunte "¿paga impuestos en EE.UU.?", "¿tiene ECI?", "¿necesita 1040-NR?", "trabaja desde EE.UU.", "tratado", "retención 30%".
---

# Determinación de ECI para dueños no residentes

Ordena los hechos y deja el análisis listo para que Johan lo confirme. No des un "sí" o "no" definitivo sin los hechos de abajo.

## Qué se decide

1. ¿El dueño (o la LLC, si es partnership o corporación) tiene un negocio en EE.UU. (trade or business)? IRC §864(b).
2. Si lo tiene, ¿qué ingreso es "effectively connected" (ECI)? IRC §864(c). Ese ingreso tributa a tasas normales, se declara (1040-NR, o 1120 / 1065 según entidad) y puede dar derecho a deducciones.
3. Si no lo tiene, ¿hay ingreso de fuente estadounidense fijo o determinable (FDAP: intereses, dividendos, regalías, rentas)? Normalmente 30% de retención (IRC §§871, 881, 1441, 1442) salvo tratado.
4. ¿Hay presencia física del dueño en EE.UU. que cambie la respuesta (días, trabajo hecho allá, test de presencia sustancial)?
5. ¿Aplica un tratado y se puede sostener? Form W-8BEN / W-8BEN-E y, si se toma posición de tratado en la declaración, Form 8833.

## Hechos que hay que levantar

- Dónde está físicamente el dueño cuando presta el servicio o hace el trabajo. Esto pesa más que dónde está el cliente. El servicio hecho fuera de EE.UU. suele ser fuente extranjera (IRC §862).
- Días en EE.UU. por año (últimos 3) y qué hizo en cada viaje.
- Tipo de ingreso: servicios, venta de productos digitales, venta de bienes físicos (la fuente depende de dónde pasa el título), comisiones, regalías, rentas, intereses, afiliados.
- Si existen en EE.UU.: oficina, empleados, contratistas que actúan como agentes, inventario, almacén (incluido fulfillment de terceros), bienes inmuebles.
- Quién paga: clientes en EE.UU. no convierten por sí solos el ingreso en ECI.
- País de residencia fiscal del dueño y si ese país tiene tratado de impuesto sobre la renta con EE.UU. (revisar la lista vigente en Pub. 901; no asumir por el país).
- Formularios W-8 existentes y qué le han retenido plataformas o clientes (Form 1042-S).
- Si la LLC eligió ser corporación (8832): cambia el análisis.

## Flujo

1. Cargar o crear `05_Clientes/<cliente>.md`.
2. Llenar la tabla de hechos con fuente de cada dato (declaración del cliente, contrato, estado bancario, pasaporte/sellos). Lo que solo dijo el cliente de palabra queda marcado "declarado, sin documento".
3. Aplicar el esquema: negocio en EE.UU. sí/no → ECI sí/no → FDAP → tratado → obligaciones de reporte y retención.
4. Dar una conclusión con banda de confianza: ALTA, MEDIA o BAJA, y qué dato la subiría.
5. Listar consecuencias prácticas: formularios a presentar, retenciones a pedir o corregir, si conviene `form-5472-reviewer` y `llc-compliance-calendar`.
6. Si el caso es complejo (trabajo en EE.UU., agentes dependientes, regalías, tratado), recomendar a Johan revisarlo con las skills de investigación fiscal (`tax-research-international`, `tax-research-entity`) y fuentes primarias.

## Salida

Una tabla de hechos, la conclusión con su banda de confianza, lo que falta, y el efecto en el trabajo del mes. Escrito para Johan en lenguaje normal y para el cliente (si se pide) sin jerga y sin prometer resultado fiscal.

## Fechas de referencia (confirmar para el año fiscal)

- 1040-NR: 15 de abril si hubo salarios con retención, 15 de junio si no. Las extensiones y fechas posteriores se confirman en las instrucciones del año.
- 5472 / 1120 pro forma: ver `form-5472-reviewer`.

## Prohibido

- "No paga impuestos en EE.UU." o "tiene que pagar" sin los hechos.
- Dar por buena una posición de tratado sin revisar el artículo y la cláusula de limitación de beneficios.
- Citar casos o secciones de memoria sin verificar. Si no está verificado, dilo.
