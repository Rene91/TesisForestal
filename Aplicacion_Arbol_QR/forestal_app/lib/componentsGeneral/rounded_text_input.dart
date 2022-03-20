import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forestal_app/componentsGeneral/constants.dart';

import 'input_container.dart';

class RoundTextInput extends StatefulWidget {
  const RoundTextInput({
    Key? key,
    required this.icon,
    required this.hint,
    required this.obtenerDatos,
    required this.tipoEscritura,
  }) : super(key: key);

  final IconData icon;
  final String hint;
  final TextEditingController obtenerDatos;
  final TextCapitalization tipoEscritura;

  @override
  _RoundTextInput createState() => new _RoundTextInput();
}

class _RoundTextInput extends State<RoundTextInput> {
  String? _TextError = null;
  bool _validacionError = false;

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      //creamos estilo de caja de texto user
      child: TextFormField(
        obscureText: false,
        controller: widget.obtenerDatos,
        textCapitalization: widget.tipoEscritura,
        cursorColor: kPrimaryColor,
        autocorrect: false,
        //enabled: false,
        //keyboardType: TextInputType.number,
        keyboardType: TextInputType.text,
        autofillHints: [AutofillHints.name],
        onSaved: (valor) => widget.obtenerDatos.text,

        textInputAction: TextInputAction.done,
        validator: (value) {
          setState(() {
            if (value!.length < 4) {
              _validacionError = true;
              _TextError = "Campo mínimo 4 caracteres";
            }
          });
          return null;
        },
        onChanged: (value) {
          setState(() {
            _validacionError = false;
            _TextError = null;
          });
        },

        decoration: InputDecoration(
          labelText: widget.hint,
          errorText: _TextError,
          // Handling error manually
          //colocamos icono a caja de texto
          icon: Icon(
            widget.icon,
            color: kPrimaryColor,
          ),
          suffixIcon: widget.obtenerDatos.text.isEmpty
              ? Container(
                  width: 0,
                )
              : IconButton(
                  /*booramos caja de texto*/
                  icon: Icon(Icons.close),
                  onPressed: () {
                    widget.obtenerDatos.clear();
                  },
                ),
          //hintText: widget.hint, //ponemos nombre a la caja de texto
          border: InputBorder.none, //colocamos borde a la caja de texto

          enabled: true,
        ),
      ),

    );
  }
}
