import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:servicios/core/providers/application_provider.dart';
import 'package:servicios/core/src/colors_app.dart';

class SesionPage extends StatefulWidget {
  const SesionPage({super.key});

  @override
  State<SesionPage> createState() => _SesionPageState();
}

class _SesionPageState extends State<SesionPage> {
  bool showPassword = false;
  TextEditingController textUserName = TextEditingController();
  TextEditingController textPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ApplicationProvider provider = context.watch<ApplicationProvider>();

    // Obtener el ancho y alto de la pantalla
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/image_background_login_screen.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Ajustar el ancho máximo según el dispositivo
                double maxWidth = screenWidth < 600 ? screenWidth * 0.9 : 400;
                double maxHeight = screenHeight < 600 ? screenHeight * 0.9 : 450;

                return ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Image(
                          image: AssetImage('assets/images/icon_login_screen.png'),
                          width: 80,
                          height: 80,
                        ),
                        
                        const SizedBox(height: 10),
                        Text(
                          'Servicios Profesionales de \nIngeniería Biomédica',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: maxHeight * 0.036,
                            color: ColorsApp.blueText,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Column(
                          children: [
                            SizedBox(
                              width: maxWidth * 0.9,
                              child: TextField(
                                controller: textUserName,
                                keyboardType: TextInputType.text,
                                style: const TextStyle(
                                  color: ColorsApp.blueText,
                                  fontSize: 16,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Usuario',
                                  hintStyle: const TextStyle(
                                    color: ColorsApp.blueText,
                                    fontSize: 16,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 2.0,
                                    horizontal: 10.0,
                                  ),
                                  suffixIcon: const Icon(
                                    Icons.account_circle,
                                    color: ColorsApp.blueIcon,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: maxWidth * 0.9,
                              child: TextField(
                                controller: textPass,
                                obscureText: !showPassword,
                                style: const TextStyle(
                                  color: ColorsApp.blueText,
                                  fontSize: 16,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Contraseña',
                                  hintStyle: const TextStyle(
                                    color: ColorsApp.blueText,
                                    fontSize: 16,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 2.0,
                                    horizontal: 10.0,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      showPassword
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      color: ColorsApp.blueIcon,
                                      size: 25,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        showPassword = !showPassword;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: maxWidth * 0.9,
                              height: 45,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: Colors.blueAccent,
                                ),
                                child: provider.isLoading
                                    ? const SpinKitFadingCircle(
                                        color: Colors.white,
                                        size: 30,
                                      )
                                    : const Text(
                                        'Iniciar Sesión',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                onPressed: () => provider.handleLogin(
                                  userName: textUserName.text,
                                  password: textPass.text,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}