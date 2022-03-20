import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forestal_app/componentsGeneral/constants.dart';

import 'input_container.dart';

class RoundLabelDescripcionInput extends StatefulWidget {
  const RoundLabelDescripcionInput({
    Key? key,
    required this.icon,
    required this.text,
    required this.obtenerDatos,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final TextEditingController obtenerDatos;

  @override
  _RoundLabelDescripcionInput createState() => _RoundLabelDescripcionInput();
}

class _RoundLabelDescripcionInput extends State<RoundLabelDescripcionInput> {

  @override
  Widget build(BuildContext context) {
    return
      InputContainer(
        child: TextFormField(
          maxLines: 5,
          keyboardType: TextInputType.multiline,
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
