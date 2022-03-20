import 'dart:convert';

import 'package:forestal_app/Modelo/InconvenienteArbol.dart';
import 'package:forestal_app/Modelo/PresenciaEnfermedades.dart';
import 'package:http/http.dart' as http;

import '../componentsGeneral/constants.dart';

class InconvenienteArbolDB {
  Future<List?> Ver_Id_IA(String idArbol) async {
    String sql = "";
    sql = "SELECT * FROM tb_inconveniente_arbol WHERE id_arbol =" + idArbol + " AND estado_ia = 'A' ";

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

  Future<String> Agregar_IA(InconvenienteArbol obj) async {
    String sql =
        "INSERT INTO tb_inconveniente_arbol (id_ia, id_arbol, id_estado_fitosanitario, id_presenacia_enfermedades, id_ubicacion_enfermedades, id_presencia_plagas, id_problema_fisico, id_riesgos_potenciales, id_acciones_recomendadas, fecha_ia, estado_ia, id_usuario) VALUES(NULL, " +
            obj.getId_a.toString() +
            ", " +
            obj.getId_ef.toString() +
            ", " +
            obj.getId_pe.toString() +
            ", " +
            obj.getId_ue.toString() +
            ", " +
            obj.getId_pp.toString() +
            ", " +
            obj.getId_pf.toString() +
            ", " +
            obj.getId_rp.toString() +
            ", " +
            obj.getId_ar.toString() +
            ", '" +
            obj.getFecha_ia.toString() +
            "', '" +
            obj.getEstado_ia.toString() +
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
      return "Falló la conexión";
    }
  }

  Future<String> Eliminar_IA(int idArbol) async {
    String sql = "";

    sql = "UPDATE tb_inconveniente_arbol SET "
            "estado_ia= 'P' "
            "WHERE id_arbol= " +
        idArbol.toString();
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
}
