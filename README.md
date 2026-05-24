# 🔢 Práctica 02 — Promedio de Números Enteros con Signo en Ensamblador x86

Programa escrito en **ensamblador x86 (MASM)** que recorre un arreglo de números enteros con signo almacenado en memoria, acumula su suma y calcula el **promedio aritmético** mediante división entera con signo, operando directamente sobre los registros del procesador, sin usar funciones externas de C/C++.

---

## 📑 Índice

- [🎯 ¿Qué hace el programa?](#-qué-hace-el-programa)
- [🧠 Idea central del algoritmo](#-idea-central-del-algoritmo)
- [📂 Estructura del repositorio](#-estructura-del-repositorio)
- [🚀 Cómo empezar](#-cómo-empezar)
- [🔍 Trazado del ejemplo `{-10, 20, -30, 40, -50, 60}`](#-trazado-del-ejemplo--10-20--30-40--50-60)
- [📘 Instrucciones x86 utilizadas](#-instrucciones-x86-utilizadas)
- [📄 Documentación adicional](#-documentación-adicional)

---

## 🎯 ¿Qué hace el programa?

El programa toma un arreglo de enteros con signo declarado en la sección `.data` (por ejemplo, `{-10, 20, -30, 40, -50, 60}`) y lo procesa en **dos etapas** sobre los registros del procesador:

- **Etapa 1 — Acumulación:** recorre el arreglo elemento por elemento sumando cada valor en `EAX`.
- **Etapa 2 — División con signo:** extiende el acumulador a 64 bits con `CDQ` y aplica `IDIV` para obtener el cociente (promedio) y el resto (residuo).

El resultado se escribe **de vuelta en memoria** en dos variables (`Promedio` y `Residuo`), sin imprimir nada en pantalla.

---

## 🧠 Idea central del algoritmo

Aprovecha la pareja de instrucciones `CDQ` + `IDIV` para hacer una **división entera con signo** correcta incluso cuando el acumulador es negativo:

```
Etapa 1 — Suma acumulada:
    Para cada elemento en Dato[0..n-1]:
        EAX += Dato[i]    →  acumulador de 32 bits con signo

Etapa 2 — División entera con signo:
    CDQ                   →  extiende EAX a EDX:EAX (64 bits)
    IDIV Cantidad         →  EAX = cociente (Promedio)
                             EDX = resto    (Residuo)
```

### Flujo de ejecución

```
inicio
 └─ ESI = dirección de Dato
 └─ ECX = Cantidad
 └─ EAX = 0

sumar:
 ├─ EAX += [ESI]
 ├─ ESI += 4
 └─ LOOP sumar        (ECX--; si ECX > 0, repetir)

dividir:
 ├─ CDQ               →  EDX:EAX = extensión de signo de EAX
 ├─ IDIV EBX          →  EAX = cociente, EDX = resto
 ├─ Promedio = EAX
 └─ Residuo  = EDX

fin:
 └─ ExitProcess(0)
```

---

## 📂 Estructura del repositorio

```
Practica02_Promedio/
├── documentacion/
│   ├── README_compilacion_latex.md         # Cómo compilar el .tex a PDF
│   ├── reporte.pdf                         # Reporte ya compilado
│   ├── reporte.tex                         # Reporte técnico en LaTeX
│   └── imagenes/                           # Imágenes usadas en el reporte
│
├── proyecto/
│   ├── README_instalacion.md               # Guía de instalación y puesta en marcha
│   ├── Practica02_Promedio.slnx            # Solución de Visual Studio
│   ├── Practica02_Promedio.vcxproj         # Proyecto MSBuild + MASM
│   └── src/
│       └── promedio.asm                    # Código fuente principal (MASM x86)
|
├── .gitattributes                          # Normalización de finales de línea
├── .gitignore                              # Archivos ignorados por Git
└── README.md                               # Este archivo
```

---

## 🚀 Cómo empezar

La guía detallada con todos los pasos (instalar Git, Visual Studio, habilitar MASM, compilar y ejecutar) está en un documento aparte:

➡️ **[Guía de instalación y puesta en marcha](proyecto/README_instalacion.md)**

Resumen rápido para quien ya tiene el entorno listo:

1. Abre el **Símbolo del sistema** (`cmd`) o **Git Bash**, ubícate en la carpeta donde quieras guardar el proyecto y ejecuta:

```bash
git clone git@github.com:7mo-ArquitecturaComputadoras/Practica02_Promedio.git
```
2. Abrir `proyecto/Practica02_Promedio.sln` en Visual Studio.
3. Seleccionar configuración **Debug | Win32**.
4. Compilar con `Ctrl + Shift + B` y ejecutar con `F5`.
5. Inspeccionar las variables `Promedio` y `Residuo` desde la ventana **Depurar → Ventanas → Memoria**.

---

## 🔍 Trazado del ejemplo `{-10, 20, -30, 40, -50, 60}`

| Iteración | Elemento | EAX (acumulador) | ECX (restante) |
|-----------|----------|------------------|----------------|
| 1         | −10      | −10              | 5              |
| 2         | +20      | +10              | 4              |
| 3         | −30      | −20              | 3              |
| 4         | +40      | +20              | 2              |
| 5         | −50      | −30              | 1              |
| 6         | +60      | +30              | 0              |

División: `30 ÷ 6 = 5` (cociente), `30 mod 6 = 0` (resto)

| Variable   | Valor almacenado |
|------------|------------------|
| `Promedio` | `5`              |
| `Residuo`  | `0`              |

Resultado final en memoria: **`Promedio = 5`, `Residuo = 0`**.

---

## 📘 Instrucciones x86 utilizadas

| Instrucción | Operación                                                            |
|-------------|----------------------------------------------------------------------|
| `LEA`       | Carga la dirección de memoria de una variable en un registro        |
| `MOV`       | Copia un valor entre registro y memoria                             |
| `XOR`       | OR-exclusivo; usado para poner `EAX` en cero eficientemente         |
| `ADD`       | Suma el operando fuente al destino                                  |
| `LOOP`      | Decrementa `ECX` y salta si `ECX > 0`                               |
| `CDQ`       | Extiende el signo de `EAX` hacia `EDX` formando un entero de 64 bits |
| `IDIV`      | División entera con signo: cociente en `EAX`, resto en `EDX`        |
| `PUSH`      | Empuja un valor a la pila                                           |
| `CALL`      | Llama a un procedimiento                                            |

---

## 📄 Documentación adicional

| Documento | Descripción |
|---|---|
| 🛠️ [`README_instalacion.md`](proyecto/README_instalacion.md) | Cómo instalar Git, Visual Studio con MASM, compilar y ejecutar el programa paso a paso. |
| 📄 [`README_compilacion_latex.md`](documentacion/README_compilacion_latex.md) | Cómo regenerar el PDF del reporte a partir de `reporte.tex` usando TeX Live, Geany o VS Code, tanto en Linux como en Windows. |
| 📕 [`reporte.pdf`](documentacion/reporte.pdf) | Reporte técnico ya compilado. |
| 📝 [`reporte.tex`](documentacion/reporte.tex) | Fuente LaTeX del reporte técnico. |

---

> **Autor:** Edson Joel Carrera Avila
