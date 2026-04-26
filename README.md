# Práctica 02 — Promedio de Números Enteros con Signo en Ensamblador x86

## Descripción

Programa en ensamblador x86 que recorre un arreglo de números enteros con signo almacenado en memoria, acumula su suma y calcula el promedio aritmético mediante división entera con signo, operando directamente sobre los registros del procesador.

El cálculo se realiza en dos etapas:

```
Etapa 1 — Suma acumulada:
    Para cada elemento en Dato[0..n-1]:
        EAX += Dato[i]    →  acumulador de 32 bits con signo

Etapa 2 — División entera con signo:
    CDQ                   →  extiende EAX a EDX:EAX (64 bits)
    IDIV Cantidad         →  EAX = cociente (Promedio)
                             EDX = resto    (Residuo)
```

---

## Estructura del Proyecto

```
Practica02_Promedio/
└── promedio.asm    # Programa principal: recorre el arreglo, suma y calcula el promedio
```

---

## Interfaz y Convención de Llamada

El programa es autocontenido: declara el arreglo y las variables de resultado en la sección `.data` y los procesa directamente en `start`. Utiliza las bibliotecas de MASM32 para la llamada de salida.

| Elemento    | Descripción                                                              |
|-------------|--------------------------------------------------------------------------|
| `Dato`      | Arreglo de 6 enteros con signo (`SDWORD`) declarado en `.data`           |
| `Cantidad`  | Constante calculada en tiempo de ensamblado: `($ - Dato) / 4`           |
| `Promedio`  | Variable `SDWORD` donde se almacena el cociente de la división           |
| `Residuo`   | Variable `SDWORD` donde se almacena el resto de la división              |
| `ESI`       | Registro puntero que recorre el arreglo elemento a elemento              |
| `ECX`       | Registro contador del ciclo; decrementado automáticamente por `LOOP`     |
| `EAX`       | Acumulador de la suma; contiene el cociente (promedio) tras `IDIV`       |
| `EDX`       | Recibe la extensión de signo vía `CDQ`; contiene el resto tras `IDIV`    |
| `EBX`       | Almacena el divisor (`Cantidad`) para la instrucción `IDIV`              |

La directiva `.model flat, stdcall` indica modelo de memoria plana con la convención de llamadas estándar de Windows. Al finalizar, se invoca `ExitProcess` para cerrar el proceso limpiamente.

---

## Funcionamiento del Algoritmo

El programa implementa un ciclo de acumulación seguido de una división entera con signo. El ciclo recorre cada elemento del arreglo sumándolo a `EAX`; al terminar, `CDQ` prepara el dividendo de 64 bits e `IDIV` produce cociente y resto.

### Flujo de ejecución

```
Inicio
 └─ ESI = dirección de Dato
 └─ ECX = Cantidad
 └─ EAX = 0

sumar_loop:
 ├─ EAX += [ESI]
 ├─ ESI += 4
 └─ LOOP sumar_loop   (ECX--; si ECX > 0, repetir)

 ├─ CDQ               →  EDX:EAX = extensión de signo de EAX
 ├─ IDIV Cantidad     →  EAX = cociente, EDX = resto
 ├─ Promedio = EAX
 └─ Residuo  = EDX

finalizar:
 └─ ExitProcess(0)
```

### Ejemplo con el arreglo `{-10, 20, -30, 40, -50, 60}`

| Iteración | Elemento | Acumulador (EAX) | ECX restante |
|-----------|----------|------------------|--------------|
| 1         | −10      | −10              | 5            |
| 2         | +20      | +10              | 4            |
| 3         | −30      | −20              | 3            |
| 4         | +40      | +20              | 2            |
| 5         | −50      | −30              | 1            |
| 6         | +60      | +30              | 0            |

División: `30 ÷ 6 = 5` (cociente), `30 mod 6 = 0` (resto)

| Variable   | Valor almacenado |
|------------|-----------------|
| `Promedio` | `5`             |
| `Residuo`  | `0`             |

---

## Instrucciones x86 Utilizadas

| Instrucción | Operación |
|-------------|-----------|
| `LEA`       | Carga la dirección de memoria de una variable en un registro |
| `MOV`       | Copia un valor entre registro y memoria |
| `XOR`       | OR-exclusivo; usado para poner `EAX` en cero eficientemente |
| `ADD`       | Suma el operando fuente al destino |
| `LOOP`      | Decrementa `ECX` y salta si `ECX > 0` |
| `CDQ`       | Extiende el signo de `EAX` hacia `EDX` formando un entero de 64 bits |
| `IDIV`      | División entera con signo: cociente en `EAX`, resto en `EDX` |
| `PUSH`      | Empuja un valor a la pila |
| `CALL`      | Llama a un procedimiento |

---

## Ejemplo de Ejecución

```
Arreglo de entrada : {-10, 20, -30, 40, -50, 60}
Suma acumulada     : 30
Promedio (cociente): 5
Residuo            : 0
```

---

## Requisitos

- **Ensamblador:** MASM (Microsoft Macro Assembler) con MASM32 SDK
- **Arquitectura:** x86 (32 bits), modo protegido plano (`flat`)
- **Sistema operativo:** Windows (uso de `ExitProcess` de la WinAPI)
- **Convención de llamadas:** `stdcall`
