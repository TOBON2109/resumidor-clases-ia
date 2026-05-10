import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';
import '../themes/app_theme.dart';
import '../widgets/base_view.dart';

class SummaryScreen extends StatelessWidget {
  final String resumen;
  const SummaryScreen({super.key, required this.resumen});

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: 'Resumen Generado',
      actions: [
        IconButton(
          icon: const Icon(Icons.copy, color: Colors.white),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: resumen));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Resumen copiado')),
            );
          },
        ),
      ],
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            color: AppTheme.primary.withOpacity(0.08),
            child: const Row(
              children: [
                Icon(Icons.auto_awesome, color: AppTheme.primary, size: 18),
                SizedBox(width: 8),
                Text('Generado por Gemini AI',
                    style: TextStyle(
                        color: AppTheme.primary,
                        fontWeight: FontWeight.w500,
                        fontSize: 13)),
              ],
            ),
          ),
          Expanded(
            child: Markdown(
              data: resumen,
              padding: const EdgeInsets.all(20),
              styleSheet: MarkdownStyleSheet(
                h2: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primary),
                p: const TextStyle(
                    fontSize: 15, color: AppTheme.textDark, height: 1.6),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => context.go('/'),
                icon: const Icon(Icons.add),
                label: const Text('Resumir otro'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
