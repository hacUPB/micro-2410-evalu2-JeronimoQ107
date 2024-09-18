  #include "definitions.h"

  .syntax unified
  .global _start
  .extern estado_matriz  
  .text

  .thumb_func

_start:
    bl PTBC_init         
    bl gpioBC_init       
    bl systick_config   

    // Máquina de estados
    ldr r4, =Base_maquina_0
    mov r1, #FILA1                    
    str r1, [r4, #var_estado_M0]
    mov r2, #0
    str r2, [r4, entrada_tiempo_M0]   

    // Bucle principal
loop_principal:
    bl estado_matriz                
    b loop_principal                  


// Configuracion de los puertos como salidas
gpioBC_init:   
    ldr r7, =leds 
    ldr r0, =GPIOB_PDDR
    ldr r1, [r0]              
    mov r2, 0b11111111
    lsl r2, #COL1
    orr r1, r2   
    str r1, [r0]
    
    ldr r0, =GPIOC_PDDR
    ldr r1, [r0]               
    mov r2, 0b11111111
    lsl r2, #ROW1
    orr r1, r2   
    str r1, [r0]
    bx lr

    // Subrutina de configuración de periféricos
PTBC_init:
    // Habilitar el reloj para el puerto B
    ldr r0, =PCC_PORTB                 
    ldr r1, [r0]                       
    orr r1, r1, #PCC_PORT_CGC         
    str r1, [r0]

    // Habilitar el reloj para el puerto C
    ldr r0, =PCC_PORTC
    ldr r1, [r0]
    orr r1, r1, #PCC_PORT_CGC
    str r1, [r0]                       

PTB_init:
    // Configurar los puertos B PCR(10-17)
    mov r2, #7
    ldr r0, =PORTB_PCR10
loop_PTB_init:    
    ldr r1, [r0]                       
    bic r1, r1, #(0x7 << 8)            
    orr r1, r1, #(MUX_GPIO << 8)       
    str r1, [r0]
    cmp r2, #0
    beq PTC_init
    subs r2, r2, #1
    add r0, r0, #4  
    b loop_PTB_init
                           
PTC_init:
    // Configurar los puertos C PCR(8-15)
    mov r2, #7
    ldr r0, =PORTC_PCR8
loop_PTC_init:              
    ldr r1, [r0]                       
    bic r1, r1, #(0x7 << 8)            
    orr r1, r1, #(MUX_GPIO << 8)       
    str r1, [r0]
    cmp r2, #0
    beq saltar
    sub r2, r2, #1
    add r0, r0, #4 
    b loop_PTC_init

    // Retornar de la subrutina
saltar:
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
    str r1, [r0]                      // Habilitar el SysTick, la interrupción y seleccionar el reloj del procesador
    bx  lr