import 'package:flutter/material.dart';
import 'package:forestal_app/componentsGeneral/constants.dart';

import 'input_container.dart';

class RoundLabelNumericoInput extends StatefulWidget {
  const RoundLabelNumericoInput({
    Key? key,
    required this.icon,
    required this.hint,
    required this.obtenerDatos,
    required this.suffixText,
  }) : super(key: key);

  final IconData icon;
  final String hint;
  final TextEditingController obtenerDatos;
  final String suffixText;

  @override
  _RoundLabelNUmericoInput createState() => _RoundLabelNUmericoInput();
}

class _RoundLabelNUmericoInput extends State<RoundLabelNumericoInput> {
  @override
  Widget build(BuildContext context) {
    return InputContainer(
      child: TextFormField(
        enabled: false,
        controller: widget.obtenerDatos,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          suffixText: widget.suffixText,
          labelText: widget.hint,
          // Handling error manually
          //colocamos icono a caja de texto
          icon: Icon(
            widget.icon,

            //FontAwesomeIcons.barcode,
            color: kPrimaryColor,
          ),
          //hintText: widget.hint, //ponemos nombre a la caja de texto
          border: InputBorder.none, //colocamos borde a la caja de texto

          //enabled: true,
        ),
      ),
    );
  }
}
