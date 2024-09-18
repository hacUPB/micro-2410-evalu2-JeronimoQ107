#include "definitions.h"            // Incluir el archivo de definiciones.

.syntax unified                       // Especificar el uso de la sintaxis unificada.
.global estado_semaforo               // Declarar el símbolo `estado_semaforo` como global.
.text                                 // Indicar que el siguiente bloque es de código ejecutable.

.align 2                              // Alinear la dirección a un múltiplo de 4 bytes (2^2 = 4).

dir_tabla_estados:                    // Etiqueta para la tabla de direcciones de los estados.
  .long estado_rojo                   // Dirección de la función para el estado "rojo" (índice 0).
  .long estado_rojo_amarillo          // Dirección de la función para el estado "rojo-amarillo" (índice 1).
  .long estado_verde                  // Dirección de la función para el estado "verde" (índice 2).
  .long estado_amarillo               // Dirección de la función para el estado "amarillo" (índice 3).

.thumb_func                           // Indicar que la función siguiente debe ser compilada en modo Thumb.

estado_semaforo:                      // Etiqueta para la función `estado_semaforo`.
    push {lr}                         // Guardar el valor del registro de enlace en la pila.
    ldr r4, =Base_maquina_0           // Cargar la dirección base de la máquina en `r4`.
    ldr r0, [r4, #var_estado_M0]      // Cargar el estado actual del semáforo en `r0`.
    lsl r0, #2                        // Multiplicar el estado por 4 (desplazar a la izquierda por 2 bits).
    ldr r4, =dir_tabla_estados        // Cargar la dirección de la tabla de estados en `r4`.
    ldr r1, [r4, r0]                  // Cargar la dirección de la función del estado actual en `r1`.
    bx r1                             // Saltar a la dirección de la función del estado actual.

.thumb_func                           // Indicar que la función siguiente debe ser compilada en modo Thumb.

// El tiempo de comparación en cada estado debe ser el tiempo del estado pasado

estado_rojo:                          // Etiqueta para la función del estado "rojo".
    ldr r4, =Base_maquina_0           // Cargar la dirección base de la máquina en `r4`.
    ldr r0, [r4, #entrada_tiempo_M0]  // Cargar el tiempo de entrada actual en `r0`.
    ldr r5, =TIEMPO_AMARILLO          // Cargar el valor de `TIEMPO_AMARILLO` en `r5`.
    cmp r0, r5                        // Comparar el tiempo de entrada con `TIEMPO_AMARILLO`.
    blt fin_estado                    // Si el tiempo es menor, saltar a `fin_estado`.

    // Salidas
    ldr r0, =GPIOB_PSOR               // Cargar la dirección del registro de salida en `r0`.
    mov r1, #((1 << LED_VERDE) | (1 << LED_AMARILLO))     // Preparar el valor para apagar los LEDs verde y amarillo.
    str r1, [r0]                      // Escribir el valor en el registro `GPIOB_PSOR`.

    ldr r0, =GPIOB_PCOR               // Cargar la dirección del registro de limpieza en `r0`.
    mov r1, #(1 << LED_ROJO)          // Preparar el valor para encender el LED rojo.
    str r1, [r0]                      // Escribir el valor en el registro `GPIOB_PCOR`.

    // Cambiar al siguiente estado
    mov r1, #ROJO_AMARILLO            // Preparar el valor `ROJO_AMARILLO` para el siguiente estado.
    str r1, [r4, #var_estado_M0]      // Guardar el siguiente estado en la dirección base.
    mov r2, #0                        // Preparar el valor 0 para el temporizador.
    str r2, [r4, entrada_tiempo_M0]   // Reiniciar el temporizador a 0.
    pop {lr}                          // Restaurar el valor del registro de enlace desde la pila.
    bx lr                             // Volver a la dirección de retorno almacenada en `lr`.

.thumb_func                           // Indicar que la función siguiente debe ser compilada en modo Thumb.

estado_rojo_amarillo:                 // Etiqueta para la función del estado "rojo-amarillo".
    ldr r4, =Base_maquina_0           // Cargar la dirección base de la máquina en `r4`.
    ldr r0, [r4, #entrada_tiempo_M0]  // Cargar el tiempo de entrada actual en `r0`.
    ldr r5, =TIEMPO_ROJO              // Cargar el valor de `TIEMPO_ROJO` en `r5`.
    cmp r0, r5                        // Comparar el tiempo de entrada con `TIEMPO_ROJO`.
    blt fin_estado                    // Si el tiempo es menor, saltar a `fin_estado`.

    // Configura la salida
    ldr r0, =GPIOB_PSOR               // Cargar la dirección del registro de salida en `r0`.
    mov r1, #(1 << LED_VERDE)         // Preparar el valor para apagar el LED verde.
    str r1, [r0]                      // Escribir el valor en el registro `GPIOB_PSOR`.

    ldr r0, =GPIOB_PCOR               // Cargar la dirección del registro de limpieza en `r0`.
    mov r1, #((1 << LED_ROJO) | (1 << LED_AMARILLO))      // Preparar el valor para endender los LEDs rojo y amarillo.
    str r1, [r0]                      // Escribir el valor en el registro `GPIOB_PCOR`.

    // Cambiar al siguiente estado
    mov r1, #VERDE                    // Preparar el valor `VERDE` para el siguiente estado.
    str r1, [r4, #var_estado_M0]      // Guardar el siguiente estado en la dirección base.
    mov r2, #0                        // Preparar el valor 0 para el temporizador.
    str r2, [r4, entrada_tiempo_M0]   // Reiniciar el temporizador a 0.
    pop {lr}                          // Restaurar el valor del registro de enlace desde la pila.
    bx lr                             // Volver a la dirección de retorno almacenada en `lr`.

.thumb_func                           // Indicar que la función siguiente debe ser compilada en modo Thumb.

estado_verde:                         // Etiqueta para la función del estado "verde".
    ldr r4, =Base_maquina_0           // Cargar la dirección base de la máquina en `r4`.
    ldr r0, [r4, #entrada_tiempo_M0]  // Cargar el tiempo de entrada actual en `r0`.
    ldr r5, =TIEMPO_ROJO_AMARILLO     // Cargar el valor de `TIEMPO_ROJO_AMARILLO` en `r5`.
    cmp r0, r5                        // Comparar el tiempo de entrada con `TIEMPO_ROJO_AMARILLO`.
    blt fin_estado                    // Si el tiempo es menor, saltar a `fin_estado`.

    // Configura salida
    ldr r0, =GPIOB_PSOR               // Cargar la dirección del registro de salida en `r0`.
    mov r1, #((1 << LED_ROJO) | (1 << LED_AMARILLO))      // Preparar el valor para apagar los LEDs rojo y amarillo.
    str r1, [r0]                      // Escribir el valor en el registro `GPIOB_PSOR`.

    ldr r0, =GPIOB_PCOR               // Cargar la dirección del registro de limpieza en `r0`.
    mov r1, #(1 << LED_VERDE)         // Preparar el valor para encender el LED verde.
    str r1, [r0]                      // Escribir el valor en el registro `GPIOB_PCOR`.

    // Cambiar al siguiente estado
    mov r1, #AMARILLO                 // Preparar el valor `AMARILLO` para el siguiente estado.
    str r1, [r4, #var_estado_M0]      // Guardar el siguiente estado en la dirección base.
    mov r2, #0                        // Preparar el valor 0 para el temporizador.
    str r2, [r4, entrada_tiempo_M0]   // Reiniciar el temporizador a 0.
    pop {lr}                          // Restaurar el valor del registro de enlace desde la pila.
    bx lr                             // Volver a la dirección de retorno almacenada en `lr`.

.thumb_func                           // Indicar que la función siguiente debe ser compilada en modo Thumb.

estado_amarillo:                      // Etiqueta para la función del estado "amarillo".
    ldr r4, =Base_maquina_0           // Cargar la dirección base de la máquina en `r4`.
    ldr r0, [r4, #entrada_tiempo_M0]  // Cargar el tiempo de entrada actual en `r0`.
    ldr r5, =TIEMPO_VERDE             // Cargar el valor de `TIEMPO_VERDE` en `r5`.
    cmp r0, r5                        // Comparar el tiempo de entrada con `TIEMPO_VERDE`.
    blt fin_estado                    // Si el tiempo es menor, saltar a `fin_estado`.

    // Configurar salida
    ldr r0, =GPIOB_PSOR               // Cargar la dirección del registro de salida en `r0`.
    mov r1, #((1 << LED_ROJO) | (1 << LED_VERDE))        // Preparar el valor para apagar los LEDs rojo y verde.
    str r1, [r0]                      // Escribir el valor en el registro `GPIOB_PSOR`.

    ldr r0, =GPIOB_PCOR               // Cargar la dirección del registro de limpieza en `r0`.
    mov r1, #(1 << LED_AMARILLO)      // Preparar el valor para encender el LED amarillo.
    str r1, [r0]                      // Escribir el valor en el registro `GPIOB_PCOR`.

    // Cambiar al siguiente estado
    mov r1, #ROJO                     // Preparar el valor `ROJO` para el siguiente estado.
    str r1, [r4, #var_estado_M0]      // Guardar el siguiente estado en la dirección base.
    mov r2, #0                        // Preparar el valor 0 para el temporizador.
    str r2, [r4, entrada_tiempo_M0]   // Reiniciar el temporizador a 0.
    pop {lr}                          // Restaurar el valor del registro de enlace desde la pila.
    bx lr                             // Volver a la dirección de retorno almacenada en `lr`.

fin_estado:                           // Etiqueta para finalizar el estado.
    pop {lr}                          // Restaurar el valor del registro de enlace desde la pila.
    bx lr                             // Volver a la dirección de retorno almacenada en `lr`.