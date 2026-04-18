import 'dart:async';
import 'dart:isolate';
import 'package:flutter/material.dart';
import '../widgets/base_view.dart';

// Función que corre en el Isolate — tarea pesada CPU-bound
void _tareaPesada(SendPort sendPort) {
  print('>>> Isolate iniciado');
  final stopwatch = Stopwatch()..start();

  // Suma grande que bloquearía la UI si corriera en el hilo principal
  int suma = 0;
  for (int i = 0; i < 500000000; i++) {
    suma += i;
  }

  stopwatch.stop();
  print('>>> Isolate terminado en ${stopwatch.elapsedMilliseconds}ms');

  // Envía el resultado de vuelta al hilo principal
  sendPort.send({'resultado': suma, 'tiempo': stopwatch.elapsedMilliseconds});
}

class IsolateScreen extends StatefulWidget {
  const IsolateScreen({super.key});

  @override
  State<IsolateScreen> createState() => _IsolateScreenState();
}

class _IsolateScreenState extends State<IsolateScreen> {
  String _estado = 'Presiona el botón para iniciar la tarea pesada';
  bool _cargando = false;
  String? _resultado;
  String? _tiempo;

  Future<void> _ejecutarIsolate() async {
    setState(() {
      _cargando = true;
      _estado = 'Ejecutando tarea en segundo plano...';
      _resultado = null;
      _tiempo = null;
    });

    print('>>> Lanzando Isolate');

    final receivePort = ReceivePort();

    await Isolate.spawn(_tareaPesada, receivePort.sendPort);

    final mensaje = await receivePort.first as Map;

    print('>>> Resultado recibido: ${mensaje['resultado']}');

    setState(() {
      _cargando = false;
      _estado = 'Tarea completada';
      _resultado = 'Suma: ${mensaje['resultado']}';
      _tiempo = 'Tiempo: ${mensaje['tiempo']} ms';
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: 'Isolate (Tarea Pesada)',
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _cargando ? Icons.memory : Icons.done_all,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 24),
              if (_cargando)
                const Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text(
                      'La UI sigue respondiendo\nmientras el Isolate trabaja',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                )
              else ...[
                Text(
                  _estado,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                if (_resultado != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    _resultado!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(_tiempo!, style: const TextStyle(color: Colors.grey)),
                ],
              ],
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: _cargando ? null : _ejecutarIsolate,
                icon: const Icon(Icons.play_circle),
                label: const Text('Ejecutar tarea pesada'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
