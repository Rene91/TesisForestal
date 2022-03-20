import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forestal_app/componentsGeneral/constants.dart';

import 'input_container.dart';

class RoundNumInput extends StatefulWidget {
  const RoundNumInput({
    Key? key,
    required this.icon,
    required this.hint,
    required this.obtenerDatos,
  }) : super(key: key);

  final IconData icon;
  final String hint;
  final TextEditingController obtenerDatos;

  @override
  _RoundNumInput createState() => _RoundNumInput();
}

class _RoundNumInput extends State<RoundNumInput> {
  String? _TextError = null;

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
            if (value!.length < 3) {
              _TextError = "Campo mínimo 3 caracteres";
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
