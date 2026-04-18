import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/base_view.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  Timer? _timer;
  int _segundos = 0;
  bool _corriendo = false;
  bool _iniciado = false;

  void _iniciar() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _segundos++);
    });
    setState(() {
      _corriendo = true;
      _iniciado = true;
    });
  }

  void _pausar() {
    _timer?.cancel();
    setState(() => _corriendo = false);
  }

  void _reanudar() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _segundos++);
    });
    setState(() => _corriendo = true);
  }

  void _reiniciar() {
    _timer?.cancel();
    setState(() {
      _segundos = 0;
      _corriendo = false;
      _iniciado = false;
    });
  }

  String _formatearTiempo() {
    final horas = _segundos ~/ 3600;
    final minutos = (_segundos % 3600) ~/ 60;
    final segs = _segundos % 60;
    return '${horas.toString().padLeft(2, '0')}:'
        '${minutos.toString().padLeft(2, '0')}:'
        '${segs.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: 'Cronómetro (Timer)',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _formatearTiempo(),
              style: TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _corriendo
                  ? 'Corriendo...'
                  : _iniciado
                      ? 'Pausado'
                      : 'Detenido',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 40),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: !_iniciado ? _iniciar : null,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Iniciar'),
                ),
                ElevatedButton.icon(
                  onPressed: _corriendo ? _pausar : null,
                  icon: const Icon(Icons.pause),
                  label: const Text('Pausar'),
                ),
                ElevatedButton.icon(
                  onPressed: _iniciado && !_corriendo ? _reanudar : null,
                  icon: const Icon(Icons.play_circle),
                  label: const Text('Reanudar'),
                ),
                ElevatedButton.icon(
                  onPressed: _iniciado ? _reiniciar : null,
                  icon: const Icon(Icons.restart_alt),
                  label: const Text('Reiniciar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
