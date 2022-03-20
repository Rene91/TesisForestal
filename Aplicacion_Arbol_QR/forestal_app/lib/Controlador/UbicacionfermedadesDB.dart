import 'dart:convert';

import 'package:forestal_app/Modelo/UbicacionEnfermedades.dart';
import 'package:http/http.dart' as http;

import '../componentsGeneral/constants.dart';

class UbicacionEnfermedadesDB {

  Future<List?> Ver_Id_UE(String id) async {
    String sql = "";
    sql = "SELECT * FROM tb_ubicacion_enfermedades WHERE id_ue =" + id + " ";

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


  Future<List?> Listar_UE() async {
    List listaDatos = [];
    String sql =
        "SELECT * FROM tb_ubicacion_enfermedades WHERE estado_ue='A' ORDER BY descripcion_ue ASC ";

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

  Future<String> Agregar_UE(UbicacionEnfermedades obj) async {
    String sql =
        "INSERT INTO tb_ubicacion_enfermedades (id_ue, descripcion_ue, estado_ue) VALUES(NULL, '" +
            obj.getDescripcion_ue.toString() +
            "', '" +
            obj.getEstado_ue.toString() +
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

  Future<String> Editar_UE(UbicacionEnfermedades obj) async {
    String sql = "";

    sql = "UPDATE tb_ubicacion_enfermedades SET "
            "descripcion_ue = '" +
        obj.getDescripcion_ue.toString() +
        "', "
            "estado_ue= '" +
        obj.getEstado_ue.toString() +
        "' "
            "WHERE id_ue= " +
        obj.getId_ue.toString();
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

  Future<String> Eliminar_UE(int id) async {
    String sql = "";

    sql = "UPDATE tb_ubicacion_enfermedades SET "
            "estado_ue= 'P' "
            "WHERE id_ue= " +
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
