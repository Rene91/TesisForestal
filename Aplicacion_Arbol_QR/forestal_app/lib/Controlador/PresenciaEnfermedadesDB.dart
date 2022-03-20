import 'dart:convert';

import 'package:forestal_app/Modelo/PresenciaEnfermedades.dart';
import 'package:http/http.dart' as http;

import '../componentsGeneral/constants.dart';

class PresenciaEnfermedadesDB {
  Future<List?> Listar_PE() async {
    List listaDatos = [];
    String sql =
        "SELECT * FROM tb_presencia_enfermedades WHERE estado_pe='A' ORDER BY descripcion_pe ASC ";

    final response = await http.post(miURLServer, body: {
      "accion": "listar",
      "sql": sql,
    });

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final datauser = json.decode(body);
      //print(json.decode(body));
      return json.decode(body);
    }
    return null;
  }

  Future<List?> Ver_Id_PE(String id) async {
    String sql = "";
    sql = "SELECT * FROM tb_presencia_enfermedades WHERE id_pe =" + id + " ";

    final response = await http.post(miURLServer, body: {
      "accion": "listar",
      "sql": sql,
    });

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final datauser = json.decode(body);
      //print(json.decode(body));
      return json.decode(body);
    }
    return null;
  }

  Future<String> Agregar_PE(PresenciaEnfermedades obj) async {
    String sql =
        "INSERT INTO tb_presencia_enfermedades (id_pe, descripcion_pe, estado_pe) VALUES(NULL, '" +
            obj.getDescripcion_pe.toString() +
            "', '" +
            obj.getEstado_pe.toString() +
            "' )";
    final response = await http.post(miURLServer, body: {
      "accion": "insertar",
      "sql": sql,
    });

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final datauser = json.decode(body);
      return datauser['respuesta'];
    } else {
      return "Falló la conexión";
    }
  }

  Future<String> Editar_PE(PresenciaEnfermedades obj) async {
    String sql = "";

    sql = "UPDATE tb_presencia_enfermedades SET "
            "descripcion_pe = '" +
        obj.getDescripcion_pe.toString() +
        "', "
            "estado_pe= '" +
        obj.getEstado_pe.toString() +
        "' "
            "WHERE id_pe= " +
        obj.getId_pe.toString();
    final response = await http.post(miURLServer, body: {
      "accion": "insertar",
      "sql": sql,
    });

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final datauser = json.decode(body);
      return datauser['respuesta'];
    } else {
      return "Falló la conexión";
    }
  }

  Future<String> Eliminar_PE(int id) async {
    String sql = "";

    sql = "UPDATE tb_presencia_enfermedades SET "
            "estado_pe= 'P' "
            "WHERE id_pe= " +
        id.toString();
    final response = await http.post(miURLServer, body: {
      "accion": "insertar",
      "sql": sql,
    });

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final datauser = json.decode(body);
      return datauser['respuesta'];
    } else {
      return "Falló la conexión";
    }
  }
}
