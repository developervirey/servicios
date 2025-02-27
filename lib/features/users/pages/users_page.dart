import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicios/core/models/rol.dart';
import 'package:servicios/core/models/user_status.dart';
import 'package:servicios/core/providers/application_provider.dart';
import 'package:servicios/core/providers/user_provider.dart';
import 'package:servicios/features/users/widgets/stat_card.dart';
import 'package:servicios/features/users/widgets/user_item.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  String searchQuery = '';
  String roleFilter = 'Todos';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ApplicationProvider pro = context.read<ApplicationProvider>();
      final UserProvider userProvider = context.read<UserProvider>();
      userProvider.downloadingUsers(
        idUser: pro.sesion.auth?.idUser ?? 0,
        name: searchQuery,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    ApplicationProvider applicationProvider = Provider.of<ApplicationProvider>(
      context,
    );
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cuentas de Usuarios'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              // Mostrar ayuda o guía de roles
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
                      hintText: 'Buscar usuarios...',
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
                  child: DropdownButtonFormField<Rol>(
                    decoration: InputDecoration(
                      labelText: 'Rol',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                   value:userProvider.selectedRolFilter,
                    items:(applicationProvider.sesion.auth?.catalogs.roles ??[])
                            .map((Rol rol) {
                              return DropdownMenuItem<Rol>(
                                value: rol,
                                child: Text(rol.role),
                              );
                            })
                            .toList(),
                    onChanged: userProvider.setUserRol,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: DropdownButtonFormField<UserStatus>(
                    decoration: InputDecoration(
                      labelText: 'Estado',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    value:userProvider.selectedUserStatusFilter,
                    items:(applicationProvider.sesion.auth?.catalogs.userStatuses ??[])
                            .map((UserStatus status) {
                              return DropdownMenuItem<UserStatus>(
                                value: status,
                                child: Text(status.status),
                              );
                            })
                            .toList(),
                    onChanged: userProvider.setUserStatus,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Estadísticas
            Row(
              children: [
                StatCard(
                  title: 'Total Usuarios',
                  value: userProvider.users.length.toString(),
                  color: Colors.blue,
                  icon: Icons.people,
                ),
                const SizedBox(width: 16),
                StatCard(
                  title: 'Técnicos',
                  value: userProvider.countTechnicians.toString(),
                  color: Colors.green,
                  icon: Icons.engineering,
                ),
                const SizedBox(width: 16),
                StatCard(
                  title: 'Administradores',
                  value: userProvider.countAdministrators.toString(),
                  color: Colors.orange,
                  icon: Icons.admin_panel_settings,
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Lista de usuarios
            Expanded(
              child:
                  userProvider.users.isEmpty
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('No se recibieron resultados, actualizar '),
                            IconButton(
                              onPressed:
                                  () => userProvider.downloadingUsers(
                                    idUser:
                                        applicationProvider
                                            .sesion
                                            .auth
                                            ?.idUser ??
                                        0,
                                    name: searchQuery,
                                  ),
                              icon: Icon(Icons.refresh),
                            ),
                          ],
                        )
                      : RefreshIndicator(
                        onRefresh:
                            () async => userProvider.downloadingUsers(
                              idUser:
                                  applicationProvider.sesion.auth?.idUser ?? 0,
                              name: searchQuery,
                            ),
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: userProvider.users.length,
                          itemBuilder: (context, index) {
                            return UserItem(user: userProvider.users[index]);
                          },
                        ),
                      ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Implementar creación de nuevo usuario
        },
        label: const Text('Nuevo Usuario'),
        icon: const Icon(Icons.person_add),
      ),
    );
  }
}
