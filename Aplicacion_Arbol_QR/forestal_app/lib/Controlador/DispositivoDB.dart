import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:forestal_app/Modelo/Dispositivo.dart';
import 'package:forestal_app/Modelo/Usuario.dart';
import 'package:get_ip/get_ip.dart';
import 'package:http/http.dart' as http;

import '../componentsGeneral/constants.dart';

class DispositivoDB {
  Future<String> Agregar_D(int Id_usuario) async {
    List datos = await _detallesDispositivo();
    Dispositivo obj = Dispositivo("Dispositivo: " + datos[0].toString(),
        datos[1], datos[2], "NOW()", "NULL", "A", Id_usuario);
    String sql =
        "INSERT INTO tb_dispositivo (id_d, nombre_d, ip_d, mac_d, inicio_sesion_d, fin_sesioin_d, estado_sesion_d,id_usuario) VALUES(NULL, '" +
            obj.getNombre_d.toString() +
            "', '" +
            obj.getIp_d.toString() +
            "', '" +
            obj.getMac_d.toString() +
            "', " +
            obj.getInicio_sesion_d.toString() +
            ", " +
            obj.getFin_sesioin_d.toString() +
            ", '" +
            obj.getEstado_sesion_d.toString() +
            "', " +
            obj.getId_usuario.toString() +
            " )";

    final response = await http.post(miURLServer, body: {
      "accion": "insertar",
      "sql": sql,
    });

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final datauser = json.decode(body);
      return datauser['respuesta'];
    } else {
      return "Falló la conexión: No se agrego dispositivo";
    }
  }

  Future<void> BuscarId_D(BuildContext context) async {
    try {
      List datos = await _detallesDispositivo(); //obtenemos datos del movil
      String sql =
          "SELECT tb_usuario.* FROM tb_dispositivo INNER JOIN tb_usuario ON tb_dispositivo.id_usuario = tb_usuario.id_u WHERE tb_dispositivo.mac_d = '" +
              datos[2].toString() +
              "' AND tb_usuario.estado_u = 'A' AND tb_dispositivo.estado_sesion_d = 'A' ";

      final response = await http.post(miURLServer, body: {
        "accion": "listar",
        "sql": sql,
      });

      if (response.statusCode == 200) {
        String body = utf8.decode(response.bodyBytes);
        final datauser = json.decode(body);
        if (datauser.length > 0) {
          Usuario usuarioBD = Usuario(
            int.parse(datauser[0]['id_u']),
            datauser[0]['nombre_u'].toString(),
            datauser[0]['apellido_u'].toString(),
            datauser[0]['email_u'].toString(),
            datauser[0]['contrasena_u'].toString(),
            "",
            datauser[0]['fecha_nacimineto_u'].toString(),
            datauser[0]['nivel_u'].toString(),
            datauser[0]['estado_u'].toString(),
            datauser[0]['foto_u'].toString(),
          );
          Navigator.of(context)
              .pushReplacementNamed("/inicio_screen", arguments: usuarioBD);
        }
      } else {
        print("Falló la conexión: Error al cargar datos dispositivo");
      }
    } catch (e) {
      print("Error al cargar datos dispositivo-->" + e.toString());
    }
  }

  Future<void> CerrarSecion_D(int idUsuario, BuildContext context) async {
    try {
      List datos = await _detallesDispositivo(); //obtenemos datos del movil
      String sql =
          "UPDATE tb_dispositivo SET  fin_sesioin_d = NOW(), estado_sesion_d = 'P' WHERE mac_d ='" +
              datos[2] +
              "'  AND id_usuario = " +
              idUsuario.toString();

      final response = await http.post(miURLServer, body: {
        "accion": "insertar",
        "sql": sql,
      });

      if (response.statusCode == 200) {
        String body = utf8.decode(response.bodyBytes);
        final datauser = json.decode(body);
        if (datauser['respuesta'] == "ACCIÓN CORRECTA") {
          Navigator.of(context).pushReplacementNamed("/");
        }
        //Navigator.of(context).pushReplacementNamed("/");
      } else {
        print("Falló la conexión: No se cerro session");
      }
    } catch (e) {
      print("Error al cargar datos dispositivo-->" + e.toString());
    }
  }

  Future<List> _detallesDispositivo() async {
    List datos = [];
    try {
      String deviceName = '';
      String deviceVersion = '';
      String identifier = '';
      final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        datos.add(build.model);
        //datos.add(build.version.toString());
        datos.add(await GetIp.ipAddress);
        datos.add(build.androidId);
        //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        datos.add(data.name);
        //datos.add(data.systemVersion);
        datos.add(await GetIp.ipAddress);
        datos.add(data.identifierForVendor);
      }
    } on PlatformException {
      print('Eror al cargar plataforma');
    }
    return datos;
  }

  Future<void> RespaldarBD() async {
    try {
      final response = await http.post(miURLServer, body: {
        "accion": "respaldoBD",
      });

      if (response.statusCode == 200) {
        String body = utf8.decode(response.bodyBytes);
        final datauser = json.decode(body);
        if (datauser['respuesta'] == "ACCIÓN CORRECTA") {
          //print("accion correcta");
        }
        //Navigator.of(context).pushReplacementNamed("/");
      } else {
        print("Falló la conexión: No se cerro session");
      }
    } catch (e) {
      print("Error al cargar datos dispositivo-->" + e.toString());
    }
  }
}
