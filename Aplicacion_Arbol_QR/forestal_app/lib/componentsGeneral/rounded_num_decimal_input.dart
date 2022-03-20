import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forestal_app/componentsGeneral/constants.dart';

import 'input_container.dart';

class RoundNumDecimalInput extends StatefulWidget {
  const RoundNumDecimalInput({
    Key? key,
    required this.icon,
    required this.hint,
    required this.obtenerDatos,
    required this.suffixText,
    required this.helperText,
    required this.caracteres,
  }) : super(key: key);

  final IconData icon;
  final String hint;
  final TextEditingController obtenerDatos;
  final String suffixText;
  final String helperText;
  final int caracteres;

  @override
  _RoundNumDecimalInput createState() => _RoundNumDecimalInput();
}

class _RoundNumDecimalInput extends State<RoundNumDecimalInput> {
  String? _TextError;

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      //creamos estilo de caja de texto user
      child: TextFormField(
        controller: widget.obtenerDatos,
        textCapitalization: TextCapitalization.words,
        cursorColor: kPrimaryColor,
        autocorrect: false,
        //keyboardType: TextInputType.number,
        keyboardType: TextInputType.number,
        autofillHints: const [AutofillHints.creditCardNumber],
        onSaved: (valor) => widget.obtenerDatos.text,

        textInputAction: TextInputAction.done,
        validator: (value) {
          setState(() {
            if (value!.length < widget.caracteres) {
              _TextError = "Campo mínimo " + widget.caracteres.toString() +" caracteres";
            }
          });
          return null;
        },
        onChanged: (value) {
          setState(() {
            _TextError = null;
          });
        },

        decoration: InputDecoration(
          suffixText: widget.suffixText,
          helperText: widget.helperText,
          //prefixIcon: Icon(Icons.favorite),
          //suffixIcon: Icon(Icons.park),
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
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    widget.obtenerDatos.clear();
                  },
                ),
          //hintText: widget.hint, //ponemos nombre a la caja de texto
          border: InputBorder.none, //colocamos borde a la caja de texto
        ),
      ),
    );
  }
}
