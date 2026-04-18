# AppResum — Taller 3: Segundo Plano, Asincronía y Servicios en Flutter

**Repositorio:** https://github.com/TOBON2109/resumidor-clases-ia

---

## Descripción del Proyecto

AppResum es una aplicación móvil en Flutter que permite cargar archivos
para generar resúmenes con Inteligencia Artificial. En este taller se
implementaron tres mecanismos de ejecución en segundo plano: asincronía
con Future/async/await, un cronómetro con Timer, y una tarea pesada
con Isolate.

---

## ¿Cuándo usar cada uno?

### Future / async / await
Se usa cuando se necesita esperar una operación que toma tiempo sin
bloquear la UI: consultas a APIs, lectura de archivos, acceso a bases
de datos. `async` marca una función como asíncrona y `await` pausa
su ejecución hasta que el Future completa, sin detener el resto de la app.

### Timer
Se usa para ejecutar código después de un tiempo determinado o de forma
periódica. Ideal para cronómetros, cuentas regresivas y actualizaciones
automáticas de pantalla. Siempre debe cancelarse cuando ya no se necesita
para liberar recursos (en dispose()).

### Isolate
Se usa para tareas CPU-intensivas que bloquearían la UI si corrieran en
el hilo principal: procesamiento de imágenes, cálculos matemáticos
complejos, generación de grandes volúmenes de datos. Cada Isolate tiene
su propia memoria y se comunica por mensajes con SendPort y ReceivePort.

---

## Pantallas y Flujos

### 1. AsyncScreen — Asincronía
**Ruta:** `/async`

Flujo:
1. Usuario presiona "Consultar datos"
2. UI muestra estado "Cargando..." con spinner
3. Future.delayed simula espera de 3 segundos
4. UI muestra resultado "Éxito" o "Error"

### 2. TimerScreen — Cronómetro
**Ruta:** `/timer`

Flujo:
1. Usuario presiona "Iniciar" → Timer.periodic arranca cada 1 segundo
2. Usuario presiona "Pausar" → timer.cancel() detiene el conteo
3. Usuario presiona "Reanudar" → Timer.periodic arranca de nuevo
4. Usuario presiona "Reiniciar" → contador vuelve a 00:00:00
5. Al salir de la pantalla → dispose() cancela el timer

### 3. IsolateScreen — Tarea Pesada
**Ruta:** `/isolate`

Flujo:
1. Usuario presiona "Ejecutar tarea pesada"
2. Se lanza un Isolate con Isolate.spawn()
3. El Isolate realiza una suma de 500 millones de iteraciones
4. La UI sigue respondiendo mientras el Isolate trabaja
5. El Isolate envía el resultado por SendPort
6. La UI recibe el resultado y muestra la suma y el tiempo

---

## Estructura del Proyecto

El proyecto está organizado por carpetas según su responsabilidad:

- **main.dart** — punto de entrada de la app
- **routes/** — contiene app_router.dart con todas las rutas definidas en un solo lugar
- **screens/** — cada pantalla de la app en su propio archivo separado
- **widgets/** — componentes reutilizables como el Drawer y la estructura base
- **themes/** — configuración del tema visual

---

## GitFlow

- `main` — versiones estables
- `dev` — desarrollo activo
- `feature/taller_segundo_plano` — implementación de este taller