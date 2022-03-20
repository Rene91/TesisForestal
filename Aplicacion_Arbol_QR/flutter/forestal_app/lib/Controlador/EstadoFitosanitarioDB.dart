import 'dart:convert';

import 'package:forestal_app/Modelo/EstadoFitosanitario.dart';
import 'package:forestal_app/Modelo/ProblemasFisicos.dart';
import 'package:forestal_app/componentsGeneral/constants.dart';
import 'package:http/http.dart' as http;

class EstadoFitosanitarioDB {

  Future<List?> Ver_Id_EF(String id) async {
    String sql = "";
    sql = "SELECT * FROM tb_estado_fitosanitario WHERE id_ef = " + id + " ";

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
  Future<List?> Listar_EF() async {
    List listaDatos = [];
    String sql =
        "SELECT * FROM tb_estado_fitosanitario WHERE estado_ef='A' ORDER BY descripcion_ef ASC ";

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

  Future<String> Agregar_EF(EstadoFitosanitario obj) async {
    String sql =
        "INSERT INTO tb_estado_fitosanitario (id_ef, descripcion_ef, estado_ef) VALUES(NULL, '" +
            obj.getDescripcion_ef.toString() +
            "', '" +
            obj.getEstado_ef.toString() +
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

  Future<String> Editar_EF(EstadoFitosanitario obj) async {
    String sql = "";

    sql = "UPDATE tb_estado_fitosanitario SET "
            "descripcion_ef = '" +
        obj.getDescripcion_ef.toString() +
        "', "
            "estado_ef= '" +
        obj.getEstado_ef.toString() +
        "' "
            "WHERE id_ef= " +
        obj.getId_ef.toString();
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

  Future<String> Eliminar_EF(int id) async {
    String sql = "";

    sql = "UPDATE tb_estado_fitosanitario SET "
            "estado_ef= 'P' "
            "WHERE id_ef= " +
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
