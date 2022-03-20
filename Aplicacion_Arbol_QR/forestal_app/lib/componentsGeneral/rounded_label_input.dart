import 'package:flutter/material.dart';
import 'package:forestal_app/componentsGeneral/constants.dart';

import 'input_container.dart';

class RoundLabelInput extends StatefulWidget {
  const RoundLabelInput({
    Key? key,
    required this.icon,
    required this.text,
    required this.obtenerDatos,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final TextEditingController obtenerDatos;

  @override
  _RoundLabelInput createState() => _RoundLabelInput();
}

class _RoundLabelInput extends State<RoundLabelInput> {

  @override
  Widget build(BuildContext context) {
    return
      InputContainer(
        child: TextFormField(
          enabled: false,
          controller: widget.obtenerDatos,
          cursorColor: kPrimaryColor,
          decoration: InputDecoration(
            labelText: widget.text,
            // Handling error manually
            //colocamos icono a caja de texto
            icon: Icon(
              widget.icon,
              //FontAwesomeIcons.barcode,
              color: kPrimaryColor,
            ),
            //hintText: widget.hint, //ponemos nombre a la caja de texto
            border:
            InputBorder.none, //colocamos borde a la caja de texto

            enabled: true,
          ),
        ),
      );
  }
}
