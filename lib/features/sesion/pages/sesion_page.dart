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
    return Scaffold(
      body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/image_background_login_screen.png'), 
                fit: BoxFit.cover, // Ajustar la imagen para cubrir toda el área
              ),
            ),
            child: Center(
                child: Container(
                  height: 500,
                  width: 450,
                  padding: const EdgeInsets.only(
                    left: 10,
                    top: 10,
                    right: 10,
                    bottom: 10,
                  ),
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Image(
                        image: AssetImage('assets/images/icon_login_screen.png'),
                        width: 100,
                        height: 100,
                      ),
                      const Text(
                        'Servicios Profecionales de',
                        style: TextStyle(
                          fontSize: 22,
                          color: ColorsApp.blueText,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Ingenieria Biomedica',
                        style: TextStyle(
                          fontSize: 22,
                          color: ColorsApp.blueText,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Column(
                        children: [
                          SizedBox(
                            width: 350,
                            height: 70,
                            child: TextField(
                              controller:textUserName,
                              enableInteractiveSelection: true,
                              keyboardType: TextInputType.text,
                              autofocus: false,
                              style: const TextStyle(
                                color: ColorsApp.blueText,
                                fontWeight: FontWeight.normal,
                                fontSize: 20,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Usuario',
                                hintStyle: const TextStyle(
                                  color: ColorsApp.blueText,
                                  fontSize: 20,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0,
                                  horizontal: 10.0,
                                ),
                                suffixIcon: const Icon(
                                  Icons.account_circle,
                                  color: ColorsApp.blueIcon,
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 350,
                            height: 70,
                            child: TextField(
                              controller: textPass,
                              enableInteractiveSelection: true,
                              obscureText: showPassword,
                              autofocus: false,
                              style: const TextStyle(
                                  color: ColorsApp.blueText,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 20),
                              decoration: InputDecoration(
                                hintText: 'Contraseña',
                                hintStyle: const TextStyle(
                                  color: ColorsApp.blueText,
                                  fontSize: 20,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                   showPassword 
                                   ?Icons.visibility_off_outlined
                                   :Icons.visibility_outlined,
                                    color: ColorsApp.blueIcon,
                                    size: 40,
                                  ),
                                  onPressed:(){
                                    setState(() {
                                      showPassword = !showPassword;
                                    });
                                  },
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0,
                                  horizontal: 10.0,
                                ),
                              ),
                              onSubmitted: (value){

                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 350,
                            height: 70,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 0,
                                  vertical: 2.0,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // Elige el radio que desees
                                ),
                                backgroundColor: Colors.blueAccent,
                              ),
                              child: provider.isLoading?SizedBox(child:SpinKitFadingCircle(
                               color: Colors.white,
                              )): Text(
                                'Iniciar Sesión',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              onPressed: () => provider.handleLogin(
                                userName:  textUserName.text,
                                password:textPass.text,
                            ),
                          ),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
          )
    );
  }
}
