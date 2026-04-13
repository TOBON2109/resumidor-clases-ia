import 'package:flutter/material.dart';
import '../widgets/base_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: 'AppResum',
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Resume cualquier archivo con IA',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: const [
                _FileCard(
                  icon: Icons.picture_as_pdf,
                  label: 'Documento',
                  sub: 'PDF, DOCX, TXT',
                ),
                _FileCard(icon: Icons.image, label: 'Foto', sub: 'JPG, PNG'),
                _FileCard(icon: Icons.mic, label: 'Audio', sub: 'MP3, WAV'),
                _FileCard(
                  icon: Icons.videocam,
                  label: 'Video',
                  sub: 'MP4, MOV',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FileCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String sub;

  const _FileCard({required this.icon, required this.label, required this.sub});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(sub, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
