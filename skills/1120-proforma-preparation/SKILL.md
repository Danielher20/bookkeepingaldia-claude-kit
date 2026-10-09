---
name: 1120-proforma-preparation
description: Arma la lista de verificación y los papeles de trabajo para el Form 1120 pro forma con el Form 5472 adjunto de una LLC unipersonal con dueño extranjero. Usar cuando pidan "1120 pro forma", "preparar el paquete del 5472", "enviar el 5472 al IRS", "extensión 7004", "presentación tardía del 5472".
---

# Preparación del 1120 pro forma + 5472

Paquete de presentación para una LLC unipersonal (disregarded) con dueño extranjero. Aplica solo si la LLC NO eligió ser corporación. Si hay Form 8832 o 2553, el 1120 es real y este skill no sirve tal cual: avisar a Johan.

## Antes de empezar

1. `foreign-owned-llc-analyzer` confirmó que es una LLC unipersonal sin elección y con dueño extranjero.
2. `form-5472-reviewer` entregó el papel de trabajo conciliado y Johan lo aprobó.
3. Descargar de IRS.gov las versiones vigentes de Form 1120, Form 5472 y sus instrucciones para el año fiscal. No uses de memoria líneas ni casillas: pueden cambiar entre versiones.

## Lista de verificación

- [ ] Año fiscal correcto y fecha límite calculada (calendario: 15 de abril; con Form 7004 la extensión es de 6 meses). Confirmar con `due-date-calculator`.
- [ ] Nombre legal exacto, EIN (verificar contra carta CP 575 / 147C), dirección, fecha de formación.
- [ ] 1120 marcado como "Pro Forma" y completado solo con lo que piden las instrucciones del 5472 para entidades ignoradas propiedad de extranjeros. No se calcula impuesto en el pro forma.
- [ ] Un Form 5472 por cada parte relacionada extranjera con transacciones reportables.
- [ ] Partes I a III (identificación) coherentes con los datos del dueño; número de identificación fiscal extranjero si existe.
- [ ] Transacciones del papel de trabajo pasadas al formulario por tipo y en dólares, con el criterio de conversión documentado.
- [ ] Firma de una persona autorizada de la LLC, con cargo y fecha. Dejar claro quién firma antes de preparar el paquete.
- [ ] Copia completa archivada en `Entregas/<cliente>/<año>/`.
- [ ] Método de envío confirmado en IRS.gov para el año (históricamente fax o correo para el pro forma; verificar si cambió) y comprobante guardado: confirmación de fax o número de correo certificado.
- [ ] Registro en `05_Clientes/<cliente>.md`: fecha de envío, medio, comprobante, quién firmó.

## Presentación tardía o años atrasados

Si el formulario no se presentó a tiempo: no improvises. Preparar por cada año atrasado el paquete completo, una declaración de causa razonable (reasonable cause) con hechos reales del cliente, y dejar la decisión de ruta a Johan. Para el análisis de penalidades y de la respuesta ante avisos usar `penalty-interest-calc` y `notice-response`. Nunca prometas al cliente que la multa se eliminará.

## Salidas

1. Checklist firmado por Johan.
2. Papeles de trabajo en Excel (de `form-5472-reviewer`) y borrador del formulario como PDF para revisión.
3. Carta de envío breve.
4. Mensaje al cliente: qué se presentó, qué no cuesta más, qué sigue y cuándo. En el estilo de Johan (ver CLAUDE.md), sin promesas y sin jerga.

## Límites

No transmitas ni envíes nada. No firmes. No llenes casillas sin la instrucción del año abierta. Todo borrador sale marcado "BORRADOR PARA REVISIÓN DE JOHAN".
