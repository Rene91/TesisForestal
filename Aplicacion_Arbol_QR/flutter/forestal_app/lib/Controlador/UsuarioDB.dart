import 'dart:convert';

import 'package:forestal_app/Modelo/Usuario.dart';
import 'package:http/http.dart' as http;

import '../componentsGeneral/constants.dart';

class UsuarioDB {
  Future<int> BuscarId_U(String Password, String Email) async {
    int id = 0;
    String sql = "SELECT * FROM tb_usuario WHERE " +
        "contrasena_u = '" +
        Password.toString() +
        "' AND email_u = '" +
        Email.toString() +
        "' AND estado_u = 'A'";

    final response = await http.post(miURLServer, body: {
      "accion": "listar",
      "sql": sql,
    });

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final datauser = json.decode(body);
      if (datauser.length == 0) {
        id = -1;
      } else {
        id = int.parse(datauser[0]['id_u']);
      }
    } else {
      id = -1;
    }
    return id;
  }

  Future<List?> Listar_U_estado(String estado, String descripcion) async {
    String sql = "SELECT * FROM tb_usuario WHERE (email_u "
            "LIKE '%" +
        descripcion +
        "%' OR nombre_u LIKE '%" +
        descripcion +
        "%' ) AND estado_u= '" +
        estado +
        "' ORDER BY nivel_u ASC ";

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

  Future<List?> BuscarAdministardor() async {
    String sql =
        "SELECT * FROM tb_usuario WHERE estado_u= 'A' AND nivel_u='admin' ";

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

  Future<String> BuscarEmail(String Email) async {
    String emailExiste = "no";
    String sql = "SELECT * FROM tb_usuario WHERE " +
        "email_u = '" +
        Email.toString() +
        "' ";

    final response = await http.post(miURLServer, body: {
      "accion": "listar",
      "sql": sql,
    });
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final datauser = json.decode(body);
      if (datauser.length == 0) {
        emailExiste = "no";
      } else {
        emailExiste = "si";
      }
    } else {
      emailExiste = "error";
    }
    return emailExiste;
  }

  Future<List> Login_U(String Password, String Email) async {
    List listaDatos = [];
    String sql = "SELECT * FROM tb_usuario WHERE " +
        "contrasena_u = '" +
        Password.toString() +
        "' AND email_u = '" +
        Email.toString() +
        "' AND estado_u = 'A'";

    //print(sql);
    final response = await http.post(miURLServer, body: {
      "accion": "listar",
      "sql": sql,
    });

    //print(response);
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final datauser = json.decode(body);
      if (datauser.length == 0) {
        listaDatos.add(null);
        listaDatos.add("Usuario o Contraseña mal digitados");
      } else {
        Usuario usuarioBD = new Usuario(
            int.parse(datauser[0]['id_u']),
            datauser[0]['nombre_u'].toString(),
            datauser[0]['apellido_u'].toString(),
            datauser[0]['email_u'].toString(),
            datauser[0]['contrasena_u'].toString(),
            datauser[0]['contrasena_u'].toString(),
            datauser[0]['fecha_nacimineto_u'].toString(),
            datauser[0]['nivel_u'].toString(),
            datauser[0]['estado_u'].toString(),
            datauser[0]['foto_u'].toString());
        //listaDatos.add(datauser[0]);
        listaDatos.add(usuarioBD);
        listaDatos.add("ACCIÓN CORRECTA");
        listaDatos.add(datauser[0]['id_u']);
      }
    } else {
      listaDatos.add(null);
      listaDatos.add("Falló la conexión");
    }
    return listaDatos;
  }

  Future<List> Listar_U(Usuario obj, String descripcion) async {
    List listaDatos = [];
    String sql = "SELECT * FROM tb_usuario WHERE " +
        "contrasena_u = '" +
        obj.getContrasena_u.toString() +
        "' AND email_u = '" +
        obj.getEmail_u.toString() +
        "' AND estado_u = '" +
        obj.getEstado_u.toString() +
        "' ";

    final response = await http.post(miURLServer, body: {
      "accion": "listar",
      "sql": sql,
    });

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final datauser = json.decode(body);
      if (datauser.length == 0) {
        listaDatos.add(null);
        listaDatos.add("Usuario o Contraseña mal digitados");
      } else {
        Usuario usuarioBD = new Usuario(
            int.parse(datauser[0]['id_u']),
            datauser[0]['nombre_u'].toString(),
            datauser[0]['apellido_u'].toString(),
            datauser[0]['email_u'].toString(),
            datauser[0]['contrasena_u'].toString(),
            datauser[0]['contrasena_u'].toString(),
            datauser[0]['fecha_nacimineto_u'].toString(),
            datauser[0]['nivel_u'].toString(),
            datauser[0]['estado_u'].toString(),
            datauser[0]['foto_u'].toString());
        //listaDatos.add(datauser[0]);
        listaDatos.add(usuarioBD);
        listaDatos.add("ACCIÓN CORRECTA");
      }
    } else {
      listaDatos.add(null);
      listaDatos.add("Falló la conexión");
    }
    return listaDatos;
  }

  Future<String> Agregar_U(Usuario obj) async {
    String sql =
        "INSERT INTO tb_usuario (id_u, nombre_u, apellido_u, email_u, contrasena_u, fecha_nacimineto_u, nivel_u, estado_u, foto_u) VALUES(NULL, '" +
            obj.getNombre_u.toString() +
            "', '" +
            obj.getApellido_u.toString() +
            "', '" +
            obj.getEmail_u.toString() +
            "', '" +
            obj.getContrasena_u.toString() +
            "', '" +
            obj.getFechaNacimiento_u.toString() +
            "', '" +
            obj.getNivel_u.toString() +
            "', '" +
            obj.getEstado_u.toString() +
            "', '" +
            obj.getFoto_u.toString() +
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


  Future<List?> Ver_Id_U(String id) async {
    String sql = "";
    sql = "SELECT * FROM tb_usuario WHERE id_u = " + id + " ";

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

  Future<String> Editar_U(Usuario obj) async {
    String sql = "";
    // La hora actual se convierte en una marca de tiempo
    var nowTime = DateTime.now(); // Obtiene la hora actual
    var fecha = nowTime.millisecondsSinceEpoch; // marca de tiempo de 13 dígitos

    String _nombreFoto = "";
    String _urlImagen = "";

    if (obj.getFoto_u.toString() != "") {
      _nombreFoto = obj.getId_u.toString() + "_" + fecha.toString() + ".png";
      _urlImagen = UrlServer + "imagenes/usuarios/" + _nombreFoto;

      /*Ingresamos aqui si hay cambio de iamgen*/
      sql = "UPDATE tb_usuario SET "
              "nombre_u = '" +
          obj.getNombre_u.toString() +
          "', "
              "apellido_u = '" +
          obj.getApellido_u.toString() +
          "', "
              "email_u = '" +
          obj.getEmail_u.toString() +
          "', "
              "fecha_nacimineto_u = '" +
          obj.getFechaNacimiento_u.toString() +
          "', "
              "foto_u = '" +
          _urlImagen +
          "' "
              "WHERE id_u= " +
          obj.getId_u.toString();
    } else {
      sql = "UPDATE tb_usuario SET "
              "nombre_u = '" +
          obj.getNombre_u.toString() +
          "', "
              "apellido_u= '" +
          obj.getApellido_u.toString() +
          "', "
              "email_u = '" +
          obj.getEmail_u.toString() +
          "', "
              "fecha_nacimineto_u = '" +
          obj.getFechaNacimiento_u.toString() +
          "' "
              "WHERE id_u= " +
          obj.getId_u.toString();
    }
    final response = await http.post(miURLServer, body: {
      "accion": "editar",
      "sql": sql,
      "fotoBase64": obj.getFoto_u.toString(),
      "carpetafoto": "../imagenes/usuarios/" + _nombreFoto,
    });

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final datauser = json.decode(body);
      return datauser['respuesta'];
    } else {
      return "Falló la conexión";
    }
  }

  Future<String> Editar_Nivel(String nivel, String id) async {
    String sql = "";
    /*Ingresamos aqui si hay cambio de iamgen*/
    sql = "UPDATE tb_usuario SET "
            "nivel_u = '" +
        nivel.toString() +
        "' "
            "WHERE id_u= " +
        id.toString();
    final response = await http.post(miURLServer, body: {
      "accion": "editar",
      "sql": sql,
      "fotoBase64": "",
      "carpetafoto": "",
    });

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final datauser = json.decode(body);
      return datauser['respuesta'];
    } else {
      return "Falló la conexión";
    }
  }

  Future<String> Estado_u(String estado, String id) async {
    String sql = "";
    /*Ingresamos aqui si hay cambio de iamgen*/
    sql = "UPDATE tb_usuario SET "
            "estado_u = '" +
        estado.toString() +
        "' "
            "WHERE id_u= " +
        id.toString();
    final response = await http.post(miURLServer, body: {
      "accion": "editar",
      "sql": sql,
      "fotoBase64": "",
      "carpetafoto": "",
    });

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final datauser = json.decode(body);
      return datauser['respuesta'];
    } else {
      return "Falló la conexión";
    }
  }

  Future<List?> enviarMensaje(String nomUsuario, String nomAdministrador,
      String emailAdministrador, String emailUsuario) async {
    final response = await http.post(miURLServer, body: {
      "accion": "enviarEmailAdmin",
      "urlServer": miURLServer.toString(),
      "nomUsuario": nomUsuario,
      "nomAdministrador": nomAdministrador,
      "emailAdministrador": emailAdministrador,
      "emailUsuario": emailUsuario,
    });
    if (response.statusCode == 200) {
      /*String body = utf8.decode(response.bodyBytes);
      final datauser = json.decode(body);
      //print(json.decode(body));
      return json.decode(body);*/
    }
    return null;
  }
}
