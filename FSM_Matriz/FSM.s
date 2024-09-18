   #include "definitions.h"

  .syntax unified
  .global estado_matriz
  .text
  .align 2                // Alinear la tabla de direcciones a 4 bytes (2^2 = 4)

   // Lista de direcciones de los estados
dir_tabla_estados:
  .long estado_fila1       //0
  .long estado_fila2       //1
  .long estado_fila3       //2
  .long estado_fila4       //3
  .long estado_fila5       //4
  .long estado_fila6       //5
  .long estado_fila7       //6
  .long estado_fila8       //7

    .thumb_func
    
    ldr r7, =leds
estado_matriz:
    push {lr}
    ldr r4, =Base_maquina_0
    ldr r0, [r4, #var_estado_M0]   
    lsl r0, #2                     
    ldr r4, =dir_tabla_estados     
    ldr r1, [r4, r0]               
    bx r1                          

    .thumb_func
estado_fila1:
    ldr r4, =Base_maquina_0
    ldr r0, [r4, #entrada_tiempo_M0]  
    mov r5, #TIEMPO_CAMBIO             
    cmp r0, r5
    blt fin_estado                    

    // Salidas
    ldr r0, =GPIOB_PDOR
    ldrb r2, [r7], #1
    lsl r2, #COL1
    str r2, [r0]                     

    ldr r0, =GPIOC_PSOR
    mov r1, #initrow        // Estado a apagar
    lsl r1, #ROW1
    str r1, [r0]
    ldr r0, =GPIOC_PCOR
    mov r1, #(1 << ROW1)    // Estado a encender
    str r1, [r0]

    // Cambiar al siguiente estado 
    mov r1, #FILA2
    str r1, [r4, #var_estado_M0]
    mov r0, #0
    str r0, [r4, #entrada_tiempo_M0] 
    pop {lr}
    bx lr

    .thumb_func
estado_fila2:
    ldr r4, =Base_maquina_0
    ldr r0, [r4, #entrada_tiempo_M0]  
    mov r5, #TIEMPO_CAMBIO             
    cmp r0, r5
    blt fin_estado                    

    // Salidas
    ldr r0, =GPIOB_PDOR
    ldrb r2, [r7], #1
    lsl r2, #COL1
    str r2, [r0]                      
                  
    ldr r0, =GPIOC_PSOR
    mov r1, #(1 << ROW1)    // Estado a apagar
    str r1, [r0]
    ldr r0, =GPIOC_PCOR
    mov r1, #(1 << ROW2)    // Estado a encender
    str r1, [r0]

    // Cambiar al siguiente estado 
    mov r1, #FILA3
    str r1, [r4, #var_estado_M0]
    mov r2, #0
    str r2, [r4, entrada_tiempo_M0]  
    pop {lr}
    bx lr
  
    .thumb_func
estado_fila3:
    ldr r4, =Base_maquina_0
    ldr r0, [r4, #entrada_tiempo_M0]  
    mov r5, #TIEMPO_CAMBIO             
    cmp r0, r5
    blt fin_estado                    

    // Salidas
    ldr r0, =GPIOB_PDOR
    ldrb r2, [r7], #1
    lsl r2, #COL1
    str r2, [r0]                      
                  
    ldr r0, =GPIOC_PSOR
    mov r1, #(1 << ROW2)    // Estado a apagar
    str r1, [r0]
    ldr r0, =GPIOC_PCOR
    mov r1, #(1 << ROW3)    // Estado a encender
    str r1, [r0]


    // Cambiar al siguiente estado 
    mov r1, #FILA4
    str r1, [r4, #var_estado_M0]
    mov r2, #0
    str r2, [r4, entrada_tiempo_M0]  
    pop {lr}
    bx lr
  
    .thumb_func
estado_fila4:
    ldr r4, =Base_maquina_0
    ldr r0, [r4, #entrada_tiempo_M0]  
    mov r5, #TIEMPO_CAMBIO             
    cmp r0, r5
    blt fin_estado                    

    // Salidas
    ldr r0, =GPIOB_PDOR
    ldrb r2, [r7], #1
    lsl r2, #COL1
    str r2, [r0]                      
                  
    ldr r0, =GPIOC_PSOR
    mov r1, #(1 << ROW3)    // Estado a apagar
    str r1, [r0]
    ldr r0, =GPIOC_PCOR
    mov r1, #(1 << ROW4)    // Estado a encender
    str r1, [r0]

    // Cambiar al siguiente estado 
    mov r1, #FILA5
    str r1, [r4, #var_estado_M0]
    mov r2, #0
    str r2, [r4, entrada_tiempo_M0]  
    pop {lr}
    bx lr
  
    .thumb_func
estado_fila5:
    ldr r4, =Base_maquina_0
    ldr r0, [r4, #entrada_tiempo_M0]  
    mov r5, #TIEMPO_CAMBIO             
    cmp r0, r5
    blt fin_estado                    

    // Salidas
    ldr r0, =GPIOB_PDOR
    ldrb r2, [r7], #1
    lsl r2, #COL1
    str r2, [r0]                      
                  
    ldr r0, =GPIOC_PSOR
    mov r1, #(1 << ROW4)    // Estado a apagar
    str r1, [r0]
    ldr r0, =GPIOC_PCOR
    mov r1, #(1 << ROW5)    // Estado a encender
    str r1, [r0]

    // Cambiar al siguiente estado 
    mov r1, #FILA6
    str r1, [r4, #var_estado_M0]
    mov r2, #0
    str r2, [r4, entrada_tiempo_M0]  
    pop {lr}
    bx lr
  
    .thumb_func
estado_fila6:
    ldr r4, =Base_maquina_0
    ldr r0, [r4, #entrada_tiempo_M0]  
    mov r5, #TIEMPO_CAMBIO             
    cmp r0, r5
    blt fin_estado                    

    // Salidas
    ldr r0, =GPIOB_PDOR
    ldrb r2, [r7], #1
    lsl r2, #COL1
    str r2, [r0]                      
                  
    ldr r0, =GPIOC_PSOR
    mov r1, #(1 << ROW5)    // Estado a apagar
    str r1, [r0]
    ldr r0, =GPIOC_PCOR
    mov r1, #(1 << ROW6)    // Estado a encender
    str r1, [r0]

    // Cambiar al siguiente estado 
    mov r1, #FILA7
    str r1, [r4, #var_estado_M0]
    mov r2, #0
    str r2, [r4, entrada_tiempo_M0]  
    pop {lr}
    bx lr
  
    .thumb_func
estado_fila7:
    ldr r4, =Base_maquina_0
    ldr r0, [r4, #entrada_tiempo_M0]  
    mov r5, #TIEMPO_CAMBIO             
    cmp r0, r5
    blt fin_estado                    

    // Salidas
    ldr r0, =GPIOB_PDOR
    ldrb r2, [r7], #1
    lsl r2, #COL1
    str r2, [r0]                      
                  
    ldr r0, =GPIOC_PSOR
    mov r1, #(1 << ROW6)    // Estado a apagar
    str r1, [r0]
    ldr r0, =GPIOC_PCOR
    mov r1, #(1 << ROW7)    // Estado a encender
    str r1, [r0]

    // Cambiar al siguiente estado 
    mov r1, #FILA8
    str r1, [r4, #var_estado_M0]
    mov r2, #0
    str r2, [r4, entrada_tiempo_M0]  
    pop {lr}
    bx lr
  
    .thumb_func
estado_fila8:
    ldr r4, =Base_maquina_0
    ldr r0, [r4, #entrada_tiempo_M0]  
    mov r5, #TIEMPO_CAMBIO             
    cmp r0, r5
    blt fin_estado                    

    // Salidas
    ldr r0, =GPIOB_PDOR
    ldrb r2, [r7], #1
    lsl r2, #COL1
    str r2, [r0]                      
                  
    ldr r0, =GPIOC_PSOR
    mov r1, #(1 << ROW7)    // Estado a apagar
    str r1, [r0]
    ldr r0, =GPIOC_PCOR
    mov r1, #(1 << ROW8)    // Estado a encender
    str r1, [r0]

    // Cambiar al siguiente estado 
    mov r1, #FILA1
    str r1, [r4, #var_estado_M0]
    mov r2, #0
    str r2, [r4, entrada_tiempo_M0]
    ldr r7, =leds
    pop {lr}
    bx lr
  
fin_estado:
    pop {lr}
    bx lr