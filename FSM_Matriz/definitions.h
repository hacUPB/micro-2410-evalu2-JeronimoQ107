    .text
    
    // Direcciones de los registros SysTick
    .equ SYSTICK_BASE, 0xE000E010        // Base del SysTick
    .equ SYST_CSR, (SYSTICK_BASE + 0x0)  // SysTick Control and Status Register
    .equ SYST_RVR, (SYSTICK_BASE + 0x4)  // SysTick Reload Value Register
    .equ SYST_CVR, (SYSTICK_BASE + 0x8)  // SysTick Current Value Register

    .equ SYSTICK_ENABLE, 0x1             // Bit para habilitar el SysTick
    .equ SYSTICK_TICKINT, 0x2            // Bit para habilitar la interrupción del SysTick
    .equ SYSTICK_CLKSOURCE, 0x4          // Bit para seleccionar el reloj del procesador

    .equ SYSTICK_RELOAD_1MS, 48000-1     // Valor para recargar el SysTick cada 1 ms (suponiendo un reloj de 48 MHz)
    
    // Dirección base y offsets
    .equ Base_maquina_0, 0x20001000      // Dirección base compartida
    .equ var_estado_M0, 0                // Offset para la variable de estado
    .equ entrada_tiempo_M0, 4            // Offset para la entrada de tiempo transcurrido

    // Direcciones de los registros GPIO (Ejemplo para Kinetis K64)
    .equ GPIOB_PDDR, 0x400FF054          // Registro de dirección de datos del puerto B
    .equ GPIOB_PDOR, 0x400FF040          // Registro de salida de datos del puerto B
    .equ GPIOB_PSOR, 0x400FF044          // Registro de establecer bits de salida en puerto B
    .equ GPIOB_PCOR, 0x400FF048          // Registro de limpiar bits de salida en puerto B
    .equ GPIOB_PTOR, 0x400FF04C          // Registro de alternancia de datos del puerto B

    .equ GPIOC_PDDR, 0x400FF094          // Registro de dirección de datos del puerto C
    .equ GPIOC_PDOR, 0x400FF080          // Registro de salida de datos del puerto C
    .equ GPIOC_PSOR, 0x400FF084          // Registro de establecer bits de salida en puerto C
    .equ GPIOC_PCOR, 0x400FF088          // Registro de limpiar bits de salida en puerto C
    .equ GPIOC_PTOR, 0x400FF08C          // Registro de alternancia de datos del puerto C

    // Definición de los registros y valores
    .equ PCC_BASE, 0x40065000                // Base del PCC (Peripheral Clock Control)
    .equ PCC_PORTB, (PCC_BASE + 0x128)       // Offset para el PCC del puerto B
    .equ PCC_PORTC, (PCC_BASE + 0x12C)       // Offset para el PCC del puerto C
    .equ PORTB_BASE, 0x4004A000              // Base del PORTB
    .equ PORTC_BASE, 0x4004B000              // Base del PORTC
    .equ PORTB_PCR10, (PORTB_BASE + 0x28)    // PCR para PTB10
    .equ PORTB_PCR17, (PORTB_BASE + 0x44)    // PCR para PTB17
    .equ PORTC_PCR8, (PORTC_BASE + 0x20)     // PCR para PTC7
    .equ PORTC_PCR15, (PORTC_BASE + 0x3C)    // PCR para PTC15
    .equ MUX_GPIO, 0x1                       // Configuración Mux para GPIO (Alternativa 1)
    .equ PCC_PORT_CGC, (1 << 30)            // Bit para habilitar el reloj del puerto

    // Bits correspondientes a las columnas
    .equ COL1, 10                          // Columna 1 (PTB10)
    .equ COL2, 11                          // Columna 2 (PTB11)
    .equ COL3, 12                          // Columna 3 (PTB12)
    .equ COL4, 13                          // Columna 4 (PTB13)
    .equ COL5, 14                          // Columna 5 (PTB14)
    .equ COL6, 15                          // Columna 6 (PTB15)
    .equ COL7, 16                          // Columna 7 (PTB16)
    .equ COL8, 17                          // Columna 8 (PTB17)

    // Bits correspondientes a las filas
    .equ ROW1, 8                           // Fila 1 (PTC8)
    .equ ROW2, 9                           // Fila 2 (PTC9)
    .equ ROW3, 10                          // Fila 3 (PTC10)
    .equ ROW4, 11                          // Fila 4 (PTC11)
    .equ ROW5, 12                          // Fila 5 (PTC12)
    .equ ROW6, 13                          // Fila 6 (PTC13)
    .equ ROW7, 14                          // Fila 7 (PTC14)
    .equ ROW8, 15                          // Fila 8 (PTC15)

    // Definición de los tiempos en ciclos de reloj (ajustar según la frecuencia del microcontrolador)
    .equ TIEMPO_CAMBIO, 2       
         
    // Definición de los estados
    .equ FILA1, 0
    .equ FILA2, 1
    .equ FILA3, 2
    .equ FILA4, 3
    .equ FILA5, 4
    .equ FILA6, 5
    .equ FILA7, 6
    .equ FILA8, 7

    .equ initrow, 0b11111111 // Primer estado de filas
    .equ initcol, 0b00111111 // Primer estado de columnas

    // Mapa de leds
    .section .rodata
leds:
    .byte 0b00111111 // Representación de la primera fila de LEDs
    .byte 0b00110000 // Representación de la segunda fila de LEDs
    .byte 0b11110000 // Representación de la tercera fila de LEDs
    .byte 0b11111111 // Representación de la cuarta fila de LEDs
    .byte 0b11111111 // Representación de la quinta fila de LEDs
    .byte 0b11111111 // Representación de la sexta fila de LEDs
    .byte 0b00111011 // Representación de la séptima fila de LEDs
    .byte 0b00111011 // Representación de la octava fila de LEDs