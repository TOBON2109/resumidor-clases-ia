import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: const Text(
              'AppResum',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () {
              context.go('/');
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.upload_file),
            title: const Text('Subir archivo'),
            onTap: () {
              context.push('/upload');
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.summarize),
            title: const Text('Resumen'),
            onTap: () {
              context.push('/summary');
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Perfil'),
            onTap: () {
              context.replace('/profile');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
