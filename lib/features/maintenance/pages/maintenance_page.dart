import 'package:flutter/material.dart';
import 'package:servicios/core/src/text_styles_app.dart';
class MaintenancePage extends StatefulWidget {
  const MaintenancePage({super.key});

  @override
  State<MaintenancePage> createState() => _MaintenancePageState();
}

class _MaintenancePageState extends State<MaintenancePage> {
String selectedFilter = 'Todos';
  String searchQuery = '';
  
  // Datos de ejemplo
  final List<Map<String, dynamic>> services = [
    {
      'id': '1',
      'type': 'Aire Acondicionado',
      'service': 'Mantenimiento Preventivo',
      'status': 'Completado',
      'date': '2024-02-23',
      'equipment': 'Split 24000 BTU',
      'location': 'Sala 101',
      'technician': 'Juan Pérez',
    },
    {
      'id': '2',
      'type': 'Equipo Médico',
      'service': 'Calibración',
      'status': 'Pendiente',
      'date': '2024-02-24',
      'equipment': 'Monitor de Signos Vitales',
      'location': 'UCI',
      'technician': 'María González',
    },
    // Agregar más servicios aquí
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Servicios de Mantenimiento',style: TextStylesApp.title,),
        actions: [
          IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
          // Implementar la creación de nuevo servicio
        },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Barra de búsqueda y filtros
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscar servicios...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    value: selectedFilter,
                    items: const [
                      DropdownMenuItem(value: 'Todos', child: Text('Todos')),
                      DropdownMenuItem(value: 'Aire Acondicionado', child: Text('Aire Acondicionado')),
                      DropdownMenuItem(value: 'Equipo Médico', child: Text('Equipo Médico')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedFilter = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Estadísticas
            Row(
              children: [
                _buildStatCard(
                  'Servicios Pendientes',
                  '5',
                  Colors.orange,
                  Icons.pending_actions,
                ),
                const SizedBox(width: 16),
                _buildStatCard(
                  'Completados Hoy',
                  '3',
                  Colors.green,
                  Icons.check_circle_outline,
                ),
                const SizedBox(width: 16),
                _buildStatCard(
                  'Programados',
                  '8',
                  Colors.blue,
                  Icons.calendar_today,
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Lista de servicios
            Expanded(
              child: ListView.builder(
                itemCount: services.length,
                itemBuilder: (context, index) {
                  final service = services[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: ExpansionTile(
                      leading: Icon(
                        service['type'] == 'Aire Acondicionado'
                            ? Icons.ac_unit
                            : Icons.medical_services,
                        color: _getStatusColor(service['status']),
                      ),
                      title: Text(
                        service['service'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('${service['type']} - ${service['status']}'),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildDetailRow('Equipo:', service['equipment']),
                              _buildDetailRow('Ubicación:', service['location']),
                              _buildDetailRow('Técnico:', service['technician']),
                              _buildDetailRow('Fecha:', service['date']),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton.icon(
                                    icon: const Icon(Icons.edit),
                                    label: const Text('Editar'),
                                    onPressed: () {
                                      // Implementar edición
                                    },
                                  ),
                                  const SizedBox(width: 8),
                                  TextButton.icon(
                                    icon: const Icon(Icons.delete),
                                    label: const Text('Eliminar'),
                                    onPressed: () {
                                      // Implementar eliminación
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Implementar la creación de nuevo servicio
        },
        label: const Text('Nuevo Servicio'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(icon, color: color, size: 32),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completado':
        return Colors.green;
      case 'pendiente':
        return Colors.orange;
      default:
        return Colors.blue;
    }
  }
}