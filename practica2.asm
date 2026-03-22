.586
.model flat, stdcall
option casemap:none

.data
    Dato  SDWORD   9, 7, 8, 6, 10, 4
    Tamanio_Dato = $-Dato 
    Cantidad     = ($-Dato)/4
    Promedio SDWORD ?             ; Variable para guardar el resultado
    Divisor  SDWORD Cantidad      ; Guardamos la constante en memoria

.code
start:
    lea esi, Dato         ; Dirección inicial del arreglo en ESI
    mov ecx, Cantidad     ; Contador del loop (6 iteraciones)
    xor eax, eax          ; Acumulador en EAX

sumar_loop:
    add eax, [esi]        ; Sumamos el valor apuntado por ESI
    add esi, 4            ; Avanzamos al siguiente SDWORD
    loop sumar_loop       ; Decrementa ECX y repite si no es cero

    cdq                   ; Extiende el signo de EAX a EDX
    idiv Divisor          ; Divide EDX:EAX entre el valor en memoria (6)

    mov Promedio, eax     ; Guardamos el promedio final

    push 0
    call ExitProcess
end start