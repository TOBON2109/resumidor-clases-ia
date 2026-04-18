import 'package:flutter/material.dart';
import '../widgets/base_view.dart';

class AsyncScreen extends StatefulWidget {
  const AsyncScreen({super.key});

  @override
  State<AsyncScreen> createState() => _AsyncScreenState();
}

class _AsyncScreenState extends State<AsyncScreen> {
  String _estado = 'Presiona el botón para consultar';
  bool _cargando = false;

  // Servicio simulado con Future.delayed
  Future<String> _consultarDatos() async {
    print('>>> Antes de consultar datos');
    await Future.delayed(const Duration(seconds: 3));
    print('>>> Datos recibidos');
    return 'Resumen generado exitosamente ✓';
  }

  Future<void> _cargarDatos() async {
    setState(() {
      _cargando = true;
      _estado = 'Cargando...';
    });

    print('>>> Iniciando consulta async');

    try {
      final resultado = await _consultarDatos();
      setState(() {
        _estado = resultado;
        _cargando = false;
      });
      print('>>> UI actualizada con resultado');
    } catch (e) {
      setState(() {
        _estado = 'Error al consultar datos';
        _cargando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: 'Asincronía (Future/async)',
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _cargando ? Icons.hourglass_top : Icons.cloud_done,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 24),
              if (_cargando)
                const CircularProgressIndicator()
              else
                Text(
                  _estado,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: _cargando ? null : _cargarDatos,
                icon: const Icon(Icons.refresh),
                label: const Text('Consultar datos'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
