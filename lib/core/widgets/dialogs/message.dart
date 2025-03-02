import 'package:flutter/material.dart';
import 'package:servicios/core/src/colors_app.dart';
class Message extends StatelessWidget {
  final String message;
  final String title;
  final String buttonText;
  final Function() onPressed;
  const Message({
    super.key,
    required this.message,
    this.title = 'Aviso',
    this.buttonText = 'Aceptar',
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title,textAlign: TextAlign.center,),
      content: Text(message, textAlign: TextAlign.center,),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
       SizedBox(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: ColorsApp.buttonBackground,
          ),
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ColorsApp.buttonText,
              fontSize: 20.0,
              fontWeight: FontWeight.normal,
            ),
          ),
          onPressed: () async {
            Navigator.of(context).pop(true);
            onPressed();
          },
        ),),
      ],
    );
  }
}