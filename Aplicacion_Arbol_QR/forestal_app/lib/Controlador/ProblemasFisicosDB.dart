import 'dart:convert';

import 'package:forestal_app/Modelo/ProblemasFisicos.dart';
import 'package:forestal_app/componentsGeneral/constants.dart';
import 'package:http/http.dart' as http;

class ProblemasFisicosDB {

  Future<List?> Ver_Id_PF(String id) async {
    String sql = "";
    sql = "SELECT * FROM tb_problemas_fisicos WHERE id_pf = " + id + " ";

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
  Future<List?> Listar_PF() async {
    List listaDatos = [];
    String sql =
        "SELECT * FROM tb_problemas_fisicos WHERE estado_pf='A' ORDER BY descripcion_pf ASC ";

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

  Future<String> Agregar_PF(ProblemasFisicos obj) async {
    String sql =
        "INSERT INTO tb_problemas_fisicos (id_pf, descripcion_pf, estado_pf) VALUES(NULL, '" +
            obj.getDescripcion_pf.toString() +
            "', '" +
            obj.getEstado_pf.toString() +
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

  Future<String> Editar_PF(ProblemasFisicos obj) async {
    String sql = "";

    sql = "UPDATE tb_problemas_fisicos SET "
            "descripcion_pf = '" +
        obj.getDescripcion_pf.toString() +
        "', "
            "estado_pf= '" +
        obj.getEstado_pf.toString() +
        "' "
            "WHERE id_pf= " +
        obj.getId_pf.toString();
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

  Future<String> Eliminar_PF(int id) async {
    String sql = "";

    sql = "UPDATE tb_problemas_fisicos SET "
            "estado_pf= 'P' "
            "WHERE id_pf= " +
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
