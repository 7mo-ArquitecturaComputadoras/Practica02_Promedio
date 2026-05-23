# 🛠️ Instalación y Puesta en Marcha

Guía paso a paso para clonar, compilar y ejecutar la **Práctica 02 — Promedio** en un equipo nuevo. Esta práctica está escrita en **ensamblador x86 (MASM)** y se compila con **Visual Studio** en **Windows**.

---

## 📑 Índice

- [📚 ¿Qué herramientas necesitas?](#-qué-herramientas-necesitas)
- [🔗 Enlaces de descarga](#-enlaces-de-descarga)
- [1️⃣ Instalar Git](#1️⃣-instalar-git)
- [2️⃣ Instalar Visual Studio con MASM](#2️⃣-instalar-visual-studio-con-masm)
- [3️⃣ Clonar el repositorio](#3️⃣-clonar-el-repositorio)
- [4️⃣ Abrir la solución en Visual Studio](#4️⃣-abrir-la-solución-en-visual-studio)
- [5️⃣ Habilitar MASM en el proyecto](#5️⃣-habilitar-masm-en-el-proyecto)
- [6️⃣ Compilar el proyecto](#6️⃣-compilar-el-proyecto)
- [7️⃣ Ejecutar y observar el resultado](#7️⃣-ejecutar-y-observar-el-resultado)
- [❗ Problemas comunes](#-problemas-comunes)

---

## 📚 ¿Qué herramientas necesitas?

Antes de empezar, conviene entender qué hace cada programa:

- **Git**: Sistema de control de versiones. Sirve para descargar (clonar) el repositorio a tu computadora.
- **Visual Studio**: Entorno integrado de desarrollo (IDE) de Microsoft. Incluye el compilador, el linker y, lo más importante para esta práctica, **MASM** (`ml.exe`), el ensamblador que traduce `promedio.asm` a un ejecutable.
- **MASM** (*Microsoft Macro Assembler*): No se instala por separado, viene incluido dentro de la carga de trabajo *Desktop development with C++* de Visual Studio.

> 💡 No se requiere ningún compilador externo ni librerías adicionales. Todo lo que necesitas está dentro de Visual Studio.

---

## 🔗 Enlaces de descarga

| Herramienta | Windows |
|---|---|
| **Git** | [https://git-scm.com/download/win](https://git-scm.com/download/win) |
| **Visual Studio Community** (gratuito) | [https://visualstudio.microsoft.com/es/downloads/](https://visualstudio.microsoft.com/es/downloads/) |

> ⚠️ Esta práctica solo se compila en **Windows**, porque el código usa `ExitProcess` de la WinAPI. No funciona nativamente en Linux ni macOS.

---

## 1️⃣ Instalar Git

1. Entra a [https://git-scm.com/download/win](https://git-scm.com/download/win).
2. Descarga el instalador `.exe` (la descarga inicia automáticamente).
3. Ejecuta el instalador y acepta las opciones por defecto pulsando **"Next"** en cada pantalla.

Para verificar la instalación, abre el **Símbolo del sistema** (escribe `cmd` en el menú Inicio) y ejecuta:

```cmd
git --version
```

Si aparece un número de versión, todo está listo.

---

## 2️⃣ Instalar Visual Studio con MASM

1. Entra a [https://visualstudio.microsoft.com/es/downloads/](https://visualstudio.microsoft.com/es/downloads/).
2. Descarga **Visual Studio Community** (la versión gratuita).
3. Ejecuta el instalador. Aparecerá una ventana llamada **"Visual Studio Installer"**.
4. En la pestaña **"Cargas de trabajo"** (*Workloads*), marca la casilla:

   ✅ **Desarrollo para el escritorio con C++** (*Desktop development with C++*)

   > 🔑 Esta casilla es **obligatoria**: dentro de ella viene MASM (`ml.exe`), el ensamblador que compila el archivo `.asm`. Sin esta carga de trabajo, el proyecto **no compilará**.

5. Haz clic en **"Instalar"** y espera. La descarga e instalación puede tardar entre 30 minutos y 2 horas según tu conexión.

> ⏳ Visual Studio ocupa entre 8 y 15 GB de espacio en disco con esta carga de trabajo.

---

## 3️⃣ Clonar el repositorio

Abre el **Símbolo del sistema** (`cmd`) o **Git Bash**, ubícate en la carpeta donde quieras guardar el proyecto y ejecuta:

```bash
git clone git@github.com:7mo-ArquitecturaComputadoras/Practica02_Promedio.git
```

---

## 4️⃣ Abrir la solución en Visual Studio

1. Entra a la carpeta `proyecto/` dentro del repositorio.
2. Haz doble clic sobre **`Practica02_Promedio.sln`**.
3. Visual Studio se abrirá y cargará automáticamente el proyecto, incluido el archivo `src/promedio.asm`.

> 💡 El archivo `.sln` es el formato clásico de soluciones de Visual Studio. Si quieres convertirlo al formato moderno `.slnx`, abre la solución en Visual Studio 2022 17.10+ y guárdala como `.slnx`. Si tu versión es anterior, abre directamente el `.vcxproj`.

---

## 5️⃣ Habilitar MASM en el proyecto

La primera vez que abras la solución, es posible que Visual Studio no reconozca las directivas `.586`, `.model`, etc. Para activar MASM:

1. En el **Explorador de soluciones** (panel derecho), haz clic derecho sobre el proyecto **Practica02_Promedio**.
2. Selecciona **"Generar dependencias"** → **"Personalizaciones de compilación…"** (*Build Customizations…*).
3. En la lista que aparece, marca la casilla:

   ✅ **masm(.targets, .props)**

4. Pulsa **"Aceptar"**.

> ⚠️ Si esta casilla **no aparece** en la lista, significa que MASM no se instaló. Vuelve al paso 2️⃣ y verifica que marcaste la carga de trabajo *Desarrollo para el escritorio con C++*.

---

## 6️⃣ Compilar el proyecto

1. En la barra superior, selecciona la configuración **Debug** y la plataforma **Win32** (32 bits).

   > 🔑 Es **obligatorio** usar **Win32**, porque el código está escrito con `.model flat, stdcall` (32 bits). En **x64** no compilará.

2. Pulsa `Ctrl + Shift + B` o ve al menú **Compilar** → **Compilar solución**.
3. En la ventana de salida (parte inferior) debe aparecer:

   ```
   ========== Compilación: 1 correctos, 0 incorrectos ==========
   ```

El ejecutable se generará en `proyecto/Debug/Practica02_Promedio.exe`.

> 💡 La carpeta `Debug/` está incluida en el `.gitignore` y no se sube al repositorio: cada quien la genera localmente al compilar.

---

## 7️⃣ Ejecutar y observar el resultado

El programa **no imprime nada en pantalla**: calcula el promedio y el residuo, almacenándolos en las variables `Promedio` y `Residuo` de memoria. Para ver el resultado tienes que inspeccionar estas variables con el depurador.

1. Abre `proyecto/src/promedio.asm` en el editor de Visual Studio.
2. Coloca un *breakpoint* (punto de interrupción) haciendo clic en el margen izquierdo, justo en la línea de la etiqueta:

   ```asm
   finalizar:
       push 0
       call ExitProcess@4
   ```

3. Pulsa `F5` para iniciar la depuración. El programa se detendrá en el *breakpoint*.
4. Ve al menú **Depurar** → **Ventanas** → **Memoria** → **Memoria 1**.
5. En la barra de **Dirección** de la ventana de memoria, escribe:

   ```
   &Promedio
   ```

6. Verás los 4 bytes del valor `Promedio` en memoria. Para el arreglo de ejemplo `{-10, 20, -30, 40, -50, 60}`, debería mostrar `05 00 00 00` (que representa el número `5` en formato SDWORD de 32 bits little-endian).

7. Reemplaza `&Promedio` por `&Residuo` en la barra de dirección para ver el residuo (debería ser `00 00 00 00`, es decir, cero).

> 💡 También puedes pasar el ratón sobre `Promedio` o `Residuo` en el código mientras el depurador está pausado; aparecerá una pequeña ventana con los valores decimales actuales.

---

## ❗ Problemas comunes

| Síntoma | Causa probable | Solución |
|---|---|---|
| `error A2006: undefined symbol : ExitProcess` | Configuración en **x64** con código de 32 bits | Cambia la plataforma a **Win32** en la barra superior |
| `error MSB6006: "ml.exe" exited with code 1` | Ruta del archivo `.asm` rota | Verifica que `proyecto/src/promedio.asm` exista |
| **masm(.targets, .props)** no aparece en *Personalizaciones de compilación* | Falta la carga de trabajo *Desarrollo C++* | Abre **Visual Studio Installer**, pulsa **"Modificar"** y agrégala |
| `git` no se reconoce como comando | Git no se instaló o no se agregó al PATH | Reinstala Git marcando *"Git from the command line and also from 3rd-party software"* |
| El `.sln` no abre | Versión de Visual Studio anterior a 2022 17.10 | Abre directamente `Practica02_Promedio.vcxproj` |

---

> **Autor:** Edson Joel Carrera Avila
