import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicios/core/models/rol.dart';
import 'package:servicios/core/providers/application_provider.dart';
import 'package:servicios/core/providers/user_provider.dart';
import 'package:servicios/core/widgets/dialogs/message.dart';

class EditUserPage extends StatefulWidget {
  const EditUserPage({super.key,});

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController _nameController;
  late TextEditingController _userController;
  late Rol _selectedRole;

  @override
  void initState() {
    super.initState();
     WidgetsBinding.instance.addPostFrameCallback((_) {
       final ApplicationProvider provider = context.read<ApplicationProvider>();
      final roles = provider.sesion.auth?.catalogs.roles ?? [];
      final UserProvider userProvider = context.read<UserProvider>();
      _nameController = TextEditingController(text: userProvider.selectedUser?.name ?? '');
      _userController = TextEditingController(text: userProvider.selectedUser?.user ?? '');
       _selectedRole = roles.firstWhere(
        (role) => role.idRole == (userProvider.selectedUser?.idRole ?? ''),
        orElse: () => roles.isNotEmpty ? roles.first : Rol(idRole: 0, role: 'Sin rol'),
      );
      setState(() {});
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _userController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ApplicationProvider applicationProvider = Provider.of<ApplicationProvider>(context);
    final roles = applicationProvider.sesion.auth?.catalogs.roles ?? [];
    UserProvider provider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Usuario'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              // Mostrar ayuda
            },
          ),
        ],
      ),
      body: Padding(
       padding: const EdgeInsets.only(
          top: 16,
          left: 20,
          right: 20
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar y nombre de usuario
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: _getRoleColor(provider.selectedUser?.role ?? ''),
                      child: Text(
                        provider.selectedUser?.getInitials() ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'ID: ${provider.selectedUser?.idUser}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // Formulario
              const Text(
                'Información Personal',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              // Nombre completo
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 400,
                ),
                child: TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre Completo',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el nombre';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              // Usuario
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 400),
                child:  TextFormField(
                controller: _userController,
                decoration: const InputDecoration(
                  labelText: 'Nombre de Usuario',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.account_circle),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre de usuario';
                  }
                  return null;
                },
              ),
              ),
              const SizedBox(height: 20),
              
              // Rol
              if (roles.isNotEmpty)
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 400,
                  ),
                  child:DropdownButtonFormField<Rol>(
                  decoration: const InputDecoration(
                    labelText: 'Rol',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.admin_panel_settings),
                  ),
                  value: _selectedRole,
                  items: roles.map((Rol rol) {
                    return DropdownMenuItem<Rol>(
                      value: rol,
                      child: Text(rol.role),
                    );
                  }).toList(),
                  onChanged: (Rol? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedRole = newValue;
                      });
                    }
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor seleccione un rol';
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 20),
            
              // Botones de acción
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 180,
                    child: OutlinedButton(
                      onPressed: provider.isLoading ? null : () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancelar'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    width: 180,
                    child: ElevatedButton(
                      onPressed: (){
                        if(_formKey.currentState!.validate() && !provider.isLoading){
                          provider.insUser(
                            idUser: applicationProvider.sesion.auth?.idUser ?? 0, 
                            user: provider.selectedUser!, 
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
                            }
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                      ),
                      child: provider.isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text('Guardar Cambios'),
                    ),
                  ),
                  
                ],
              ),
            ],
          ),
        ),
      ),
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
}
