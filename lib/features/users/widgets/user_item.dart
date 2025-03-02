import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicios/core/providers/application_provider.dart';
import 'package:servicios/core/providers/user_provider.dart';
import 'package:servicios/core/widgets/dialogs/message.dart';
import 'package:servicios/features/users/models/user.dart';
class UserItem extends StatelessWidget {
  final User user;
  const UserItem({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    ApplicationProvider applicationProvider = Provider.of<ApplicationProvider>(
      context,
    );
    UserProvider provider = Provider.of<UserProvider>(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: _getRoleColor(user.role),
          child: Text(
            user.getInitials(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(
          user.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Row(
          children: [
            _buildRoleBadge(user.role),
            const SizedBox(width: 8),
            _buildStatusBadge(user.idStatus == 1 ? 'Activo' : 'Inactivo'),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               _buildInfoSection(
                  'Información de Contacto',
                  [
                    _buildDetailRow('Usuario:', user.user),
                    _buildDetailRow('Rol:', user.role),
                  ],
                ), 
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      icon: const Icon(Icons.edit),
                      label: const Text('Editar'),
                      onPressed: ()=>provider.goToEditUser(user: user),
                    ),
                    const SizedBox(width: 8),
                    TextButton.icon(
                      icon: const Icon(Icons.lock),
                      label: const Text('Cambiar Contraseña'),
                      onPressed: ()=>provider.goToChangePassword(user: user),
                    ),
                    const SizedBox(width: 8),
                    if (applicationProvider.sesion.auth?.hasPermission('delete_user') ?? false)
                    TextButton.icon(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      label: Text(
                        'Eliminar',
                        style: TextStyle(
                          color: user.idStatus == 1 ? Colors.red : Colors.green,
                        ),
                      ),
                      onPressed: ()=> provider.delUser(
                        idUser: applicationProvider.sesion.auth?.idUser ?? 0, 
                        idUserDeleted: user.idUser,  
                        showDialog: (bool success, String message) async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Message(
                                message: message, 
                                onPressed: (){}
                              );
                            },
                          );
                        },
                      )
                    ),
                    const SizedBox(width: 8),
                    TextButton.icon(
                      icon: Icon(
                        user.idStatus == 1 ? Icons.block : Icons.check_circle,
                        color: user.idStatus == 1 ? Colors.red : Colors.green,
                      ),
                      label: Text(
                        user.idStatus == 1 ? 'Desactivar' : 'Activar',
                        style: TextStyle(
                          color: user.idStatus == 1 ? Colors.red : Colors.green,
                        ),
                      ),
                      onPressed: ()=> provider.updateActiveUser(
                        idUser: applicationProvider.sesion.auth?.idUser ?? 0, 
                        idUserUpdated: user.idUser, 
                        idStatus: user.idStatus == 1 ? 2 : 1, 
                        showDialog: (bool success, String message) async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Message(
                                message: message, 
                                onPressed: (){}
                              );
                            },
                          );
                        },
                      )
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
                
  }


  Widget _buildRoleBadge(String role) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getRoleColor(role).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _getRoleColor(role)),
      ),
      child: Text(
        role,
        style: TextStyle(
          color: _getRoleColor(role),
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getStatusColor(status).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _getStatusColor(status)),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: _getStatusColor(status),
          fontSize: 12,
          fontWeight: FontWeight.bold,
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

 
  Color _getRoleColor(String role) {
    switch (role) {
      case 'Técnico':
        return Colors.green;
      case 'Administrador':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Activo':
        return Colors.green;
      case 'Inactivo':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  
   Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
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

}