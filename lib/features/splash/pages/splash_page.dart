import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicios/core/providers/application_provider.dart';

import '../../../core/src/colors_app.dart';
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    await Provider.of<ApplicationProvider>(context, listen: false).hasSesionController(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: ColorsApp.backgroundSplash
        ),
        child: Center(
          child: Image.asset(
            'assets/images/icon_splash.png',
          ),
        ),
      )
    );
  }
}
