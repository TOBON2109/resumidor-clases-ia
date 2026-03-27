import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taller 1',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _titulo = 'Hola, Flutter';
  bool _tituloCambiado = false;

  void _cambiarTitulo() {
    setState(() {
      _tituloCambiado = !_tituloCambiado;
      _titulo = _tituloCambiado ? '¡Título cambiado!' : 'Hola, Flutter';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Título actualizado'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titulo),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            // Nombre del estudiante
            const SizedBox(height: 12),
            const Text(
              'Juan Esteban Tobon Diaz',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Row con dos imágenes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Imagen Network
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.indigo, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      'https://picsum.photos/120/100',
                      width: 120,
                      height: 100,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) =>
                          progress == null
                              ? child
                              : const SizedBox(
                                  width: 120,
                                  height: 100,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                    ),
                  ),
                ),

                // Imagen Asset
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.deepOrange, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.asset(
                      'assets/foto.jpg',
                      width: 120,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Botón con setState()
            ElevatedButton.icon(
              onPressed: _cambiarTitulo,
              icon: const Icon(Icons.swap_horiz),
              label: const Text('Cambiar título'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
            const SizedBox(height: 28),

            // Widget adicional 1: Stack
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                'Widget 1 — Stack',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const Text(
                  'Texto superpuesto con Stack',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),

            // Widget adicional 2: ListView
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                'Widget 2 — ListView',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Container(
              height: 180,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListView(
                children: const [
                  ListTile(
                    leading: Icon(Icons.star, color: Colors.amber),
                    title: Text('Flutter'),
                  ),
                  ListTile(
                    leading: Icon(Icons.code, color: Colors.indigo),
                    title: Text('Dart'),
                  ),
                  ListTile(
                    leading: Icon(Icons.phone_android, color: Colors.green),
                    title: Text('Android Studio'),
                  ),
                  ListTile(
                    leading: Icon(Icons.cloud, color: Colors.blue),
                    title: Text('GitHub'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}