import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../themes/app_theme.dart';
import '../services/storage_service.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.primary, Color(0xFF9C94FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.auto_awesome,
                      color: Colors.white, size: 32),
                ),
                const SizedBox(height: 12),
                const Text('AppResum',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold)),
                const Text('Resumidor con IA',
                    style: TextStyle(color: Colors.white70, fontSize: 13)),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _item(context, Icons.home_rounded, 'Inicio', '/'),
                _item(context, Icons.description_rounded, 'Resumir Texto',
                    '/upload/texto'),
                _item(context, Icons.image_rounded, 'Resumir Imagen',
                    '/upload/imagen'),
                _item(context, Icons.storage_rounded, 'Almacenamiento Local',
                    '/storage'),
                _item(context, Icons.person_rounded, 'Perfil', '/profile'),
                const Divider(indent: 16, endIndent: 16),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text('Cerrar sesión',
                      style: TextStyle(color: Colors.red)),
                  onTap: () async {
                    await StorageService.logout();
                    if (context.mounted) context.go('/login');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ListTile _item(
      BuildContext context, IconData icon, String label, String ruta) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primary),
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
      onTap: () {
        Navigator.pop(context);
        context.go(ruta);
      },
    );
  }
}
