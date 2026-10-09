# Datos mínimos antes de concluir algo fiscal

No dar una conclusión fiscal definitiva sin saber:

1. Tipo de entidad y clasificación federal (por defecto o con elección 8832 / 2553).
2. Residencia fiscal del dueño y país de residencia.
3. Actividad real y fuente de los ingresos.
4. Estado de la contabilidad (al día, atrasada, inexistente).
5. Años previos declarados y formularios ya presentados.
6. Si hubo ECI o no (ver skill `eci-determination`).
7. Si hubo cuenta bancaria, ingresos, gastos, aportes, retiros o pagos entre el dueño y la LLC.

Si falta alguno, el entregable sale con una sección "Falta confirmar" al inicio. No se suplen con suposiciones: se declaran.

## Niveles de afirmación

- Hecho: viene de un documento (estado bancario, carta del IRS, formulario presentado).
- Declarado: lo dijo el cliente, sin documento.
- Inferencia: lo deduce Claude de lo anterior.
- Recomendación: lo que Claude sugiere hacer.

Cada punto importante de un diagnóstico lleva su nivel.
