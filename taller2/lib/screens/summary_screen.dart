import 'package:flutter/material.dart';
import '../widgets/base_view.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: 'Resumen IA',
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.smart_toy,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 16),
              const Text(
                'Generado por IA',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Sube un archivo para ver su resumen aquí.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
