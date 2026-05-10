import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../themes/app_theme.dart';
import '../widgets/base_view.dart';
import '../services/storage_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _nombre = 'Estudiante';

  @override
  void initState() {
    super.initState();
    _cargarNombre();
  }

  Future<void> _cargarNombre() async {
    final info = await StorageService.getUserInfo();
    setState(() => _nombre = info['name'] ?? 'Estudiante');
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: 'AppResum',
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 40, 24, 48),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.primary, Color(0xFF9C94FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('¡Hola, $_nombre! 👋',
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 16)),
                  const SizedBox(height: 4),
                  const Text('Resume tus clases\ncon Inteligencia Artificial',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          height: 1.3)),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () => context.go('/upload/texto'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppTheme.primary,
                    ),
                    icon: const Icon(Icons.auto_awesome),
                    label: const Text('Empezar ahora'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('¿Qué quieres resumir?',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textDark)),
                  const SizedBox(height: 16),
                  _OptionCard(
                    icon: Icons.description_rounded,
                    title: 'Texto o Apuntes',
                    subtitle: 'Pega o escribe el contenido de tu clase',
                    color: AppTheme.primary,
                    onTap: () => context.go('/upload/texto'),
                  ),
                  const SizedBox(height: 12),
                  _OptionCard(
                    icon: Icons.image_rounded,
                    title: 'Foto de Apuntes',
                    subtitle: 'Selecciona una imagen de galería',
                    color: const Color(0xFF00BFA5),
                    onTap: () => context.go('/upload/imagen'),
                  ),
                  const SizedBox(height: 12),
                  _OptionCard(
                    icon: Icons.storage_rounded,
                    title: 'Almacenamiento Local',
                    subtitle: 'Ver datos guardados en el dispositivo',
                    color: const Color(0xFF6C63FF),
                    onTap: () => context.go('/storage'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _OptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _OptionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppTheme.textDark)),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style: const TextStyle(
                          fontSize: 13, color: AppTheme.textGray)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, color: color, size: 18),
          ],
        ),
      ),
    );
  }
}
