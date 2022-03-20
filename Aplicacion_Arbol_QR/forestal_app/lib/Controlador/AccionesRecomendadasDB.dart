import 'dart:convert';

import 'package:forestal_app/Modelo/AccionesRecomendadas.dart';
import 'package:forestal_app/componentsGeneral/constants.dart';
import 'package:http/http.dart' as http;

class AccionesRecomendadasDB {
  Future<List?> Ver_Id_AR(String id) async {
    String sql = "";
    sql = "SELECT * FROM tb_acciones_recomendadas WHERE id_ar = " + id + " ";

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
  Future<List?> Listar_AR() async {
    List listaDatos = [];
    String sql =
        "SELECT * FROM tb_acciones_recomendadas WHERE estado_ar='A' ORDER BY descripcion_ar ASC ";

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

  Future<String> Agregar_AR(AccionesRecomendadas obj) async {
    String sql =
        "INSERT INTO tb_acciones_recomendadas (id_ar, descripcion_ar, estado_ar) VALUES(NULL, '" +
            obj.getDescripcion_ar.toString() +
            "', '" +
            obj.getEstado_ar.toString() +
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

  Future<String> Editar_AR(AccionesRecomendadas obj) async {
    String sql = "";

    sql = "UPDATE tb_acciones_recomendadas SET "
            "descripcion_ar = '" +
        obj.getDescripcion_ar.toString() +
        "', "
            "estado_ar= '" +
        obj.getEstado_ar.toString() +
        "' "
            "WHERE id_ar= " +
        obj.getId_ar.toString();
    final response = await http.post(miURLServer, body: {
      "accion": "insertar",
      "sql": sql,
    });

    print(sql);
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final datauser = json.decode(body);
      return datauser['respuesta'];
    } else {
      return "Falló la conexión";
    }
  }

  Future<String> Eliminar_AR(int id) async {
    String sql = "";

    sql = "UPDATE tb_acciones_recomendadas SET "
            "estado_ar= 'P' "
            "WHERE id_ar= " +
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
