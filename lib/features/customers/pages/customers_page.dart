import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class CustomersPage extends StatefulWidget {
  const CustomersPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CustomersPageState createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
 String searchQuery = '';
  String selectedFilter = 'Todos';

  // Datos de ejemplo
  final List<Map<String, dynamic>> clients = [
    {
      'id': '1',
      'name': 'Hospital Central',
      'contact': 'Dr. Juan Martínez',
      'phone': '+1234567890',
      'email': 'contacto@hospitalcentral.com',
      'address': 'Av. Principal #123',
      'activeServices': 2,
      'totalServices': 15,
      'equipment': [
        {
          'id': '1',
          'type': 'Aire Acondicionado',
          'model': 'Split Inverter 24000 BTU',
          'lastService': '2024-02-20',
          'nextService': '2024-05-20',
          'status': 'Activo',
        },
        {
          'id': '2',
          'type': 'Equipo Médico',
          'model': 'Monitor Multiparámetros',
          'lastService': '2024-02-15',
          'nextService': '2024-03-15',
          'status': 'Mantenimiento Pendiente',
        },
      ],
    },
    // Agregar más clientes aquí
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes y Servicios'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Implementar agregar nuevo cliente
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
                      hintText: 'Buscar clientes...',
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
                      DropdownMenuItem(value: 'Todos', child: Text('Todos los Clientes')),
                      DropdownMenuItem(value: 'Activos', child: Text('Con Servicios Activos')),
                      DropdownMenuItem(value: 'Pendientes', child: Text('Con Servicios Pendientes')),
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
                  'Clientes Activos',
                  '24',
                  Colors.blue,
                  Icons.business,
                ),
                const SizedBox(width: 16),
                _buildStatCard(
                  'Servicios Activos',
                  '18',
                  Colors.green,
                  Icons.build,
                ),
                const SizedBox(width: 16),
                _buildStatCard(
                  'Próximos Servicios',
                  '7',
                  Colors.orange,
                  Icons.upcoming,
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Lista de clientes
            Expanded(
              child: ListView.builder(
                itemCount: clients.length,
                itemBuilder: (context, index) {
                  final client = clients[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: ExpansionTile(
                      title: Text(
                        client['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                        'Servicios Activos: ${client['activeServices']} | Total: ${client['totalServices']}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      leading: const CircleAvatar(
                        child: Icon(Icons.business),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Información del cliente
                              _buildInfoSection(
                                'Información del Cliente',
                                [
                                  _buildDetailRow('Contacto:', client['contact']),
                                  _buildDetailRow('Teléfono:', client['phone']),
                                  _buildDetailRow('Email:', client['email']),
                                  _buildDetailRow('Dirección:', client['address']),
                                ],
                              ),
                              const Divider(),
                              // Equipos del cliente
                              _buildEquipmentList(client['equipment']),
                              const SizedBox(height: 16),
                              // Botones de acción
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton.icon(
                                    icon: const Icon(Icons.add),
                                    label: const Text('Nuevo Servicio'),
                                    onPressed: () {
                                      // Implementar nuevo servicio
                                    },
                                  ),
                                  const SizedBox(width: 8),
                                  TextButton.icon(
                                    icon: const Icon(Icons.history),
                                    label: const Text('Historial'),
                                    onPressed: () {
                                      // Mostrar historial completo
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
          // Implementar agregar nuevo cliente
        },
        label: const Text('Nuevo Cliente'),
        icon: const Icon(Icons.add_business),
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

  Widget _buildInfoSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...children,
      ],
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

  Widget _buildEquipmentList(List<dynamic> equipment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Equipos',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...equipment.map((equip) => Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: Icon(
              equip['type'] == 'Aire Acondicionado'
                  ? Icons.ac_unit
                  : Icons.medical_services,
              color: _getStatusColor(equip['status']),
            ),
            title: Text(equip['model']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Último servicio: ${_formatDate(equip['lastService'])}'),
                Text('Próximo servicio: ${_formatDate(equip['nextService'])}'),
                Text(
                  equip['status'],
                  style: TextStyle(
                    color: _getStatusColor(equip['status']),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                // Implementar menú de opciones del equipo
              },
            ),
          ),
        )),
      ],
    );
  }

  Color _getStatusColor(String status) {
    if (status.toLowerCase().contains('activo')) return Colors.green;
    if (status.toLowerCase().contains('pendiente')) return Colors.orange;
    return Colors.grey;
  }

  String _formatDate(String date) {
    final DateTime dateTime = DateTime.parse(date);
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }
}