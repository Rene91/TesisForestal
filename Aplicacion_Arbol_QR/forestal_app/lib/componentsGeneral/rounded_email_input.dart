import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forestal_app/componentsGeneral/constants.dart';

import 'input_container.dart';
class RoundEmailtInput extends StatefulWidget {
  const RoundEmailtInput({
    Key? key,
    required this.icon,
    required this.hint,
    required this.obtenerDatos,
  }) : super(key: key);

  final IconData icon;
  final String hint;
  final TextEditingController obtenerDatos;

  @override
  _RoundEmailtInput createState() => _RoundEmailtInput();
}

class _RoundEmailtInput extends State<RoundEmailtInput> {
  String? _TextError;

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      //creamos estilo de caja de texto user
      child: TextFormField(
        controller: widget.obtenerDatos,
        cursorColor: kPrimaryColor,
        autocorrect: false,
        //keyboardType: TextInputType.number,
        keyboardType: TextInputType.emailAddress,
        autofillHints: const [AutofillHints.email],
        onSaved: (valor) => widget.obtenerDatos.text,

        textInputAction: TextInputAction.done,
        validator: (value) {
          setState(() {
            if (value != null && !EmailValidator.validate(value)) {
              _TextError = "Email no valido";
            }
          });
          return null;
        },
        onChanged: (value) {
          setState(() {
            _TextError= null;
          });
        },

        decoration: InputDecoration(
          errorText: _TextError, // Handling error manually
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
          labelText: widget.hint,
          border: InputBorder.none, //colocamos borde a la caja de texto
        ),
      ),
    );
  }

}