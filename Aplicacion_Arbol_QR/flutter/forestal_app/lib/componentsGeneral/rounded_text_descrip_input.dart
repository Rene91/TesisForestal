import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forestal_app/componentsGeneral/constants.dart';

import 'input_container.dart';

class RoundTextDescripInput extends StatefulWidget {
  const RoundTextDescripInput({
    Key? key,
    required this.icon,
    required this.hint,
    required this.obtenerDatos,
  }) : super(key: key);

  final IconData icon;
  final String hint;
  final TextEditingController obtenerDatos;

  @override
  _RoundTextDescripInput createState() => new _RoundTextDescripInput();
}

class _RoundTextDescripInput extends State<RoundTextDescripInput> {
  String? _TextError = null;
  bool _validacionError = false;

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      //creamos estilo de caja de texto user
      child: TextFormField(
        maxLines: 5,
        controller: widget.obtenerDatos,
        //textCapitalization: TextCapitalization.words,
        cursorColor: kPrimaryColor,
        autocorrect: false,
        //keyboardType: TextInputType.number,
        keyboardType: TextInputType.multiline,
        autofillHints: [AutofillHints.name],
        onSaved: (valor) => widget.obtenerDatos.text,

        textInputAction: TextInputAction.newline,
        validator: (value) {
          setState(() {
            if (value!.length < 3) {
              _validacionError = true;
              _TextError = "Campo mínimo 3 caracteres";
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
        ),
      ),
    );
  }
}
