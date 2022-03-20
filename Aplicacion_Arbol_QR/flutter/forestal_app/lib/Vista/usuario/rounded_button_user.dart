import 'dart:io';

import 'package:flutter/material.dart';
import 'package:forestal_app/Controlador/DispositivoDB.dart';
import 'package:forestal_app/Controlador/UsuarioDB.dart';
import 'package:forestal_app/Modelo/Usuario.dart';
import 'package:forestal_app/componentsGeneral/constants.dart';

class RoundeButtonUser extends StatefulWidget {
  const RoundeButtonUser({
    Key? key,
    required this.title,
    required this.Metodo,
    required this.objUser,
    required this.globalFormkey,
  }) : super(key: key);

  final String title;
  final String Metodo;
  final Usuario objUser;
  final globalFormkey;

  @override
  _ButtonLogin createState() => _ButtonLogin();
}

class _ButtonLogin extends State<RoundeButtonUser> {
  @override
  Widget build(BuildContext context) {
    Size size =
        MediaQuery.of(context).size; //obtenemos todo el ancho de la pantalla

    return InkWell(
      onTap: () {
        try {
          final form = widget.globalFormkey.currentState;
          if (form.validate()) {
            const Center(
              child: CircularProgressIndicator(),
            );

            UsuarioDB obj = UsuarioDB();
            switch (widget.Metodo) {
              case "registroUsuario":
                {
                  if (widget.objUser.getContrasena_u!.length > 1) {
                    if (widget.objUser.getContrasena_u!.toString() ==
                        widget.objUser.getContrasenaConfirmar_u!.toString()) {
                      setState(() async {
                        String ExisteCorreo = await obj.BuscarEmail(
                            widget.objUser.getEmail_u!.toString());
                        if (ExisteCorreo == "no") {
                          _cargarDatos(context);
                          String accion = await obj.Agregar_U(widget.objUser);

                          if (accion == "ACCIÓN CORRECTA") {
                            getAdministradores(
                                widget.objUser.getNombre_u.toString() +
                                    " " +
                                    widget.objUser.getApellido_u.toString(),
                                widget.objUser.getEmail_u.toString());
                            _Mensaje(
                                "Datos registardos: esperar mensaje de confirmación a su correo electronico");

                            Navigator.of(context).pushReplacementNamed(
                                "/login");
                            /*traemos id Usuario*/
                            /*obj = UsuarioDB();
                            int _idUsuario = await obj.BuscarId_U(
                                widget.objUser.getContrasena_u!,
                                widget.objUser.getEmail_u!);
                            DispositivoDB dispositivo = DispositivoDB();
                            accion = await dispositivo.Agregar_D(_idUsuario);
                            Navigator.pop(context);
                            if (accion == "ACCIÓN CORRECTA") {
                              //verificamos si dispositivo se guardo bien
                              /*widget.objUser.setId_u(
                                  _idUsuario); //cargamos el ide de usaurio al objeto
                              Navigator.of(context).pushReplacementNamed(
                                  "/inicio_screen",
                                  arguments: widget.objUser);*/
                            }*/
                          } else {
                            _Mensaje(accion);
                          }
                        } else {
                          if (ExisteCorreo == "error") {
                            _Mensaje("Error -> revise su conexión de internet");
                          } else {
                            _Mensaje("Correo existente colocar otro");
                          }
                        }
                      });
                    } else {
                      _Mensaje("Error en la digitación de contraseña");
                    }
                  }
                }
                break;
              case "loginUsuario":
                {
                  if (widget.objUser.getContrasena_u!.length > 1 &&
                      widget.objUser.getEmail_u!.length > 1) {
                    setState(() async {
                      _cargarDatos(context);
                      List _listAccion = await obj.Login_U(
                          //obtenemos el Objeto de usaurio en forma de lista
                          widget.objUser.getContrasena_u!.toString(),
                          widget.objUser.getEmail_u!.toString());

                      if (_listAccion[1] == "ACCIÓN CORRECTA") {
                        //loguin correcto
                        DispositivoDB dispositivo = DispositivoDB();
                        String accion = await dispositivo.Agregar_D(int.parse(
                            _listAccion[2])); //obtenemos id de usuario
                        Navigator.pop(context);

                        _cargarDatos(context);
                        if (accion == "ACCIÓN CORRECTA") {
                          Navigator.pop(context);
                          //dispositivo guardado
                          Navigator.of(context).pushReplacementNamed(
                              "/inicio_screen",
                              arguments: _listAccion[0]);
                        } else {
                          Navigator.pop(context);
                          _Mensaje(_listAccion[1]);
                        }
                      } else {
                        Navigator.pop(context);
                        _Mensaje(_listAccion[1]);
                      }
                    });
                  }
                }
                break;
            }
          }
        } on Exception catch (exception) {
          _Mensaje("Error on server-> " + exception.toString());
          throw Exception("Error on server");
        } catch (error) {
          //_Mensaje("Error-> " + error.toString());
        }
      },
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: size.width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: kPrimaryColor,
        ),
        padding: const EdgeInsets.symmetric(vertical: 20),
        alignment: Alignment.center,
        //child: Row(
        //mainAxisAlignment: MainAxisAlignment.center,
        child: Text(
          widget.title,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }

  void _Mensaje(String testo) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(testo)));
  }
}

void _cargarDatos(context) {
  showDialog<String>(
    barrierDismissible: false,
    //barrierColor: Colors.green,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: kTreeColor,
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7),
              child: const Text("Loading...")),
        ],
      ),
      actions: <Widget>[],
    ),
  );
}

/*Obtenemos los datos del servidor*/
Future<List?> getAdministradores(String nomUsuario, String emailUsuario) async {
  UsuarioDB mm = UsuarioDB();
  List? response = await mm.BuscarAdministardor();
  for (var element in response!) {
    UsuarioDB obj = UsuarioDB();
    obj.enviarMensaje(
        nomUsuario,
        element['nombre_u'].toString() + " " + element['apellido_u'].toString(),
        element['email_u'].toString(),
        emailUsuario);
  }
  return response;
}
