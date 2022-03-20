import 'package:flutter/material.dart';
import 'package:forestal_app/Controlador/ArbolesDB.dart';
import 'package:forestal_app/Modelo/Arboles.dart';
import 'package:permission_handler/permission_handler.dart';

import 'constants.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class RoundeButtonQr extends StatefulWidget {
  const RoundeButtonQr({
    Key? key,
    required this.title,
    required this.ubicacion,
  }) : super(key: key);

  final String title;
  final String ubicacion;

  @override
  _ButtonCancelar createState() => _ButtonCancelar();
}

class _ButtonCancelar extends State<RoundeButtonQr> {
  @override
  Widget build(BuildContext context) {
    Size size =
        MediaQuery.of(context).size; //obtenemos todo el ancho de la pantalla

    return InkWell(
      onTap: () {
        setState(() {
          ventanaScaner();
        });
        /*Navigator.of(context).pushNamed(
            widget.ubicacion);*/
      },
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: size.width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: kTreeColor,
        ),
        padding: const EdgeInsets.symmetric(vertical: 20),
        alignment: Alignment.center,
        //child: Row(
        //mainAxisAlignment: MainAxisAlignment.center,
        child: Text(
          widget.title,
          style: const TextStyle(color: Colors.green, fontSize: 18),
        ),
      ),
    );
  }

  void ventanaScaner() async {
    await Permission.camera.request();
    String? barcode = await scanner.scan();
    if (barcode == null) {
      print('QR no existe');
      Navigator.of(context).pop();
    } else {
      ArbolesDB mm = ArbolesDB();
      List? response = await mm.Ver_Id_A(barcode.toString());
      Arboles? _objArbol = Arboles(
          int.parse(response![0]['id_a']),
          response[0]['nombre_comun_a'],
          response[0]['nombre_cientifico_a'],
          response[0]['longitud_a'],
          response[0]['latitud_a'],
          response[0]['altitud_a'],
          double.parse(response[0]['cap_a']),
          double.parse(response[0]['dap_a']),
          double.parse(response[0]['ht_a']),
          double.parse(response[0]['hc_a']),
          double.parse(response[0]['tam_copa_prom_a']),
          int.parse(response[0]['porcentaje_hojas_a']),
          response[0]['madurez_a'],
          response[0]['floracion_a'],
          response[0]['fructificacion_a'],
          response[0]['rectitud_fuste_a'],
          response[0]['crecimiento_a'],
          response[0]['comentarios_a'],
          response[0]['estado_a'],
          response[0]['foto_a'],
          response[0]['familia_a'],
          response[0]['sector_a'],
          response[0]['proyecto_a']);

      //Navigator.of(context).pop();
      Navigator.of(context)
          .pushNamed("/verid_form_a_screen", arguments: _objArbol);
    }
  }
}
