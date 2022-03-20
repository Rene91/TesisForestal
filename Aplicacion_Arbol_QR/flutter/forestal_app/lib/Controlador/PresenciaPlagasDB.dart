import 'dart:convert';

import 'package:forestal_app/Modelo/PresenciaPlagas.dart';
import 'package:http/http.dart' as http;

import '../componentsGeneral/constants.dart';

class PresenciaPlagasDB {
  Future<List?> Ver_Id_PP(String id) async {
    String sql = "";
    sql = "SELECT * FROM tb_presencia_plagas WHERE id_pp = " + id + " ";

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


  Future<List?> Listar_PP() async {
    List listaDatos = [];
    String sql =
        "SELECT * FROM tb_presencia_plagas WHERE estado_pp='A' ORDER BY descripcion_pp ASC ";

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

  Future<String> Agregar_PP(PresenciaPlagas obj) async {
    String sql =
        "INSERT INTO tb_presencia_plagas (id_pp, descripcion_pp, estado_pp) VALUES(NULL, '" +
            obj.getDescripcion_pp.toString() +
            "', '" +
            obj.getEstado_pp.toString() +
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

  Future<String> Editar_PP(PresenciaPlagas obj) async {
    String sql = "";

    sql = "UPDATE tb_presencia_plagas SET "
            "descripcion_pp = '" +
        obj.getDescripcion_pp.toString() +
        "', "
            "estado_pp= '" +
        obj.getEstado_pp.toString() +
        "' "
            "WHERE id_pp= " +
        obj.getId_pp.toString();
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

  Future<String> Eliminar_PP(int id) async {
    String sql = "";

    sql = "UPDATE tb_presencia_plagas SET "
            "estado_pp= 'P' "
            "WHERE id_pp= " +
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
