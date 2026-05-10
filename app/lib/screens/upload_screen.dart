import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../themes/app_theme.dart';
import '../widgets/base_view.dart';
import '../services/gemini_service.dart';

class UploadScreen extends StatefulWidget {
  final String tipo;
  const UploadScreen({super.key, required this.tipo});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final TextEditingController _textController = TextEditingController();
  bool _cargando = false;
  String _estadoCarga = '';

  Future<void> _generarResumen() async {
    if (_textController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Escribe o pega el texto a resumir')),
      );
      return;
    }

    setState(() {
      _cargando = true;
      _estadoCarga = 'Generando resumen con IA...';
    });

    try {
      final resumen =
          await GeminiService.resumirTexto(_textController.text.trim());
      if (mounted) context.push('/summary', extra: resumen);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) setState(() => _cargando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: 'Resumir Texto',
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Pega o escribe el texto',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textDark)),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                          color: AppTheme.primary.withOpacity(0.08),
                          blurRadius: 12)
                    ],
                  ),
                  child: TextField(
                    controller: _textController,
                    maxLines: 16,
                    decoration: const InputDecoration(
                      hintText: 'Pega aquí tus apuntes o notas de clase...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _cargando ? null : _generarResumen,
                    icon: const Icon(Icons.auto_awesome),
                    label: const Text('Generar Resumen con IA'),
                  ),
                ),
              ],
            ),
          ),
          if (_cargando)
            Container(
              color: Colors.black45,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(color: AppTheme.primary),
                      const SizedBox(height: 16),
                      Text(_estadoCarga,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppTheme.textDark)),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
