; ============================================================
; Autor: Edson Joel Carrera Avila
; promedio.asm
; ============================================================

.586
.model flat, stdcall

; ============================================================
; SECCIÓN DE DATOS (.data)
; ============================================================
.data
    Dato      SDWORD  -10, 20, -30, 40, -50, 60
    ; Calcula la cantidad de elementos: (Dirección actual - Inicio de Dato) / 4 bytes
    Cantidad  EQU ($ - Dato) / 4
    Promedio  SDWORD ?
    Residuo   SDWORD ?

; ============================================================
; SECCIÓN DE CÓDIGO (.code)
; ============================================================
.code
; --- Declaramos la función externa de la API de Windows ---
EXTERN ExitProcess@4 : PROC

; --- Inicio del programa ---
start:
    lea esi, Dato       ; Carga la dirección de memoria inicial del arreglo en ESI
    mov ecx, Cantidad   ; Inicializa el contador del bucle con el número de elementos
    xor eax, eax        ; Limpia EAX (lo pone en 0) para usarlo como acumulador de la suma

; --- Bucle que suma lo elementos de la cadena Dato ---
sumar:
    add eax, [esi]      ; Suma el valor apuntado por ESI al registro EAX
    add esi, 4          ; Mueve el puntero ESI al siguiente elemento (4 bytes adelante)
    loop sumar          ; Decrementa ECX y salta a sumar_loop si ECX > 0
    cdq                 ; Extiende el signo de EAX hacia EDX (crea un número de 64 bits en EDX:EAX)
    mov ebx, Cantidad   ; Carga el divisor (n=6) en EBX
    idiv ebx            ; Divide EDX:EAX entre EBX. Cociente en EAX, Resto en EDX
    mov Promedio, eax   ; Guarda el resultado del promedio
    mov Residuo, edx    ; Guarda el sobrante de la división

; --- Fin del programa ---
    push 0
    call ExitProcess@4
end start
