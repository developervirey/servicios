import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicios/core/providers/application_provider.dart';
import 'package:servicios/features/customers/pages/customers_page.dart';
import 'package:servicios/features/maintenance/pages/maintenance_page.dart';
import 'package:servicios/features/settings/pages/settings_page.dart';
import 'package:servicios/features/users/pages/users_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    ApplicationProvider provider = context.watch<ApplicationProvider>();
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(
                        'assets/images/icon_login_screen.png',
                      ),
                    ),
                    SizedBox(height: 10), // Espaciado entre elementos
                    Text(
                      provider.sesion.auth?.name ?? 'userName',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.build),
              title: Text('Mantenimiento'),
              onTap: () {
              provider.selectPage(0);
              Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Clientes'),
              onTap: () {
                provider.selectPage(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Usuarios'),
              onTap: () {
                provider.selectPage(2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configuración'),
              onTap: () {
                provider.selectPage(3);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Cerrar sesión'),
              onTap: () {
                provider.logout();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.only(left: 15, top: 15, right: 15),
        child: Column(
          children: [
            Expanded(
              child: IndexedStack(
                index: provider.selectedPage,
                children: [MaintenancePage(), CustomersPage(), UsersPage(), SettingsPage()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
