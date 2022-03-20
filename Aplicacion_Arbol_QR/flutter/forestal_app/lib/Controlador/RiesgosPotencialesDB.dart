import 'dart:convert';

import 'package:forestal_app/Modelo/RiesgosPotenciales.dart';
import 'package:forestal_app/componentsGeneral/constants.dart';
import 'package:http/http.dart' as http;

class RiesgosPotencialesDB {
  Future<List?> Ver_Id_RP(String id) async {
    String sql = "";
    sql = "SELECT * FROM tb_riesgos_potenciales WHERE id_rp = " + id + " ";

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
  Future<List?> Listar_RP() async {
    List listaDatos = [];
    String sql =
        "SELECT * FROM tb_riesgos_potenciales WHERE estado_rp='A' ORDER BY descripcion_rp ASC ";

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

  Future<String> Agregar_RP(RiesgosPotenciales obj) async {
    String sql =
        "INSERT INTO tb_riesgos_potenciales (id_rp, descripcion_rp, estado_rp) VALUES(NULL, '" +
            obj.getDescripcion_rp.toString() +
            "', '" +
            obj.getEstado_rp.toString() +
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

  Future<String> Editar_RP(RiesgosPotenciales obj) async {
    String sql = "";

    sql = "UPDATE tb_riesgos_potenciales SET "
            "descripcion_rp = '" +
        obj.getDescripcion_rp.toString() +
        "', "
            "estado_rp= '" +
        obj.getEstado_rp.toString() +
        "' "
            "WHERE id_rp= " +
        obj.getId_rp.toString();
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

  Future<String> Eliminar_RP(int id) async {
    String sql = "";

    sql = "UPDATE tb_riesgos_potenciales SET "
            "estado_rp= 'P' "
            "WHERE id_rp= " +
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
