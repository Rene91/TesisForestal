import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; /*packete para cargar */

import 'constants.dart';
import 'input_container.dart';

class RoundDateTimeInput extends StatefulWidget {
  const RoundDateTimeInput({
    Key? key,
    required this.icon,
    required this.hint,
    required this.obtenerDatos,
  }) : super(key: key);

  final IconData icon;
  final String hint;
  final TextEditingController obtenerDatos;

  @override
  _RoundDateTimeInput createState() => _RoundDateTimeInput();
}

class _RoundDateTimeInput extends State<RoundDateTimeInput> {
  String? _TextError = null;

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      //creamos estilo de caja de texto user
      child: TextFormField(
        onSaved: (valor) => widget.obtenerDatos.text,
        readOnly: true,
        controller: widget.obtenerDatos,
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
        onTap: () async {
          await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1800),
            lastDate: DateTime(2100),
          ).then((selectedDate) {
            if (selectedDate != null) {
              widget.obtenerDatos.text =
                  DateFormat('yyyy-MM-dd').format(selectedDate);
            }
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Porfavor ingrese fecha.';
          }
          return null;
        },
      ),
    );
  }
}
