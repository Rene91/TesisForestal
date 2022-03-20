import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:forestal_app/Modelo/Arboles.dart';
import 'package:forestal_app/componentsGeneral/constants.dart';
import 'package:http/http.dart' as http;

class ArbolesDB {
  Future<List?> Listar_A(String descripcion, String campo) async {
    String sql = "";
    if (descripcion == "") {
      sql = "SELECT * FROM tb_arbol  WHERE estado_a = 'A'  ORDER BY " +
          campo +
          " ASC ";
    } else {
      sql = "SELECT * FROM tb_arbol WHERE " +
          campo +
          " LIKE '%" +
          descripcion +
          "%'  AND estado_a = 'A'  ORDER BY " +
          campo +
          " ASC ";
    }

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

  Future<List?> Ver_Id_A(String id) async {
    String sql = "";
    sql = "SELECT * FROM tb_arbol WHERE id_a =" + id + " ";

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

  Future<String> Agregar_A(Arboles obj) async {
    // La hora actual se convierte en una marca de tiempo
    var nowTime = DateTime.now(); // Obtiene la hora actual
    var fecha = nowTime.millisecondsSinceEpoch; // marca de tiempo de 13 dígitos

    String _nombreFoto = "";
    String _urlImagen = "";

    _nombreFoto = fecha.toString() + ".png";
    _urlImagen = UrlServer + "imagenes/arboles/" + _nombreFoto;

    String sql =
        "INSERT INTO tb_arbol (id_a, nombre_comun_a, nombre_cientifico_a, longitud_a, latitud_a, altitud_a, cap_a, dap_a, ht_a, hc_a, tam_copa_prom_a, porcentaje_hojas_a, madurez_a, floracion_a, fructificacion_a, rectitud_fuste_a, crecimiento_a, comentarios_a, estado_a, foto_a, familia_a, sector_a, proyecto_a) VALUES( NULL, '" +
            obj.getNombre_comun_a.toString() +
            "', '" +
            obj.getNombre_cientifico_a.toString() +
            "', '" +
            obj.getLongitud_a.toString() +
            "', '" +
            obj.getLatitud_a.toString() +
            "', '" +
            obj.getAltitud_a.toString() +
            "', " +
            obj.getCap_a.toString() +
            ", " +
            obj.getDap_a.toString() +
            ", " +
            obj.getHt_a.toString() +
            ", " +
            obj.getHc_a.toString() +
            ", " +
            obj.getTam_copa_prom_a.toString() +
            ", " +
            obj.getPorcentaje_hojas_a.toString() +
            ", '" +
            obj.getMadurez_a.toString() +
            "', '" +
            obj.getFloracion_a.toString() +
            "', '" +
            obj.getFructificacion_a.toString() +
            "', '" +
            obj.getRectitud_fuste_a.toString() +
            "', '" +
            obj.getCrecimiento_a.toString() +
            "', '" +
            obj.getComentarios_a.toString() +
            "', '" +
            obj.getEstado_a.toString() +
            "', '" +
            _urlImagen +
            "', '" +
            obj.getFamilia_a.toString() +
            "', '" +
            obj.getSector_a.toString() +
            "', '" +
            obj.getProyecto_a.toString() +
            "' )";
    //print(obj.getFoto_a.toString());
    final response = await http.post(miURLServer, body: {
      "accion": "insertar",
      "sql": sql,
      "fotoBase64": obj.getFoto_a.toString(),
      "carpetafoto": "../imagenes/arboles/" + _nombreFoto,
    });

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final datauser = json.decode(body);
      return datauser['respuesta'];
    } else {
      return "Falló la conexión";
    }
  }

  Future<String> Editar_A(Arboles obj) async {
    // La hora actual se convierte en una marca de tiempo
    var nowTime = DateTime.now(); // Obtiene la hora actual
    var fecha = nowTime.millisecondsSinceEpoch; // marca de tiempo de 13 dígitos

    String _nombreFoto = "";
    String _urlImagen = "";

    String sql = "";
    if (obj.getFoto_a.toString() == "") {
      sql = "UPDATE tb_arbol SET "
              "nombre_comun_a = '" +
          obj.getNombre_comun_a.toString() +
          "', nombre_cientifico_a = '" +
          obj.getNombre_cientifico_a.toString() +
          "', longitud_a = '" +
          obj.getLongitud_a.toString() +
          "', latitud_a = '" +
          obj.getLatitud_a.toString() +
          "', altitud_a = '" +
          obj.getAltitud_a.toString() +
          "', cap_a = " +
          obj.getCap_a.toString() +
          ", dap_a = " +
          obj.getDap_a.toString() +
          ", ht_a = " +
          obj.getHt_a.toString() +
          ", hc_a = " +
          obj.getHc_a.toString() +
          ", tam_copa_prom_a = " +
          obj.getTam_copa_prom_a.toString() +
          ", porcentaje_hojas_a = " +
          obj.getPorcentaje_hojas_a.toString() +
          ", madurez_a = '" +
          obj.getMadurez_a.toString() +
          "', floracion_a = '" +
          obj.getFloracion_a.toString() +
          "', fructificacion_a = '" +
          obj.getFructificacion_a.toString() +
          "', rectitud_fuste_a = '" +
          obj.getRectitud_fuste_a.toString() +
          "', crecimiento_a = '" +
          obj.getCrecimiento_a.toString() +
          "', comentarios_a = '" +
          obj.getComentarios_a.toString() +
          "', estado_a = '" +
          obj.getEstado_a.toString() +
          "', familia_a = '" +
          obj.getFamilia_a.toString() +
          "', sector_a = '" +
          obj.getSector_a.toString() +
          "', proyecto_a = '" +
          obj.getProyecto_a.toString() +
          "' WHERE id_a= " +
          obj.getId_a.toString() +
          " ";
    } else {
      _nombreFoto = obj.getId_a.toString() + "_" + fecha.toString() + ".png";
      _urlImagen = UrlServer + "imagenes/arboles/" + _nombreFoto;

      sql = "UPDATE tb_arbol SET "
              "nombre_comun_a = '" +
          obj.getNombre_comun_a.toString() +
          "', nombre_cientifico_a = '" +
          obj.getNombre_cientifico_a.toString() +
          "', longitud_a = '" +
          obj.getLongitud_a.toString() +
          "', latitud_a = '" +
          obj.getLatitud_a.toString() +
          "', altitud_a = '" +
          obj.getAltitud_a.toString() +
          "', cap_a = " +
          obj.getCap_a.toString() +
          ", dap_a = " +
          obj.getDap_a.toString() +
          ", ht_a = " +
          obj.getHt_a.toString() +
          ", hc_a = " +
          obj.getHc_a.toString() +
          ", tam_copa_prom_a = " +
          obj.getTam_copa_prom_a.toString() +
          ", porcentaje_hojas_a = " +
          obj.getPorcentaje_hojas_a.toString() +
          ", madurez_a = '" +
          obj.getMadurez_a.toString() +
          "', floracion_a = '" +
          obj.getFloracion_a.toString() +
          "', fructificacion_a = '" +
          obj.getFructificacion_a.toString() +
          "', rectitud_fuste_a = '" +
          obj.getRectitud_fuste_a.toString() +
          "', crecimiento_a = '" +
          obj.getCrecimiento_a.toString() +
          "', comentarios_a = '" +
          obj.getComentarios_a.toString() +
          "', estado_a = '" +
          obj.getEstado_a.toString() +
          "', foto_a= '" +
          _urlImagen +
          "', familia_a = '" +
          obj.getFamilia_a.toString() +
          "', sector_a = '" +
          obj.getSector_a.toString() +
          "', proyecto_a = '" +
          obj.getProyecto_a.toString() +
          "' WHERE id_a= " +
          obj.getId_a.toString() +
          " ";
    }
    final response = await http.post(miURLServer, body: {
      "accion": "editar",
      "sql": sql,
      "fotoBase64": obj.getFoto_a.toString(),
      "carpetafoto": "../imagenes/arboles/" + _nombreFoto,
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

  Future<String> Eliminar_A(int id) async {
    String sql = "";

    sql = "UPDATE tb_arbol SET "
            "estado_a= 'P' "
            "WHERE id_a= " +
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
