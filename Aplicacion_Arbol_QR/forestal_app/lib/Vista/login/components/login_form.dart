import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forestal_app/Controlador/UsuarioDB.dart';
import 'package:forestal_app/Modelo/Usuario.dart';
import 'package:forestal_app/Vista/usuario/rounded_button_user.dart';
import 'package:forestal_app/componentsGeneral/constants.dart';
import 'package:forestal_app/componentsGeneral/rounded_button_qr.dart';
import 'package:forestal_app/componentsGeneral/rounded_email_input.dart';
import 'package:forestal_app/componentsGeneral/rounded_password_input.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
    required this.isLogin,
    required this.animationDuration,
    required this.size,
    required this.defaultLoginSize,
    required this.getTextEmail_Login,
    required this.getTextPassword_login,
    required this.globalFormkey,
  }) : super(key: key);

  final bool isLogin;
  final Duration animationDuration;
  final Size size;
  final double defaultLoginSize;
  final TextEditingController getTextEmail_Login;
  final TextEditingController getTextPassword_login;
  final globalFormkey;

  @override
  _LoginForm createState() => _LoginForm();
}

class _LoginForm extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    //final globalFormkey = new GlobalKey<FormState>();
    return AnimatedOpacity(
      opacity: widget.isLogin ? 1.0 : 0.0,
      duration: widget.animationDuration * 4,
      child: Form(
        key: widget.globalFormkey,
        child: Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: SizedBox(
              width: widget.size.width,
              height: widget.defaultLoginSize,
              child: Column(
                //vista forma de columnas
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  //cargamos elementos en columna
                  Flexible(
                    child: SvgPicture.asset('assets/images/arbol_QR.svg',
                        height: 170),
                  ),

                  const SizedBox(
                    height: 10,
                  ), //sa/cargamos imagen
                  const Text(
                    'Iniciar sesión', //creamos titulo de bien venidad
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        //ponemos en negrita el texto
                        fontSize: 25 //aumentamos letra
                        ),
                  ),

                  const SizedBox(
                    height: 10,
                  ), //salto de linea

                  RoundEmailtInput(
                    icon: FontAwesomeIcons.envelope,
                    hint: 'Correo Electrónico',
                    obtenerDatos: widget.getTextEmail_Login,
                  ), //creamos caja de texto user
                  RoundPasswordInput(
                    icon: FontAwesomeIcons.key,
                    hint: 'Contraseña',
                    obtenerDatos: widget.getTextPassword_login,
                  ), //creamos caja de texto password

                  const SizedBox(
                    height: 10,
                  ), //salto de linea

                  RoundeButtonUser(
                    title: 'ACCEDER',
                    Metodo: "loginUsuario",
                    objUser: Usuario(0, "", "", widget.getTextEmail_Login.text,
                        widget.getTextPassword_login.text, "", "", "", "", ""),
                    globalFormkey: widget.globalFormkey,
                  ),
                  const SizedBox(
                    height: 0,
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: FlatButton(
                      padding: EdgeInsets.only(right: 10.0),
                      splashColor: Colors.white,
                      onPressed: restablecer_contrasena,
                      child: Text(
                        /*verifacomos si es login o pantalla usuario */
                        "¿Olvidaste tu contraseña?",
                        style: TextStyle(color: Colors.red, fontSize: 15),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const RoundeButtonQr(title: "Leer código QR", ubicacion: ""),
                ],
              ),
            ),
          ),
        ),
      ),
      // )
    );
  }

  void _Mensaje(String testo) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(testo)));
  }
}

Future<List?> restablecer_contrasena() async {
  UsuarioDB obj = UsuarioDB();
  obj.restablecerContrasena();
}
