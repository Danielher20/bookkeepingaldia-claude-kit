---
name: 1065-foreign-partners
description: Revisa datos y arma papeles de trabajo para la declaración Form 1065 de una LLC con 2 o más miembros donde hay socios extranjeros, incluyendo K-1, retenciones (sección 1446, FDAP) y formularios W-8. Usar cuando pidan "1065", "K-1", "LLC con socios", "socio extranjero", "retención a socios", "8804 / 8805", "partnership".
---

# 1065 con socios extranjeros

Para LLC multimiembro sin elección de corporación (tratada como partnership por defecto). Prepara el paquete y señala lo que cambia por tener socios no residentes.

## Primero verifica

1. Quiénes son los socios, porcentaje de cada uno, país de residencia, identificación fiscal (SSN, ITIN o extranjero) y si son personas o entidades.
2. ¿Hay elección de corporación (8832 / 2553)? Si sí, este skill no aplica.
3. ¿La LLC tuvo ingresos, deducciones o créditos en el año? Una sociedad doméstica sin nada que reportar puede no estar obligada a presentar; confirmarlo con las instrucciones del 1065 y Treas. Reg. 1.6031(a)-1 antes de decir "no presenta".
4. Estado de formación y estados donde opera.

## Lo que cambia con socios extranjeros

- **Retención sobre ECI (IRC §1446):** si la sociedad tiene ingreso conectado con un negocio en EE.UU. asignable a socios extranjeros, debe pagar retención y reportarla (Forms 8804, 8805, 8813; la tasa y los plazos se confirman en las instrucciones del año). Para saber si hay ECI usar `eci-determination` con los hechos de la sociedad.
- **Retención sobre FDAP (Capítulo 3 y 4):** pagos de intereses, regalías, rentas u otros ingresos de fuente EE.UU. a socios extranjeros pueden requerir retención y Form 1042 / 1042-S.
- **Documentación:** Forms W-8BEN o W-8BEN-E de cada socio. Sin documento vigente se presume retención máxima.
- **K-1 y anexos internacionales:** la asignación a cada socio se reporta en Schedule K-1; los anexos K-2 y K-3 aplican cuando hay socios extranjeros salvo excepción documentada en las instrucciones del año.
- **TIN:** socios extranjeros pueden necesitar ITIN para reclamar tratado o recibir ciertos reportes.
- **Transferencias de interés (IRC §1446(f)):** si un socio vende su participación, hay retención del comprador. Confirmar con Johan.
- **Penalidades:** presentación tardía y K-1 omitidos tienen penalidad por socio y por mes (montos indexados; verificar en las instrucciones del año).

## Flujo

1. Tabla de socios con datos y documentos que faltan.
2. Revisar el libro: capital de cada socio, aportes, retiros, pagos garantizados, préstamos de socios. Cuadrar capital inicial + aportes + resultado − retiros = capital final por socio.
3. Asignación del resultado según el acuerdo operativo (operating agreement). Si no existe acuerdo, avisar a Johan: la asignación por defecto sigue el porcentaje de capital y debe documentarse.
4. Determinar retenciones y formularios adicionales por socio.
5. Papel de trabajo en Excel: resumen por socio, conciliación de capital, retenciones, pendientes.
6. Fechas: 1065 el 15 de marzo para año calendario, extensión de 6 meses con Form 7004; K-1 en la misma fecha. Confirmar con `due-date-calculator`.
7. Revisión final de Johan. No firmes ni transmitas.

## Salidas

Checklist, papel de trabajo, lista de documentos que pedir al cliente, y borrador del correo al cliente en el estilo de Johan.

## Límites

La retención a socios extranjeros es una zona de multas altas. Cuando el cálculo dependa de ECI dudoso, de tratados o de transferencias de interés, dilo y recomienda investigación con fuentes primarias (`tax-research-international`).
