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
          _item(context, Icons.home, 'Inicio', '/'),
          _item(context, Icons.upload_file, 'Subir archivo', '/upload'),
          _item(context, Icons.summarize, 'Resumen', '/summary'),
          _item(context, Icons.person, 'Perfil', '/profile'),
          const Divider(),
          const Padding(
            padding: EdgeInsets.only(left: 16, top: 8, bottom: 4),
            child: Text('Segundo Plano',
                style: TextStyle(color: Colors.grey, fontSize: 12)),
          ),
          _item(context, Icons.cloud_sync, 'Asincronía', '/async'),
          _item(context, Icons.timer, 'Cronómetro', '/timer'),
          _item(context, Icons.memory, 'Isolate', '/isolate'),
        ],
      ),
    );
  }

  ListTile _item(
      BuildContext context, IconData icon, String label, String ruta) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: () {
        context.go(ruta);
        Navigator.pop(context);
      },
    );
  }
}
