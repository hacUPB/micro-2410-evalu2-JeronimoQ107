  #include "definitions.h"

  .syntax unified
  .global _start
  .extern estado_semaforo  
  .text

  .thumb_func

_start:
    bl PTB_init         
    bl gpioB_init       
    bl systick_config   

    // Máquina de estados
    ldr r4, =Base_maquina_0
    mov r1, #ROJO                     
    str r1, [r4, #var_estado_M0]
    mov r2, #0
    str r2, [r4, entrada_tiempo_M0]   

    // Bucle principal
loop_principal:
    bl estado_semaforo                
    b loop_principal                  


// Configuraciones iniciales
gpioB_init:    
    ldr r0, =GPIOB_PDDR               
    ldr r1, [r0]
    orr r1, r1, #(1 << LED_ROJO)      
    orr r1, r1, #(1 << LED_AMARILLO)  
    orr r1, r1, #(1 << LED_VERDE)     
    str r1, [r0]                // Indico que los pines son salidas (outputs)

    ldr r0, =GPIOB_PSOR
    mov r1, #((1 << LED_ROJO) | (1 << LED_AMARILLO) | (1 << LED_VERDE)) 
    str r1, [r0]                // Apago todos los leds
             
    bx  lr


    // Subrutina de configuración de periféricos
PTB_init:
    // Habilitar el reloj para el puerto B
    ldr r0, =PCC_PORTB                 
    ldr r1, [r0]                       
    orr r1, r1, #PCC_PORTB_CGC         
    str r1, [r0]                       

    // Configurar el puerto
    ldr r0, =PORTB_PCR12               
    ldr r1, [r0]                       
    bic r1, r1, #(0x7 << 8)            
    orr r1, r1, #(MUX_GPIO << 8)       
    str r1, [r0]                       

    // Configurar el puerto
    ldr r0, =PORTB_PCR13               
    ldr r1, [r0]
    bic r1, r1, #(0x7 << 8)
    orr r1, r1, #(MUX_GPIO << 8)
    str r1, [r0]

    // Configurar el puerto
    ldr r0, =PORTB_PCR14               
    ldr r1, [r0]
    bic r1, r1, #(0x7 << 8)
    orr r1, r1, #(MUX_GPIO << 8)
    str r1, [r0]

    // Retornar de la subrutina
    bx lr


systick_config:
   // Configurar SysTick 
    ldr r0, =SYST_RVR
    ldr r1, =SYSTICK_RELOAD_1MS
    str r1, [r0]                      

    ldr r0, =SYST_CVR
    mov r1, #0
    str r1, [r0]                      

    ldr r0, =SYST_CSR
    mov r1, #(SYSTICK_ENABLE | SYSTICK_TICKINT | SYSTICK_CLKSOURCE)
    str r1, [r0]              // Habilitar el SysTick, la interrupción y seleccionar el reloj del procesador
    bx  lr