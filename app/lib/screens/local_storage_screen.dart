import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/storage_service.dart';
import '../themes/app_theme.dart';
import '../widgets/base_view.dart';

class LocalStorageScreen extends StatefulWidget {
  const LocalStorageScreen({super.key});

  @override
  State<LocalStorageScreen> createState() => _LocalStorageScreenState();
}

class _LocalStorageScreenState extends State<LocalStorageScreen> {
  Map<String, String?> _userInfo = {};
  bool _tokenPresente = false;
  bool _cargando = true;

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  Future<void> _cargarDatos() async {
    final info = await StorageService.getUserInfo();
    final token = await StorageService.getToken();
    setState(() {
      _userInfo = info;
      _tokenPresente = token != null && token.isNotEmpty;
      _cargando = false;
    });
  }

  Future<void> _cerrarSesion() async {
    await StorageService.logout();
    if (mounted) context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: 'Almacenamiento Local',
      body: _cargando
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header info
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppTheme.primary, Color(0xFF9C94FF)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.storage_rounded,
                            color: Colors.white, size: 32),
                        SizedBox(height: 8),
                        Text('Evidencia de almacenamiento',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        Text('Datos guardados localmente en el dispositivo',
                            style:
                                TextStyle(color: Colors.white70, fontSize: 13)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // shared_preferences section
                  const Text('shared_preferences (No sensible)',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textGray)),
                  const SizedBox(height: 8),
                  _InfoCard(
                    icon: Icons.person_rounded,
                    label: 'Nombre',
                    value: _userInfo['name'] ?? 'No disponible',
                    color: AppTheme.primary,
                  ),
                  const SizedBox(height: 8),
                  _InfoCard(
                    icon: Icons.email_rounded,
                    label: 'Correo electrónico',
                    value: _userInfo['email'] ?? 'No disponible',
                    color: AppTheme.primary,
                  ),
                  const SizedBox(height: 24),

                  // flutter_secure_storage section
                  const Text('flutter_secure_storage (Sensible)',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textGray)),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.1), blurRadius: 8)
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: (_tokenPresente ? Colors.green : Colors.red)
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            _tokenPresente
                                ? Icons.verified_user_rounded
                                : Icons.no_encryption_rounded,
                            color: _tokenPresente ? Colors.green : Colors.red,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('access_token',
                                style: TextStyle(
                                    color: AppTheme.textGray, fontSize: 12)),
                            Text(
                              _tokenPresente
                                  ? '🟢 Token presente'
                                  : '🔴 Sin token',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color:
                                    _tokenPresente ? Colors.green : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Logout button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _cerrarSesion,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      icon: const Icon(Icons.logout),
                      label: const Text('Cerrar sesión'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: _cargarDatos,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Actualizar datos'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _InfoCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 8)
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style:
                      const TextStyle(color: AppTheme.textGray, fontSize: 12)),
              Text(value,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: AppTheme.textDark)),
            ],
          ),
        ],
      ),
    );
  }
}
