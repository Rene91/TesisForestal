import 'package:flutter/material.dart';

import 'constants.dart';

class RoundeButtonCancelar extends StatefulWidget {
  const RoundeButtonCancelar({
    Key? key,
    required this.title,
    required this.ubicacion,
  }) : super(key: key);

  final String title;
  final String ubicacion;

  @override
  _ButtonCancelar createState() => _ButtonCancelar();
}

class _ButtonCancelar extends State<RoundeButtonCancelar> {
  @override
  Widget build(BuildContext context) {
    Size size =
        MediaQuery.of(context).size; //obtenemos todo el ancho de la pantalla

    return InkWell(
      onTap: () {
        showDialog<String>(
          barrierDismissible: false,
          //barrierColor: Colors.green,
          context: context,
          builder: (BuildContext context) => AlertDialog(
            backgroundColor: kTreeColor,
            //title: const Text('Se perdera todos los cambios'),
            content: const Text(
              '¿Estás seguro de que quieres salir?',
              style: TextStyle(color: kSecondColor),
            ),
            actions: <Widget>[
              const Divider(
                // height: 1.0,
                color: kGroundColorColor,
              ),
              TextButton(
                onPressed: () => {
                  Navigator.pop(context, 'Si'),
                  Navigator.of(context).pop(),
                },
                child: const Text('Si'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'No'),
                child: const Text('No'),
              ),
            ],
          ),
        );
        /*Navigator.of(context).pushNamed(
            widget.ubicacion);*/
      },
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: size.width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.deepOrange,
        ),
        padding: const EdgeInsets.symmetric(vertical: 20),
        alignment: Alignment.center,
        //child: Row(
        //mainAxisAlignment: MainAxisAlignment.center,
        child: Text(
          widget.title,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
