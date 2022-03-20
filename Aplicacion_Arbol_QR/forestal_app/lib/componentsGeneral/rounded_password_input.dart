import 'package:flutter/material.dart';
import 'package:forestal_app/componentsGeneral/constants.dart';

import 'input_container.dart';

class RoundPasswordInput extends StatefulWidget {
  const RoundPasswordInput({
    Key? key,
    required this.icon,
    required this.hint,
    required this.obtenerDatos,
  }) : super(key: key);

  final IconData icon;
  final String hint;
  final TextEditingController obtenerDatos;

  @override
  _PasswordFieldState createState() => new _PasswordFieldState();
}

class _PasswordFieldState extends State<RoundPasswordInput> {
  bool _obscureText = true;
  String? _TextError = null;
  bool _validacionError = false;

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      //creamos estilo de caja de texto user
      child: TextFormField(
        controller: widget.obtenerDatos,
        // obtenermos los datos de la caja
        cursorColor: kPrimaryColor,
        //maxLength: 8,
        //keyboardType: TextInputType.visiblePassword,
        autofillHints: [AutofillHints.password],
        onSaved: (valor) => widget.obtenerDatos.text,

        textInputAction: TextInputAction.done,
        obscureText: _obscureText,
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
          errorText: _TextError,
          // Handling error manually
          //colocamos icono a caja de texto
          icon: Icon(
            widget.icon,
            color: kPrimaryColor,
          ),
          //hintText: widget.hint,
          labelText: widget.hint,
          //ponemos nombre a la caja de texto
          border: InputBorder.none,
          //colocamos borde a la caja de texto

          /*CReamos el icoono y la accion para ver o no ver contraseña*/
          suffixIcon: new GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: new Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off),
          ),
        ),
      ),
    );
  }
}
